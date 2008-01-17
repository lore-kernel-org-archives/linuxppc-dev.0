Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id A31DFDDF02
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:44:25 +1100 (EST)
Date: Thu, 17 Jan 2008 15:44:22 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 06/18] PS3: Fix kexec storage probe
In-Reply-To: <20080116235154.946247739@am.sony.com>
Message-ID: <Pine.LNX.4.64.0801171543470.15992@vixen.sonytel.be>
References: <20080116235154.250479649@am.sony.com>
	<20080116235154.946247739@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-235241465-1200581043=:15992"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-235241465-1200581043=:15992
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0801171544081.15992@vixen.sonytel.be>

On Wed, 16 Jan 2008, geoffrey.levand@am.sony.com wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> The PS3 storage probe thread left the storage notification device open on
> shutdown, so the device open would fail with LV1_BUSY when the second stage
> kexec kernel tried to open the device.
> 
> To fix this:
>   - Replace the call to wait_for_completion_interruptible() by a call to
>     wait_event_interruptible() that also checks kthread_should_stop(),
>   - Install a reboot notifier that stops the storage probe thread on shutdown.

Actually I had planned to fold this into `[patch 05/18] PS3: Use the HVs
storage device notification mechanism properly'.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584349381-235241465-1200581043=:15992--
