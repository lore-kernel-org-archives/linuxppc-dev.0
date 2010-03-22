Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 0FBF6B7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 05:00:38 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: ppc64 sys_ipc breakage in 2.6.34-rc2
References: <20100322064759.GE24064@kryten>
Date: Mon, 22 Mar 2010 19:00:20 +0100
In-Reply-To: <20100322064759.GE24064@kryten> (Anton Blanchard's message of
	"Mon, 22 Mar 2010 17:47:59 +1100")
Message-ID: <m2ocigkzij.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Hirokazu Takata <takata@linux-m32r.org>, James Morris <jmorris@namei.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, "Luck, Tony" <tony.luck@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> diff --git a/ipc/syscall.c b/ipc/syscall.c
> index 355a3da..1d6f53f 100644
> --- a/ipc/syscall.c
> +++ b/ipc/syscall.c
> @@ -13,7 +13,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  
> -SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, int, second,
> +SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
>  		unsigned long, third, void __user *, ptr, long, fifth)

ipc/syscall.c:17: error: conflicting types for ‘sys_ipc’
include/linux/syscalls.h:691: note: previous declaration of ‘sys_ipc’ was here

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
