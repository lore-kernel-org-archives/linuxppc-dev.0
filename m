Date: Thu, 6 Feb 2003 12:37:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch moving latest linux-galileo common & ev64260 code to 2_4_devel
Message-ID: <20030206193746.GA17840@ip68-0-152-218.tc.ph.cox.net>
References: <3E088CAD.2030102@mvista.com> <3E08A93E.8000409@mvista.com> <20030114163239.GD791@opus.bloom.county> <3E24A188.6050802@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E24A188.6050802@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 14, 2003 at 04:47:20PM -0700, Mark A. Greer wrote:
> Tom Rini wrote:
>
> >Also, I would really like to see the if/else of PPCBoot go away in favor
> >of something like parsing PPCBoot, if it exists, and if not setting up
> >things the 'other' way.  ie:
> >platform_init(...) {
> > if (r3 == ppcboot)
> >   parse_ppcboot()
> > else
> >   find_things_out()
> > ...
> >}
> >
> >find_things_out() {
> > bd_t.memsize = gt64260_find_end_of_memory();
> > ...
> >}
> >
> >IOW, if we don't have PPCBoot and it's 'bd_t', fill it out.[1]
>
> I suppose but there is code that can be ifdef'd out which makes the
> executable smaller.  Isn't it worth keeping them for that reason?

That's the exact opposite of what I intended, actually.  I want
CONFIG_USE_PPCBOOT to go away.  For example, in
gt64260_eth.c::gt64260_eth_init yoou do:
#ifndef CONFIG_USE_PPCBOOT
 else {
   return -ENODEV;
 }
#else
  ... magic to find an enet addr from PPCBOOT
#endif

IMHO, this should all be:
  if (gt64260_info_struct.enet_addr)
    memcpy(..)
  else
    return -ENODEV

And so on.  Convert the bd_t into a 'generic' struct, fill it out with
what PPCBoot passes, or is gleaned from the cmdline, or bi_recs of stuff
gleaned from i2c, or whatever.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
