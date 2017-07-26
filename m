Return-Path: <jonathan.cameron@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHZCQ6ZsrzDqnC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 22:28:34 +1000 (AEST)
Date: Wed, 26 Jul 2017 13:28:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: <dzickus@redhat.com>, <sfr@canb.auug.org.au>, <linuxarm@huawei.com>,
 <npiggin@gmail.com>, <abdhalee@linux.vnet.ibm.com>,
 <sparclinux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170726132801.00001e8c@huawei.com>
In-Reply-To: <20170726103232.0000368e@huawei.com>
References: <20170725175207.000001cb@huawei.com>
 <20170725.141029.676882447882600000.davem@davemloft.net>
 <20170726035545.GG3730@linux.vnet.ibm.com>
 <20170725.210233.1441906980505926406.davem@davemloft.net>
 <20170726041217.GH3730@linux.vnet.ibm.com>
 <20170726091623.000004f7@huawei.com>
 <20170726103232.0000368e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Jul 2017 10:32:32 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 26 Jul 2017 09:16:23 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Tue, 25 Jul 2017 21:12:17 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >   
> > > On Tue, Jul 25, 2017 at 09:02:33PM -0700, David Miller wrote:    
> > > > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > > Date: Tue, 25 Jul 2017 20:55:45 -0700
> > > >       
> > > > > On Tue, Jul 25, 2017 at 02:10:29PM -0700, David Miller wrote:      
> > > > >> Just to report, turning softlockup back on fixes things for me on
> > > > >> sparc64 too.      
> > > > > 
> > > > > Very good!
> > > > >       
> > > > >> The thing about softlockup is it runs an hrtimer, which seems to run
> > > > >> about every 4 seconds.      
> > > > > 
> > > > > I could see where that could shake things loose, but I am surprised that
> > > > > it would be needed.  I ran a short run with CONFIG_SOFTLOCKUP_DETECTOR=y
> > > > > with no trouble, but I will be running a longer test later on.
> > > > >       
> > > > >> So I wonder if this is a NO_HZ problem.      
> > > > > 
> > > > > Might be.  My tests run with NO_HZ_FULL=n and NO_HZ_IDLE=y.  What are
> > > > > you running?  (Again, my symptoms are slightly different, so I might
> > > > > be seeing a different bug.)      
> > > > 
> > > > I run with NO_HZ_FULL=n and NO_HZ_IDLE=y, just like you.
> > > > 
> > > > To clarify, the symptoms show up with SOFTLOCKUP_DETECTOR disabled.      
> > > 
> > > Same here -- but my failure case happens fairly rarely, so it will take
> > > some time to gain reasonable confidence that enabling SOFTLOCKUP_DETECTOR
> > > had effect.
> > > 
> > > But you are right, might be interesting to try NO_HZ_PERIODIC=y
> > > or NO_HZ_FULL=y.  So many possible tests, and so little time.  ;-)
> > > 
> > > 							Thanx, Paul
> > >     
> > I'll be the headless chicken running around and trying as many tests
> > as I can fit in.  Typical time to see the failure for us is sub 10
> > minutes so we'll see how far we get.
> > 
> > Make me a list to run if you like ;)
> > 
> > NO_HZ_PERIODIC=y running now.  
> By which I mean CONFIG_HZ_PERIODIC=y
> 
> Anyhow, run for 40 minutes with out seeing a splat but my sanity check
> on the NO_FULL_HZ=n and NO_HZ_IDLE=y this morning took 20 minutes so
> I won't have much confidence until we are a few hours in on this.
> 
> Anyhow, certainly looking like a promising direction for investigation!
> 
Well it's done over 3 hours without a splat so I think it is fine with
CONFIG_HZ_PERIODIC=y


> Jonathan
> 
> > 
> > Jonathan
> > 
> > _______________________________________________
> > linuxarm mailing list
> > linuxarm@huawei.com
> > http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm  
> 
> 
> _______________________________________________
> linuxarm mailing list
> linuxarm@huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
