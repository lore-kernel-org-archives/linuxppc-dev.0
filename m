Return-Path: <srs0=wz6g=hm=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VMQC2JryzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 09:01:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40VMQC1RvHz8t3C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 09:01:07 +1000 (AEST)
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40VMQB2bWWz9rxx
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2018 09:01:04 +1000 (AEST)
Received: by mail-pg0-x231.google.com with SMTP id b5so9395733pgv.5
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 16:01:04 -0700 (PDT)
Message-ID: <86f908c08688f3c1787b924acf42daab87778b22.camel@gmail.com>
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Date: Tue, 24 Apr 2018 09:00:54 +1000
In-Reply-To: <20180423230116.0d3e9fc5@roar.ozlabs.ibm.com>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
 <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
 <cb831682-8cc6-4cd7-9778-52e5f4ad5af0@linux.vnet.ibm.com>
 <CAKTCnzm=OAXmUp0g7YrR9wFoFwB3TS_LnQiwZPR6QgeKk6ExYQ@mail.gmail.com>
 <20180423230116.0d3e9fc5@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-23 at 23:01 +1000, Nicholas Piggin wrote:
> On Mon, 23 Apr 2018 21:14:12 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
> > On Mon, Apr 23, 2018 at 8:33 PM, Mahesh Jagannath Salgaonkar
> > <mahesh@linux.vnet.ibm.com> wrote:
> > > On 04/23/2018 12:21 PM, Balbir Singh wrote:  
> > > > On Mon, Apr 23, 2018 at 2:59 PM, Mahesh J Salgaonkar
> > > > <mahesh@linux.vnet.ibm.com> wrote:  
> > > > > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > > > > 
> > > > > The current code extracts the physical address for UE errors and then
> > > > > hooks it up into memory failure infrastructure. On successful extraction
> > > > > of physical address it wrongly sets "handled = 1" which means this UE error
> > > > > has been recovered. Since MCE handler gets return value as handled = 1, it
> > > > > assumes that error has been recovered and goes back to same NIP. This causes
> > > > > MCE interrupt again and again in a loop leading to hard lockup.
> > > > > 
> > > > > Also, initialize phys_addr to ULONG_MAX so that we don't end up queuing
> > > > > undesired page to hwpoison.
> > > > > 
> > > > > Without this patch we see:
> > > > > [ 1476.541984] Severe Machine check interrupt [Recovered]
> > > > > [ 1476.541985]   NIP: [000000001002588c] PID: 7109 Comm: find
> > > > > [ 1476.541986]   Initiator: CPU
> > > > > [ 1476.541987]   Error type: UE [Load/Store]
> > > > > [ 1476.541988]     Effective address: 00007fffd2755940
> > > > > [ 1476.541989]     Physical address:  000020181a080000
> > > > > [...]
> > > > > [ 1476.542003] Severe Machine check interrupt [Recovered]
> > > > > [ 1476.542004]   NIP: [000000001002588c] PID: 7109 Comm: find
> > > > > [ 1476.542005]   Initiator: CPU
> > > > > [ 1476.542006]   Error type: UE [Load/Store]
> > > > > [ 1476.542006]     Effective address: 00007fffd2755940
> > > > > [ 1476.542007]     Physical address:  000020181a080000
> > > > > [ 1476.542010] Severe Machine check interrupt [Recovered]
> > > > > [ 1476.542012]   NIP: [000000001002588c] PID: 7109 Comm: find
> > > > > [ 1476.542013]   Initiator: CPU
> > > > > [ 1476.542014]   Error type: UE [Load/Store]
> > > > > [ 1476.542015]     Effective address: 00007fffd2755940
> > > > > [ 1476.542016]     Physical address:  000020181a080000
> > > > > [ 1476.542448] Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
> > > > > [ 1476.542452] Memory failure: 0x20181a08: already hardware poisoned
> > > > > [ 1476.542453] Memory failure: 0x20181a08: already hardware poisoned
> > > > > [ 1476.542454] Memory failure: 0x20181a08: already hardware poisoned
> > > > > [ 1476.542455] Memory failure: 0x20181a08: already hardware poisoned
> > > > > [ 1476.542456] Memory failure: 0x20181a08: already hardware poisoned
> > > > > [ 1476.542457] Memory failure: 0x20181a08: already hardware poisoned
> > > > > [...]
> > > > > [ 1490.972174] Watchdog CPU:38 Hard LOCKUP
> > > > > 
> > > > > After this patch we see:
> > > > > 
> > > > > [  325.384336] Severe Machine check interrupt [Not recovered]  
> > > > 
> > > > How did you test for this?  
> > > 
> > > By injecting cache SUE using L2 FIR register (0x1001080c).
> > >  
> > > > If the error was recovered, shouldn't the
> > > > process have gotten
> > > > a SIGBUS and we should have prevented further access as a part of the handling
> > > > (memory_failure()). Do we just need a MF_MUST_KILL in the flags?  
> > > 
> > > We hook it up to memory_failure() through a work queue and by the time
> > > work queue kicks in, the application continues to restart and hit same
> > > NIP again and again. Every MCE again hooks the same address to memory
> > > failure work queue and throws multiple recovered MCE messages for same
> > > address. Once the memory_failure() hwpoisons the page, application gets
> > > SIGBUS and then we are fine.
> > >  
> > 
> > That seems quite broken and not recovered is very confusing. So effectively
> > we can never recover from a MCE UE. I think we need a notion of delayed
> > recovery then? Where we do recover, but mark is as recovered with delays?
> > We might want to revisit our recovery process and see if the recovery requires
> > to turn the MMU on, but that is for later, I suppose.
> 
> The notion of being handled in the machine check return value is not
> whether the failing resource is later de-allocated or fixed, but if
> *this* particular exception was able to be corrected / processing
> resume as normal without further action.
> 
> The MCE UE is not recovered just by finding its address here, so I think
> Mahesh's patch is right.
> 

OK, It would nice to see a "recovered" in the output as opposed to process
killed, but the MCE is "not recovered"? The kernel bits do sound sane

Balbir Singh.
