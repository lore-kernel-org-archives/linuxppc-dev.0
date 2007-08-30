Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40F9CDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 21:53:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7UBqoWm025585
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Aug 2007 07:52:50 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7UBqnOl458742
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Aug 2007 05:52:49 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7UBqn6V031218
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Aug 2007 05:52:49 -0600
Date: Thu, 30 Aug 2007 06:50:39 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: melinda develey <melinda.develey70@yahoo.com>
Subject: Re: spin_lock doesn't work?!?
Message-ID: <20070830065039.0f660dad@zod.rchland.ibm.com>
In-Reply-To: <762949.1267.qm@web63906.mail.re1.yahoo.com>
References: <20070829214050.8C47A1A2804D@mail19-sin.bigfish.com>
	<762949.1267.qm@web63906.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 29 Aug 2007 23:30:22 -0700 (PDT)
melinda develey <melinda.develey70@yahoo.com> wrote:

>   >You should still put the spin_lock calls into your code because >you
> >never know if someone else will compile it and for another >target. If
> >someone would, for example, compile the same code for a SMP >machine then
> >the spin_lock will actually lock.
> 
>   I used the spinlock both in an interrupt handler to protect a group of variables (because in an interrupt I can't use a semaphore) and the same spinlock in a ioctl handler where the same group of variables is accessed. Is this wrong? I have a 2.6.19.2 linux kernel.

You might want to use spin_lock_irq instead.  That will disable
interrupts in the critical section in the ioctl.  Seems more like what
you are trying to do.

josh
