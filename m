Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF149DDF1C
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 02:51:15 +1000 (EST)
Date: Fri, 24 Aug 2007 11:51:10 -0500
To: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070824165110.GH4282@austin.ibm.com>
References: <200708241559.17055.ossthema@de.ibm.com>
	<20070824153703.GN5592@sgi.com>
	<200708241747.16592.ossthema@de.ibm.com>
	<20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Eder <meder@de.ibm.com>,
	akepner@sgi.com, Stefan Roscher <stefan.roscher@de.ibm.com>,
	Marcus@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 08:52:03AM -0700, Stephen Hemminger wrote:
> 
> You need hardware support for deferred interrupts. Most devices have it (e1000, sky2, tg3)
> and it interacts well with NAPI. It is not a generic thing you want done by the stack,
> you want the hardware to hold off interrupts until X packets or Y usecs have expired.

Just to be clear, in the previous email I posted on this thread, I
described a worst-case network ping-pong test case (send a packet, wait
for reply), and found out that a deffered interrupt scheme just damaged
the performance of the test case.  Since the folks who came up with the
test case were adamant, I turned off the defferred interrupts.  
While defferred interrupts are an "obvious" solution, I decided that 
they weren't a good solution. (And I have no other solution to offer).

--linas
