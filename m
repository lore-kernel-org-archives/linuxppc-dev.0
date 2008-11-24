Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18730.1723.708467.812600@drongo.ozlabs.ibm.com>
Date: Mon, 24 Nov 2008 12:43:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/5] powerpc: ftrace,
	convert to new dynamic ftrace arch API
In-Reply-To: <20081120191149.285359258@goodmis.org>
References: <20081120190948.057007623@goodmis.org>
	<20081120191149.285359258@goodmis.org>
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

Steven Rostedt writes:

> Thanks to Paul Mackennas for pointing out the mistakes of my original

Mackerras

> +static int test_24bit_addr(unsigned long ip, unsigned long addr)
> +{
> +	long diff;
> +
> +	/*
> +	 * Can we get to addr from ip in 24 bits?
> +	 *  (26 really, since we mulitply by 4 for 4 byte alignment)
> +	 */
> +	diff = addr - ip;
> +
> +	/*
> +	 * Return true if diff is less than 1 << 25
> +	 *  and greater than -1 << 26.
> +	 */
> +	return (diff < (1 << 25)) && (diff > (-1 << 26));

I think this still isn't right, and the comment is one of those ones
that is only useful to people who can't read C, as it's just a
transliteration of the code.

The comment should say something like "Return true if diff can be
represented as a 26-bit twos-complement binary number" and the second
part of the test should be (diff >= (-1 << 25)).  However, since you
define a test_offset() function in patch 4/5 that does the same test
but using only one comparison instead of two, why don't you just say:

	return !test_offset(diff);

(having first moved test_offset() before test_24bit_addr)?

Paul.
