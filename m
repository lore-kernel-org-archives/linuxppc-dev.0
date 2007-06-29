Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A395FDDF82
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 22:52:55 +1000 (EST)
Message-ID: <4685010C.4000108@ru.mvista.com>
Date: Fri, 29 Jun 2007 16:54:36 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: kgdb-bugreport@lists.sourceforge.net
Subject: Re: 2.6.22-rc6-mm1
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>
	<200706291432.10128.m.kozlowski@tuxland.pl>
In-Reply-To: <200706291432.10128.m.kozlowski@tuxland.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org,
	jason.wessel@windriver.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Mariusz Kozlowski wrote:

> 	allmodconfig on powerpc (iMac g3) fails due to
> git-kgdb.patch. allmodconfig defaults should be changed?

>   CC      arch/powerpc/kernel/kgdb.o
> arch/powerpc/kernel/kgdb.c:485:2: error: #error Both XMON and KGDB selected 
> in .config. Unselect one of them.
> make[1]: *** [arch/powerpc/kernel/kgdb.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2

    I'm not sure if this will work out but maybe it's worth to disable XMON if 
KGDB is selected, like this?

config XMON
	bool "Include xmon kernel debugger"
	depends on DEBUGGER && !KGDB

> Regards,

> 	Mariusz

WBR, Sergei
