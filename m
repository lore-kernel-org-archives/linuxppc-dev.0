Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D713140084
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 02:33:34 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 10 May 2014 10:33:32 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 379481FF003D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 10:33:31 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4AGWegT3080682
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 18:32:41 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s4AGbMWM020102
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 10:37:22 -0600
Date: Sat, 10 May 2014 09:33:28 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
Message-ID: <20140510163328.GA4827@linux.vnet.ibm.com>
References: <20140509174712.55fe72d0@kryten>
 <20140509134113.GP8754@linux.vnet.ibm.com>
 <20140509215005.GA28239@visitor2.iram.es>
 <20140509220845.GY8754@linux.vnet.ibm.com>
 <20140510063337.GA13634@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140510063337.GA13634@iris.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 10, 2014 at 04:33:37PM +1000, Paul Mackerras wrote:
> On Fri, May 09, 2014 at 03:08:45PM -0700, Paul E. McKenney wrote:
> > On Fri, May 09, 2014 at 11:50:05PM +0200, Gabriel Paubert wrote:
> > > On Fri, May 09, 2014 at 06:41:13AM -0700, Paul E. McKenney wrote:
> > > > On Fri, May 09, 2014 at 05:47:12PM +1000, Anton Blanchard wrote:
> > > > > I am seeing an issue where a CPU running perf eventually hangs.
> > > > > Traces show timer interrupts happening every 4 seconds even
> > > > > when a userspace task is running on the CPU.
> > > > 
> > > > Is this by chance every 4.2 seconds?  The reason I ask is that
> > > > Paul Clarke and I are seeing an interrupt every 4.2 seconds when
> > > > he runs NO_HZ_FULL, and are trying to get rid of it.  ;-)
> > > 
> > > Hmmm, it's close to 2^32 nanoseconds, isnt't it suspiscious?
> > 
> > Now that you mention it...  ;-)
> > 
> > So you are telling me that we are not succeeding in completely turning
> > off the decrementer interrupt?
> 
> There is no way to turn off the decrementer interrupt without turning
> off external (device) interrupts.
> 
> On IBM Power CPUs since POWER6, the decrementer runs at 512MHz.  If
> you set the decrementer to 0x7fffffff it will interrupt in 4.194
> seconds, so that would be what you're seeing.  The only way to avoid
> the interrupt becoming pending is to keep on setting it to a large
> value before it gets to -1.
> 
> If an interrupt every 4.2 seconds is a problem in some applications,
> then we need to talk to the Power architects.

Thank you for filling me in on this!  Might be worth doing just that.

							Thanx, Paul
