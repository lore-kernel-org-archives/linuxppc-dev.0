Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD2B7DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 12:14:14 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3315f3m014522
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 21:05:41 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n331EA12196926
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 21:14:10 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n331EAIK030803
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 21:14:10 -0400
Date: Thu, 2 Apr 2009 21:13:27 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] powerpc ptrace block-step
Message-ID: <20090403011327.GA16881@zod.rchland.ibm.com>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
	<1238650016.17330.193.camel@pasglop>
	<20090403004450.F2166FC3AB@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090403004450.F2166FC3AB@magilla.sf.frob.com>
Cc: utrace-devel@redhat.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 02, 2009 at 05:44:50PM -0700, Roland McGrath wrote:
>> The patch only implements it for "server/classic" processors, not BookE,
>> thus it should probably only advertise it for these :-)
>>
>> Though it wouldn't be too hard to implement it for BookE using DBCR0:BRT
>> (Branch Taken debug event) though it might need some careful fixups such
>> as the one we have for single step regarding hitting exception entry
>> code.
>
>In that case, this code seems fairly mysterious:
>
>> > +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>> > +		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
>> > +		regs->msr |= MSR_DE;
>
>That doesn't already do whatever it is you described?
>
>Can we assume now that you or someone else who knows what all that means
>will take this up?

I will try and look at the patch a bit more tomorrow, yes.

I don't think having it working for BookE is really a requirement before this
gets in though.  If we can get it working with minimal effort for ppc64, that
would help get systemtap and related things functioning correctly there.

While I would love to believe that systemtap should work everywhere, I can't
really see it running on an embedded board at this point.

josh
