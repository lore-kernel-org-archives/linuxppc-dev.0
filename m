Return-Path: <jengelh@linux01.gwdg.de>
Received: from linux01.gwdg.de (linux01.gwdg.de [134.76.13.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A23267A05
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 23:44:48 +1000 (EST)
Date: Fri, 21 Apr 2006 15:14:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix spu_callbacks BUILD_BUG_ON
In-Reply-To: <200604211245.27744.arnd@arndb.de>
Message-ID: <Pine.LNX.4.61.0604211512370.23180@yvahk01.tjqt.qr>
References: <20060421080239.GC4717@suse.de>
	<20060421022555.2d460805.akpm@osdl.org>
	<200604211241.36596.arnd@arndb.de> <200604211245.27744.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, Paul Mackerras <paulus@samba.org>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_callbacks.c
>+++ linus-2.6/arch/powerpc/platforms/cell/spu_callbacks.c
>@@ -317,17 +317,16 @@ void *spu_syscall_table[] = {
> 	[__NR_ppoll]			sys_ni_syscall, /* sys_ppoll */
> 	[__NR_unshare]			sys_unshare,
> 	[__NR_splice]			sys_splice,
>+	[__NR_tee]			sys_tee,

+      [__NR_syscalls] = NULL,

> };
> 
> long spu_sys_callback(struct spu_syscall_block *s)
> {
> 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
> 
>-	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
>-
> 	syscall = spu_syscall_table[s->nr_ret];
> 
>-	if (s->nr_ret >= __NR_syscalls) {
>+	if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {

+       if(syscall == NULL) {



That way, syscalls could be added in the master table while spu does not 
break. Comments?


Jan Engelhardt
-- 
