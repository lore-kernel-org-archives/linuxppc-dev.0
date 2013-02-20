Return-Path: <b08248@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B39692C007C
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2013 01:22:54 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id un15so2915203pbc.10
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 06:22:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1361303278.29654.7@snotra>
References: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
 <1360887119.22260.10.camel@pasglop>
 <511E513F.7090103@freescale.com> <1361303278.29654.7@snotra>
Date: Wed, 20 Feb 2013 08:22:52 -0600
Message-ID: <CALRxmdCpS6cJ6kJ=cg4Mre6YA572fxyk+596E1k1MX+iRL7s9Q@mail.gmail.com>
Subject: Re: [PATCH][RFC] Replaced tlbilx with tlbwe in the initialization code
From: Stuart Yoder <b08248@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Diana Craciun <diana.craciun@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 19, 2013 at 1:47 PM, Scott Wood <scottwood@freescale.com> wrote:
>
> This patch addresses boot-time invalidations only.  How will you handle
> hugetlb invalidations (or indirect entry invalidations, once that becomes
> supported)?

We do envision that "direct guest TLB management" is an opt-in option
that a guest can enable.

If LRAT is on, with TLB management directly handled by guests, the only
mechanism we have to do TLB1 invalidates is tlbwe.   That is our only option
as far as I know.   So, hugetlb and indirect entries will each need to be
addressed separately.    The kernel code that handles these either needs
to be A) modified to unconditionally do all invalidates by tlbwe or B)
conditionally
use tlbwe depending on whether this is a guest that has enabled direct
TLB management.

Stuart
