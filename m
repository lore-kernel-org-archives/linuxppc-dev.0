Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11EEEB70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Sep 2011 03:06:24 +1000 (EST)
Message-ID: <4E73816C.6000304@freescale.com>
Date: Fri, 16 Sep 2011 12:03:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vineeth <vneethv@gmail.com>
Subject: Re: Timer interrupt on Linux 3.0.3
References: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
In-Reply-To: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2011 06:43 AM, Vineeth wrote:
> Hi,
> 
> We are porting Linux on MPC7410 based board. As there was some issue
> with the processor DECrementer and timebase registers,

What was the issue?  You really should try to make this work rather than
hack around it.

> lately we moved to Linux 3.0.3. What we found was even without a proper
> timer, the kernel with initramfs worked (except the calls like
> sleep,delay ofcourse); Is there any major difference in the scheduler ?
> or the way context switch happens ? is it not depended on the timer
> interrupt or the timer ??

If your timer is broken then you won't get timeslice expiration, but
basic scheduling should still work.  Most scheduling (depending on type
of load, of course) will be triggered by processes blocking or being
woken up by I/O, not timeslice expiration.

-Scott
