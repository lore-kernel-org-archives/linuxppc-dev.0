Message-ID: <3946FD0F.7545C068@embeddededge.com>
Date: Tue, 13 Jun 2000 23:33:35 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, all@cideas.com
Subject: Re: init is running (didn't trigger the wait queue panic)
References: <m131qWd-001SyaC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

>         I tried running init again with Linux 2.4.0-test1-ac10
>         (through changeset 1.247.1.6 00/06/12 18:04:09-04:00
>         dmalek@geefour.netx4.com), and I was surprised to find that it
>         worked.  Previously, init was triggering a wait queue panic in the
>         scheduler.


I forget that if you are not on the BitKeeper mailing list you don't
see the updates people make.  Wolfgang sent me a stack backtrace that
pointed right to a problem in the uart driver with wait queues.  They
were not initialized properly (actually, not at all :-), so you would
get erratic behavior for any type of uart open/close.  This was fixed
a couple of days ago.

This affects both 8xx and 8260, so suck down the latest 2.4.0 sources
and give them a test.

Now, I will do some 8260 updates, hopefully to fix that irritating
Ethernet bug and the timer stuff you sent me.  I'll try to be better
about posting update message to this list (if people want that info).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
