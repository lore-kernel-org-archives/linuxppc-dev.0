Return-Path: <peerlessdeepaks@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id ECDB5DDDD4
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 05:33:41 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1574733wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 10:33:40 -0800 (PST)
Message-ID: <cbaa36330811141033y305285f9r97489ad5f85dd002@mail.gmail.com>
Date: Sat, 15 Nov 2008 00:03:40 +0530
From: "Deepak Pandian" <peerlessdeepaks@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Canyonlands PCIE Interrupt Handler
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to implement a platform driver for msi.  Whenever I write
in to the PCIE-IH space, the kernel stops abruptly and the system is
reset.

 Below is the part of the code which lead me to the brick wall!

I am getting the PCIEIH base addr  from dts .
          if (of_address_to_resource(dn, 0,&pcieih_reg)) {

                printk(KERN_ERR "%s: Can't get PCIEIH Resource !",

                       dn->full_name);

                return -1;

       	 }

	
        pcieih_base = ioremap(pcieih_reg.start, pcieih_reg.end + 1 -
pcieih_reg.start);
        out_be32(pcieih_base + PEIH_TERMADL, PPC4XX_PCIE_MSI_LADDR)

       Whenever I try to access the registers in PCIE-IH space the
device gets restarted.


I have one more clarification to be made. The datasheet says that the
PCIE-IH  registers are implemented at EF62 0000. But the SDR registers
- PESDRn_PEIHS1 and PESDRn_PEIHS2 reset value is c00100000.

When I read the SDR registers I am getting only 000000 instead of the
specified reset value.

 sdrbase = of_get_property(dn, "sdr-base", NULL);

        if (sdrbase == NULL) {

                printk(KERN_ERR "PCIEIH-msi: missing sdr-base for %s\n",

                       dn->full_name);

                return -1;

        }

        sdr_base = *sdrbase;

	printk("SDR_BASE :%08x \n", sdr_base);	

	mtdcri(SDR0,sdr_base + PESDRn_PEIHS1, baseaddrhi);

    	mtdcri(SDR0,sdr_base + PESDRn_PEIHS2, baseaddrlow);

   I have tried both with ef62 0000 and c00100000 but both didnt help.
Expecting your guidance to proceed further!

--
With Regards,
Deepak Pandian
"Time is precious,One day we will find that we have less than what we
think" -RandyPausch
