Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id 4CBDD2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 08:24:06 +1100 (EST)
Message-ID: <007d01c4c37e$17e8e0d0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Wolfgang Denk" <wd@denx.de>
References: <20041105204710.735A7C1430@atlas.denx.de>
Date: Fri, 5 Nov 2004 16:26:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Handling power failure - MPC5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >
> > >What I've seen is marketing bullet points saying the cards can survive
a
> > >power loss event with no loss of data, but when I read the >detailed CF
> > >specification, the disclaimer was that power had to be held up for X
mSec (I
> > >forgot what X was, 2mSec or 10mSec most likely) after the last write
> > >operation.  The marketing bullet point was exactly that: marketing.
The
> > >real requirement levied on the user
> > >(you) was that you had to have X mSec power hold up after the last
write
> > >operation (i.e. a X mSec power fail warning with no write >operations
after
> > >the PF warning).  The hold-up requirement gave the CF internals enough
time
> > >to complete a flash write cycle.
> >
> > One simple use for the power fail interrupt would be to just turn off
> > interrupts and loop until power fail.
> > This would insure that a write or erase operation completed fully.
>

> Maybe it would - but do you know exactly how long a  write  operation
> will  take?  I  haven't  seen  such information in the specs I had so
> far...
>
> Best regards,
>
> Wolfgang Denk
>

No, I guess I only know numbers for discrete flash chips.  And
then you've still got the long erase times.

So maybe, are you thinking that a power fail interrupt is a waste of
time?  Just segment the file system as you suggested and trust the
writeable part to jffs2?

Another technique that has fallen out of favor but is still useful in some
applications is battery backed RAM.  It's relatively expensive, but if
you want fast non-volatile memory it can't be beat.

Mark Chambers
