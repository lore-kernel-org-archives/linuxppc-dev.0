Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssx1K5NVnzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 21:19:01 +1100 (AEDT)
Date: Mon, 10 Oct 2016 21:18:12 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 ravi.bangoria@linux.vnet.ibm.com, acme@redhat.com, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: perf TUI fails with "failed to process type: 64"
Message-ID: <20161010211812.13eb89d5@kryten>
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

Hi Michael,

> >  14c00-14c00 g exc_virt_0x4c00_system_call  
>    ^
>    What's this? The address? If so it's wrong?

Offset into the binary I think, there's one 64kB page of ELF gunk at
the start.

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
> So more digging required.

Thanks for checking, it's starting to sound like a perf bug.

Anton
