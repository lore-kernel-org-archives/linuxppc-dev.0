Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id D86332BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Oct 2004 00:03:32 +1000 (EST)
Message-ID: <003001c4abad$8752a9d0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Wolfgang Denk" <wd@denx.de>
References: <20041005202017.6DC7BC1430@atlas.denx.de>
	<Pine.LNX.4.60.0410060926320.8416@dell.enoriver.com>
Date: Wed, 6 Oct 2004 10:05:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

rday:
> >>
> >> that's definitely understandable.  it's just potentially confusing to
> >> have a structure's reserved chunks declared as some combination of
> >> uchar, ushort, uint and/or ulong, when it's obviously more
> >> comprehensible to make each reserved chunk a standard array of char
> >> whose size is obvious at a glance.
> >
wd:
> > Actually this might not be confusing, but making the code  easier  to
> > read,  to  understand,  and  maybe  one day to extend - remember that
> > these struct definitions are direct translations of Motorola provided
> > documentation - and I tend to  believe  that  the  chip  manufacturer
> > knows  more about the internals of his chips than you or me. One day,
> > a "uint reserved_xxx;" may turn into a new, shiny 32 bit register.
>
rday:
> it seems that, if that's good advice for patches, it should be good
> advice for the code proper.  i do appreciate your point, but if at
> some point, a shiny new register suddenly appears, that strikes me as
> a significant enough change that mods to the header file shouldn't be
> considered a big deal.
>
> anyway, just my $0.02.
>

Rob,

What about, "if it ain't broke, don't fix it".  If it were my code I
wouldn't
touch that stuff - at best you get pretty code, at worst you break
something.
Remember, these aren't 'real' structures, they're just templates to make
I/O addressing come out right.  Wolfgang is likely right, that Motorola
created the structures based on what they know about the internal
decoding logic.  So if in the future one needs to add new registers you
again minimize the chance of breaking something by not rearranging
the arrays correctly.  Then again, if Motorola adds registers (or they
may already be there, but not documentented) they will probably
release a new header file, which you'll have to clean up all over
again.

That's my two cents.

Mark C.
