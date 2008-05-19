Return-Path: <gregory.haskins.ml@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 32B86DE247
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 05:59:25 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1753386pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 12:59:24 -0700 (PDT)
Message-ID: <4831DBDC.8000008@gmail.com>
Date: Mon, 19 May 2008 15:58:20 -0400
From: Gregory Haskins <gregory.haskins.ml@gmail.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>
	<4831D527.2020907@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Reply-To: gregory.haskins@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Scott Wood wrote:
>
>> You're recursively entering lock_timer_base, which does a
>> spin_lock_irqsave().  Either interrupts are enabled when they should
>> not be, or an interrupt was supposed to be threaded that isn't.
> 
> Sort of figured. How do I figure out which one, and how to fix it?
> I've never gotten any -rt patchsets to work on this CPU, and it always
> seems to be related to the disk driver.
> I've tried since 2.6.16 ppc.... (2.6.16, 2.6.18 on ppc, 2.6.24 and 25 on
> powerpc)
> 
> Even though this is a custom board, I'm pretty sure I can get it to fail
> on a pq2fads board with the same disk controller.

Im not sure if LOCKDEP is available for that architecture.  Have you 
tried it?  Its pretty good at flushing these kinds of issues out 
(assuming its available).

-Greg
