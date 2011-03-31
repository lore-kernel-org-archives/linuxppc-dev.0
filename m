Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C5F9B6F44
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2011 09:42:14 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2VMVtt2020551
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2011 18:31:55 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A0FA56E8036
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2011 18:42:11 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2VMgBm42633796
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2011 18:42:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2VMgAWt015993
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2011 19:42:11 -0300
Date: Thu, 31 Mar 2011 15:42:08 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac/mpc85xx: Limit setting/clearing of HID1[RFXE] to
	e500v1/v2 cores
Message-ID: <20110331224208.GA30426@us.ibm.com>
References: <1301610194-29971-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301610194-29971-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31.03.2011 [17:23:14 -0500], Kumar Gala wrote:
> Only the e500v1/v2 cores have HID1[RXFE] so we should attempt to set or
> clear this register bit on them.  Otherwise we get crashes like:

<snip>

> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index b123bb3..5aef2ed 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c

<snip>

> @@ -1209,10 +1215,15 @@ static void __exit mpc85xx_mc_restore_hid1(void *data)
>  static void __exit mpc85xx_mc_exit(void)
>  {
>  #ifdef CONFIG_FSL_SOC_BOOKE
> -	on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
> +	u32 pvr = mfspr(SPRN_PVR);
> +
> +	if ((PVR_VER(pvr) == PVR_VER_E500V1) ||
> +	    (PVR_VER(pvr) == PVR_VER_E500V2)) {
> +		on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
> +	}
>  #endif
>  #ifdef CONFIG_PCI
> -	of_unregister_platform_driver(&mpc85xx_pci_err_driver);
> +	of_unregistr_platform_driver(&mpc85xx_pci_err_driver);

Unintended change?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
