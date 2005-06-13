Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9511C679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 02:40:24 +1000 (EST)
Message-ID: <42ADB6EE.30205@am.sony.com>
Date: Mon, 13 Jun 2005 09:40:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Prosun Niyogi <pniyogi@us.ibm.com>
References: <OF6BE916AF.4D6A65C4-ON8625701F.004ACEBA-8625701F.004B9D77@us.ibm.com>
In-Reply-To: <OF6BE916AF.4D6A65C4-ON8625701F.004ACEBA-8625701F.004B9D77@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: KGDB on BookE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Prosun Niyogi wrote:
> 
> I've grabbed latest kernel.org kernel (2.6.11.11) to attempt to get a
> working kgdb on my ebony setup. Checking the mailing list archives, it
> seems as if all the 4xx specific kgdb patches have been merged with
> kernel.org. Is this the case? If so, I have a problem single stepping
> using kgdb. The debugger_sstep(regs) function is never called from
> traps.c. So, as of right now.. I can only set/hit an arbitrary
> breakpoint (for my testing, I've been setting a breakpoint at sys_sync).
> After setting the breakpoint and continuing from the initial kgdb entry
> point, gdb successfully catches the breakpoint at sys_sync, but when I
> attempt to step, the kernel continues normal operation, and subsequent
> attempts at breaking into gdb control by issuing a "sync" command on the
> ebony terminal in minicom do not hit the breakpoint. Any
> pointers/suggestions as to where I can obtain a working kgdb-enabled
> kernel for the ebony board? Any assistance would be helpful.
> 

Apply the patches in CVS from http://sourceforge.net/projects/kgdb

This works with 2.6.11.11 and Ebony with both serial and Ether connections, 
but I found the kernel hangs with CONFIG_PREEMPT=y.

-Geoff
