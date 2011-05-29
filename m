Return-Path: <ronne@list.ru>
Received: from smtp12.mail.ru (smtp12.mail.ru [94.100.176.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A3B4B6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 05:16:17 +1000 (EST)
Message-ID: <4DE29B78.1070209@list.ru>
Date: Sun, 29 May 2011 23:16:08 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: PROBLEM: 2.6.39 doesn't boot on POWER MAC
References: <4DE0AA62.4070909@list.ru>
	<BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
In-Reply-To: <BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

28.05.2011 22:09, Tabi Timur-B04825 пишет:
> On Sat, May 28, 2011 at 2:55 AM, Andrey Gusev<ronne@list.ru>  wrote:
>> Hi!
>> A kernel 2.6.39 doesn't boot on my POWER MAC G4.  A kernel 2.6.38.6 with
>> almost the same config boots without any problems.
> Have you tried using git-bisect to isolate the commit that breaks?
>
Fortunately, the rc1 is booted. I made git bisect:

andrey@power-debian:~/trash/build/kernel/git$ git bisect log
# bad: [a6360dd37e1a144ed11e6548371bade559a1e4df] Linux 2.6.39-rc3
# good: [0ce790e7d736cedc563e1fb4e998babf5a4dbc3d] Linux 2.6.39-rc1
git bisect start 'v2.6.39-rc3' 'v2.6.39-rc1'
# bad: [d14f5b810b49c7dbd1a01be1c6d3641d46090080] Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
git bisect bad d14f5b810b49c7dbd1a01be1c6d3641d46090080
# good: [84daeb09ef2b11cb0b29e100766e38e206c8bc47] Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
git bisect good 84daeb09ef2b11cb0b29e100766e38e206c8bc47
# bad: [fb9a7d76da108d120efb2258ea83b18dbbb2ecdd] Merge branch 
'core-fixes-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
git bisect bad fb9a7d76da108d120efb2258ea83b18dbbb2ecdd
# bad: [ccd00d1091fa7fff151127f26f6900be2ac8cc10] Merge branch 'merge' 
of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc
git bisect bad ccd00d1091fa7fff151127f26f6900be2ac8cc10
# good: [d72944457bb7d5c4be43aa1b741cb93c69484c20] powerpc/smp: Add a 
smp_ops->bringup_up() done callback
git bisect good d72944457bb7d5c4be43aa1b741cb93c69484c20
# good: [afdef69c7ff7d0bf59e3cafc187aefb12878dbe3] Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-2.6
git bisect good afdef69c7ff7d0bf59e3cafc187aefb12878dbe3
# bad: [c56e58537d504706954a06570b4034c04e5b7500] powerpc/smp: Create 
idle threads on demand and properly reset them
git bisect bad c56e58537d504706954a06570b4034c04e5b7500
# bad: [105765f451d3ff007bb4ae3761e825686d9615db] powerpc/smp: Don't 
expose per-cpu "cpu_state" array
git bisect bad 105765f451d3ff007bb4ae3761e825686d9615db
# bad: [734796f12351f9a0f38c47b981414f82d852f222] powerpc/pmac/smp: Fix 
CPU hotplug crashes on some machines
git bisect bad 734796f12351f9a0f38c47b981414f82d852f222

I have errors on building bad kernels:
arch/powerpc/platforms/powermac/smp.c: In function ‘smp_core99_cpu_notify’:
arch/powerpc/platforms/powermac/smp.c:855:7: error: 
‘pmac_tb_clock_chip_host’ undeclared (first use in this function)
arch/powerpc/platforms/powermac/smp.c:855:7: note: each undeclared 
identifier is reported only once for each function it appears in

Andrey
