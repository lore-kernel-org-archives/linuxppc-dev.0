Date: Tue, 14 Jan 2003 09:32:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch moving latest linux-galileo common & ev64260 code to 2_4_devel
Message-ID: <20030114163239.GD791@opus.bloom.county>
References: <3E088CAD.2030102@mvista.com> <3E08A93E.8000409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E08A93E.8000409@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 24, 2002 at 11:36:46AM -0700, Mark A. Greer wrote:

> Okay, as requested, the big patch has been broken up into somewhat
> logical pieces (although not perfect).  They are available here:
>
> ftp://source.mvista.com/linuxppc/gal/

I've applied all of this, in the interest of getting things back into
sync.

What I want to know 'tho, is why is there still the 'reg base' being
either here or there.  How hard would it be to always have it at the
'other' location?  Or, was it decided that it was best to allow this to
end up anywhere?

Also, I would really like to see the if/else of PPCBoot go away in favor
of something like parsing PPCBoot, if it exists, and if not setting up
things the 'other' way.  ie:
platform_init(...) {
  if (r3 == ppcboot)
    parse_ppcboot()
  else
    find_things_out()
  ...
}

find_things_out() {
  bd_t.memsize = gt64260_find_end_of_memory();
  ...
}

IOW, if we don't have PPCBoot and it's 'bd_t', fill it out.[1]

[1] And of course this brings us to bi_recs, which is another
flamewar^H^H^H^H^H^H^H^Hdiscussion.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
