Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9Kpd1S2tzDvXv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 22:48:09 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so7758776pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 04:48:09 -0700 (PDT)
Date: Fri, 4 Nov 2016 22:47:47 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, "Shreyas B .
 Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
Message-ID: <20161104224747.3721b755@roar.ozlabs.ibm.com>
In-Reply-To: <20161104090409.GA12645@in.ibm.com>
References: <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
 <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
 <20161102082433.GA17365@in.ibm.com>
 <20161102193624.7f0cbfee@roar.ozlabs.ibm.com>
 <20161102084548.GD17909@in.ibm.com>
 <20161103162100.1b50777e@roar.ozlabs.ibm.com>
 <CAAVMmb5Zj4oKVF6f3Ag0mEHOUrAYro65JyuULMO7+abRs4D=OQ@mail.gmail.com>
 <20161103171751.44798270@roar.ozlabs.ibm.com>
 <CAAVMmb7wmgYY6AFLb2kqJsgOJwQK_vYaJtxmeouF9ZXezWtEDA@mail.gmail.com>
 <20161103180244.4a41796b@roar.ozlabs.ibm.com>
 <20161104090409.GA12645@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 4 Nov 2016 14:34:09 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Thu, Nov 03, 2016 at 06:02:44PM +1100, Nicholas Piggin wrote:
> > On Thu, 3 Nov 2016 02:32:39 -0400
> > "Shreyas B. Prabhu" <shreyasbp@gmail.com> wrote:
> >   
> > > On Thu, Nov 3, 2016 at 2:17 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > > On Thu, 3 Nov 2016 01:56:46 -0400
> > > > "Shreyas B. Prabhu" <shreyasbp@gmail.com> wrote:
> > > >    
> > > >> On Thu, Nov 3, 2016 at 1:21 AM, Nicholas Piggin <npiggin@gmail.com> wrote:    
> > > >> > On Wed, 2 Nov 2016 14:15:48 +0530
> > > >> > Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > > >> >    
> > > >> >> Hi Nick,
> > > >> >>
> > > >> >> On Wed, Nov 02, 2016 at 07:36:24PM +1100, Nicholas Piggin wrote:    
> > > >> >> >
> > > >> >> > Okay, I'll work with that. What's the best way to make a P8 do
> > > >> >> > winkle sleeps?    
> > > >> >>
> > > >> >> From the userspace, offlining the CPUs of the core will put them to
> > > >> >> winkle.    
> > > >> >
> > > >> > Thanks for this. Hum, that r13 manipulation throughout the idle
> > > >> > and exception code is a bit interesting. I'll do the minimal patch
> > > >> > for 4.9, but what's the reason not to just use the winkle state
> > > >> > in the PACA rather than storing it into HSPRG0 bit, can you (or
> > > >> > Shreyas) explain?
> > > >> >    
> > > >> Hi Nick,
> > > >>
> > > >> Before deep winkle, checking SRR1's wakeup bits (Bits 46:47) was enough to
> > > >> figure out which idle state we are waking up from. But in P8, SRR1's wakeup
> > > >> bits aren't enough since bits 46:47 are 0b11 for both fast sleep and
> > > >> deep winkle.
> > > >> So to distinguish bw fastsleep and deep winkle, we use the current HSPRG0/PORE
> > > >> trick. We program the PORE engine (which is used for state restore when waking
> > > >> up from deep winkle) to restore HSPRG0 with the last bit set (we do this in
> > > >> pnv_save_sprs_for_winkle()). R13 bit manipulation in pnv_restore_hyp_resource
> > > >> is related to this.    
> > > >
> > > > Right, I didn't realize how that exactly worked until I had to go read
> > > > the code just now. It's a neat little trick. I'm wondering can we use PACA_THREAD_IDLE_STATE==PNV_THREAD_WINKLE for this instead? It would just
> > > > make the early PACA usage in the exception handlers able to use more common
> > > > code.
> > > >    
> > > 
> > > PACA_THREAD_IDLE_STATE will have what was 'requested'. It may not be the
> > > state we are waking up from. For example, if 7 threads of the core execute
> > > winkle instruction while 1 thread of the same core executes sleep. Here
> > > the core only enters sleep whereas PACA_THREAD_IDLE_STATE for the 7 threads
> > > will have PNV_THREAD_WINKLE.  
> > 
> > I see, that makes sense. Would it be possible to keep count of the number of
> > threads going into winkle in core_idle_state? Even if that is not a guarantee
> > if them requiring a PORE wakeup, would the restore case be harmful?  
> 
> Doing a full restore on wakeup when the hardware didn't actually go to
> winkle isn't harmful. The first few iterations of the winkle
> enablement patchset based the decision on
> PACA_THREAD_IDLE_STATE==PNV_THREAD_WINKLE upon a wakeup.
> 
> The disadvantage was that we would end up restoring a whole bunch of
> Subcore SPRs (SDR1, RPR, AMOR), Core SPRs (TSCR,WORC) and per thread
> SPRs (SLBs, SPURR,PURR,DSCR,WORT) which would waste quite lot of
> cycles if the hardware didn't actually demote the CPU all the way to
> winkle.
> 
> Hence Ben suggested piggybacking on PORE engine to set the LSB of the
> HSPRG0 to indicate wakeup from winkle.

Hi Gautham,

Okay this makes sense, thanks for the clarification.

Thanks,
Nick
