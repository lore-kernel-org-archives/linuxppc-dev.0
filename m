Date: Sun, 4 Feb 2001 21:09:02 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4: PCIBIOS_MIN_MEM correct?
In-Reply-To: <01020413004001.06077@momiji>
Message-ID: <Pine.LNX.4.05.10102042107540.16275-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 4 Feb 2001, Joseph P. Garcia wrote:
> should PCIBIOS_MIN_MEM be 0x10000000?  I caught this when i noticed it is

That value is suited for `PC' systems.

> used as the minimum address in the pci assign resource function, used in such
> situations as the OF/ATY-overlap re-allocate in wallstreets.  My system would
> panic with the lcd melting effect as some may recall.
>
> I brute forced in the following lines in
> drivers/pci/setup-res.c:pci_assign_resource()
>      min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
> +    if(res->start==0)
> +         min = 0x83000000;
>
> resulting in the same mapping used by Michael Schmitz earlier 2.2 patch.
> (its the only re-alloc on my system, so it works :)  My kernel isn't
> panicing.. yet.
>
> Anyway, looking in /proc/iomem, one might get the idea that PCIBIOS_MIN_MEM
> should be defined as 0x80000000.  This might resolve the problem I had in a
> less brute way.  I haven't tried it myself yet.  waiting for a second opinion.

The correct fix is to add bus resources that indicate the allowed region.
pci_assign_resource() will assign a region from the allowed region.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
