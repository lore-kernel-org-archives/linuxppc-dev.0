In-Reply-To: <40CA25B8.8050809@mvista.com>
References: <20040611144323.F293AC109F@atlas.denx.de> <40CA25B8.8050809@mvista.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EC24D1FC-BC15-11D8-82F4-000393DBC2E8@freescale.com>
Cc: "'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	David Woodhouse <dwmw2@infradead.org>, Wolfgang Denk <wd@denx.de>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	<linuxppc-embedded@lists.linuxppc.org>,
	Pantelis Antoniou <panto@intracom.gr>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: U-Boot and kernel 2.6
Date: Fri, 11 Jun 2004 21:12:14 -0500
To: "Mark A. Greer" <mgreer@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Some things have changed since that thread.  In particular, the "On
> Chip
> Peripheral" or OCP support has been added to the kernel.  Matt Porter
> has spent a lot of time working on the OCP and has it looking/working
> well.  If you're not familiar with it, its worth a look.
>
> We can use the OCP to pass information from the platform-specific
> kernel
> code to drivers.  We still have the issue of getting info into the
> kernel in the first place so we still need to resolve that issue.
> However, I would rather have drivers look in the OCP for info instead
> of
> directly at bi_recs (or whatever we chose).
>
> So for example, a network driver does not have to worry about where to
> get a MAC address, it just looks in the OCP.  The board-specific code
> can deal with getting the MAC addr from a bi_rec, the cmd line, an I2C
> SROM somewhere, conjuring one up using incrementing MAC addrs, or
> whatever.  After all, where to get the MAC addr really is platform (&
> firmware) specific.  The OCP provides a single, clean interface to pass
> info into drivers.
>
> I think its something worth considering.

I agree with Mark.  We are already doing this for 85xx in 2.4 and 2.6.
The board code handles populating mac addr's in OCP info.

Our intention is that drivers that support Freescale parts should use
OCP.  One of the reasons for this is because of all the various
processors that will exist from Freescale were the driver should be
reusable.

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
