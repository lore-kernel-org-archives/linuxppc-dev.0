Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63D5EDDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 04:07:00 +1100 (EST)
Received: from d23relay03.au.ibm.com ([202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1IH76sM004596
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 04:07:06 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1IH6Opu4079792
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 04:06:24 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1IH6Nt3030474
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 04:06:24 +1100
Date: Mon, 18 Feb 2008 22:36:18 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@suse.de>
Subject: [PATCH-RESEND] next-20080218 build failure at pmac_ide_macio_attach ()
Message-ID: <20080218170618.GA7435@linux.vnet.ibm.com>
References: <20080218140159.GA31310@linux.vnet.ibm.com>
	<jeodae4acy.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jeodae4acy.fsf@sykes.suse.de>
Cc: sfr@canb.auug.org.au, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2008 at 03:17:49PM +0100, Andreas Schwab wrote:
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
> 
.
.
<snip>
> Just remove the cast.
> 
> Andreas.

Resending the patch after making the changes Andreas said.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Andreas Schwab <schwab@suse.de>
--
--- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 22:24:49.000000000 +0530
+++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 22:25:10.000000000 +0530
@@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	int irq, rc;
 	hw_regs_t hw;
 
-	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif = kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
@@ -1229,7 +1229,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		return -ENODEV;
 	}
 
-	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif = kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
