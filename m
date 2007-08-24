Return-Path: <SRS0=dWc9=NV=gmx.de=7eggert@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id B33FFDDD0D
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 05:10:21 +1000 (EST)
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: RFC: issues concerning the next NAPI interface
To: Linas Vepstas <linas@austin.ibm.com>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
Date: Fri, 24 Aug 2007 21:04:56 +0200
References: <8VHRR-45R-17@gated-at.bofh.it> <8VKwj-8ke-27@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1IOeSm-0000bm-Jo@be1.lrz>
Reply-To: 7eggert@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas <linas@austin.ibm.com> wrote:
> On Fri, Aug 24, 2007 at 03:59:16PM +0200, Jan-Bernd Themann wrote:

>> 3) On modern systems the incoming packets are processed very fast. Especially
>> on SMP systems when we use multiple queues we process only a few packets
>> per napi poll cycle. So NAPI does not work very well here and the interrupt
>> rate is still high.
> 
> I saw this too, on a system that is "modern" but not terribly fast, and
> only slightly (2-way) smp. (the spidernet)
> 
> I experimented wih various solutions, none were terribly exciting.  The
> thing that killed all of them was a crazy test case that someone sprung on
> me:  They had written a worst-case network ping-pong app: send one
> packet, wait for reply, send one packet, etc.
> 
> If I waited (indefinitely) for a second packet to show up, the test case
> completely stalled (since no second packet would ever arrive).  And if I
> introduced a timer to wait for a second packet, then I just increased
> the latency in the response to the first packet, and this was noticed,
> and folks complained.

Possible solution / possible brainfart:

Introduce a timer, but don't start to use it to combine packets unless you
receive n packets within the timeframe. If you receive less than m packets
within one timeframe, stop using the timer. The system should now have a
decent response time when the network is idle, and when the network is
busy, nobody will complain about the latency.-)
-- 
Funny quotes:
22. When everything's going your way, you're in the wrong lane and and going
    the wrong way.
Friﬂ, Spammer: rsRxhvmk@CaR.7eggert.dyndns.org m@z3T.7eggert.dyndns.org
