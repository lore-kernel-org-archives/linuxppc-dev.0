Return-Path: <dlstevens@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CDAFEDDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 02:51:08 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7OGp1JK022880
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 12:51:01 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7OGp18K235210
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 10:51:01 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7OGp0K3011225
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 10:51:00 -0600
In-Reply-To: <20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
To: Stephen Hemminger <shemminger@linux-foundation.org>
MIME-Version: 1.0
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <OF0002C3DB.2E4C4A38-ON88257341.005B1253-88257341.005C7C2A@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Fri, 24 Aug 2007 09:50:58 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, netdev-owner@vger.kernel.org,
	linux-ppc <linuxppc-dev@ozlabs.org>, akepner@sgi.com,
	Marcus Eder <meder@de.ibm.com>, Jan-Bernd Themann <ossthema@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Hemminger <shemminger@linux-foundation.org> wrote on 08/24/2007 
08:52:03 AM:

> 
> You need hardware support for deferred interrupts. Most devices have it 
> (e1000, sky2, tg3)
> and it interacts well with NAPI. It is not a generic thing you want done 
by the stack,
> you want the hardware to hold off interrupts until X packets or Y usecs 
have expired.

        For generic hardware that doesn't support it, couldn't you use an 
estimater
and adjust the timer dynamicly in software based on sampled values? Switch 
to per-packet
interrupts when the receive rate is low...
        Actually, that's how I thought NAPI worked before I found out 
otherwise (ie,
before I looked :-)).

        The hardware-accelerated one is essentially siloing as done by 
ancient serial
devices on UNIX systems. If you had a tunable for a target count, and an 
estimator
for the time interval, then switch to per-packet when the estimator 
exceeds a tunable
max threshold (and also, I suppose, if you near overflowing the ring on 
the min
timer granularity), you get almost all of it, right?
        Problem is if it increases rapidly, you may drop packets before 
you notice
that the ring is full in the current estimated interval.

 +-DLS
