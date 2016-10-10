Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssqFw6jmpzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 16:59:32 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id qn10so6473800pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 22:59:32 -0700 (PDT)
Date: Mon, 10 Oct 2016 16:59:24 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 ravi.bangoria@linux.vnet.ibm.com, acme@redhat.com, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: perf TUI fails with "failed to process type: 64"
Message-ID: <20161010165924.0a0f3f1d@roar.ozlabs.ibm.com>
In-Reply-To: <874m4k7q5s.fsf@concordia.ellerman.id.au>
References: <20161009121232.174915eb@kryten>
 <874m4k7q5s.fsf@concordia.ellerman.id.au>
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

On Mon, 10 Oct 2016 16:02:07 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Anton Blanchard <anton@samba.org> writes:
> 
> > Hi,
> >
> > Updating to mainline as of last night, I started seeing the following
> > error when running the perf report TUI:
> >
> > 0x46068 [0x8]: failed to process type: 68
> >
> > This event is just PERF_RECORD_FINISHED_ROUND:
> >
> > 0x46068 [0x8]: event: 68
> > .
> > . ... raw event: size 8 bytes
> > .  0000:  44 00 00 00 00 00 08 00                          D.......        
> >
> > 0x46068 [0x8]: PERF_RECORD_FINISHED_ROUND
> >
> > Which of course is not our error. It took me a while to find the real
> > culprit:
> >
> >  14c00-14c00 g exc_virt_0x4c00_system_call  
>    ^
>    What's this? The address? If so it's wrong?
>    
> 
> > A zero length symbol, which __symbol__inc_addr_samples() barfs on:
> >
> >         if (addr < sym->start || addr >= sym->end) {
> > ...
> > 		return -ERANGE;
> >
> > Seems like we have 3 bugs here:  
> ...
> >
> > 3. Why do we have zero length symbols in the first place? Does the recent
> >    ppc64 exception clean up have something to do with it?  
> 
> Seems likely. But I can't see why.
> 
> AFAICS we have never emitted a size for those symbols:
> 
> Old:
> $ nm --print-size build/vmlinux | grep -w system_call_relon_pSeries
> c000000000004c00 T system_call_relon_pSeries
> 
> New:
> $ nm --print-size build/vmlinux | grep -w exc_virt_0x4c00_system_call
> c000000000004c00 T exc_virt_0x4c00_system_call
> 
> 
> It also doesn't look like we're emitting another symbol with the same
> address, which has caused confusion in the past:
> 
> Old:
> c000000000004c00 T exc_virt_0x4c00_system_call
> c000000000004d00 T exc_virt_0x4d00_single_step
> 
> New:
> c000000000004c00 T system_call_relon_pSeries
> c000000000004d00 T single_step_relon_pSeries
> 
> 
> So more digging required.

Yeah, strange. Maybe perf changes?

We were talking about adding size and type to the exception symbols
though.
