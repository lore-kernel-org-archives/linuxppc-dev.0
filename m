In-Reply-To: <40EC2DC8.5020400@246tNt.com>
References: <40EB1C28.3000402@246tNt.com> <40EC2DC8.5020400@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <17EAD0B0-D057-11D8-9E83-003065F9B7DC@embeddededge.com>
Cc: ppc linux embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Getting rid of static IO mapping
Date: Wed, 7 Jul 2004 16:49:08 -0400
To: Sylvain Munaut <tnt@246tnt.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 7, 2004, at 1:07 PM, Sylvain Munaut wrote:

> I'll try to re-explain my problem more clearly. Maybe some one will
> see a solution.

I think you are trying too hard to solve something that really
isn't a problem.

The use of BATs is a significant performance advantage.  It's
relatively easy to create an ioremap() function that can see if
a BAT covers a space we want and return an appropriate
mapped address.  The converse, creating an ioremap() function
that is smart enough to track all of the I/O usage and determine
how best to use BATs, is very challenging.

Due to the way we have to access memory and devices for
initialization (when vm mapping through ioremap() isn't available)
and the constraints on the kernel VM space, I find it easy to
just declare the BAT values and let ioremap() work as it does in 2.4.

If you look outside of the traditional PowerPC cores (to things
like 8xx, 4xx, and 85xx) you will find even more challenging
early or efficient mapping problems.

Just set the BATs according to the board configurations, keep
the functions simple, and move on.  These functions are
currently working fine for many of the 603 core platforms.  I'd
suggest changing your board setup functions to work with
the common code already present instead of trying to fix
something that isn't broken.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
