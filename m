Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.131.36]) by ozlabs.org (Postfix) with ESMTP id 4C1932BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 02:07:26 +1100 (EST)
Received: from filter01.roc.ny.frontiernet.net
	(filter01.roc.ny.frontiernet.net [66.133.131.176])
	by relay03.roc.ny.frontiernet.net (Postfix) with ESMTP id A6B82192128
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 15:07:21 +0000 (UTC)
Received: from relay03.roc.ny.frontiernet.net ([66.133.131.36])
	by filter01.roc.ny.frontiernet.net (filter01.roc.ny.frontiernet.net
	[66.133.131.176]) (amavisd-new, port 10024)
	with LMTP id 15793-02-12 for <linuxppc-embedded@ozlabs.org>;
	Fri, 5 Nov 2004 15:07:21 +0000 (UTC)
Received: from chuck2 (170-215-154-178.br1.rmn.wv.frontiernet.net
	[170.215.154.178])
	by relay03.roc.ny.frontiernet.net (Postfix) with ESMTP id 7D95119292C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 15:07:00 +0000 (UTC)
Message-ID: <005a01c4c349$7949b8c0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <065ACD8E84315E4394C835E398C8D5EB9E97EB@COSSMGMBX02.email.corp.tld>
Date: Fri, 5 Nov 2004 10:09:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

> > > Capacitors on the supply provide me with some
> milliseconds to repond
> to
> > > power failure, which I would
> > > like to use to do as much cleanup as possible before power is
> > > totally gone.  In particular, I am concerned
> >

>What I've seen is marketing bullet points saying the cards can survive a
power loss event with no loss of data, but when I read the >detailed CF
specification, the disclaimer was that power had to be held up for X mSec (I
forgot what X was, 2mSec or 10mSec most >likely) after the last write
operation.  The marketing bullet point was exactly that: marketing.  The
real requirement levied on the user
>(you) was that you had to have X mSec power hold up after the last write
operation (i.e. a X mSec power fail warning with no write >operations after
the PF warning).  The hold-up requirement gave the CF internals enough time
to complete a flash write cycle.

One simple use for the power fail interrupt would be to just turn off
interrupts and loop until power fail.
This would insure that a write or erase operation completed fully.
P.S. Don't forget to cover the situation where power comes back rather than
going all the way down!

Mark Chambers
wvcomputronics.com
