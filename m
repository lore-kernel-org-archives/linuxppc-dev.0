Return-Path: <mrz5149@acm.org>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id D66AB68703
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Nov 2005 02:46:59 +1100 (EST)
Message-ID: <43736557.6020008@acm.org>
Date: Thu, 10 Nov 2005 10:20:55 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: Kalle Pokki <kalle.pokki@iki.fi>
References: <437302CE.8070309@iki.fi>
In-Reply-To: <437302CE.8070309@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC reservations
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle Pokki wrote:

> Am I just not getting how this is really supposed to work? Are there 
> still some other constructs in use to prevent this, e.g. extra stwcx. 
> instructions when changing the thread of execution?

Yes. When a context switch occurs, there's a stcwx. to clear any 
reservations from the previous thread. When you enter another thread 
from a context switch, you enter it with no reservations pending.

So you might have something that looks like this:

thread 1 -> lwarx w/ successful reservation
context switch -> stwcx.. to garbage location to clear any reservations
thread 2 -> stwcx. fails since there's no reservation pending
context switch -> stwcx. to garbage location to clear any reservations
thread 1 -> stwcx. fails since there's no reservation pending
thread 1 -> loops to try lwarx again

So the context switcher protects a reservation from "leaking" into 
another thread. In that sense, you can act as though lwarx/stwcx. pairs 
belong to a single thread.

The other important thing to remember is that there can only be one 
outstanding reservation. Thus, lwarx and stcwx. instructions have to be 
"paired" or you're going to get unexpected results.
