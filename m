Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHffr2W4PzDqpL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 01:49:08 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6QFmj7J094513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 11:49:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bxw812mqb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 11:49:05 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 11:49:04 -0400
Date: Wed, 26 Jul 2017 08:49:00 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dzickus@redhat.com, sfr@canb.auug.org.au, linuxarm@huawei.com,
 npiggin@gmail.com, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170725.141029.676882447882600000.davem@davemloft.net>
 <20170726035545.GG3730@linux.vnet.ibm.com>
 <20170725.210233.1441906980505926406.davem@davemloft.net>
 <20170726041217.GH3730@linux.vnet.ibm.com>
 <20170726091623.000004f7@huawei.com>
 <20170726103232.0000368e@huawei.com>
 <20170726132801.00001e8c@huawei.com>
 <20170726141417.GJ3730@linux.vnet.ibm.com>
 <20170726152315.00003d61@huawei.com>
 <20170726163340.0000014f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170726163340.0000014f@huawei.com>
Message-Id: <20170726154900.GQ3730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 26, 2017 at 04:33:40PM +0100, Jonathan Cameron wrote:
> On Wed, 26 Jul 2017 15:23:15 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Wed, 26 Jul 2017 07:14:17 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > On Wed, Jul 26, 2017 at 01:28:01PM +0100, Jonathan Cameron wrote:  
> > > > On Wed, 26 Jul 2017 10:32:32 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >     
> > > > > On Wed, 26 Jul 2017 09:16:23 +0100
> > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > > >     
> > > > > > On Tue, 25 Jul 2017 21:12:17 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >       
> > > > > > > On Tue, Jul 25, 2017 at 09:02:33PM -0700, David Miller wrote:        
> > > > > > > > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > > > > > > Date: Tue, 25 Jul 2017 20:55:45 -0700
> > > > > > > >           
> > > > > > > > > On Tue, Jul 25, 2017 at 02:10:29PM -0700, David Miller wrote:          
> > > > > > > > >> Just to report, turning softlockup back on fixes things for me on
> > > > > > > > >> sparc64 too.          
> > > > > > > > > 
> > > > > > > > > Very good!
> > > > > > > > >           
> > > > > > > > >> The thing about softlockup is it runs an hrtimer, which seems to run
> > > > > > > > >> about every 4 seconds.          
> > > > > > > > > 
> > > > > > > > > I could see where that could shake things loose, but I am surprised that
> > > > > > > > > it would be needed.  I ran a short run with CONFIG_SOFTLOCKUP_DETECTOR=y
> > > > > > > > > with no trouble, but I will be running a longer test later on.
> > > > > > > > >           
> > > > > > > > >> So I wonder if this is a NO_HZ problem.          
> > > > > > > > > 
> > > > > > > > > Might be.  My tests run with NO_HZ_FULL=n and NO_HZ_IDLE=y.  What are
> > > > > > > > > you running?  (Again, my symptoms are slightly different, so I might
> > > > > > > > > be seeing a different bug.)          
> > > > > > > > 
> > > > > > > > I run with NO_HZ_FULL=n and NO_HZ_IDLE=y, just like you.
> > > > > > > > 
> > > > > > > > To clarify, the symptoms show up with SOFTLOCKUP_DETECTOR disabled.          
> > > > > > > 
> > > > > > > Same here -- but my failure case happens fairly rarely, so it will take
> > > > > > > some time to gain reasonable confidence that enabling SOFTLOCKUP_DETECTOR
> > > > > > > had effect.
> > > > > > > 
> > > > > > > But you are right, might be interesting to try NO_HZ_PERIODIC=y
> > > > > > > or NO_HZ_FULL=y.  So many possible tests, and so little time.  ;-)
> > > > > > > 
> > > > > > > 							Thanx, Paul
> > > > > > >         
> > > > > > I'll be the headless chicken running around and trying as many tests
> > > > > > as I can fit in.  Typical time to see the failure for us is sub 10
> > > > > > minutes so we'll see how far we get.
> > > > > > 
> > > > > > Make me a list to run if you like ;)
> > > > > > 
> > > > > > NO_HZ_PERIODIC=y running now.      
> > > > > By which I mean CONFIG_HZ_PERIODIC=y    
> > > 
> > > I did get that messed up, didn't I?  Sorry for my confusion!
> > >   
> > > > > Anyhow, run for 40 minutes with out seeing a splat but my sanity check
> > > > > on the NO_FULL_HZ=n and NO_HZ_IDLE=y this morning took 20 minutes so
> > > > > I won't have much confidence until we are a few hours in on this.
> > > > > 
> > > > > Anyhow, certainly looking like a promising direction for investigation!
> > > > >     
> > > > Well it's done over 3 hours without a splat so I think it is fine with
> > > > CONFIG_HZ_PERIODIC=y    
> > > 
> > > Thank you!
> > > 
> > > If you run with SOFTLOCKUP_DETECTOR=n and NO_HZ_IDLE=y, but have a normal
> > > user task waking up every few seconds on each CPU, does the problem occur?
> > > (The question is whether any disturbance gets things going, or whether there
> > > is something special about SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y.
> > > 
> > > Dave, any other ideas on what might be causing this or what might be
> > > tested?
> > > 
> > > 							Thanx, Paul
> > >   
> > 
> > Although it's still early days (40 mins in) it looks like the issue first
> > occurred between 4.10-rc7 and 4.11-rc1 (don't ask why those particular RCs)
> > 
> > Bad as with current kernel on 4.11-rc1 and good on 4.10-rc7.
> 
> Didn't leave it long enough. Still bad on 4.10-rc7 just took over
> an hour to occur.

And it is quite possible that SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y
are just greatly reducing the probability of the problem rather than
completely preventing it.

Still, hopefully useful information, thank you for the testing!

							Thanx, Paul

> > Could be something different was hiding it in 4.10 though.  We have a fair
> > delta from mainline back then unfortunately so bisecting will be
> > 'interesting'.
> > 
> > I'll see if I can get the test you suggest running.
> > 
> > Jonathan
> > _______________________________________________
> > linuxarm mailing list
> > linuxarm@huawei.com
> > http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
> 
