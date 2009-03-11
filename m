Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 26865DE163
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 16:10:03 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
Date: Tue, 10 Mar 2009 22:09:59 -0700
In-Reply-To: <ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
	(Timur Tabi's message of "Tue, 10 Mar 2009 19:22:28 -0500")
Message-ID: <adaiqmgbq6w.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Alan did have one valid point though.  Determining how long to loop
 > for is architecture-specific.  Using jiffies is bad, because even one
 > jiffy is too long.  Adding a udelay() inside the loop means that it
 > only checks he condition every microsecond.  So the real solution is
 > to use keep looping until a certain amount of time has passed.  This
 > means using an architecture-specific timebase register.

Are there really cases where spinning for 1 jiffy is too long of a
timeout?  It might make sense for the parameter passed in to be in terms
of microseconds but I have a hard time coming up with a case where
having the real timeout be 40 msecs or whatever 1 jiffy ends up being is
a real problem -- after all, this helper is intended for the case where
we expect the condition to become true much sooner than the worst case.

 - R.
