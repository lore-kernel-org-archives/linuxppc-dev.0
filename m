Return-Path: <clg@kaod.org>
Received: from 14.mo4.mail-out.ovh.net (14.mo4.mail-out.ovh.net [46.105.40.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y76X14d7TzDr5L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 20:13:52 +1100 (AEDT)
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 07616C3301
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 10:18:57 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <20171003033615.GA3260@umbus.fritz.box>
 <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
 <20171003065858.GL3260@umbus.fritz.box>
 <87infui863.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <da27cec5-2b09-9fb6-6eee-41b5a57e5127@kaod.org>
Date: Thu, 5 Oct 2017 10:18:51 +0200
MIME-Version: 1.0
In-Reply-To: <87infui863.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> I haven't yet because I fail to understand why the decrementer is not 
>>> interrupting the dying CPU under xics as it is the case under XIVE.
>>
>> Oh.. ok.  This sounds very similar to the problem Nikunj hit under TCG
>> with decrementer interrupts waking up a supposedly dead CPU.  He had a
>> couple of proposed fixes, but we got bogged down trying to work out
>> why  (with TCG at least).
> 
> Yeah, I wasnt able to get to the exact reason for that.

Yes. Tracking all the CPU states is a nightmare.

 * @running: #true if CPU is currently running (lockless).
 * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
 * valid under cpu_list_lock.
 * @created: Indicates whether the CPU thread has been successfully created.
 * @interrupt_request: Indicates a pending interrupt request.
 * @halted: Nonzero if the CPU is in suspended state.
 * @stop: Indicates a pending stop request.
 * @stopped: Indicates the CPU has been artificially stopped.
 * @unplug: Indicates a pending CPU unplug request.


I will spend some more time to understand why XICS is not behaving 
the same. This is really time consuming ...

C.
