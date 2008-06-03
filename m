Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5618DE2D6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 01:14:47 +1000 (EST)
Message-Id: <57B740A4-A3E0-4D93-A5D9-77B14C6E9E92@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48455EEA.3040909@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Make board force selection of PHYLIB
Date: Tue, 3 Jun 2008 10:14:33 -0500
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
	<83820D83-487C-4586-9867-F4226A87A276@freescale.com>
	<48445851.4090105@garzik.org>
	<095F258F-72DD-4F27-A457-A57D9FAA1E76@kernel.crashing.org>
	<48448020.5020407@freescale.com>
	<Pine.LNX.4.64.0806030945540.21537@blarg.am.freescale.net>
	<48455EEA.3040909@freescale.com>
Cc: netdev@vger.kernel.org, adrian.bunk@movial.fi,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2008, at 10:10 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> How is this as a fix.
>> - k
>> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
>> platforms/85xx/Kconfig
>> index 7ff29d5..9e5c884 100644
>> --- a/arch/powerpc/platforms/85xx/Kconfig
>> +++ b/arch/powerpc/platforms/85xx/Kconfig
>> @@ -34,6 +34,7 @@ config MPC85xx_MDS
>> 	bool "Freescale MPC85xx MDS"
>> 	select DEFAULT_UIMAGE
>> 	select QUICC_ENGINE
>> +	select PHYLIB if GIANFAR=m
>> 	help
>> 	  This option enables support for the MPC85xx MDS board
>
> I assume you'll also ifdef-protect the phy calls in the platform code?

yes this needs to get done.

> I'd rather avoid adding another case where the kernel needs to know  
> what modules are being built, though, especially if the result of  
> changing the .config and building modules is a mysterious runtime  
> failure (due to a missing platform fixup) rather than compile- or  
> insertion-time.

I don't follow what you are getting at here.  Is this something more  
than #ifdef PHYLIB in the platform code?

- k
