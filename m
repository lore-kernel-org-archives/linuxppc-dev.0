Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6784867A5C
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 09:27:41 +1000 (EST)
Date: Fri, 2 Jun 2006 16:30:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
Message-Id: <20060602163035.05ab7c71.akpm@osdl.org>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Rune Torgersen" <runet@innovsys.com> wrote:
>
> > -----Original Message-----
> > From: Rune Torgersen
> > Sent: Thursday, June 01, 2006 16:10
> > To: linuxppc-dev@ozlabs.org
> > Subject: SII3124-2
> > 
> > Has anybody been successful in getting a SII3124-2 based SATA 
> > controller
> > to work under PPC?
> > 
> > I have a eval board that I tried on two different freescale boards (a
> > MPC8266ADS board and a MPC8560ADS board).
> > Kernel 2.6.16.16.
> > 
> > Here is the relevant output from the kernel.
> > 
> > ata1: SATA max UDMA/100 cmd 0xD1010000 ctl 0x0 bmdma 0x0 irq 115
> > ata2: SATA max UDMA/100 cmd 0xD1012000 ctl 0x0 bmdma 0x0 irq 115
> > ata3: SATA max UDMA/100 cmd 0xD1014000 ctl 0x0 bmdma 0x0 irq 115
> > ata4: SATA max UDMA/100 cmd 0xD1016000 ctl 0x0 bmdma 0x0 irq 115
> > ata1: SATA link down (SStatus 0)
> > scsi0 : sata_sil24
> > ata2: SATA link up 3.0 Gbps (SStatus 123)
> > sata_sil24 ata2: SRST failed, disabling port
> > scsi1 : sata_sil24
> > ata3: SATA link down (SStatus 0)
> > scsi2 : sata_sil24
> > ata4: SATA link down (SStatus 0)
> > scsi3 : sata_sil24
> > 
> > I added debug output to see the content of the Command Error register.
> > It is set to 26 which according to the datasheet for the 3124-1 (I am
> > running a -2), is PLDCMDERRORMASTERABORT, "A PCI Master Abort occurred
> > while the SiI3124 was fetching a Port Request Block (PRB) from host
> > memory."
> 
> There is an endian issue in the sil24 driver. 
> The follwing pathc seems to fix it for me. (it is also attached in case
> the mailer borks it for me)
> 
> Signed-off-by: Rune Torgersen <runet@innovsys.com>
> 
> Index: linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c
> ===================================================================
> --- linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(revision 101)
> +++ linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(working copy)
> @@ -446,7 +446,7 @@
>  	 */
>  	msleep(10);
>  
> -	prb->ctrl = PRB_CTRL_SRST;
> +	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
>  	prb->fis[1] = 0; /* no PM yet */
>  
>  	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
> @@ -537,9 +537,9 @@
>  
>  		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
>  			if (qc->tf.flags & ATA_TFLAG_WRITE)
> -				prb->ctrl = PRB_CTRL_PACKET_WRITE;
> +				prb->ctrl =
> cpu_to_le16(PRB_CTRL_PACKET_WRITE);
>  			else
> -				prb->ctrl = PRB_CTRL_PACKET_READ;
> +				prb->ctrl =
> cpu_to_le16(PRB_CTRL_PACKET_READ);
>  		} else
>  			prb->ctrl = 0;
>  

This bug has been fixed in the current libata development tree.

This bug is present in 2.6.16 and is present in 2.6.17-rc.  Probably we
should merge Rune's above patch into Linus's tree and into 2.6.16.x.

Jeff ack?
