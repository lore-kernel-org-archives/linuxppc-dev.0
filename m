Return-Path: <benh@kernel.crashing.org>
Subject: Re: can't boot mpc5200, powerpc: Enable AT_BASE_PLATFORM aux vector
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080725220038.GI9594@localdomain>
References: <9e4733910807251451s623b87cetcf7ed5ff6a12f012@mail.gmail.com>
	<20080725220038.GI9594@localdomain>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 08:15:08 +1000
Message-Id: <1217024108.11188.117.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 17:00 -0500, Nathan Lynch wrote:
> Jon Smirl wrote:
> > I've lost my ability to boot on the mpc5200. Reverting this patch fixes it.
> 
> How does it fail?
> 
> 
> > @@ -1652,6 +1655,14 @@ struct cpu_spec * __init identify_cpu(unsigned
> > long offset, unsigned int pvr)
> >  			} else
> >  				*t = *s;
> >  			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
> > +
> > +			/*
> > +			 * Set the base platform string once; assumes
> > +			 * we're called with real pvr first.
> > +			 */
> > +			if (powerpc_base_platform == NULL)
> > +				powerpc_base_platform = t->platform;
> > +
> 
> Hmm, maybe this needs RELOC/PTRRELOC tricks?

Hrm... indeed.

if (RELOC(powerpc_base_platform))
	RELOC(powerpc_base_platform) = t->platform;

try that.

Ben.
