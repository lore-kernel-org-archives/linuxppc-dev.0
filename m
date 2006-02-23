Return-Path: <dgibson@ozlabs.org>
Date: Fri, 24 Feb 2006 10:49:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
Message-ID: <20060223234945.GB25101@localhost.localdomain>
References: <20060214190700.GB17822@xyzzy.farnsworth.org>
	<Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2006 at 10:19:54PM -0600, Kumar Gala wrote:
> On Tue, 14 Feb 2006, Dale Farnsworth wrote:
> 
> > From: Dale Farnsworth <dale@farnsworth.org>
> > 
> > On PPC Book E processsors, we currently handle debug
> > exceptions on the critical exception stack (debug stack
> > for E200).  This causes problems with the kgdb single
> > step handler, which calls smp_processor_id() and spin_lock(),
> > which reference current_thread_info(), which only works when
> > we are on the kernel stack.
> > 
> > We address this by switching to the kernel stack early while
> > handling debug exceptions.  Note that the entry values of r10
> > and r11 are still saved on the critical exception (or debug) stack.
> > 
> > Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> > 
> 
> Paul,
> 
> We were wondering if you or David remember why a specific critical
> exception stack was added in the 40x port from 2.4 to 2.6?

I don't, in any detail.  But did it have to do with a possible race
with a critical exception in just the wrong part of the normal
exception exit path.  ISTR BenH was worried about something in that
area.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
