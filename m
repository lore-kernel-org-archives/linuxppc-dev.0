Return-Path: <mmarek@suse.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 716141A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 18:27:19 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D6FB91402BF
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 18:27:18 +1100 (AEDT)
Subject: Re: [PATCH] scripts/kconfig/Makefile: Fix KBUILD_DEFCONFIG check when
 building with O=
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1444889150-23609-1-git-send-email-mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Olof Johannsson <olof@lixom.net>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 yann.morin.1998@free.fr
From: Michal Marek <mmarek@suse.com>
Message-ID: <561F5552.4070902@suse.com>
Date: Thu, 15 Oct 2015 09:27:14 +0200
MIME-Version: 1.0
In-Reply-To: <1444889150-23609-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=iso-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dne 15.10.2015 v 08:05 Michael Ellerman napsal(a):
> My recent commit d2036f30cfe1 ("scripts/kconfig/Makefile: Allow
> KBUILD_DEFCONFIG to be a target"), contained a bug in that when it
> checks if KBUILD_DEFCONFIG is a file it forgets to prepend $(srctree) to
> the path.
> 
> This causes the build to fail when building out of tree (with O=), and
> when the value of KBUILD_DEFCONFIG is 'defconfig'. In that case we will
> fail to find the 'defconfig' file, because we look in the build
> directory not $(srctree), and so we will call Make again with
> 'defconfig' as the target. From there we loop infinitely calling 'make
> defconfig' again and again.
> 
> The fix is simple, we need to look for the file under $(srctree).
> 
> Fixes: d2036f30cfe1 ("scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be a target")
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Michal Marek <mmarek@suse.com>

I could have spotted it myself :-/.

Michal
