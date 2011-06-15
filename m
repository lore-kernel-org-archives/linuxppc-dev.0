Return-Path: <nacc@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98286B6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 05:18:14 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5FIs1Cv022974
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 14:54:01 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5FJI9I1051488
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 15:18:09 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5FDHtwf027335
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 07:17:55 -0600
Date: Wed, 15 Jun 2011 12:17:47 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: jgarzik@pobox.com
Subject: libata/ipr/powerpc: regression between 2.6.39-rc4 and 2.6.39-rc5
Message-ID: <20110615191747.GA6324@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, tj@kernel.org, mbizon@freebox.fr,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeff,

It appears that commit 7b3a24c57d2eeda8dba9c205342b12689c4679f9 broke
CD-ROMs on the IPR SATA bus on powerpc machines:

 ata_port_alloc: ENTER
 ata_port_probe: ata1: bus probe begin
 ata1.00: ata_dev_read_id: ENTER
 ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
 ata1.00: ata_dev_read_id: ENTER
 ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
 ata1.00: limiting speed to UDMA7:PIO5
 ata1.00: ata_dev_read_id: ENTER
 ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
 ata1.00: disabled
 ata_port_probe: ata1: bus probe end
 scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured

The commit in question is tagged as AHCI, but does touch the libata
core. I'm not well-versed with this code, but here's what I think I know
:)

>From __scsi_add_device, we first allocate the target:

 scsi_alloc_target ->
  shost->hostt->target_alloc ->
   ipr_target_alloc ->
    ata_port_alloc ->
     sets FROZEN

We error out when we allocate the sdev:

 scsi_alloc_sdev ->
  shost->hostt->slave_alloc ->
   ipr_slave_alloc ->
    ipr_ata_slave_alloc ->
     ata_sas_port_init ->
      ata_port_probe

>From what I can tell, the only place that explicitly clears the FROZEN
flag is the error-handling code via ata_eh_thaw_port().

So I thought either we're not invoking the error-handler at probe time
correctly to kick the port or perhaps the SAS code is not clearing the
flag?

I tried the following patch:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d51f979..abd0e0b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3797,6 +3797,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
  */
 int ata_sas_port_start(struct ata_port *ap)
 {
+       ap->pflags &= ~ATA_PFLAG_FROZEN;
        return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_start);

and the CD-ROM drive works, but I have no idea if it's the right thing
to do. I chose this particular change, FWIW, because we call
ata_sas_port_start before we probe in ata_sas_port_init and it seems
like we need to mark the port as not frozen before we init it? Perhaps
that should really be a call to a thaw function, not sure. Let's just
say the ATA/SAS/SCSI interactions are a bit hard to follow at first :)

Any insight you can provide would be great!

Thanks,
Nish


-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
