Message-ID: <3DA3347B.1000004@mvista.com>
Date: Tue, 08 Oct 2002 12:39:39 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
References: <20021002014219.GF1848@zax> <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com> <20021002053422.GL1848@zax> <20021002100312.A2240@home.com> <20021003011044.GB1102@zax> <20021003081439.C4643@home.com> <20021004024832.GG1933@zax> <3D9DDEE9.5070909@mvista.com> <20021008041758.GG32555@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

>>Rainier (NP4GS3) PMM1 is setup specially in the existing code, is this
>>no longer needed?
>
>
> Well, I don't know if it's necessary - it's not there, because I
> didn't notice the difference in the Rainier code before.  Now that I
> do look at it, I'm confused: it appears to be setting up both PMM0 and
> PMM1 to map from the same PLB addresses, but the manual specifically
> prohibits overlapping PMM ranges.

And the code used for MontaVista's products has diverged somehow; it has
an empty bios_fixup but code in a different place that does something
different:

	/* plb address 0x8000 0000 will be set to pci address 0x8000 0000 which
	   corresponds to PCI 9030 Dev 0x10 BAR4 */
	out_le32((void*)PMM1LA,0x80000000);
	out_le32((void*)PMM1MA,0xFFFE0001);    /* PLB range is 128KB */
	out_le32((void*)PMM1PCILA,0x80000000);
	out_le32((void*)PMM1PCIHA,0x00000000);

I'll try to figure out the story on this, but everything NP4GS3-related
seems to be murky...  NP4GS3 will probably need a custom bios_fixup that
does the above (among other things), can worry about that platform later.

>>This code is fragile and tends to break on certain platforms in ways
>>that can't be explained by the available documentation.  I can help test
>>the unified version on Walnut/Sycamore/Ash if needed.
>
>
> Do you mean the existing code, or my proposed patch (or both).  That
> would be great if you could test the code on those machines -  I don't
> have a Sycamore or Ash, and I'd have to drag the Walnut out again to
> test on it.

Yes, I can test your proposed code on those machines.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
