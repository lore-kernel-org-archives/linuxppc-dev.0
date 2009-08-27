Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8BA06B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 06:55:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7348DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 06:55:17 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090827110545.GJ5387@hansolo.jdub.homelinux.org>
References: <1251344028.20467.8.camel@pasglop>
	<20090827110545.GJ5387@hansolo.jdub.homelinux.org>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 06:55:10 +1000
Message-Id: <1251406510.20467.54.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-27 at 07:05 -0400, Josh Boyer wrote:
> On Thu, Aug 27, 2009 at 01:33:48PM +1000, Benjamin Herrenschmidt wrote:
> >Hi Linus !
> >
> >Here are a couple of last minute patches for 2.6.31. One is a regression fix
> >(afaik) where a PS3 driver gets incorrectly loaded on other platforms and
> >crashes, along with a PS3 defconfig update.
> >The following changes since commit f415c413f458837bd0c27086b79aca889f9435e4:
> >  Linus Torvalds (1):
> >        Merge git://git.kernel.org/.../davem/net-2.6
> >
> >are available in the git repository at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
> >
> >Geert Uytterhoeven (1):
> >      powerpc/ps3: Add missing check for PS3 to rtc-ps3 platform device registration
> >
> >Geoff Levand (1):
> >      powerpc/ps3: Update ps3_defconfig
> 
> Hm.  No 44x flush_icache_range patch?

Well, the ps3 stuff is a regression that will crash the machine on boot
with some of the default configs... the 44x icache problem is not a
regression and will cause some obscure ltrace behaviour issues. So the
later is less high priority and I prefer having it in .32 and then send
back to -stable.

Cheers,
Ben.
