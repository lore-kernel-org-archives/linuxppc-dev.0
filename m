Return-Path: <SRS0+974f8591537a7899356a+1637+infradead.org+arjan@pentafluge.srs.infradead.org>
Date: Sat, 16 Feb 2008 10:39:27 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080216103927.2a02352b@laptopd505.fenrus.org>
In-Reply-To: <47B72BFE.9060302@am.sony.com>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <12o3l@tiscali.nl>,
	Willy Tarreau <w@1wt.eu>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 16 Feb 2008 10:31:26 -0800
Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> On 02/16/2008 09:42 AM, Arjan van de Ven wrote:
> > On Sat, 16 Feb 2008 18:33:16 +0100
> > Willy Tarreau <w@1wt.eu> wrote:
> > 
> >> On Sat, Feb 16, 2008 at 09:25:52AM -0800, Arjan van de Ven wrote:
> >> > On Sat, 16 Feb 2008 17:08:01 +0100
> >> > Roel Kluin <12o3l@tiscali.nl> wrote:
> >> > 
> >> > > The patch below was not yet tested. If it's correct as it is,
> >> > > please comment. ---
> >> > > Fix Unlikely(x) == y
> >> > > 
> >> > 
> >> > you found a great set of bugs..
> >> > but to be honest... I suspect it's just best to remove unlikely
> >> > altogether for these cases; unlikely() is almost a
> >> > go-faster-stripes thing, and if you don't know how to use it you
> >> > shouldn't be using it... so just removing it for all wrong cases
> >> > is actually the best thing to do imo.
> >> 
> >> Well, eventhough the author may not know how to use it, "unlikely"
> >> at least indicates the intention of the author, or his knowledge
> >> of what should happen here. I'd suggest leaving it where it is
> >> because the authot of this code is in best position to know that
> >> this branch is unlikely to happen, eventhough he does not
> >> correctly use the macro.
> >>
> > 
> > you have more faith in the authors knowledge of how his code
> > actually behaves than I think is warranted  :) Or faith in that he
> > knows what "unlikely" means. I should write docs about this; but
> > unlikely() means: 1) It happens less than 0.01% of the cases.
> > 2) The compiler couldn't have figured this out by itself
> >    (NULL pointer checks are compiler done already, same for some
> > other conditions) 3) It's a hot codepath where shaving 0.5 cycles
> > (less even on x86) matters (and the author is ok with taking a 500
> > cycles hit if he's wrong)
> > 
> > If you think unlikely() means something else, we should fix what it
> > maps to towards gcc ;) (to.. be empty ;)
> 
> Well, I didn't consider what today's compiler does, but used it as a
> general indicator, because I think that code will be around a long
> time.  If you show me some test results that prove it causes harm I
> might consider removing it. 

for mordern (last 10 years) x86 cpus... the cpu branchpredictor is better
than the coder in general. Same for most other architectures.

unlikely() creates bigger code as well.

Now... we're talking about your super duper hotpath function here right?
One where you care about 0.5 cycle speed improvement? (less on modern
systems ;)

Because if not, the bigger code and general "compiler second guessing" is just
more harmful than good, shown already here by the fact that the code was just incorrect
as a virtue of having the unlikely() in.

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
