Return-Path: <michael@ellerman.id.au>
Date: Fri, 28 Jun 2013 00:16:31 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4] powerpc: Rename and flesh out the facility
 unavailable exception handler
Message-ID: <20130627141631.GA13867@concordia>
References: <1372146477-4338-1-git-send-email-michael@ellerman.id.au>
 <1372146477-4338-3-git-send-email-michael@ellerman.id.au>
 <20130627140539.5ff63bad1e7e99e5526d0f3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130627140539.5ff63bad1e7e99e5526d0f3d@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 27, 2013 at 02:05:39PM +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Tue, 25 Jun 2013 17:47:56 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> > -void tm_unavailable_exception(struct pt_regs *regs)
> > +void facility_unavailable_exception(struct pt_regs *regs)
> >  {
> > +	static char *facility_strings[] = {
> > +		"FPU",
> > +		"VMX/VSX",
> > +		"DSCR",
> > +		"PMU SPRs",
> > +		"BHRB",
> > +		"TM",
> > +		"AT",
> > +		"EBB",
> > +		"TAR",
> > +	};
> 
> Are the indexes into this array defined somewhere?  If not, can we do
> that.  Then, can we use explicit indexed initialisers for this array?

I'm not sure I follow.

The mapping is defined by the definition of the "Interruption Cause"
field of the FSCR, section 6.2.10 of PowerISA v2.07.

cheers
