Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id BD1B4DDDDF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 12:44:53 +1100 (EST)
Message-ID: <4935E493.9050402@consentry.com>
Date: Tue, 02 Dec 2008 17:44:51 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>
	<49347317.5080600@consentry.com>
	<200812021207.06140.laurentp@cse-semaphore.com>
In-Reply-To: <200812021207.06140.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Laurent,

> While the problem seems to be similar to CPM98, I don't understand how it 
> could happen on the first character of the first I2C transfer.

I agree, that is hard to explain given that i2c-cpm keeps the controller
shut off until the very moment of the first transfer.  Can you check that
the bus is really idle (SCL is high) when the timeout happens?  If one of
the slave devices is in a bad state and pulling SCL low, I think the
behavior you see is expected (CPM will wait forever for the bus to be
idle).  The same is probably true if a GPIO pin is mis-configured.

> As explained in my previous mail to Joakim, I spent some more time last Friday 
> investigating the problem, and it seems the baud rate generator configuration 
> plays an important role. The default configuration (60kHz nominal => 65.104kHz 
> using a 25MHz brg clock and a /32 predivider) leads to timeouts, while I 
> haven't been able to reproduce the problem with the i2c-mpc8260.c 
> configuration (100kHz nominal => 104.167kHz using a 25MHz brg clock and a /8 
> predivider).

It would be interesting to try each driver with the other's clock settings.

					-=] Mike [=-
