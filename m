From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Kumar Gala" <kumar.gala@motorola.com>,
	"Eugene Surovegin" <ebs@ebshome.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	"Stephen Williams" <612dlag102@sneakemail.com>
Subject: RE: [RFC] "indirect" DCR access (40x, BookE)
Date: Fri, 12 Mar 2004 09:53:25 -0500
Message-ID: <IIEEICKJLNEPBBDJICNGCEIGENAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Before you guys go too far with this, just keep in mind that there are
efforts under way to have Linux XIP -- not running from RAM.  You will
need to have any self-modifying code in a writable region obviously.
What is not obvious is that you may need to preallocate a region of RAM
to do this in the case of XIP.

Chuck

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kumar
> Gala
> Sent: Friday, March 12, 2004 9:25 AM
> To: Eugene Surovegin
> Cc: linuxppc-embedded@lists.linuxppc.org; Stephen Williams
> Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
>
>
>
> Look in u-boot.  They have some user commands that allow
> reading/writing dcr's.  These commands are written with self modifying
> code, I would recommend that we reuse that.
>
> Also, it begs the question of should this be extended to SPRs, not that
> I have come across a case with SPRs that I need to iterate over a large
> list.
>
> - kumar
>
> On Mar 11, 2004, at 10:54 PM, Eugene Surovegin wrote:
>
> >
> > On Thu, Mar 11, 2004 at 08:44:09PM -0800, Stephen Williams wrote:
> >>>> I think you should just write it as self modifying code :-)
> >>>> Write the instruction with the DCR number and just execute it.
> >>>
> >>>
> >>> And deal with locking and icache/dcache coherency ?
> >>>
> >>> No, thanks :)
> >>
> >>
> >> Actually, I recall that there is a code fixup mechanism that
> >> is invoked early in kernel init that does exactly that: it
> >> manages some machine specific differences by editing the code
> >> in place in a safe way.
> >
> > Yes, you are correct, but this is done only once during startup and
> > nobody cares how fast it is. BTW, there is no locking issues at this
> > stage.
> >
> > I'm not saying that it's impossible :). It's just not very efficient
> > to do such stuff on run-time (lock a spinlock, change memory, dcache
> > flush, icache invalidate, isync...)
> >
> > Eugene.
> >
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
