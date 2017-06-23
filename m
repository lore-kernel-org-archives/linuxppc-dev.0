Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv8WW2ZwTzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 17:01:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 James Hogan <james.hogan@imgtec.com>, Pratyush Anand <panand@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/4] powerpc: Reduce ELF_ET_DYN_BASE
In-Reply-To: <1498154792-49952-4-git-send-email-keescook@chromium.org>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
 <1498154792-49952-4-git-send-email-keescook@chromium.org>
Date: Fri, 23 Jun 2017 17:01:42 +1000
Message-ID: <87podvp4q1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kees Cook <keescook@chromium.org> writes:

> Now that explicitly executed loaders are loaded in the mmap region,
> position PIE binaries lower in the address space to avoid possible
> collisions with mmap or stack regions. For 64-bit, align to 4GB to
> allow runtimes to use the entire 32-bit address space for 32-bit
> pointers.

The change log and subject are a bit out of whack with the actual patch
because previously we used 512MB.

How about?

  powerpc: Move ELF_ET_DYN_BASE to 4GB / 4MB
  
  Now that explicitly executed loaders are loaded in the mmap region,
  we have more freedom to decide where we position PIE binaries in the
  address space to avoid possible collisions with mmap or stack regions.
  
  For 64-bit, align to 4GB to allow runtimes to use the entire 32-bit
  address space for 32-bit pointers. On 32-bit use 4MB.


Is there any particular reasoning behind the 4MB value on 32-bit?


I gave this a quick spin and it booted OK on all my test boxes, which
covers 64-bit/32-bit kernel and userspace. So seems to work!

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
