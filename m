Return-Path: <jwboyer@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
 [209.85.213.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09FE2B6EE7
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 00:29:44 +1100 (EST)
Received: by yenl5 with SMTP id l5so871757yen.15
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 06:29:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F69C553.6070409@gmail.com>
References: <4F69C553.6070409@gmail.com>
Date: Wed, 21 Mar 2012 09:29:41 -0400
Message-ID: <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
From: Josh Boyer <jwboyer@gmail.com>
To: robert.karl.berger@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2012 at 8:10 AM, Robert Berger
<robert.karl.berger@gmail.com> wrote:
> Hi,
>
> Up to 3.2.x I was able to compile a mainline kernel for the kilauea
> board, but...
>
> http://git.denx.de/?p=linux-denx.git;a=commitdiff;h=075bcf5879225d0c2a119c23d8046b890e051e81
>
> shows, that mfdcrx was introduced in the v3.3 kernel.
>
> The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes with the
> ELDK 4.2) this assembly instruction is not known and the build breaks.

Sigh.  GCC 4.2 is pretty old at this point.

> There are some obvious workarounds, like using a more recent toolchain
> (e.g ELDK 5.x) or use make -k to keep on compiling even when there is an
> error as much as possible;)

That would be the most expedient option, yes.

> What puzzles me is that also stuff for boards is being compiled which is
> not really needed like treeboot-currituck.c even when I configure the
> kernel for a kilauea board.
>
> Is this on purpose and if so why?

All of the stuff in arch/powerpc/boot/ is built regardless of the
configured board and stuffed into a wrapper.a archive.  Then the
individual board targets are built and the necessary pieces are pulled
from the wrapper.a file.

> Please advise.

If upgrading ELDK is an option for you, it will get you the quickest
solution.  Otherwise we'll need to figure out how to stub out the
instruction in boot/dcr.h and use the asm long trick.  Ew.  I can look
at that next week.

josh
