Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1wRN3wdfzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 02:21:11 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3AGDft8002007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 12:20:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rahetbn5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 12:20:57 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 02:20:55 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3AGKhRN43319442
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 02:20:51 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3AGKFv7028186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 02:20:15 +1000
Date: Mon, 10 Apr 2017 16:19:59 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc64/kprobe: Fix oops when kprobed on 'stdu' instruction
To: mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, chris@distroguy.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, paulus@samba.org, viro@zeniv.linux.org.uk
References: <1491837657-4918-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
In-Reply-To: <1491837657-4918-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1491840547.fs94dx4913.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ravi Bangoria's message of April 10, 2017 20:50:
> If we set a kprobe on a 'stdu' instruction on powerpc64, we see a kernel=20
> OOPS:
>=20
>   [ 1275.165932] Bad kernel stack pointer cd93c840 at c000000000009868
>   [ 1275.166378] Oops: Bad kernel stack pointer, sig: 6 [#1]
>   ...
>   GPR00: c000001fcd93cb30 00000000cd93c840 c0000000015c5e00 00000000cd93c=
840
>   ...
>   [ 1275.178305] NIP [c000000000009868] resume_kernel+0x2c/0x58
>   [ 1275.178594] LR [c000000000006208] program_check_common+0x108/0x180
>=20
> Basically, on 64 bit system, when user probes on 'stdu' instruction,
> kernel does not emulate actual store in emulate_step itself because it
> may corrupt exception frame. So kernel does actual store operation in
> exception return code i.e. resume_kernel().
>=20
> resume_kernel() loads the saved stack pointer from memory using lwz,
> effectively loading a corrupt (32bit) address, causing the kernel crash.
>=20
> Fix this by loading the 64bit value instead.

Thanks for fixing this!

>=20
> Fixes: 8e9f69371536 ("powerpc/kprobe: Don't emulate store when kprobe stw=
u r1")

I think this should really be:
Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of=20
emulate_step()")

...since the original commit just handled stwu on powerpc64 as well. In=20
some ways, the 64-bit part of that commit wasn't that useful, but it=20
never addressed stdu directly.

> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> History:
>   Commit 8e9f69371536 ("powerpc/kprobe: Don't emulate store when kprobe
>   stwu r1") fixed exception frame corruption for 32 bit system which uses
>   'stwu' instruction for stack frame allocation. This commit also added
>   code for 64 bit system but did not enabled it for 'stdu' instruction.
>   So 'stdu' instruction on 64 bit machine was emulating actual store in
>   emulate_step() itself until...
>=20
>   Commit be96f63375a1 ("powerpc: Split out instruction analysis part of
>   emulate_step()"), enabled it for 'stdu' instruction on 64 bit machine.
>=20
>   Since then it's broken. So this should also go into stable.

Hmm... so I think kprobe on 'stdu' has always been broken on powerpc64. =20
We haven't noticed since most stdu operations were probably landing in=20
the red zone so the exception frame never got corrupted. In that sense,=20
this fix is needed for BE ever since load/store emulation was added.

For LE, this is only getting exposed now due to your recent patch to=20
enable load/store emulation on LE.

>=20
>  arch/powerpc/kernel/entry_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 6432d4b..530f6e9 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -689,7 +689,7 @@ resume_kernel:
>=20
>  	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
>=20
> -	lwz	r3,GPR1(r1)
> +	ld	r3,GPR1(r1)
>  	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame=
 */
>  	mr	r4,r1			/* src:  current exception frame */
>  	mr	r1,r3			/* Reroute the trampoline frame to r1 */
> @@ -704,7 +704,7 @@ resume_kernel:
>  	bdnz	2b
>=20
>  	/* Do real store operation to complete stwu */

Can you also update the above comment to refer to 'stdu'?
Apart from that, for this patch:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen


> -	lwz	r5,GPR1(r1)
> +	ld	r5,GPR1(r1)
>  	std	r8,0(r5)
>=20
>  	/* Clear _TIF_EMULATE_STACK_STORE flag */
> --=20
> 1.9.3
>=20
>=20
=
