Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id 0456EDE43C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 18:30:16 +1100 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id F284081D2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 08:30:14 +0100 (CET)
Date: Tue, 6 Jan 2009 08:31:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Message-ID: <20090106073149.GA12371@uranus.ravnborg.org>
References: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
	<20090104182441.GA5086@linux.vnet.ibm.com>
	<98d6aef17cba9d835d7866745f811dc7@bga.com>
	<20090106072549.GA5066@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090106072549.GA5066@linux.vnet.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> 	Sorry for resending the patch before taking care of the response. Resending 
> the patch with changes made to other three drivers also.
> 
> Impact: Fix the VIOPATH dependency in the iSeries dependent drivers.
> 
> iSeries depend drivers build fails, when CONFIG_VIOPATH is disabled.
> Removing the dependency of VIOPATH by selecting it, when the drivers
> dependent on iSeries code.
> 
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/iseries/Kconfig |    5 ++++-
>  drivers/char/Kconfig                   |    1 +
>  drivers/scsi/Kconfig                   |    1 +
>  3 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
> index ed3753d..5cb2320 100644
> --- a/arch/powerpc/platforms/iseries/Kconfig
> +++ b/arch/powerpc/platforms/iseries/Kconfig
> @@ -10,18 +10,21 @@ menu "iSeries device drivers"
>  config VIODASD
>  	tristate "iSeries Virtual I/O disk support"
>  	depends on BLOCK
> +	select VIOPATH
>  	help
>  	  If you are running on an iSeries system and you want to use
>  	  virtual disks created and managed by OS/400, say Y.
>  
>  config VIOCD
>  	tristate "iSeries Virtual I/O CD support"
> +	select VIOPATH
>  	help
>  	  If you are running Linux on an IBM iSeries system and you want to
>  	  read a CD drive owned by OS/400, say Y here.
>  
>  config VIOTAPE
>  	tristate "iSeries Virtual Tape Support"
> +	select VIOPATH
>  	help
>  	  If you are running Linux on an iSeries system and you want Linux
>  	  to read and/or write a tape drive owned by OS/400, say Y here.
> @@ -30,5 +33,5 @@ endmenu
>  
>  config VIOPATH
>  	bool
> -	depends on VIODASD || VIOCD || VIOTAPE || ISERIES_VETH
> +	depends on PPC_ISERIES
>  	default y

VIOPATH is set using select so the "depends on" is effectively ignored.
If you think you need the "depends on" then you need to revisit the
symbol that will select VIOPATH and make sure _they_ have this dependency.

	Sam
