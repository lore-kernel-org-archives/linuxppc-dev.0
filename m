Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1F17BDDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 06:48:40 +1000 (EST)
Date: Fri, 29 Jun 2007 13:47:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Jason Wessel
	<jason.wessel@windriver.com>, Michal Marek <mmarek@suse.cz>
Subject: Re: 2.6.22-rc6-mm1
Message-Id: <20070629134748.71adba1e.akpm@linux-foundation.org>
In-Reply-To: <200706291432.10128.m.kozlowski@tuxland.pl>
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>
	<200706291432.10128.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: xfs-masters@oss.sgi.com, xfs@oss.sgi.com, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Jun 2007 14:32:09 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	allmodconfig on powerpc (iMac g3) fails due to
> git-kgdb.patch. allmodconfig defaults should be changed?
> 
>   CC      arch/powerpc/kernel/kgdb.o
> arch/powerpc/kernel/kgdb.c:485:2: error: #error Both XMON and KGDB selected 
> in .config. Unselect one of them.
> make[1]: *** [arch/powerpc/kernel/kgdb.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2

Jason cc'ed

> anyway after unselecting XMON we can see:
> 
>   CC [M]  fs/xfs/linux-2.6/xfs_ioctl32.o
> fs/xfs/linux-2.6/xfs_ioctl32.c: In function 'xfs_ioc_bulkstat_compat':
> fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: 'xfs_inumbers_fmt_compat' 
> undeclared (first use in this function)
> fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: (Each undeclared identifier is 
> reported only once
> fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: for each function it appears in.)
> make[2]: *** [fs/xfs/linux-2.6/xfs_ioctl32.o] Blad 1
> make[1]: *** [fs/xfs] Blad 2
> 
> This is just allmodconfig - not a .config that's used daily by users but I'm 
> used to compiling the kernel using it anyway 8)
> 

Michal cc'ed.  I think this is the one which was already reported but
I haven't seen a fix yet?
