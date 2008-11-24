Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id BE34ADDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 05:00:38 +1100 (EST)
Date: Mon, 24 Nov 2008 13:00:36 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] powerpc: ftrace, convert to new dynamic ftrace arch
	API
In-Reply-To: <18730.1723.708467.812600@drongo.ozlabs.ibm.com>
Message-ID: <alpine.DEB.1.10.0811241256370.32561@gandalf.stny.rr.com>
References: <20081120190948.057007623@goodmis.org>
	<20081120191149.285359258@goodmis.org>
	<18730.1723.708467.812600@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 24 Nov 2008, Paul Mackerras wrote:

> Steven Rostedt writes:
> 
> > Thanks to Paul Mackennas for pointing out the mistakes of my original
> 
> Mackerras

Heh, I have two reasons for that typo.

 1) I reference Paul McKenney a lot, and my fingers are programmed.
 2) I type with the dvorak layout, and the 'r' is just above the 'n'.
    qwerty 'o' == dvorak 'r'
    qwerty 'l' == dvorak 'n'

;-)

> 
> > +static int test_24bit_addr(unsigned long ip, unsigned long addr)
> > +{
> > +	long diff;
> > +
> > +	/*
> > +	 * Can we get to addr from ip in 24 bits?
> > +	 *  (26 really, since we mulitply by 4 for 4 byte alignment)
> > +	 */
> > +	diff = addr - ip;
> > +
> > +	/*
> > +	 * Return true if diff is less than 1 << 25
> > +	 *  and greater than -1 << 26.
> > +	 */
> > +	return (diff < (1 << 25)) && (diff > (-1 << 26));
> 
> I think this still isn't right, and the comment is one of those ones
> that is only useful to people who can't read C, as it's just a
> transliteration of the code.

Argh!!! That must be a misfold.  I fixed that code.  The final version 
ad the same shift for both.

> 
> The comment should say something like "Return true if diff can be
> represented as a 26-bit twos-complement binary number" and the second
> part of the test should be (diff >= (-1 << 25)).  However, since you
> define a test_offset() function in patch 4/5 that does the same test
> but using only one comparison instead of two, why don't you just say:
> 
> 	return !test_offset(diff);
> 
> (having first moved test_offset() before test_24bit_addr)?

OK, will fix. Thanks. Hmm, maybe I ment to do that, and miss the patch :-/

-- Steve
