Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E588EDDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 03:30:09 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 2/9] autoselect optimal -mcpu= flag by platform
Date: Sun, 17 Jun 2007 19:20:10 +0200
References: <20070616000511.712667424@arndb.de>
	<20070616000618.314570319@arndb.de>
	<91EBCC0C-48B7-4748-A936-E74CEB7685E0@kernel.crashing.org>
In-Reply-To: <91EBCC0C-48B7-4748-A936-E74CEB7685E0@kernel.crashing.org>
MIME-Version: 1.0
Message-Id: <200706171920.10898.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 17 June 2007, you wrote:
> 
> On Jun 15, 2007, at 7:05 PM, arnd@arndb.de wrote:
> 
> > We can choose the -mcpu= gcc flags for compiling the kernel
> > based on the platform that we build for. In case of multiplatform
> > kernels, this chooses a setting for a common subset.
> >
> > When using a platform type that can use different CPUs, a
> > new option CONFIG_PPC_CPU_SELECTION can be enabled to select
> > more specifically which CPUs the kernel will be able to
> > run on.
> >
> > This replaces the CONFIG_POWER4_ONLY option with an much more
> > generic approach.
> >
> > Also, when CONFIG_PPC_CPU_SELECTION is set, it is now possible
> > to select a CPU to tune for by means of the -mtune= option.
> >
> > I tried to be very careful when coding the specific rules into
> > the Kconfig language, but it would be good to have a few
> > people sanity-checking them.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Is there a reason we don't distinguish between 7400/7410 and 74{4,5} 
> x?  Is it because we dont have any discrete systems with just a 7400  
> on it?

No, I just didn't know that there was a difference. I had looked at the
gcc source and found that gcc produces the same instruction for both,
but I didn't bother to look at the optimizations. From all I can
tell, -mcpu=7400 is identical to -mcpu=7450 -mtune=750.

Can you look through the patch again to see which of the platforms
that have a 7400 instead of 7450 type CPUs?

> Also I'd suggest we have the config options be a 1:1 matching for the  
> -mcpu/-mtune options in gcc for the following cases:
> 
> > +	default "-mcpu=750" if CPU_7xx
> > +	default "-mcpu=7450" if CPU_74xx
> > +	default "-mcpu=860" if PPC_8xx
> > +	default "-mcpu=8540" if PPC_85xx
> 
> So if in the future we have code scheduling for 8599 or some other  
> variant we don't have to go change the Kconfig just add to it.

I'm not sure I understand what you would like to see this, would you
like them to be simply renamed to CPU_750/CPU_7450/CPU_860/CPU_8540
or rather add more options for 740/801/821/823/8548, which are
treated as aliases of the others?

For 74xx, I guess you already convinced me and for 85xx, I'll trust
your word if you think that we will need future flags in the future.

I'm not so sure about 7xx and 8xx though. I could not find any
code in gcc that knows about the difference between the CPUs in
either family, and it doesn't seem like anyone is working on
changing that. Anything I missed there?

	Arnd <><
