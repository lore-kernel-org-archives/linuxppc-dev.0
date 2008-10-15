Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D15D2DDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 20:25:32 +1100 (EST)
Date: Wed, 15 Oct 2008 11:25:30 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
In-Reply-To: <1224046194.8157.428.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0810151050330.1133@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
	<Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
	<1224046194.8157.428.camel@pasglop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-709154712-1224061093=:1133"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Aaron Tokhy <atokhy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-709154712-1224061093=:1133
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0810151125001.1133@vixen.sonytel.be>

On Wed, 15 Oct 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-10-14 at 11:32 +0200, Geert Uytterhoeven wrote:
> > which points again to smp_call_function_single...
> 
> Yup, it doesn't bring more information. At this stage, your 'other' CPU
> is stuck with interrupts disabled. Hard to tell what's happening without
> some HW assist. Do you have ways to trigger a non-maskable interrupt
> such as a 0x100 ? That would allow to catch the other guy in xmon and
> see what it was doing...

Interrupts are not disabled on the other CPU thread, at least not according to
the irqs_disabled() check I added to the printing of the `spinlock lockup'
message in __spin_lock_debug().

As the log also said

| hardirqs last  enabled at (5018779): [<c000000000007c1c>] restore+0x1c/0xe4
| hardirqs last disabled at (5018780): [<c000000000003600>] decrementer_common+0x100/0x180

I started blinking the LEDs on decrementer interupts, which do arrive on both
CPU threads.

However, I'm a bit puzzled by these `hardirqs last enabled/disabled' messages,
as they do indicate interrupts are off...

> It could be something in the ps3vram driver causing the kernel to
> lockup.... Now the question is whether the kernel is stuffed with
> something like a deadlock with interrupts off, or is it a HW problem
> causing a CPU to lockup on an access to the vram ?

It's not related to the ps3vram driver, as it happens without, too.

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
---584349381-709154712-1224061093=:1133--
