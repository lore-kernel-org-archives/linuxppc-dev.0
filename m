Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2LWC2ZJ7zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 18:56:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id o126so12240835pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 01:56:07 -0700 (PDT)
Message-ID: <1491900956.8380.5.camel@gmail.com>
Subject: Re: [PATCH v2] ppc64/kprobe: Fix oops when kprobed on 'stdu'
 instruction
From: Balbir Singh <bsingharora@gmail.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, chris@distroguy.com,
 viro@zeniv.linux.org.uk,  christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 anton@samba.org, naveen.n.rao@linux.vnet.ibm.com
Date: Tue, 11 Apr 2017 18:55:56 +1000
In-Reply-To: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

On Tue, 2017-04-11 at 10:38 +0530, Ravi Bangoria wrote:
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
> ---

The patch looks correct to me from the description and code. I have not
validated that the write to GPR1(r1) via store of r8 to 0(r5) is indeed correct.
I would assume r8 should contain regs->gpr[r1] with the updated ea that
is written down to the GPR1(r1) which will be what we restore when we return
from the exception.

The conversion of lwz to ld indeed looks correct

Balbir Singh.
