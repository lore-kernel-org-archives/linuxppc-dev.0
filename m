Return-Path: <paulus@ozlabs.org>
Date: Fri, 13 Dec 2013 08:19:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom Musta <tommusta@gmail.com>
Subject: Re: [V2 PATCH 3/3] powerpc: Fix Unaligned LE Floating Point Loads
 and Stores
Message-ID: <20131212211921.GA22557@iris.ozlabs.ibm.com>
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
 <1383244738-5986-4-git-send-email-tommusta@gmail.com>
 <20131211035440.GA9399@drongo> <20131211045728.GB9399@drongo>
 <52A9D17E.3000809@gmail.com> <52AA1DA0.80003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52AA1DA0.80003@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 12, 2013 at 02:33:36PM -0600, Tom Musta wrote:
> On 12/12/2013 9:08 AM, Tom Musta wrote:
> > On 12/10/2013 10:57 PM, Paul Mackerras wrote:
> >> On Wed, Dec 11, 2013 at 02:54:40PM +1100, Paul Mackerras wrote:
> > 
> >>> This breaks 32-bit big-endian (as well as making the code longer and
> >>> more complex).
> >>
> >> And in fact none of this code will get executed in little-endian mode
> >> anyway, since we still have this in the middle of emulate_step():
> >>
> >> 	/*
> >> 	 * Following cases are for loads and stores, so bail out
> >> 	 * if we're in little-endian mode.
> >> 	 */
> >> 	if (regs->msr & MSR_LE)
> >> 		return 0;
> >>
> >> Paul.
> >>
> > 
> > See patch 1/3 to explain how it becomes relevant in LE.
> > 
> > I will take another look at the change.
> > 
> 
> It appears that patch 1/3 never got picked up, even though I thought Ben & I
> had worked through that.
> 
> And I agree that the code could be simpler.  I will work up a patch to address
> these two issues.

The other thing that's important for us to know is how you are testing
these changes.  For something like this I'd like to see a description
of the tests you have done in the commit message.

I have been hacking on sstep.c pretty heavily myself recently, so we
will need to coordinate on the changes.

Paul.
