From: linas@austin.ibm.com
Date: Wed, 19 Nov 2003 16:35:12 -0600
To: "Michael R. Zucca" <mrz5149@acm.org>
Cc: Juergen Kienhoefer <juergen@kienhoefer.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: cache coherence problem
Message-ID: <20031119163512.A34072@forte.austin.ibm.com>
References: <3FB972E8.5090701@kienhoefer.com> <4CE8E7E9-1970-11D8-ADD5-003065D401D8@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CE8E7E9-1970-11D8-ADD5-003065D401D8@acm.org>; from mrz5149@acm.org on Mon, Nov 17, 2003 at 09:38:32PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 09:38:32PM -0500, Michael R. Zucca wrote:
>
> have to make sure everything is flushed and the icache is invalidated
> before executing the code. You have to do the same thing when you do
> self-modifying code.
>
> Why would you want to do this, anyway?

I don't know what he's doing, but sometimes one has static if tests
inside of tight inner loops, but you don't know (at compile time)
what the compare op will be until runtime. One way to solve this
is build an optimized loop for each possible compare op.

This optimization strategy fails if you have more than a handful of
if-tests, cause then you have a combinatorial explosion (i.e. dozens
of nearly identical .o files eating up megabytes with nearly identical
code).   So one way around this to have a few basic loops, and patch
them up at run time.

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
