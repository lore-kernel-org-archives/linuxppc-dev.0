Date: Tue, 23 Feb 1999 16:06:46 -0500 (EST)
From: Tom Vier <nester@erols.com>
Reply-To: Tom Vier <thomassr@erols.com>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
cc: Tom Vier <thomassr@erols.com>,
        mklinux-development-system@public.lists.apple.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs-1.1.1-1c bug (was Re: major ksyms problem)
In-Reply-To: <4.1.19990223155132.049de8f0@mail.lauterbach.com>
Message-ID: <Pine.LNX.4.05.9902231559510.6465-100000@localhost.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Feb 1999, Franz Sirl wrote:

> At 15:36 22.02.99 , Tom Vier wrote:
> >
> >it's an egcs bug. i think it's not aligning instructions properly, cuz
> >i believe the 601 is more strict about alignment. is anyone having
> >problems using bsd_comp.o, ppp_deflate.o, and hfs.o on a non-601
> >machine built under pre-R5 (egcs-1.1.1-1c)?
> 
> What makes you think that it is an egcs bug? I have no problems on 601
> (7200/75) with any of the modules you listed. Are you sure you have the
> latest modutils (2.1.121 or later) installed?

it is an egcs bug. egcs-1.1.1-1c failss to build working bsd_comp.o,
ppp_deflate.o, and hfs.o; egcs-1.0-2e.ppc.rpm builds it perfectly. i'm
getting a newer build of egcs right now, to see if it's fixed.

> >i rebuilt bsd_comp.o and ppp_deflate.o w/ egcs-1.0-2e from dr3 and
> >they worked perfectly.
> >
> >egcs-1.1.1-1c failed using -O0, -O2, and -O3 with all combinations of
> >-mcpu=601, -mcpu=604, and -fno-schedule-insns. -fpic did work, however
> >it addes an offset table symbol that makes insmod complain.
> >> > Feb 21 09:36:18 zero insmod: /lib/modules/2.0.37-osfmach3/net/bsd_comp.o:
> >> > Unhandled relocation of type 26 for .L343
> 
> Is "Unhandled relocation of type 26" the behaviour for standard compilation
> or for -fpic? You can't compile a kernel/modules with -fpic and expect
> modutils still to work, modutils only handles the minimum necessary
> relocation types.

the unhandled relocation was from egcs-1.1.1-1c using the standard
flags (no -fpic). i didn't expect it work w/ -fpic, but i thought it
might work better and it appears to, since it stopped insmod from
complaining about relocations and instead complain about the symbol
offset table (though it may just complain about the offset table
before finding the relocation problem, thus -fpic might not actually
make a difference).

--
Tom Vier - 0x82B007A8
thomass@erols.com        | goto the Zero Page at:
Tortured Souls Software  | http://www.erols.com/thomassr/zero/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
