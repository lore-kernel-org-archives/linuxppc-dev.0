Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF6D32C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 17:27:52 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 16 Jun 2013 01:27:50 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 354F3C90049
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 03:27:47 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5G7Rlkn317562
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 03:27:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5G7RlBr012909
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 04:27:47 -0300
Date: Sun, 16 Jun 2013 15:27:45 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 21/27] powerpc/eeh: Process interrupts caused by EEH
Message-ID: <20130616072744.GA3845@shangw.(null)>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371286998-2842-22-git-send-email-shangw@linux.vnet.ibm.com>
 <1371359531.21896.128.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371359531.21896.128.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 16, 2013 at 03:12:11PM +1000, Benjamin Herrenschmidt wrote:
>On Sat, 2013-06-15 at 17:03 +0800, Gavin Shan wrote:
>> On PowerNV platform, the EEH event is produced either by detect
>> on accessing config or I/O registers, or by interrupts dedicated
>> for EEH report. The patch adds support to process the interrupts
>> dedicated for EEH report.
>> 
>> Firstly, the kernel thread will be waken up to process incoming
>> interrupt. The PHBs will be scanned one by one to process all
>> existing EEH errors. Besides, There're mulple EEH errors that can
>> be reported from interrupts and we have differentiated actions
>> against them:
>> 
>> - If the IOC is dead, all PCI buses under all PHBs will be removed
>>   from the system.
>> - If the PHB is dead, all PCI buses under the PHB will be removed
>>   from the system.
>> - If the PHB is fenced, EEH event will be sent to EEH core and
>>   the fenced PHB is expected to be resetted completely.
>> - If specific PE has been put into frozen state, EEH event will
>>   be sent to EEH core so that the PE will be resetted.
>> - If the error is informational one, we just output the related
>>   registers for debugging purpose and no more action will be
>>   taken.
>

Thanks for the review, Ben.

>Getting better.... but:
>
> - I still don't like having a kthread for that. Why not use schedule_work() ?
>

Ok. Will update it with schedule_work() in next revision :-)

> - We already have an EEH thread, why not just use it ? IE send it a special
>type of message that makes it query the backend for error info instead ?
>

Ok. I'll try to do as you suggested in next revision. Something like:

	- Interrupt comes in
	- OPAL notifier callback
	- Mark all PHB and its subordinate PEs "isolated" since we don't know
	  which PHB/PE has problems (Note: we still need eeh_serialize_lock())
	- Create an EEH event without binding PE to EEH core.
	- EEH core starts new kthread and calls to next_error() backend
	  and handle the EEH errors accordingly.
	  
	  * Informational errors: clear PHB "isolated" state and output diag-data
	    in backend (in eeh-ioda.c as you suggested).
	  * Fenced PHB: PHB complete reset by EEH core and "isolated" state will
	    be cleared during the reset automatically.
	  * Dead PHB: Remove the PHB and its subordinate PCI buses/devices from
		      the system.
	  * Dead IOC: Remove PCI domain from the system.

The problem with the scheme is that the PHB's state can't reflect the real state
any more. For example, PHB#0 has been fenced, but PHB#1 is normal state. We have
to mark all PHBs as "isolated" (fenced) since we don't know which PHB is encountering
problems in the OPAL notifier callback.

I think it would work well. Let me have a try to change the code and make it
workable. The side-effect would be introducing more logic to EEH core and it's
shared by multiple platforms (powernv, pseries, powerkvm guest in future). So
my initial though is making opal_pci_next_error() invisible from EEH core and
make the EEH core totally event-driven :-)

> - I'm not fan of exposing that EEH private lock. I don't entirely understand
>why you need to do that either.
>

It's used to get consistent PE isolated state, which is protected by the lock.
Without it, we would have following case. Since we're going to change the
PE's state in platform code (pci-err.c), we need the lock to protect the PE's
state.

	
		    CPU#0				CPU#1
	PCI-CFG read returns 0xFF's		PCI-CFG read returns 0xFF's
	PE not fenced				PE not fenced
	PE marked as fenced			PE marked as fenced
	EEH event to EEH core			EEH event to EEH core

>Generally speaking, I'm thinking this file should contain less stuff, most of
>it should move into the ioda backend, the interrupt just turning into some
>request down to the existing EEH thread.
>

Yeah, I'll move most of the stuff into eeh-ioda.c with above scheme applied :-)

Thanks,
Gavin
