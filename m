Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id A6267B7D81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 01:00:16 +1000 (EST)
Date: Fri, 14 May 2010 00:00:10 +0900
From: Simon Horman <horms@verge.net.au>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc new toolchains fix (crt.S)
Message-ID: <20100513150008.GC10534@verge.net.au>
References: <20100512070841.9572.78661.stgit@muvarov>
	<20100512070849.9572.84728.stgit@muvarov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100512070849.9572.84728.stgit@muvarov>
Cc: lists@nerdbynature.de, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 12, 2010 at 11:08:49AM +0400, Maxim Uvarov wrote:
> 
> Hello everybody,
> 
>       Changes from previous version:
>       - removed bogus hyphen from the patch;
>       - move ifdefs to crt.S instead of Makefile
> 
> 
>       Please find here patch for user land kexec-tools application. Following
>       patch makes kexec-tools work for both kexec and kdump. I tested it with 
>       git kernel (linus-tree) and Freescale/Logic MPC8360ERDK board with 
>       mpc83xx_defconfig kernel config.
> 
>       kexec:
>       kexec -l vmlinux --command-line="console= ... etc"
>       kexec -e
> 
>       kdump:
>       kexec -p vmlinux_dump --command-line="console=... etc"
>       echo c > /proc/sysrq-trigger
> 
>       I also think that is is reasonable:
>       - put GAME_CUBE specific code to separate files;
>       - combine  ppc and ppc64 to powerpc directory (I'm planning to do it.
> 	And that why in some places my patch have ifdefs for PPC64);
> 
> Best regards,
> Maxim Uvarov.

Thanks,

I'm assuming that the silence that this patch set received,
in contrast to the first revision where there was some quick discussion,
means that everyone is ok with these changes. So I've gone ahead and pushed
them into the tree.

> From: Maxim Uvarov <muvarov@gmail.com>
> 
> Linker does not provide some vital functions when building freestanding
> applications with a new toolchain, so we have to provide our own CRT.
> 
> p.s.
> Without the CRT we won't see any build errors (since the purgatory is
> linked with --no-undefined), but the purgatory code won't work,
> 'kexec -e' will just hang the board.
> 
> 
> I added option to configure to keep code buildable for old toolchais.
> But there should be way to do this automatically.

I seem to have an old toolchain :-)

> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
