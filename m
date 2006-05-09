Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0973B679E9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 09:36:11 +1000 (EST)
In-Reply-To: <adalktbcgl1.fsf@cisco.com>
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com>
	<44608C90.30909@de.ibm.com> <adalktbcgl1.fsf@cisco.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75CCC04D-06EF-48B6-BE76-8BFAA541A764@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
Date: Wed, 10 May 2006 01:35:57 +0200
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>     Heiko> Yes, I agree. It would not be an optimal solution, because
>     Heiko> other upper level protocols (e.g. SDP, SRP, etc.) or
>     Heiko> userspace verbs would not be affected by this
>     Heiko> changes. Nevertheless, how can an improved "scaling" or
>     Heiko> "SMP" version of IPoIB look like. How could it be
>     Heiko> implemented?
>
> The trivial way to do it would be to use the same idea as the current
> ehca driver: just create a thread for receive CQ events and a thread
> for send CQ events, and defer CQ polling into those two threads.
>
> Something even better may be possible by specializing to IPoIB of  
> course.

The hardware IRQ should go to some CPU close to the hardware itself.   
The
softirq (or whatever else) should go to the same CPU that is handling  
the
user-level task for that message.  Or a CPU close to it, at least.


Segher
