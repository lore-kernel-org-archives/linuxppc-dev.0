Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 816D8DDE2B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 08:28:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Hook compat_sys_nanosleep up to high res timer code
Date: Mon, 15 Oct 2007 00:28:05 +0200
References: <20071014215437.GF26693@kryten>
In-Reply-To: <20071014215437.GF26693@kryten>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710150028.06493.arnd@arndb.de>
Cc: mingo@elte.hu, tglx@linutronix.de, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 14 October 2007, Anton Blanchard wrote:
> Now we have high res timers on ppc64 I thought Id test them. It turns
> out compat_sys_nanosleep hasnt been converted to the hrtimer code and so
> is limited to HZ resolution.
> 
> The following patch makes compat_sys_nanosleep call hrtimer_nanosleep
> and uses compat_alloc_user_space to avoid setting KERNEL_DS.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

The code looks correct, but I think it would be nicer to change 
hrtimer_nanosleep to take a kernel pointer and have all three
callers (common_nsleep, sys_nanosleep and compat_sys_nanosleep)
do the copy_to_user/put_compat_timespec in the caller.

This would also make it possible to get rid of set_fs() in
compat_sys_clock_nanosleep().

	Arnd <><
