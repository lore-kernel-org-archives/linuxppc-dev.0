Message-ID: <3D9DDEE9.5070909@mvista.com>
Date: Fri, 04 Oct 2002 11:33:13 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
References: <20021002014219.GF1848@zax> <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com> <20021002053422.GL1848@zax> <20021002100312.A2240@home.com> <20021003011044.GB1102@zax> <20021003081439.C4643@home.com> <20021004024832.GG1933@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> +	/* Now configure the PCI->PLB windows, we only use PTM1 */
> +	out_le32((void *) &(pcip->ptm1ms), 0x00000000); /* first disable */
> +	out_le32((void *) &(pcip->ptm1la), 0x00000000); /* base address */
> +	out_le32((void *) &(pcip->ptm1ms), 0x80000001); /* re-enable */
> +	out_le32((void *) &(pcip->ptm2ms), 0x00000000); /* disable PTM2 */
> +
> +	/* Zero config bars */
> +	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
> +		early_write_config_dword(hose, hose->first_busno,
> +					 PCI_FUNC(hose->first_busno), bar,
> +					 0x00000000);
> +		early_read_config_dword(hose, hose->first_busno,
> +					PCI_FUNC(hose->first_busno), bar,
> +					&bar_response);
> +		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
> +		    hose->first_busno, PCI_SLOT(hose->first_busno),
> +		    PCI_FUNC(hose->first_busno), bar, bar_response);
> +	}

Only PCI_BASE_ADDRESS_1 (aka PCIL0_PTM1BAR) needs to be set since PTM2
is disabled (Ash is already doing it this way).  My reading of the
manual would indicate that the BAR ought to be set before PTM1 is
enabled, but haven't seen any problems with this.

Could enclose the early_read_config_dword() in #ifdef DEBUG.

Rainier (NP4GS3) PMM1 is setup specially in the existing code, is this
no longer needed?

This code is fragile and tends to break on certain platforms in ways
that can't be explained by the available documentation.  I can help test
the unified version on Walnut/Sycamore/Ash if needed.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
