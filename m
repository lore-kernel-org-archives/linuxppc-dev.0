Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB94E1A0C04
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 23:26:45 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
 <1424307520.22020.5.camel@ellerman.id.au>
Date: Thu, 19 Feb 2015 19:26:39 +0700
In-Reply-To: <1424307520.22020.5.camel@ellerman.id.au> (Michael Ellerman's
 message of "Thu, 19 Feb 2015 11:58:40 +1100")
Message-ID: <87d256kry8.fsf@KB00016249.iskra.kb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mon, 2015-02-16 at 17:56 +0700, Arseny Solokha wrote:
>> Drop unused fsl_mpic_primary_get_version(), mpic_set_clk_ratio(),
>> mpic_set_serial_int().
>
> I'm always happy to remove unused code, but the interesting question is w=
hy are
> they unused? Please tell me in the changelog.

To being able to give a definitive answer, it's necessary to understand
the intentions of original developers of these pieces. I just can tell
these functions have no users and trivial grepping easily proves it;
I've got the impression they are here only for the sake of
implementation completeness.

Two machines at hands, e300 and e500 based, boot and run without
regressions on my workload with this series applied. The removed code
seems also been rarely touched, so it seems the series is safe at least
in general. But I can't obviously express any strong point in support of
the series, so it's completely OK to leave things as is.

  + fsl_mpic_primary_get_version() is just a safe wrapper around
fsl_mpic_get_version() for SMP configurations. While the latter is
called explicitly for handling PIC initialization and setting up error
interrupt vector depending on PIC hardware version, the former isn't
used for anything.

  + As for mpic_set_clk_ratio() and mpic_set_serial_int(), they both
are almost nine years old[1] but still have no chance to be called even
from out-of-tree modules because they both are __init and of course
aren't exported. Non-demanded functionality?

Of course I'll include the last two paragraphs into the V2 patch
description if the explanation is convincing enough and you ACK it. If
the patch is safe it's also necessary to extend it a bit, making its
second part actually a complete revert of [1].


[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-June/023867.html


Ars=C3=A9ny


> cheers
