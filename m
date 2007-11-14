Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 433B3DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 20:39:41 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 14 Nov 2007 10:39:39 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1194997072.28865.5.camel@pasglop>
Message-ID: <20071114093939.297890@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net>	 <1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net>	 <1194594629.6561.34.camel@pasglop>
	<20071110171130.254580@gmx.net>	 <1194753340.21340.24.camel@pasglop>
	<20071113212320.85840@gmx.net>	 <1194990218.28865.1.camel@pasglop>
	<20071113220655.85840@gmx.net> <1194997072.28865.5.camel@pasglop>
Subject: Re: Kernel locks up after calling kernel_execve()
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 14 Nov 2007 10:37:52 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> Add printk's to things :-) It's a UP kernel so there should be no
> spinlocks anyway.
> 
> Best is to try to get a 100% reprocase and printk your way toward the
> origin of the problem if you don't have a HW debugger. Unless you manage
> to sneak in an irq to xmon but if you are totally locked up, you
> probably can't.
Also xmon seems to lockup the machine. I was able to active it through the
magic sysrq key, but the machine died afterwards.

> Could also be something you do that your buggy northbridge doesn't like.
> For example, maybe it dislikes M bit in the hash table and you end up
> with it set due to other reasons (I know we had changes in this area).
Yeah, the northbridge hates the M bit! Thus the AmigaOne platform code
masks out the CPU_FTR_NEED_COHERENT flag and disables the L2 cache
prefetch engines (I don't care about the performance loss).
I couldn't find any other code that sets the M bit, except for huge TLB
page support, but isn't that only for PPC64?

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
