Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 0646A679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 01:23:40 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 23 Feb 2006 07:23:37 -0700
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
Message-ID: <20060223142337.GA6161@xyzzy.farnsworth.org>
References: <Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
	<1140692043.2892.1.camel@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1140692043.2892.1.camel@yoda.jdub.homelinux.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2006 at 10:54:02AM +0000, Josh Boyer wrote:
> On Wed, 2006-02-22 at 22:19 -0600, Kumar Gala wrote:
> > On Tue, 14 Feb 2006, Dale Farnsworth wrote:
> > 
> > > From: Dale Farnsworth <dale@farnsworth.org>
> > > 
> > > On PPC Book E processsors, we currently handle debug
> > > exceptions on the critical exception stack (debug stack
> > > for E200).  This causes problems with the kgdb single
> > > step handler, which calls smp_processor_id() and spin_lock(),
> > > which reference current_thread_info(), which only works when
> > > we are on the kernel stack.
> > > 
> > > We address this by switching to the kernel stack early while
> > > handling debug exceptions.  Note that the entry values of r10
> > > and r11 are still saved on the critical exception (or debug) stack.
> > > 
> > > Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> > 
> > Paul,
> > 
> > We were wondering if you or David remember why a specific critical
> > exception stack was added in the 40x port from 2.4 to 2.6?
> 
> I think Matt did that.  And if I remember correctly, it was to avoid
> corruption if you were in the middle of handling a normal interrupt and
> a critical interrupt came in.

Thanks Josh, Matt was one of the "we" who were wondering.  If indeed
you are remembering correctly, then I think we're safe to use the
normal kernel stack rather than the critical exception stack.

-Dale
