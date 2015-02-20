Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB8071A0DD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 14:34:33 +1100 (AEDT)
Message-ID: <1424403272.26444.1.camel@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Fri, 20 Feb 2015 14:34:32 +1100
In-Reply-To: <87d256kry8.fsf@KB00016249.iskra.kb>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
 <1424307520.22020.5.camel@ellerman.id.au>
 <87d256kry8.fsf@KB00016249.iskra.kb>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2015-02-19 at 19:26 +0700, Arseny Solokha wrote:
> > On Mon, 2015-02-16 at 17:56 +0700, Arseny Solokha wrote:
> >> Drop unused fsl_mpic_primary_get_version(), mpic_set_clk_ratio(),
> >> mpic_set_serial_int().
> >
> > I'm always happy to remove unused code, but the interesting question is why are
> > they unused? Please tell me in the changelog.
> 
> To being able to give a definitive answer, it's necessary to understand
> the intentions of original developers of these pieces. I just can tell
> these functions have no users and trivial grepping easily proves it;
> I've got the impression they are here only for the sake of
> implementation completeness.

Yeah OK. I didn't expect you to read the minds of the developers who wrote the
code :)
 
> Two machines at hands, e300 and e500 based, boot and run without
> regressions on my workload with this series applied. The removed code
> seems also been rarely touched, so it seems the series is safe at least
> in general. But I can't obviously express any strong point in support of
> the series, so it's completely OK to leave things as is.

OK that's a good data point.

>   + fsl_mpic_primary_get_version() is just a safe wrapper around
> fsl_mpic_get_version() for SMP configurations. While the latter is
> called explicitly for handling PIC initialization and setting up error
> interrupt vector depending on PIC hardware version, the former isn't
> used for anything.
> 
>   + As for mpic_set_clk_ratio() and mpic_set_serial_int(), they both
> are almost nine years old[1] but still have no chance to be called even
> from out-of-tree modules because they both are __init and of course
> aren't exported. Non-demanded functionality?
> 
> Of course I'll include the last two paragraphs into the V2 patch
> description if the explanation is convincing enough and you ACK it. If
> the patch is safe it's also necessary to extend it a bit, making its
> second part actually a complete revert of [1].
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-June/023867.html

That is more like what I was looking for.

If I just get a patch saying "removed unused foo()", I have to go and dig and
find out:
  - was it recently added and will be used soon?
  - is it ancient and never used, if so can we work out why, ie. feature X
    never landed so this code is no longer needed.
  - is it old code that *was* used but isn't now because commit ... removed the
    last user.
  - is it code that *should* be used, but isn't for some odd reason?


So if you can provide that sort of detail for me, that really adds value to the
patch. Otherwise the patch is basically just a TODO for me, to go and work out
why the code is unused.

cheers
