Date: Fri, 2 Jun 2000 09:43:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andreas Tobler <toa@pop.agri.ch>
Cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 7200 & bitkeeper/linuxcare devel?
Message-ID: <20000602094334.C840@work.bitmover.com>
References: <39379C61.E33FF001@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39379C61.E33FF001@pop.agri.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I played with bk sccstool to track down the relevant changes, but it
> seems that I have to learn a lot with this bk tool. Also, there are many
> changes from 2.3.99p6 until 2.4.0test1-ac7 so it's really difficult to
> find out.

I can't help you with the kernel part but I'm happy to try and help out with
the sccstool part.  I can also tell you how I "debug" stuff like this, it's
somewhat time consuming but you can more or less automate it.

If you do a "bk changes" which gives you a listing of what has changed, and
then identify the point where it worked, now you can basically do a binary
search to find a point that works.  Suppose you were at 1.100 when it worked
and 1.200 doesn't work.   Let's say that 1.180 was the one that caused the
problem.  So you do this:

	bk clone -r1.150 busted test
		cd test
		build and install
		this one worked
		cd ..
		rm -rf test
	# we know that 1.100..1.150 work
	bk clone -r1.175 busted test
		build and install, it works
	# we know that 1.100..1.175 work
	bk clone -r1.182 busted test
		build and install, it fails
	# we know that it broke somewhere between 1.175 and 1.182

This may or may not be the right way to go about finding the problem.  If you
narrow it down, then get into sccstool and click left on 1.175 and right on
1.182 and then click "view changesets".  Now you can walk through all the
changes by hitting the spacebar repeatedly.  This may give you a hint about
what broke it.

Please let me know if this is helpful or useless or if you want some more
info and good luck.
--
---
Larry McVoy            	   lm@bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
