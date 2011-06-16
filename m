Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6968DB6FB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 01:28:48 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5GF4R91031025
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 11:04:27 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5GFSeZp137834
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 11:28:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5GBSRVt026811
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 08:28:28 -0300
Date: Thu, 16 Jun 2011 08:28:36 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
Message-ID: <20110616152836.GA15268@us.ibm.com>
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
	<20110615233417.GB6324@us.ibm.com>
	<20110616075114.GH8141@htj.dyndns.org>
	<4DFA0507.3090609@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DFA0507.3090609@linux.vnet.ibm.com>
Cc: jgarzik@pobox.com, wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	mbizon@freebox.fr, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.06.2011 [08:28:39 -0500], Brian King wrote:
> On 06/16/2011 02:51 AM, Tejun Heo wrote:
> > On Wed, Jun 15, 2011 at 04:34:17PM -0700, Nishanth Aravamudan wrote:
> >>> That looks like the right thing to do. For ipr's usage of
> >>> libata, we don't have the concept of a port frozen state, so this flag
> >>> should really never get set. The alternate way to fix this would be to
> >>> only set ATA_PFLAG_FROZEN in ata_port_alloc if ap->ops->error_handler
> >>> is not NULL.
> >>
> >> It seemed like ipr is as you say, but I wasn't sure if it was
> >> appropriate to make the change above in the common libata-scis code or
> >> not. I don't want to break some other device on accident.
> >>
> >> Also, I tried your suggestion, but I don't think that can happen in
> >> ata_port_alloc? ata_port_alloc is allocated ap itself, and it seems like
> >> ap->ops typically gets set only after ata_port_alloc returns?
> > 
> > Maybe we can test error_handler in ata_sas_port_start()?
> 
> Good point. Since libsas is converted to the new eh now, we would need to have
> this test.

Commit 7b3a24c57d2eeda8dba9c205342b12689c4679f9 ("ahci: don't enable
port irq before handler is registered") caused a regression for CD-ROMs
attached to the IPR SATA bus on Power machines:

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

The FROZEN flag added in that commit is only cleared by the new EH code,
which is not used by ipr. Clear this flag in the SAS code if we don't
support new EH.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d51f979..ebe1685 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3797,6 +3797,12 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
  */
 int ata_sas_port_start(struct ata_port *ap)
 {
+	/*
+	 * the port is marked as frozen at allocation time, but if we don't
+	 * have new eh, we won't thaw it
+	 */
+	if (!ap->ops->error_handler)
+		ap->pflags &= ~ATA_PFLAG_FROZEN;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_start);


-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
