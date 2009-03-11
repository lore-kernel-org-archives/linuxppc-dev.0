Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A34ADE179
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 08:50:02 +1100 (EST)
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40903111010l7bd7e2f8r47c7d42184d0a36a@mail.gmail.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
	<1236731097.7086.32.camel@pasglop>
	<fa686aa40903111010l7bd7e2f8r47c7d42184d0a36a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Mar 2009 08:49:50 +1100
Message-Id: <1236808190.7086.61.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> No, not udelay.  Or any delay for that matter.  If spinning on a
> condition, then there is no advantage to burning cycles with a
> udelay().  Those cycles may as well be used to keep testing the
> condition so the loop can be exited faster.  a udelay() would only
> serve to always make the busywait longer.

Well, there's a non-empty set of HW where polling as fast as you can
will effectively prevent it to make fwd progress...

Ben.
