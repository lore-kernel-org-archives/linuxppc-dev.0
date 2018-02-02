Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXdDg1ZHCzDqZY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 11:30:27 +1100 (AEDT)
Date: Fri, 2 Feb 2018 11:30:18 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, lvivier@redhat.com
Subject: Re: [PATCH v5 0/1] Implements MMIO emulation for lvx/stvx instructions
Message-ID: <20180202003018.GA27665@fergus.ozlabs.ibm.com>
References: <20180201181539.9650-1-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180201181539.9650-1-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 01, 2018 at 04:15:38PM -0200, Jose Ricardo Ziviani wrote:
> v5:
>  - Fixed the mask off of the effective address
> 
> v4:
>   - Changed KVM_MMIO_REG_VMX to 0xc0 because there are 64 VSX registers
> 
> v3:
>   - Added Reported-by in the commit message
> 
> v2:
>   - kvmppc_get_vsr_word_offset() moved back to its original place
>   - EA AND ~0xF, following ISA.
>   - fixed BE/LE cases
> 
> TESTS:
> 
> For testing purposes I wrote a small program that performs stvx/lvx using the
> program's virtual memory and using MMIO. Load/Store into virtual memory is the
> model I use to check if MMIO results are correct (because only MMIO is emulated
> by KVM).

I'd be interested to see your test program because in my testing it's
still not right, unfortunately.  Interestingly, it is right for the BE
guest on LE host case.  However, with a LE guest on a LE host the two
halves are swapped, both for lvx and stvx:

error in lvx at byte 0
was: -> 62 69 70 77 7e 85 8c 93 2a 31 38 3f 46 4d 54 5b
ref: -> 2a 31 38 3f 46 4d 54 5b 62 69 70 77 7e 85 8c 93
error in stvx at byte 0
was: -> 49 50 57 5e 65 6c 73 7a 11 18 1f 26 2d 34 3b 42
ref: -> 11 18 1f 26 2d 34 3b 42 49 50 57 5e 65 6c 73 7a

The byte order within each 8-byte half is correct but the two halves
are swapped.  ("was" is what was in memory and "ref" is the correct
value.  For lvx it does lvx from emulated MMIO and stvx to ordinary
memory, and for stvx it does lvx from ordinary memory and stvx to
emulated MMIO.  In both cases the checking is done with a byte by byte
comparison.)

Paul.
