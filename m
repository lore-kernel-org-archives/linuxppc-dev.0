Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D238ADDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 16:14:46 +1100 (EST)
Date: Tue, 23 Jan 2007 00:10:40 -0500
From: Sonny Rao <sonny@burdell.org>
To: Adam Litke <agl@us.ibm.com>, linuxppc-dev@ozlabs.org,
	libhugetlbfs-devel@lists.sourceforge.net, nacc@us.ibm.com
Subject: Re: [Libhugetlbfs-devel] 2.6.19: kernel BUG in hugepd_page at
	arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070123051040.GA17272@kevlar.boston.burdell.org>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
	<1168632510.12413.62.camel@localhost.localdomain>
	<20070112204250.GA2290@kevlar.boston.burdell.org>
	<20070112224348.GA18201@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070112224348.GA18201@localhost.localdomain>
Cc: sonnyrao@us.ibm.com, anton@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 13, 2007 at 09:43:48AM +1100, David Gibson wrote:
> On Fri, Jan 12, 2007 at 03:42:50PM -0500, Sonny Rao wrote:
> > On Fri, Jan 12, 2007 at 02:08:30PM -0600, Adam Litke wrote:
> > > On Fri, 2007-01-12 at 14:57 -0500, Sonny Rao wrote:
> > > > (Apologies if this is a re-post)
> > > > 
> > > > Hi, I was running 2.6.19 and running some benchmarks using
> > > > libhugetlbfs (1.0.1) and I can fairly reliably trigger this bug:
> > > 
> > > Is this triggered by a libhugetlbfs test case?  If so, which one?
> > 
> > Ok so the testsuite all passed except for "slbpacaflush" which said
> > "PASS (inconclusive)" ... not sure if that is expected or not. 
> 
> I used "PASS (inconclusive)" to mean: you're probably ok, but the bug
> in question is non-deterministically triggered, so maybe we just got
> lucky.
> 
> This testcase attempts to trigger a bunch of times (50?), but the
> conditions are sufficiently dicey that a false PASS is still a
> realistic possibility (I've seen it happen, but not often).  Some
> other tests (e.g. alloc-instantiate-race) are technically
> non-deterministic too, but I've managed to device trigger conditions
> which are reliable in practice, those tests report plain PASS.


Ok, I have figured out what is happening.. here we go

I have a 32bit process and I make sure ulimit -s is set to unlimited
beforehand.  When libhugetlbfs sets up the text and data sections it
temporarily maps a hugepage at 0xe0000000 and tears it down after
copying the contents in.  Then later the stack grows to the point that
it runs into that segment.

The problem is that we never clear out the bits in
mm->context.low_htlb_areas once they're set... so the arch-specific
code thinks it is handling a huge page while the generic code thinks
we're instantiating a regular page.

Specifically, follow_page() in mm/memory.c unconditionally calls
arch-specific follow_huge_page() to determine if it's a huge page.  We
look at the bits in context.low_htlb_areas and determine that it is a
huge page, even though the VM thinks it's a stack page resulting in
confusion and dead kernels.  The basic problem seems to be that we
never cleared out that bit when we unmapped the file, and I've even
hit this problem in other ways (with gdb debugging the process and
trying to touch the area in question, get a NULL ptep and die);

I have a testcase which will demonstrate the fail on 2.6.19 and
2.6.20-rc4 using 64k or 4k pages below.

You must set ulimit -s unlimited before running the case to cause the
fail.. I tried setting it using programatically using setrlimit(3) but
that didn't reproduce the fail for some reason...

Messy. I'll leave it to you guys to figure out what to do.

Sonny

uncesessarily complex testcase source below:

/* ulimit -s unlimited */
/* gcc -m32 -O2 -Wall -B /usr/local/share/libhugetlbfs -Wl,--hugetlbfs-link=BDT  */
static char buf[1024 * 1024 * 16 * 10];

/* outwit the optimizer, since we were foolish enough to turn on optimization */
/* Without all the "buf" gunk, GCC was smart enough to emit a branch to self */
/* and no stack frames */
int recurse_forever(int n) 
{
	char buf[256] = { 0xff, };
	int ret = n * recurse_forever(n+1); 
	return ret + buf[n % 256];
}

int main(int argc, char *argv[])
{
	int i = 0;
	for( i = 0; i< 1024 * 1024 * 16 * 10; i++) {
		buf[i] = 0xff;
	}
	return recurse_forever(1);

}
