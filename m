Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1BC1868457
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 02:33:56 +1000 (EST)
Date: Mon, 10 Oct 2005 18:33:49 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Message-ID: <20051010163349.GA1381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
Subject: error: implicit declaration of function 'cpu_die'
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


How can I fix this properly?
arch/ppc/kernel/idle.c includes linux/smp.h, which includes asm-smp.h
only if CONFIG_SMP is defined.
As a result, cpu_die remains undefined for non-SMP builds.

The include order was changed recently, as this kernel .config built ok with 2.6.13.
I see cpu_die was introduced recently in include/asm-ppc/smp.h, in 2.6.14-rc1.


  CC      arch/ppc/kernel/idle.o
arch/ppc/kernel/idle.c: In function 'default_idle':
arch/ppc/kernel/idle.c:58: error: implicit declaration of function 'cpu_die'
make[1]: *** [arch/ppc/kernel/idle.o] Error 1


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
