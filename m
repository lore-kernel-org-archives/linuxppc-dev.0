Date: Tue, 8 Oct 2002 14:17:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021008041758.GG32555@zax>
References: <20021002014219.GF1848@zax> <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com> <20021002053422.GL1848@zax> <20021002100312.A2240@home.com> <20021003011044.GB1102@zax> <20021003081439.C4643@home.com> <20021004024832.GG1933@zax> <3D9DDEE9.5070909@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D9DDEE9.5070909@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 04, 2002 at 11:33:13AM -0700, Todd Poynor wrote:
>
> David Gibson wrote:
>
> >+	/* Now configure the PCI->PLB windows, we only use PTM1 */
> >+	out_le32((void *) &(pcip->ptm1ms), 0x00000000); /* first disable */
> >+	out_le32((void *) &(pcip->ptm1la), 0x00000000); /* base address */
> >+	out_le32((void *) &(pcip->ptm1ms), 0x80000001); /* re-enable */
> >+	out_le32((void *) &(pcip->ptm2ms), 0x00000000); /* disable PTM2 */
> >+
> >+	/* Zero config bars */
> >+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
> >+		early_write_config_dword(hose, hose->first_busno,
> >+					 PCI_FUNC(hose->first_busno), bar,
> >+					 0x00000000);
> >+		early_read_config_dword(hose, hose->first_busno,
> >+					PCI_FUNC(hose->first_busno), bar,
> >+					&bar_response);
> >+		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is
> >0x%8.8x\n",
> >+		    hose->first_busno, PCI_SLOT(hose->first_busno),
> >+		    PCI_FUNC(hose->first_busno), bar, bar_response);
> >+	}
>
> Only PCI_BASE_ADDRESS_1 (aka PCIL0_PTM1BAR) needs to be set since PTM2
> is disabled (Ash is already doing it this way).  My reading of the
> manual would indicate that the BAR ought to be set before PTM1 is
> enabled, but haven't seen any problems with this.

I guess that's true.  On the other hand, I wonder if there is merit in
setting the other BAR, just so that everything is in a known state.

> Could enclose the early_read_config_dword() in #ifdef DEBUG.

Yes, good idea.

> Rainier (NP4GS3) PMM1 is setup specially in the existing code, is this
> no longer needed?

Well, I don't know if it's necessary - it's not there, because I
didn't notice the difference in the Rainier code before.  Now that I
do look at it, I'm confused: it appears to be setting up both PMM0 and
PMM1 to map from the same PLB addresses, but the manual specifically
prohibits overlapping PMM ranges.

> This code is fragile and tends to break on certain platforms in ways
> that can't be explained by the available documentation.  I can help test
> the unified version on Walnut/Sycamore/Ash if needed.

Do you mean the existing code, or my proposed patch (or both).  That
would be great if you could test the code on those machines -  I don't
have a Sycamore or Ash, and I'd have to drag the Walnut out again to
test on it.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
