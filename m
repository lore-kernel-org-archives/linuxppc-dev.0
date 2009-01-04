Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58B5CDE18D
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 05:28:36 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n04IRYF1021250
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 05:27:34 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n04IOmkW224498
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 05:24:48 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n04IOmmd001146
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 05:24:48 +1100
Date: Sun, 4 Jan 2009 23:54:41 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Message-ID: <20090104182441.GA5086@linux.vnet.ibm.com>
References: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Milton Miller <miltonm@bga.com> [2009-01-04 02:54:15]:

> In-Reply-To: <20090103191359.GA9304@linux.vnet.ibm.com>
>
> Kamalesh Babulal wrote:
>>  config SCSI_IBMVSCSI
>>         tristate "IBM Virtual SCSI support"
>> -       depends on PPC_PSERIES || PPC_ISERIES
>> +       depends on (PPC_PSERIES || PPC_ISERIES) && VIOPATH
>>         select SCSI_SRP_ATTRS
>>         help
>>           This is the IBM POWER Virtual SCSI Client
>
> As VIOPATH is iSeries code and is only used by the iSeries code, the 
> requirment should be
>
> depends on PPC_PSERIES || (PPC_ISERIES && VIOPATH)
>
> except VIOPATH isn't selectable:
>
> arch/powerpc/platforms/iseries/Kconfig:
>
>  config VIOPATH
>         bool
>         depends on VIODASD || VIOCD || VIOTAPE || ISERIES_VETH
>         default y
>
> so instead we should be adding
>
> select VIOPATH if PPC_ISERIES
>
> to SCSI_IBMVSCSI and just
>
> select VIOPATH
>
> to HVC_ISERIES as it depends on PPC_ISERIES
>
> otherwise you have to enable one driver to get these other drivers.
>
> milton
>

Hi Milton,

	Thanks for the review comments, I am resending the patch with the 
changes you have recommended.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
 drivers/char/Kconfig |    1 +
 drivers/scsi/Kconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 1697043..b8da09a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -616,6 +616,7 @@ config HVC_ISERIES
 	default y
 	select HVC_DRIVER
 	select HVC_IRQ
+	select VIOPATH
 	help
 	  iSeries machines support a hypervisor virtual console.
 
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index b732297..256c7be 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -884,6 +884,7 @@ config SCSI_IBMVSCSI
 	tristate "IBM Virtual SCSI support"
 	depends on PPC_PSERIES || PPC_ISERIES
 	select SCSI_SRP_ATTRS
+	select VIOPATH if PPC_ISERIES
 	help
 	  This is the IBM POWER Virtual SCSI Client
 
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
