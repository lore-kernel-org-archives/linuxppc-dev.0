Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 4FA2F67A33
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 05:52:53 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 24 Feb 2006 11:52:51 -0700
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
Message-ID: <20060224185251.GA9084@xyzzy.farnsworth.org>
References: <20060214190700.GB17822@xyzzy.farnsworth.org>
	<Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
	<20060223234945.GB25101@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060223234945.GB25101@localhost.localdomain>
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

On Fri, Feb 24, 2006 at 10:49:45AM +1100, David Gibson wrote:
> On Wed, Feb 22, 2006 at 10:19:54PM -0600, Kumar Gala wrote:
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
> > > 
> > 
> > Paul,
> > 
> > We were wondering if you or David remember why a specific critical
> > exception stack was added in the 40x port from 2.4 to 2.6?
> 
> I don't, in any detail.  But did it have to do with a possible race
> with a critical exception in just the wrong part of the normal
> exception exit path.  ISTR BenH was worried about something in that
> area.

There's a race between a critical exception and the normal exception
entry path.  If a normal exception occurs in user mode and then a
critical exception occurs before the normal exception handler has set
r1 to the kernel stack area, we end up with r1 containing the user sp,
though the critical exception occurred in kernel mode.

I haven't yet come up with a way to detect this case and reliably use
the kernel stack on a critical exception.

-Dale
