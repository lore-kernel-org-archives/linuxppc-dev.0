Date: Sun, 5 Dec 1999 20:42:01 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: dwp@bluesteelnet.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Update:  RE: G4 + Linux + PCI device + x86 driver = 0
In-Reply-To: <199912041157.MAA00463@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.05.9912052040150.376-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 4 Dec 1999, Michel Lanners wrote:
> > 3.  I had to byte-swap all data that I supply to my device, except the data
> > that is handled as a byte stream.  This involved major discussions with my
> > colleagues, because of the need to consider Big Endian, Little Endian, and
> > Network Byte Order.
> 
> David pointed out le16_to_cpu() et al; personally, I use in_/out_le32
> et al for access to PCI memory space like this:
> 
> out_le32 (&device->register, val);

Which is wrong! Portable PCI memory space accesses must be done using
{read,write}[bwl]()!

See linux/Documentation/IO-mapping.txt 

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
