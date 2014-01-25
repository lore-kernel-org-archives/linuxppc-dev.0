Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-wg0-x22a.google.com (mail-wg0-x22a.google.com
 [IPv6:2a00:1450:400c:c00::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0FDC72C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 11:47:44 +1100 (EST)
Received: by mail-wg0-f42.google.com with SMTP id l18so2439050wgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 16:47:39 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <20140108224529.GA4708@windriver.com>
References: <20140108224529.GA4708@windriver.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 24 Jan 2014 19:47:09 -0500
Message-ID: <CAP=VYLqOfubyQT+H3y0kn=v3dNHBfadm7uNtFDx6ugovyRPasg@mail.gmail.com>
Subject: Re: mpic build failure for 7447_hpc defconfig (bisected)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 8, 2014 at 5:45 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Commit 446f6d06fab0b49c61887ecbe8286d6aaa796637 ("powerpc/mpic: Properly
> set default triggers") breaks the mpc7447_hpc_defconfig as follows:
>
>   CC      arch/powerpc/sysdev/mpic.o
> arch/powerpc/sysdev/mpic.c: In function 'mpic_set_irq_type':
> arch/powerpc/sysdev/mpic.c:886:9: error: case label does not reduce to an integer constant
> arch/powerpc/sysdev/mpic.c:890:9: error: case label does not reduce to an integer constant
> arch/powerpc/sysdev/mpic.c:894:9: error: case label does not reduce to an integer constant
> arch/powerpc/sysdev/mpic.c:898:9: error: case label does not reduce to an integer constant
>
> Looking at the cpp output (gcc 4.7.3 from the kernel.org toolchains), I see:
>
>    case mpic->hw_set[MPIC_IDX_VECPRI_SENSE_EDGE] |
>         mpic->hw_set[MPIC_IDX_VECPRI_POLARITY_POSITIVE]:
>
> The pointer into an array appears because CONFIG_MPIC_WEIRD=y is set for
> this thing.
>
> -------------------
>   #ifdef CONFIG_MPIC_WEIRD
>   static u32 mpic_infos[][MPIC_IDX_END] = {
>         [0] = { /* Original OpenPIC compatible MPIC */
>
>   [...]
>
>   #define MPIC_INFO(name) mpic->hw_set[MPIC_IDX_##name]
>
>   #else /* CONFIG_MPIC_WEIRD */
>
>   #define MPIC_INFO(name) MPIC_##name
>
>   #endif /* CONFIG_MPIC_WEIRD */
> -------------------
>
>
> Given it has been broken since 3.4-rc5, is it safe to say MPIC_WEIRD is dead
> and unused?  Or should the case be converted to if/else or similar?  Or were
> other versions of gcc actually able to "see" constant numbers?

Ping.  I'll default to conversion to if/else since I don't see any other
solution that will solve thiis easily.  However I am tempted to delete
the abandonware platforms, if given a choice.  The 3.4 was quite some
time ago, and if nobody cared since then, well ....

P.
--

>
> Paul.
> --
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
