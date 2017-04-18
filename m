Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6k4T60PqzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 21:51:37 +1000 (AEST)
In-Reply-To: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: chris@distroguy.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, viro@zeniv.linux.org.uk
Subject: Re: [v2] ppc64/kprobe: Fix oops when kprobed on 'stdu' instruction
Message-Id: <3w6k4T3xS7z9rxw@ozlabs.org>
Date: Tue, 18 Apr 2017 21:51:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 05:08:13 UTC, Ravi Bangoria wrote:
> If we set a kprobe on a 'stdu' instruction on powerpc64, we see a kernel 
> OOPS:
> 
>   [ 1275.165932] Bad kernel stack pointer cd93c840 at c000000000009868
>   [ 1275.166378] Oops: Bad kernel stack pointer, sig: 6 [#1]
>   ...
>   GPR00: c000001fcd93cb30 00000000cd93c840 c0000000015c5e00 00000000cd93c840
>   ...
>   [ 1275.178305] NIP [c000000000009868] resume_kernel+0x2c/0x58
>   [ 1275.178594] LR [c000000000006208] program_check_common+0x108/0x180
> 
> Basically, on 64 bit system, when user probes on 'stdu' instruction,
> kernel does not emulate actual store in emulate_step itself because it
> may corrupt exception frame. So kernel does actual store operation in
> exception return code i.e. resume_kernel().
> 
> resume_kernel() loads the saved stack pointer from memory using lwz,
> effectively loading a corrupt (32bit) address, causing the kernel crash.
> 
> Fix this by loading the 64bit value instead.
> 
> Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of emulate_step()") 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Reviewed-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9e1ba4f27f018742a1aa95d11e3510

cheers
