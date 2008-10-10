Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 04FBCDE6E6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 23:55:19 +1100 (EST)
Date: Fri, 10 Oct 2008 14:55:17 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 14/16] powerpc: expand vs demux ipi actions per message
In-Reply-To: <patch-ipi-2@bga.com>
Message-ID: <Pine.LNX.4.64.0810101453380.12257@vixen.sonytel.be>
References: <patch-ipi-2@bga.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1239339143-1223643317=:12257"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
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

---584349381-1239339143-1223643317=:12257
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 10 Oct 2008, Milton Miller wrote:
> +/*
> + * irq controllers that have dedicated ipis per message and don't
> + * need additional code in the action handler may use this
> + */
> +extern int smp_request_message_ipi(int irq, int message);
                                          ^^^      ^^^^^^^
> +/* optional function to request ipi, for controllers with >= 4 ipis */
> +int smp_request_message_ipi(int msg, int virq)
                                   ^^^      ^^^^

Woops, the order (and to a lesser extend, the name) of the arguments doesn't
match?
Worse, all callers use the order of the prototype, not the one of the
implementation.

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
---584349381-1239339143-1223643317=:12257--
