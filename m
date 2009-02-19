Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 0E081DDDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 23:37:44 +1100 (EST)
Date: Thu, 19 Feb 2009 13:37:36 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: BUG: MAX_STACK_TRACE_ENTRIES too low!
Message-ID: <alpine.LRH.2.00.0902191334550.15109@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When running 2.6.29-rc5+ on PS3 (ppc64), I got the following BUG once during
bootup:

| Freeing unused kernel memory: 3436k freed
| BUG: MAX_STACK_TRACE_ENTRIES too low!
| turning off the locking correctness validator.
| Call Trace:
| [c000000006e1b640] [c00000000000f850] .show_stack+0x6c/0x16c (unreliable)
| [c000000006e1b6f0] [c00000000007cf6c] .save_trace+0xe0/0x108
| [c000000006e1b780] [c00000000007d058] .add_lock_to_list+0xc4/0x124
| [c000000006e1b830] [c0000000000816d0] .__lock_acquire+0x13c4/0x17c8
| [c000000006e1b930] [c000000000081b78] .lock_acquire+0xa4/0xec
| [c000000006e1b9f0] [c0000000003be034] ._spin_lock+0x34/0x58
| [c000000006e1ba80] [c0000000000d3e40] .kmem_cache_free+0x84/0x1a8
| [c000000006e1bb30] [c0000000001f9abc] .idr_remove+0x214/0x248
| [c000000006e1bbf0] [c00000000002867c] .destroy_context+0x34/0x64
| [c000000006e1bc80] [c00000000005008c] .__mmdrop+0x4c/0x7c
| [c000000006e1bd10] [c00000000004de90] .finish_task_switch+0xec/0x14c
| [c000000006e1bdb0] [c00000000004e6fc] .schedule_tail+0x2c/0xa0
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
| [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc

(There are 65 call trace lines)

After that the system continued.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
