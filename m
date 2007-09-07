Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id DF843DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 22:24:41 +1000 (EST)
Message-ID: <46E14306.9040200@anagramm.de>
Date: Fri, 07 Sep 2007 14:24:38 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: random panic and freezes on mpc8349 itx
References: <200709071405.06500.nschichan@freebox.fr>
In-Reply-To: <200709071405.06500.nschichan@freebox.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Nicolas!

Nicolas Schichan schrieb:
> Hi,
> 
> I am currently working with an MPC8349ITX board and I have some trouble with 
> the kernel as soon as it reaches userland.
> 
> If I boot the kernel with all the memory (256MB) available (no mem=... on the 
> command line), I get random freezes or random kernel panics. Some times it 
> won't even run init. Some times it will panic badly if I try to put some 
> pressure to the system (stress --cpu 256). Some times it will hang 
> immediately after logging in, ...

Just some ideas how I prefer to roughly track down random crashes:

Check if the problems dependend of supply voltages, grounding or temperature.
Mounting a prototype to an aluminum board improved uptime a lot in one case.
If you don't see any variations at all, I would guess it's a problem caused
by software.

> If I boot the kernel with mem=64M, these freeze and random panic disapear and 
> I am able to run the stress program without any problems.
> 
> I have had this strange behaviour on both kernel 2.6.20 and 2.6.22 with 
> mpc834x_itx_defconfig (both from kernel.org) (ARCH=powerpc).
> 
> I am inclined to say that it is not a broken RAM chip problem because if I use 
> a 2.6.17 from kernel.org with all the RAM available (ARCH=ppc) configured 
> with mpc834x_sys_defconfig (there was no defconfig for the itx board on this 
> version) everything runs fine and I am able to run the stress program without 
> any problems.

Hmm... check the cpu/memory timing manually (by dumping some registers) and compare.
The two ARCHitectures might do things quite different in the meanwhile.
Otherwise, if you can stay within one ARCH, git bisect might be your friend here.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
