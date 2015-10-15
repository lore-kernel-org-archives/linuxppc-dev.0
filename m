Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 577CC1A0679
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 20:38:06 +1100 (AEDT)
Message-ID: <1444901885.8464.1.camel@ellerman.id.au>
Subject: Re: [PATCH] scripts/kconfig/Makefile: Fix KBUILD_DEFCONFIG check
 when building with O=
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Marek <mmarek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Olof Johannsson <olof@lixom.net>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 yann.morin.1998@free.fr
Date: Thu, 15 Oct 2015 20:38:05 +1100
In-Reply-To: <561F5552.4070902@suse.com>
References: <1444889150-23609-1-git-send-email-mpe@ellerman.id.au>
 <561F5552.4070902@suse.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-15 at 09:27 +0200, Michal Marek wrote:
> Dne 15.10.2015 v 08:05 Michael Ellerman napsal(a):
> > My recent commit d2036f30cfe1 ("scripts/kconfig/Makefile: Allow
> > KBUILD_DEFCONFIG to be a target"), contained a bug in that when it
> > checks if KBUILD_DEFCONFIG is a file it forgets to prepend $(srctree) to
> > the path.
> > 
> > This causes the build to fail when building out of tree (with O=), and
> > when the value of KBUILD_DEFCONFIG is 'defconfig'. In that case we will
> > fail to find the 'defconfig' file, because we look in the build
> > directory not $(srctree), and so we will call Make again with
> > 'defconfig' as the target. From there we loop infinitely calling 'make
> > defconfig' again and again.
> > 
> > The fix is simple, we need to look for the file under $(srctree).
> > 
> > Fixes: d2036f30cfe1 ("scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be a target")
> > Reported-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Acked-by: Michal Marek <mmarek@suse.com>
> 
> I could have spotted it myself :-/.

It was pretty easy to miss in the diff, especially as the kconfig invocation
doesn't use $(srctree).

I should have noticed it in my testing, but it didn't actually break powerpc,
so the only clue was that the message says "based on target". Anyway fixed now
hopefully.

cheers
