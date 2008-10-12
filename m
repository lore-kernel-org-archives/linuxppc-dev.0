Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD7ABDDDEA
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 00:40:00 +1100 (EST)
Date: Sun, 12 Oct 2008 15:39:55 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Message-ID: <20081012133955.GA7536@Chamillionaire.breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<20081008030325.GD22396@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20081008030325.GD22396@verge.net.au>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Simon Horman | 2008-10-08 14:03:26 [+1100]:

>> +#ifdef WITH_GAMECUBE
>> +static int go_purgatory = 0;
>> +#else
>> +static int go_purgatory = 1;
>> +#endif
>
>Can you just use WITH_GAMECUBE inside elf_ppc_load() and remove
>the need for go_purgatory, or do you plan to make go_purgatory
>switchable at run-time at some point in the future?
For the first shot I would prefer to use WITH_GAMECUBE inside of
elf_ppc_load(). In longterm I don't see any reason why GameCube can't
use the purgatory code like the other archs and get the memory maps from
the device tree. However I'm not sure if GameCube still runs on a recent
kernel: now that arc/ppc isn't available anymore GameCube has to pass a
dtb somehow and this isn't the case. So therefore I would like the keep
#ifdef and the exisiting behavior until someone clears this up.

>Simon Horman

Sebastian
