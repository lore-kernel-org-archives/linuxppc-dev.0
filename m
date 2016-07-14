Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrB7J1jBMzDqF8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 09:02:51 +1000 (AEST)
Date: Fri, 15 Jul 2016 02:02:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/qe: Increase MAX_QE_RISC to 4
Message-ID: <20160714230239.GA2395@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton Vorontsov,

The patch 98eaa0987afd: "powerpc/qe: Increase MAX_QE_RISC to 4" from
Aug 27, 2009, leads to the following static checker warning:

	drivers/soc/fsl/qe/qe.c:524 qe_upload_firmware()
	error: buffer overflow 'qe_immr->rsp' 2 <= 3

drivers/soc/fsl/qe/qe.c
   425  int qe_upload_firmware(const struct qe_firmware *firmware)
   426  {
   427          unsigned int i;
   428          unsigned int j;
   429          u32 crc;
   430          size_t calc_size = sizeof(struct qe_firmware);
   431          size_t length;
   432          const struct qe_header *hdr;
   433  
   434          if (!firmware) {
   435                  printk(KERN_ERR "qe-firmware: invalid pointer\n");
   436                  return -EINVAL;
   437          }
   438  
   439          hdr = &firmware->header;
   440          length = be32_to_cpu(hdr->length);
   441  
   442          /* Check the magic */
   443          if ((hdr->magic[0] != 'Q') || (hdr->magic[1] != 'E') ||
   444              (hdr->magic[2] != 'F')) {
   445                  printk(KERN_ERR "qe-firmware: not a microcode\n");
   446                  return -EPERM;
   447          }
   448  
   449          /* Check the version */
   450          if (hdr->version != 1) {
   451                  printk(KERN_ERR "qe-firmware: unsupported version\n");
   452                  return -EPERM;
   453          }
   454  
   455          /* Validate some of the fields */
   456          if ((firmware->count < 1) || (firmware->count > MAX_QE_RISC)) {
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This used to be capped at 2.


   457                  printk(KERN_ERR "qe-firmware: invalid data\n");
   458                  return -EINVAL;
   459          }
   460  
   461          /* Validate the length and check if there's a CRC */
   462          calc_size += (firmware->count - 1) * sizeof(struct qe_microcode);
   463  
   464          for (i = 0; i < firmware->count; i++)
   465                  /*
   466                   * For situations where the second RISC uses the same microcode
   467                   * as the first, the 'code_offset' and 'count' fields will be
   468                   * zero, so it's okay to add those.
   469                   */
   470                  calc_size += sizeof(__be32) *
   471                          be32_to_cpu(firmware->microcode[i].count);
   472  
   473          /* Validate the length */
   474          if (length != calc_size + sizeof(__be32)) {
   475                  printk(KERN_ERR "qe-firmware: invalid length\n");
   476                  return -EPERM;
   477          }
   478  
   479          /* Validate the CRC */
   480          crc = be32_to_cpu(*(__be32 *)((void *)firmware + calc_size));
   481          if (crc != crc32(0, firmware, calc_size)) {
   482                  printk(KERN_ERR "qe-firmware: firmware CRC is invalid\n");
   483                  return -EIO;
   484          }
   485  
   486          /*
   487           * If the microcode calls for it, split the I-RAM.
   488           */
   489          if (!firmware->split)
   490                  setbits16(&qe_immr->cp.cercr, QE_CP_CERCR_CIR);
   491  
   492          if (firmware->soc.model)
   493                  printk(KERN_INFO
   494                          "qe-firmware: firmware '%s' for %u V%u.%u\n",
   495                          firmware->id, be16_to_cpu(firmware->soc.model),
   496                          firmware->soc.major, firmware->soc.minor);
   497          else
   498                  printk(KERN_INFO "qe-firmware: firmware '%s'\n",
   499                          firmware->id);
   500  
   501          /*
   502           * The QE only supports one microcode per RISC, so clear out all the
   503           * saved microcode information and put in the new.
   504           */
   505          memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
   506          strlcpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
   507          qe_firmware_info.extended_modes = firmware->extended_modes;
   508          memcpy(qe_firmware_info.vtraps, firmware->vtraps,
   509                  sizeof(firmware->vtraps));
   510  
   511          /* Loop through each microcode. */
   512          for (i = 0; i < firmware->count; i++) {
   513                  const struct qe_microcode *ucode = &firmware->microcode[i];
   514  
   515                  /* Upload a microcode if it's present */
   516                  if (ucode->code_offset)
   517                          qe_upload_microcode(firmware, ucode);
   518  
   519                  /* Program the traps for this processor */
   520                  for (j = 0; j < 16; j++) {
   521                          u32 trap = be32_to_cpu(ucode->traps[j]);
   522  
   523                          if (trap)
   524                                  out_be32(&qe_immr->rsp[i].tibcr[j], trap);
                                                           ^^^^^^
   525                  }
   526  
   527                  /* Enable traps */
   528                  out_be32(&qe_immr->rsp[i].eccr, be32_to_cpu(ucode->eccr));
                                           ^^^^^^
These arrays only have 0x2 elements so we're beyond the end.

   529          }
   530  
   531          qe_firmware_uploaded = 1;
   532  
   533          return 0;

regards,
dan carpenter
