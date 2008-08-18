Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01A06DE55B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 03:52:13 +1000 (EST)
Message-ID: <48A9AFA7.8080508@freescale.com>
Date: Mon, 18 Aug 2008 12:21:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
References: <48591941.4070408@extricom.com>
	<48A92E15.2080709@extricom.com>	<48A9901B.1080900@redhat.com>
	<20080818154746.GA26835@Krystal>
In-Reply-To: <20080818154746.GA26835@Krystal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Eran Liberty <liberty@extricom.com>, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mathieu Desnoyers wrote:
>         asm volatile (
>                 "1: lwz         %1, 0(%2)\n"
>                 "   cmpw        %1, %5\n"
>                 "   bne         2f\n"
>                 "   stwu        %3, 0(%2)\n"
>                 "2:\n"
>                 ".section .fixup, \"ax\"\n"
>                 "3:     li %0, 1\n"
>                 "       b 2b\n"
>                 ".previous\n"
>                 ".section __ex_table,\"a\"\n"
>                 _ASM_ALIGN "\n"
>                 _ASM_PTR "1b, 3b\n"
>                 ".previous"
>                 : "=r"(faulted), "=r"(replaced)
>                 : "r"(ip), "r"(new),
>                   "0"(faulted), "r"(old)
>                 : "memory");

Some (most likely unrelated) nits in the above inline asm:

Should use a "b" constraint for %2, or you could get r0.  Or, use an "m" 
constraint with %U2%X2 after the lwz/stw.  Why stwu with an offset of 
zero, BTW?

%1 also needs to be an early clobber.

-Scott
