Return-Path: <root@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id 95384DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 03:27:27 +1000 (EST)
Date: Mon, 28 May 2007 17:25:40 +0200 (CEST)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: Is it possible to call a C function in
	transfer_to_handler(arch/ppc/kernel/entry.S)?
In-Reply-To: <380406375.32007@eyou.net>
Message-ID: <Pine.LNX.4.60.0705281723260.1664@rtl14.hofr.at>
References: <380406375.32007@eyou.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Nicholas McGuire <der.herr@hofr.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>
>  I'm sorry to ask this topic in this mailling list. I've spend more than 2
> days try to add a C function call in transfer_to_handler(in
> arch/ppc/kernel/entry.S) like this:
>

Why are you sorry ? This is what this list is for - and if nobody can
answer it then its good you sent it - thanks !

<snip...>
> #if 1	/* this is add by me */

could you change this to use onle R3-R13 as these are caller safe - My
suspicion i sthat you are using R0/1/2 and that is not healthy here.

>        stwu    r1, -16(r1)
>        mflr    r0
>        stw     r0, 20(r1)
>        bl      emulate_iret
>        lwz     r0, 20(r1)
>        mtlr    r0
>        addi    r1, r1, 16
> #endif
>        addi    r11,r1,STACK_FRAME_OVERHEAD
>        stw     r11,PT_REGS(r12)
>
out of PPC too long - but will see if I can find something.

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFGWvR4nU7rXZKfY2oRArQDAJ99xJOrUlqYpPPuJtoqH27lGeDJ9ACeIj97
1bPlGITc1bVMw1V5YmXnG34=
=hvub
-----END PGP SIGNATURE-----
