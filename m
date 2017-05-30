Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSXM0mDJzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:31 +1000 (AEST)
In-Reply-To: <20170529073940.15234-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, 
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [v2] powerpc/64: handle linker stubs in low .text code
Message-Id: <3wcSXL6Bvnz9s89@ozlabs.org>
Date: Tue, 30 May 2017 19:11:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-29 at 07:39:40 UTC, Nicholas Piggin wrote:
> Very large kernels may require linker stubs for branches from HEAD
> text code. The linker may place these stubs before the HEAD text
> sections, which breaks the assumption that HEAD text is located at 0
> (or the .text section being located at 0x7000/0x8000 on Book3S
> kernels).
> 
> Provide an option to create a small section just before the .text
> section with an empty 256 - 4 bytes, and adjust the start of the .text
> section to match. The linker will tend to put stubs in that section
> and not break our relative-to-absolute offset assumptions.
> 
> This causes a small waste of space on common kernels, but allows large
> kernels to build and boot. For now, it is an EXPERT config option,
> defaulting to =n, but a reference is provided for it in the build-time
> check for such breakage. This is good enough for allyesconfig and
> custom users / hackers.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/951eedebcdea06fdcc742c82dc3475

cheers
