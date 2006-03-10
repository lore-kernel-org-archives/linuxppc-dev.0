Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 99ECB679F5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 19:20:59 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 7E455FB87C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 08:52:43 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 64D7FFB87C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 08:52:43 +0100 (CET)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id E91721EA525
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 08:52:42 +0100 (CET)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.15-rc5-latest doesn't work anymore on mpc8540ads
Date: Fri, 10 Mar 2006 08:52:33 +0100
References: <Pine.LNX.4.44.0512191437460.4403-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0512191437460.4403-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603100852.34088.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
Has the knowledge about this issue advanced?
What I have noticed so far is that the same happens in 2.6.14, therefore the 
problem rose in the transition from 2.6.13.
Would this be related to the IRQ stuff initialization? Any guess?

On Monday 19 December 2005 21:38, Kumar Gala wrote:
> On Mon, 19 Dec 2005, Clemens Koller wrote:
> > Hello!
> >
> > Here is a little update:
> > > I am just about to update my kernel from 2.6.13-rc7 which is working
> > > fine to linus' 2.6.15-rc5-latest git on my mpc8540ads flavored board.
> > > However, the kernel hangs pretty early after
> > >
> > > openpic: exit
> >
> > openpic_init() is called by mpc85xx_ads_init_IRQ in ppc/platforms/85xx
> >
> > ppc_md.init_IRQ=mpc85xx_ads_init_IRQ in ppc/platforms/85xx
> >
> > ppc_md.init_IRQ() is called from powerpc/kernel/irq.c
> >
> > init_IRQ() is  called from init/main.c:start_kernel()
> >
> > and that seems to work fine. So, it crashes silently somewhere
> > after that point. I try to build 2.6.15-rc6-latest with kgbd support,
> > not knowing if it's supposed to work on this platform.
>
> It was a guess :)
>
> > Are there some open issues from the ppc->powerpc migration?
>
> possible, can you use git bisect to find what commit may have caused the
> issue?
>
> - kumar
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Carlos Mitidieri
