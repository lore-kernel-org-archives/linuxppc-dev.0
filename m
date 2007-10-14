Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 4F902DDE2E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 08:42:46 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1876615wag
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 15:42:45 -0700 (PDT)
Message-ID: <fa686aa40710141542w552eacet7ba13e8e251e2285@mail.gmail.com>
Date: Sun, 14 Oct 2007 16:42:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 2/2] clk for mpc52xx: use psc_mclk's in spi driver
In-Reply-To: <20071014081027.GJ3000@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014080813.GH3000@nd47.coderock.org>
	<20071014081027.GJ3000@nd47.coderock.org>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/14/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Use clocks subsystem in spi driver.

I don't understand the advantage of this approach.  Is the current code broken?

I agree that abstraction is good; but in this case it seems these two
patches add a lot of code for a very simple calculation.  Also, there
is exactly 2 chips that use these devices, the mpc5200 and the
mpc5200b, and they are both wired up in exactly the same way.  I'm
inclined to believe that splitting of reading of the CDM into a
separate driver (or at least using the clk infrastructure) is over the
edge of diminishing returns.  However, I could be convinced that
having a utility function for setting the PSC clock rate is a useful
thing, but until arch/ppc goes away, you should support it in both
arch/ppc and arch/powerpc.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
