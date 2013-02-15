Return-Path: <STFD002@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6946A2C02CC
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2013 02:16:24 +1100 (EST)
Message-ID: <511E513F.7090103@freescale.com>
Date: Fri, 15 Feb 2013 17:16:15 +0200
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RFC] Replaced tlbilx with tlbwe in the initialization code
References: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
 <1360887119.22260.10.camel@pasglop>
In-Reply-To: <1360887119.22260.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2013 02:11 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-02-14 at 14:56 +0200, Diana Craciun wrote:
>> From: Diana Craciun <Diana.Craciun@freescale.com>
>>
>> On Freescale e6500 cores EPCR[DGTMI] controls whether guest supervisor
>> state can execute TLB management instructions. If EPCR[DGTMI]=0
>> tlbwe and tlbilx are allowed to execute normally in the guest state.
>>
>> A hypervisor may choose to virtualize TLB1 and for this purpose it
>> may use IPROT to protect the entries for being invalidated by the
>> guest. However, because tlbwe and tlbilx execution in the guest state
>> are sharing the same bit, it is not possible to have a scenario where
>> tlbwe is allowed to be executed in guest state and tlbilx traps. When
>> guest TLB management instructions are allowed to be executed in guest
>> state the guest cannot use tlbilx to invalidate TLB1 guest entries.
> Sorry, I don't understand the explanation... can you be more detailed ?

TLB1 supports huge page sizes. The guest may see the memory as 
contiguous but it sees the guest physical memory as presented by the 
hypervisor. In reality the real physical memory may be fragmented. In 
this case the hypervisor can add more than one TLB1 entry for one guest 
request and the hypervisor will keep track of all fragments. When the 
guest performs a tlbilx, the hypervisor will correctly invalidate all 
the corresponding fragments because both tlbwe and tlbilx trap and has 
full control of tlb management instructions targeting TLB1.

For e6500 a single bit controls if tlbwe and tlbilx trap to the 
Hypervisor. tlbwe targeting TLB1 always traps. But if we want to use 
LRAT for TLB0, we have to configure tlbwe (targeting TLB 0) to go 
directly to the guest. But in this case tlbilx (which is targeting both 
TLBs) will never trap.

If the tlbilx does not trap, the guest can invalidate only one of 
(possible more) fragments and furthermore the synchronization between 
what entries the hypervisor thinks there are in the TLB1 and what are 
the actual entries is lost.

Diana
