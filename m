Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A1C01007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:02:08 +1100 (EST)
Message-ID: <1322510511.23348.40.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc/time: Handle wrapping of decrementer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 29 Nov 2011 07:01:51 +1100
In-Reply-To: <4ED3C875.5050002@freescale.com>
References: <20111124060716.362614789@samba.org>
 <20111124060847.105131188@samba.org> <4ED3C875.5050002@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: johnstul@us.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-11-28 at 11:44 -0600, Scott Wood wrote:
> > -#ifndef CONFIG_BOOKE
> > -     /* On server, re-trigger the decrementer if it went negative since
> > -      * some processors only trigger on edge transitions of the sign bit.
> > -      *
> > -      * BookE has a level sensitive decrementer (latches in TSR) so we
> > -      * don't need that
> > +     /*
> > +      * Trigger the decrementer if we have a pending event. Some processors
> > +      * only trigger on edge transitions of the sign bit. We might also
> > +      * have disabled interrupts long enough that the decrementer wrapped
> > +      * to positive.
> >        */
> > -     if ((int)mfspr(SPRN_DEC) < 0)
> > -             mtspr(SPRN_DEC, 1);
> > -#endif /* CONFIG_BOOKE */
> > +     decrementer_check_overflow();
> 
> Where did the #ifndef CONFIG_BOOKE go?  BookE doesn't need this; the
> interrupt will continue asserting until software clears TSR[DIS].

Ooops, I didnt notice Anton was removing it. Please send me a followup
patch to make decrementer_check_overflow() an empty inline on BookE.

Cheers,
Ben.
