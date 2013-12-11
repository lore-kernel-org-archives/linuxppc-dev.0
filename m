Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 Dec 2013 15:57:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom <tommusta@gmail.com>
Subject: Re: [V2 PATCH 3/3] powerpc: Fix Unaligned LE Floating Point Loads
 and Stores
Message-ID: <20131211045728.GB9399@drongo>
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
 <1383244738-5986-4-git-send-email-tommusta@gmail.com>
 <20131211035440.GA9399@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131211035440.GA9399@drongo>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 11, 2013 at 02:54:40PM +1100, Paul Mackerras wrote:
> On Thu, Oct 31, 2013 at 01:38:58PM -0500, Tom wrote:
> > From: Tom Musta <tommusta@gmail.com>
> > 
> > This patch addresses unaligned single precision floating point loads
> > and stores in the single-step code.  The old implementation
> > improperly treated an 8 byte structure as an array of two 4 byte
> > words, which is a classic little endian bug.
> > 
> > Signed-off-by: Tom Musta <tommusta@gmail.com>
> > ---
> >  arch/powerpc/lib/sstep.c |   52 +++++++++++++++++++++++++++++++++++----------
> >  1 files changed, 40 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index c8743e1..1cfd150 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -355,22 +355,36 @@ static int __kprobes do_fp_load(int rn, int (*func)(int, unsigned long),
> >  				struct pt_regs *regs)
> >  {
> >  	int err;
> > -	unsigned long val[sizeof(double) / sizeof(long)];
> > +	union {
> > +		double dbl;
> > +		unsigned long ul[2];
> > +		struct {
> > +#ifdef __BIG_ENDIAN__
> > +			unsigned _pad_;
> > +			unsigned word;
> > +#endif
> > +#ifdef __LITTLE_ENDIAN__
> > +			unsigned word;
> > +			unsigned _pad_;
> > +#endif
> > +		} single;
> > +	} data;
> >  	unsigned long ptr;
> >  
> >  	if (!address_ok(regs, ea, nb))
> >  		return -EFAULT;
> >  	if ((ea & 3) == 0)
> >  		return (*func)(rn, ea);
> > -	ptr = (unsigned long) &val[0];
> > +	ptr = (unsigned long) &data.ul;
> >  	if (sizeof(unsigned long) == 8 || nb == 4) {
> > -		err = read_mem_unaligned(&val[0], ea, nb, regs);
> > -		ptr += sizeof(unsigned long) - nb;
> > +		err = read_mem_unaligned(&data.ul[0], ea, nb, regs);
> > +		if (nb == 4)
> > +			ptr = (unsigned long)&(data.single.word);
> >  	} else {
> >  		/* reading a double on 32-bit */
> > -		err = read_mem_unaligned(&val[0], ea, 4, regs);
> > +		err = read_mem_unaligned(&data.ul[0], ea, 4, regs);
> >  		if (!err)
> > -			err = read_mem_unaligned(&val[1], ea + 4, 4, regs);
> > +			err = read_mem_unaligned(&data.ul[1], ea + 4, 4, regs);
> 
> This breaks 32-bit big-endian (as well as making the code longer and
> more complex).

And in fact none of this code will get executed in little-endian mode
anyway, since we still have this in the middle of emulate_step():

	/*
	 * Following cases are for loads and stores, so bail out
	 * if we're in little-endian mode.
	 */
	if (regs->msr & MSR_LE)
		return 0;

Paul.
