Return-Path: <jason.wessel@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C7639DDF18
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 00:45:48 +1000 (EST)
Message-ID: <46890F8D.3080807@windriver.com>
Date: Mon, 02 Jul 2007 09:45:33 -0500
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.22-rc6-mm1
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>
	<200706291432.10128.m.kozlowski@tuxland.pl>
	<4685010C.4000108@ru.mvista.com> <4689025C.8000001@windriver.com>
	<46890A52.6020201@ru.mvista.com>
In-Reply-To: <46890A52.6020201@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Hello.
>
> Jason Wessel wrote:
>
>>>>     allmodconfig on powerpc (iMac g3) fails due to
>>>> git-kgdb.patch. allmodconfig defaults should be changed?
>
>>>>   CC      arch/powerpc/kernel/kgdb.o
>>>> arch/powerpc/kernel/kgdb.c:485:2: error: #error Both XMON and KGDB 
>>>> selected in .config. Unselect one of them.
>>>> make[1]: *** [arch/powerpc/kernel/kgdb.o] Blad 1
>>>> make: *** [arch/powerpc/kernel] Blad 2
>
>    This patch does not seem complete as the #error that was tiggering 
> has not been deleleted from arch/powerpc/kernel/kgdb.c (and not it's 
> useless)
>

I suppose the argument could be made to remove the check in the compiled 
file, but it does serve as a way to protect kgdb for now if someone 
tries to hard compile in xmon and kgdb.  Completely unpredictable 
results will occur with the debugger unless some pieces are fixed.  I 
would rather make sure until that happens there is no way head down the 
rat hole.

That issue aside would it be useful to have xmon+kgdb?  After having 
looked at the hook points for xmon, if a command was added to xmon to 
provide an "detach" it would be easy enough to have kgdb and xmon in the 
same kernel.  Obviously only one or the other can be used at any given time.

Jason.
