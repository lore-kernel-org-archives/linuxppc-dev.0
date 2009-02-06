Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23BD8DDE11
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:04:57 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n16G4rAY005398
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2009 09:04:54 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n16G4rkY022179
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2009 10:04:53 -0600 (CST)
Date: Fri, 6 Feb 2009 10:04:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Build breakage for CONFIG_PM but no CONFIG_SUSPEND
Message-ID: <20090206160452.GB1641@ld0162-tx32.am.freescale.net>
References: <1436.1233879027@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436.1233879027@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 06, 2009 at 11:10:27AM +1100, Michael Neuling wrote:
> I noticed this doing some randconfig testing (.config below).  I have
> CONFIG_PM but no CONFIG_SUSPEND.  Bug is against mainline.  
> 
> arch/powerpc/sysdev/built-in.o: In function `ipic_suspend':
> ipic.c:(.text+0x6b34): undefined reference to `fsl_deep_sleep'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
> 
> Looks like #ifdef CONFIG_PM in arch/powerpc/sysdev/ipic.c should be
> CONFIG_SUSPEND.  d49747bdfb2ddebea24d1580da55b79d093d48a9 introduced
> this.
> 
> Maybe this fixes it?
> 
> 
> Fix build when we have CONFIG_PM but no CONFIG_SUSPEND.  

ACK.  That was a leftover from before CONFIG_SUSPEND was introduced.

-Scott
