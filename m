Return-Path: <johnpol@2ka.mipt.ru>
Received: from 2ka.mipt.ru (relay.2ka.mipt.ru [194.85.82.65])
	by ozlabs.org (Postfix) with ESMTP id 1D772DDF87
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 22:24:20 +1000 (EST)
Date: Tue, 28 Aug 2007 16:16:19 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070828121617.GA4160@2ka.mipt.ru>
References: <46D2F301.7050105@katalix.com>
	<20070827.145600.102570576.davem@davemloft.net>
	<46D3E971.4010909@katalix.com>
	<200708281348.21302.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708281348.21302.ossthema@de.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, James Chapman <jchapman@katalix.com>,
	raisch@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akepner@sgi.com, meder@de.ibm.com,
	shemminger@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 01:48:20PM +0200, Jan-Bernd Themann (ossthema@de.ibm.com) wrote:
> I'm not sure if I understand your approach correctly.
> This approach may reduce the number of interrupts, but it does so
> by blocking the CPU for up to 1 jiffy (that can be quite some time
> on some platforms). So no other application / tasklet / softIRQ type
> can do anything in between. The CPU utilization does not drop at all, 
> and I thought that is one reason why we try to reduce the number of interrupts.

Only NICs interrupts are suposed to be stopped, system will continue to
work as usual, since all others are alive.
Having hrtimer to reshcedule NIC procesing can work only if number of
timer's interrupts are much less than NICs and if rate of the timer's
starts/changes (presumbly in NICs interrupt) is small too, otherwise
having too many NIC interrupts will not gain anything (actually it is
what is supposed to be dropped noticebly).

-- 
	Evgeniy Polyakov
