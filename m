Return-Path: <adobriyan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id F0DB4679FB
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jun 2006 02:17:05 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id l36so1321670nfa
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Jun 2006 09:17:04 -0700 (PDT)
Date: Sun, 4 Jun 2006 20:11:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
Message-ID: <20060604161124.GA7587@martell.zuzino.mipt.ru>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com>
	<20060602163035.05ab7c71.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060602163035.05ab7c71.akpm@osdl.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 02, 2006 at 04:30:35PM -0700, Andrew Morton wrote:
> > There is an endian issue in the sil24 driver.
> > The follwing pathc seems to fix it for me. (it is also attached in case
> > the mailer borks it for me)
> >
> > Signed-off-by: Rune Torgersen <runet@innovsys.com>
> >
> > Index: linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c
> > ===================================================================
> > --- linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(revision 101)
> > +++ linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(working copy)
> > @@ -446,7 +446,7 @@
> >  	 */
> >  	msleep(10);
> >
> > -	prb->ctrl = PRB_CTRL_SRST;
> > +	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
> >  	prb->fis[1] = 0; /* no PM yet */
> >
> >  	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
> > @@ -537,9 +537,9 @@
> >
> >  		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
> >  			if (qc->tf.flags & ATA_TFLAG_WRITE)
> > -				prb->ctrl = PRB_CTRL_PACKET_WRITE;
> > +				prb->ctrl =
> > cpu_to_le16(PRB_CTRL_PACKET_WRITE);
> >  			else
> > -				prb->ctrl = PRB_CTRL_PACKET_READ;
> > +				prb->ctrl =
> > cpu_to_le16(PRB_CTRL_PACKET_READ);

Are there some other fields that should be marked?

[PATCH] sata_sil24: endian annotations

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/sata_sil24.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -37,7 +37,7 @@
  * Port request block (PRB) 32 bytes
  */
 struct sil24_prb {
-	u16	ctrl;
+	__le16	ctrl;
 	u16	prot;
 	u32	rx_cnt;
 	u8	fis[6 * 4];
@@ -47,9 +47,9 @@ struct sil24_prb {
  * Scatter gather entry (SGE) 16 bytes
  */
 struct sil24_sge {
-	u64	addr;
-	u32	cnt;
-	u32	flags;
+	__le64	addr;
+	__le32	cnt;
+	__le32	flags;
 };
 
 /*
