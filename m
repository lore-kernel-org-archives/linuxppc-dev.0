Return-Path: <linus971@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0BF2EB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2012 15:25:05 +1100 (EST)
Received: by eeke50 with SMTP id e50so590541eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 21:25:02 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
References: <5599.1332958811@redhat.com> <30702.1332989444@neuling.org>
 <20120329135555.06593144b65bf81cc9191f8a@canb.auug.org.au>
 <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Mar 2012 21:24:41 -0700
Message-ID: <CA+55aFzn=bsH76hPDUgS-FBP=RVu51gwmRdqjkw5RJO=Q_cRfA@mail.gmail.com>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, paul.gortmaker@windriver.com,
 hpa@zytor.com, akpm@linux-foundation.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2012 at 9:15 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
>
> The following patch fixes (as much as possible) a powerpc allyesconfig bu=
ild.

Ugh:

> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index af48e59..1f94ddf 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -12,6 +12,9 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/smp.h>
> =A0#include <linux/fs.h>
> +#ifdef CONFIG_VIRQ_DEBUG
> +#include <asm/debug.h>
> +#endif

Can we please move that abortion into arch/powerpc/? Instead of making
generic code even uglier..

                       Linus
