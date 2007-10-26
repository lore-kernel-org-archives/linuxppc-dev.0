Return-Path: <oxymoron@waste.org>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2A5CCDDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Oct 2007 00:41:55 +1000 (EST)
Date: Fri, 26 Oct 2007 09:41:34 -0500
From: Matt Mackall <mpm@selenic.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Apparent kernel bug with GDB on ppc405
Message-ID: <20071026144134.GW19691@waste.org>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
	<1193369005.7018.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193369005.7018.46.camel@pasglop>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 26, 2007 at 01:23:25PM +1000, Benjamin Herrenschmidt wrote:
> 
> > This is actually 405.  Does that have the same issue?
> 
> hrm... I don't remember :-) There -is- something fishy about the icache
> on 405 but I don't remember for sure. Try sticking an iccci in there and
> tell us if that helps.

I did. I stuck an iccci -and- a dccci loop in. I threw in the tlbia
when I ran out of other ideas. And the tlbia + existing
flush_icache_range appears to be sufficient (tested on a non-trivial
app).

According to my docs, the 405fx's icache is virtually
indexed/physically mapped, while the dcache is phys/phys.

-- 
Mathematics is the supreme nostalgia of our time.
