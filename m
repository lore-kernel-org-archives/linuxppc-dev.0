Date: Mon, 18 Nov 2002 07:19:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Magnus Damm <damm@opensource.se>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd
Message-ID: <20021118141949.GB15279@opus.bloom.county>
References: <3DD3C747.8B7EE5CD@opensource.se> <20021114174807.GC605@opus.bloom.county> <3DD4E271.16FA374A@opensource.se> <20021115100857.H9673@duath.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021115100857.H9673@duath.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 15, 2002 at 10:08:57AM -0700, Cort Dougan wrote:

> This would be a good opportunity to switch-over to allowing the bootloader
> stick the initrd where it wants and just pass the physical pointer in via
> bi_record in all cases.  It would certainly simplify these cases.

I'm not so sure.  In the case of arch/ppc/boot/ and not on OF, there
aren't many places we really know are 'good' that we can throw things.
I think what might help, and that we can do in 2.5 even, is allow the
bootloader to put the bi_recs wherever it wants to, pass that along in
r3 or r4 or so, and then in this case, we would align the bi_recs at
_ALIGN(0+zimage)+_ALIGN(initrd), and if that's > 8MB, make sure that we
don't allow the end of the initrd to be overwritten too.

And keep in mind it's Monday, and I haven't had any coffee yet, if
there's any horribly silly mistakes above :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
