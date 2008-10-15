Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 30C04DE15B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 22:46:59 +1100 (EST)
Date: Wed, 15 Oct 2008 13:46:57 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
In-Reply-To: <1224070653.8157.452.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0810151343480.1133@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
	<Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
	<1224046194.8157.428.camel@pasglop>
	<Pine.LNX.4.64.0810151050330.1133@vixen.sonytel.be>
	<1224062907.8157.446.camel@pasglop>
	<Pine.LNX.4.64.0810151135330.1133@vixen.sonytel.be>
	<1224070653.8157.452.camel@pasglop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1073345617-1224071217=:1133"
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

---584349381-1073345617-1224071217=:1133
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 15 Oct 2008, Benjamin Herrenschmidt wrote:
> > > Well, at the time of the sample, the other CPU indeed -seems- to be in
> > > an IRQ disabled section yes. 
> > 
> > This is not really a sample. The hardirqs enable/disable is actually tracked
> > using the TRACE_{EN,DIS}ABLE_INTS macros.
> 
> That's what I meant. IE. the hardirq state was updated by the stuck CPU
> but sampled by the non-stuck one. ie. the non-stuck one could have
> sampled a transcient value where it happened to have hard irq
> disabled...

These states are per_cpu.

> > Aha, none of the PPC interrupt handlers actually us TRACE_ENABLE_INTS (they do
> > use TRACE_DISABLE_INTS). So that's why it thinks decrementer_common disabled
> > interrupts, without enabling them again...
> 
> Well, they aren't supposed to enable IRQs if they were disabled...

They do call TRACE_DISABLE_INTS, which records the interrupt being disabled.
So this makes the actual state recording useless...

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
---584349381-1073345617-1224071217=:1133--
