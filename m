Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 5F67C2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 11:21:52 +1000 (EST)
Received: from mail-vb0-f46.google.com (mail-vb0-f46.google.com
 [209.85.212.46])
 by muin.pair.com (Postfix) with ESMTPSA id CC1F78FC3E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 21:21:50 -0400 (EDT)
Received: by mail-vb0-f46.google.com with SMTP id p13so3861345vbe.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 18:21:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130925110643.db5fa154bea3838ed6affa45@canb.auug.org.au>
References: <20130925110643.db5fa154bea3838ed6affa45@canb.auug.org.au>
Date: Tue, 24 Sep 2013 20:21:50 -0500
Message-ID: <CAOZdJXUGD2dTpEodRgMfMVGQ8xor-RUYOGLAuECHMQVQGOuxvg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
From: Timur Tabi <timur@tabi.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
 Sergei Trofimovich <slyfox@gentoo.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 24, 2013 at 8:06 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Andrew,
>
> After merging the akpm tree, linux-next builds (powerpc allmodconfig)
> fail like this:
>
> drivers/tty/ehv_bytechan.c:362:1: error: type defaults to 'int' in declaration of 'console_initcall' [-Werror=implicit-int]
>
> Caused by commit 0f01cf96c2d4 ("./Makefile: enable -Werror=implicit-int
> and -Werror=strict-prototypes by default") which has bee in linux-next
> since Aug 16.  This commit exposed that fact that
> drivers/tty/ehv_bytechan.c can be built as a module, but has a
> console_initcall (which is not available to modules).

Is this something new?  This code hasn't changed in over two years, so
I'm surprised it suddenly broke.

> This was
> originally introduced in commit dcd83aaff1c8 ("tty/powerpc: introduce the
> ePAPR embedded hypervisor byte channel driver") in v3.2.
>
> Anyone got a good solution?

How about:

#ifndef MODULE

static int __init ehv_bc_console_init(void)
{
    ...
}
console_initcall(ehv_bc_console_init);
#endif
