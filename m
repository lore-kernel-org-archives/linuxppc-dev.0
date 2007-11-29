Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 98849DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 12:02:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc3-mm2 - Build Failure on powerpc timerfd() undeclared
Date: Thu, 29 Nov 2007 01:57:51 +0100
References: <20071128034140.648383f0.akpm@linux-foundation.org>
	<200711281432.09178.arnd@arndb.de>
	<20071128104345.9474025e.akpm@linux-foundation.org>
In-Reply-To: <20071128104345.9474025e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711290157.52487.arnd@arndb.de>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007 19:43:45 Andrew Morton wrote:
> > I guess all architectures except x86 are currently broken because they
> > reference the old sys_timerfd function.
>
> None of them were broken in my testing and I'm unsure why powerpc broke
> here.

PowerPC is unique in that it actually relies on the declarations
in include/{linux,asm}/syscalls.h to be present, because the
spu_syscall_table is generated from C code, not from assembly.
One reason why I did this was to be sure to find this exact
type of problem at compile-time, not at link time.

	Arnd <><
