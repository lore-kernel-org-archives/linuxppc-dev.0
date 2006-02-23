Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-70-125.roch.qwest.net [67.41.70.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF27B679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Feb 2006 22:53:42 +1100 (EST)
Subject: Re: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 05:54:02 -0500
Message-Id: <1140692043.2892.1.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-02-22 at 22:19 -0600, Kumar Gala wrote:
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

I think Matt did that.  And if I remember correctly, it was to avoid
corruption if you were in the middle of handling a normal interrupt and
a critical interrupt came in.

josh
