Message-ID: <19991215055541.23843.qmail@web301.mail.yahoo.com>
Date: Tue, 14 Dec 1999 21:55:41 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: linuxppc embedded boot problems.
To: bsimon@ctam.com.au, Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--- Brendan Simon <bsimon@ctam.com.au> wrote:
<snip>
> > Considering you are doing your own UPM, the Linux
> kernel will
> > find lots of timing errors with it. 
<snip>
> 1) there is something I'm doing wrong which affects
> the cache setup.


When UPM tables are involved, and enabling the cache
causes problems, here is a likely issue that's caught
me the past.  The 8xx doesn't do burst-accesses until
the cache is enabled.  If you're runnning synchronous
DRAM, all of your accesses will be single-beat until
you turn on that cache.  If any of your burst-cycle
timing in the UPM is wrong, that's when you will see
problems. 

Other potential problem, which has bitten me, is to
make sure you don't have any lines locked in cache
before you jump to the kernel loader.  Last time I
checked the loader did an INVALIDATE ALL and ENABLE on
the I-Cache.  Ideally it should also do an UNLOCK ALL.
 If, for any reason, your bootloader locks lines in
cache, you can execute those stale cache lines after
jumping to the kernel.

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
