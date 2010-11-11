Return-Path: <subrata@linux.vnet.ibm.com>
Subject: Re: [linux-2.6.36-git7: Power7] LTP Memory CGROUP Controller
	functional test creates Backtrace,
	OOMKill & rcu_sched_state detected stall jiffies
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20101027094502.208c1207.kamezawa.hiroyu@jp.fujitsu.com>
References: <1288089237.5010.9.camel@subratamodak.linux.ibm.com>
	<20101027094502.208c1207.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 11 Nov 2010 13:27:25 +0530
Message-Id: <1289462245.5622.46.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Li Zefan <lizf@cn.fujitsu.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ltp-list <ltp-list@lists.sf.net>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-10-27 at 09:45 +0900, KAMEZAWA Hiroyuki wrote: 
> On Tue, 26 Oct 2010 16:03:56 +0530
> Subrata Modak <subrata@linux.vnet.ibm.com> wrote:
> 
> > If you run LTP Memory CGROUP Controller functional test on
> > linux-2.6.36-git7, the following Backtrace, OOMKill & rcu_sched_state
> > detected stall jiffies are created. The machine is not reachable
> > thereafter. Ways to reproduce this problem:
> > 
> > 1) Build and boot kernel 2.6.36-git7 on Power7 machine with attached
> > config file,
> > 2) Fetch, build and install LTP:
> > 	git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
> > 	cd ltp
> > 	./configure
> > 	make
> > 	make install
> > 3) Create a LTP runtest file /opt/ltp/runtest/memcg_function_test with
> > the following entry:
> > memcg_function          memcg_function_test.sh
> > <<EOF>>
> > 	cd /opt/ltp
> > 	./runltp -f memcg_function_test
> > 
> 
> IIUC, memcg test includes intentional OOM-Kill test by setting the limit to 0.
> And it has another test to set the limit to PAGE_SIZE.
> 
> In your environemnt, I think page size is 64kb...right ?
> 
> About rcu_sched_state()....I have no idea at this stage. I reviewed memcontrol.c
> and oom_kill.c again and coundn't found anything in quick review.
> 
> Could you try again after -rc1 shipped ?

Oh Sure, I saw this mail now. I will try it out on the latest git tree
available :-)

Regards--
Subrata

> I think Andrew Morton sent some amount of updates for oom_kill and memcg, vmscan
> to Linus, today.
> 
> Thanks,
> -Kame
> 
