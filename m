Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18669.28058.495259.72182@cargo.ozlabs.ibm.com>
Date: Thu, 9 Oct 2008 13:34:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
In-Reply-To: <20081008154212.GA21723@secretlab.ca>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> On Wed, Oct 08, 2008 at 04:39:13PM +0200, Dominik Bozek wrote:
> > Hi all,
> > 
> > I have done a test of memcpy() and __copy_tofrom_user() on the mpc8313.
> > And the major conclusion is that __copy_tofrom_user is more efficient
> > than memcpy. Sometimes about 40%.
> > 
> > If I good understand, the memcpy() just copy the data, while
> > __copy_tofrom_user() take care if the memory wasn't swapped out. So then
> > memcpy() shall be faster than __copy_tofrom_user(). Am I right?
> > Is here anybody, who can confirm such results and maybe is able to
> > improve the memcpy()?

When I looked at this last (which was a few years ago, I'll admit), I
found that the vast majority of memcpy calls were for small copies,
i.e. less than 128 bytes, whereas __copy_tofrom_user was often used
for larger copies (usually 1 page).  So with memcpy the focus was more
on keeping the startup costs low, while __copy_tofrom_user was
optimized more for bandwidth.

The other point is that the kernel memcpy doesn't consume a noticeable
amount of CPU time (at least not on any workload I've seen), so it
hasn't been a target for aggressive optimization.

Paul.
