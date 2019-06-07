Return-Path: <SRS0=OFQA=UG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE528C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 00:52:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0A6208E3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 00:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="jubTl1Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0A6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KkWk4yq3zDqkT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 10:52:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KkTp5sCqzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 10:50:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="jubTl1Xv"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 45KkTn2QZnz9sDX;
 Fri,  7 Jun 2019 10:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1559868637;
 bh=U7nqidMeM/8XknoLlxj1vv8Py2UMz+gk+UbXzxDB/rU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=jubTl1Xvy/MvBXMf1gKQk4fyUBHQ3Bl2M5rF752yfwnHKWsWX3kzbX2FffletZ9wq
 dc3RN39kLZunPSXp1JtabJ7hZZ0vpx09/rHI0iooM9b3aRSQo3JH1b2vpGEXqLTSDH
 NzuMAJ+oWy+2pQmVIaRfpzSJ4RTHjZRnwgwnY468O3O/IoBemdmL96ZOcAQ3pTIm5B
 toNb7AfP2RWk/Tk5CYj4mjTWOPTkcn5rm+blRpHO1H8qfAbGfoV0DOUt1rYmg5uWOm
 VOZRGS9FCrcKs7gn6gEBOpauXPFImAFjmvcn+ZcHfs5F5DFPM3+xV1xy1QU31adn9S
 UxOae1rZD4ukQ==
Received: by neuling.org (Postfix, from userid 1000)
 id 49C912A27C4; Fri,  7 Jun 2019 10:50:37 +1000 (AEST)
Message-ID: <80cfc8d7327d3bb744ea1f7e2843943a998d48de.camel@neuling.org>
Subject: Re: [PATCH] Powerpc/Watchpoint: Restore nvgprs while returning from
 exception
From: Michael Neuling <mikey@neuling.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Date: Fri, 07 Jun 2019 10:50:37 +1000
In-Reply-To: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
References: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com, paulus@samba.org,
 mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-06-06 at 12:59 +0530, Ravi Bangoria wrote:
> Powerpc hw triggers watchpoint before executing the instruction.
> To make trigger-after-execute behavior, kernel emulates the
> instruction. If the instruction is 'load something into non-
> volatile register', exception handler should restore emulated
> register state while returning back, otherwise there will be
> register state corruption. Ex, Adding a watchpoint on a list
> can corrput the list:
>=20
>   # cat /proc/kallsyms | grep kthread_create_list
>   c00000000121c8b8 d kthread_create_list
>=20
> Add watchpoint on kthread_create_list->next:
>=20
>   # perf record -e mem:0xc00000000121c8c0
>=20
> Run some workload such that new kthread gets invoked. Ex, I
> just logged out from console:
>=20
>   list_add corruption. next->prev should be prev (c000000001214e00), \
> 	but was c00000000121c8b8. (next=3Dc00000000121c8b8).
>   WARNING: CPU: 59 PID: 309 at lib/list_debug.c:25 __list_add_valid+0xb4/=
0xc0
>   CPU: 59 PID: 309 Comm: kworker/59:0 Kdump: loaded Not tainted 5.1.0-rc7=
+ #69
>   ...
>   NIP __list_add_valid+0xb4/0xc0
>   LR __list_add_valid+0xb0/0xc0
>   Call Trace:
>   __list_add_valid+0xb0/0xc0 (unreliable)
>   __kthread_create_on_node+0xe0/0x260
>   kthread_create_on_node+0x34/0x50
>   create_worker+0xe8/0x260
>   worker_thread+0x444/0x560
>   kthread+0x160/0x1a0
>   ret_from_kernel_thread+0x5c/0x70
>=20
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

How long has this been around? Should we be CCing stable?

Mikey

> ---
>  arch/powerpc/kernel/exceptions-64s.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64s.S
> b/arch/powerpc/kernel/exceptions-64s.S
> index 9481a11..96de0d1 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1753,7 +1753,7 @@ handle_dabr_fault:
>  	ld      r5,_DSISR(r1)
>  	addi    r3,r1,STACK_FRAME_OVERHEAD
>  	bl      do_break
> -12:	b       ret_from_except_lite
> +12:	b       ret_from_except
> =20
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64

