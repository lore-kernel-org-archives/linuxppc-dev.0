Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 7F94B2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 07:06:11 +1000 (EST)
Message-ID: <1371243967.9844.338.camel@gandalf.local.home>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Date: Fri, 14 Jun 2013 17:06:07 -0400
In-Reply-To: <1645938.As0LR1yeVd@pcimr>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com> <1645938.As0LR1yeVd@pcimr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-14 at 14:46 +0200, Rojhalat Ibrahim wrote:
> On Friday 14 June 2013 05:28:00 Paul E. McKenney wrote:
> > On Fri, Jun 14, 2013 at 01:47:00PM +0200, Rojhalat Ibrahim wrote:
> > > Hi,
> > > 
> > > the current mainline kernel from git reproducibly hangs on my Freescale
> > > PowerPC P5020DS development system. Most of the time the hang occurs
> > > during
> > > boot (kernel just stops booting, system hangs), sometimes shortly after
> > > booting (system hangs, no message). Very often booting stops at the
> > > initialization of the Intel PRO 1000 PCIe network device (e1000e).

I was pretty much able to reproduce this on my PA Semi PPC box. Funny
thing is, when I type on the console, it makes progress. Anyway, it
seems that powerpc has an issue with irq_work(). I'll try to get some
time either tonight or next week to figure it out.

Thanks!

-- Steve

> > > 
> > > I used git bisect and arrived at this commit:
> > > 
> > > 016a8d5be6ddcc72ef0432d82d9f6fa34f61b907
> > > rcu: Don't call wakeup() with rcu_node structure ->lock held
> > > 
> > > With versions before that commit the system runs normally.
> > 
> > Odd, given that this fix was intended to prevent hangs.  Could you
> > please send your .config?
> > 
> > 							Thanx, Paul
