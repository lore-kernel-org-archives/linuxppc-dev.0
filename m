Message-ID: <40CA25B8.8050809@mvista.com>
Date: Fri, 11 Jun 2004 14:35:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	David Woodhouse <dwmw2@infradead.org>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6
References: <20040611144323.F293AC109F@atlas.denx.de>
In-Reply-To: <20040611144323.F293AC109F@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <40C9BED6.3010809@intracom.gr> you wrote:
>
>
>>OK, lets look at the very simple problem of having two
>>ethernet interfaces. From where do I get the ethernet
>>mac addresses? Modifying bd_t with defines is gross.
>>
>>
>
>This is hardware dependend. For  example,  on  some  boards  the  MAC
>addresses are simply sequential - so you just add one :-)
>
>
>
>>Putting everything on the kernel command line results in
>>an unreadable command line.
>>
>>
>
>Agreed. The command  line  is  another  bad  solution  to  pass  such
>information.
>
>
>
>>Yeah, having the bi_recs interface actually working
>>would be ideal, but at the present time nothing is
>>working and as AFAIK no-one is working on it.
>>
>>
>
>Mark A. Greer made a  nice  proposal  more  than  2  years  ago.  See
>discussion  that  started  as  "EV-64260-BP & GT64260 bi_recs" around
>March 19, 2002.
>
>I'd be happy to see this accepted.
>
Hey, thanks for the plug Wolfgang!  :)

Here are some thoughts that don't directly address the bi_rec (or
whatever) issue but they are related...

Some things have changed since that thread.  In particular, the "On Chip
Peripheral" or OCP support has been added to the kernel.  Matt Porter
has spent a lot of time working on the OCP and has it looking/working
well.  If you're not familiar with it, its worth a look.

We can use the OCP to pass information from the platform-specific kernel
code to drivers.  We still have the issue of getting info into the
kernel in the first place so we still need to resolve that issue.
However, I would rather have drivers look in the OCP for info instead of
directly at bi_recs (or whatever we chose).

So for example, a network driver does not have to worry about where to
get a MAC address, it just looks in the OCP.  The board-specific code
can deal with getting the MAC addr from a bi_rec, the cmd line, an I2C
SROM somewhere, conjuring one up using incrementing MAC addrs, or
whatever.  After all, where to get the MAC addr really is platform (&
firmware) specific.  The OCP provides a single, clean interface to pass
info into drivers.

I think its something worth considering.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
