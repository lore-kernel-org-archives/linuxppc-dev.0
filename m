Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1F7DCDE02B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:51:50 +1000 (EST)
Date: Tue, 26 May 2009 13:51:47 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
In-Reply-To: <ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221507.21370.68301.stgit@terra>
	<alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
	<ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 May 2009, Timur Tabi wrote:
> On Tue, May 26, 2009 at 2:29 AM, Geert Uytterhoeven
> <Geert.Uytterhoeven@sonycom.com> wrote:
> 
> > static inline function, returning rc, instead of a macro?
> 
> It won't work as an inline function ...
> 
> >> +     unsigned long __loops = tb_ticks_per_usec * timeout;                \
> >> +     unsigned long __start = get_tbl();                                  \
> >> +     while ((rc = (condition)) && (tb_ticks_since(__start) <= __loops)) \
> 
> There's no way to pass a expression to an inline function.  It has to
> be a macro.  Here, the loop evaluates "condition" at every pass.  If
> this were an inline function, "condition" would be evaluated once when
> the function were called, and never again.

You're right, I missed that part. Sorry about that.

However, you can still improve useability by making the macro return the rc,
instead of letting the caller pass it, cfr. wait_event_timeout() and friends.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
