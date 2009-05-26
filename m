Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 8B74DDE066
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:32:38 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1925265qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 04:32:36 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221507.21370.68301.stgit@terra>
	<alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
Date: Tue, 26 May 2009 06:32:35 -0500
Message-ID: <ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
From: Timur Tabi <timur@freescale.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 2:29 AM, Geert Uytterhoeven
<Geert.Uytterhoeven@sonycom.com> wrote:

> static inline function, returning rc, instead of a macro?

It won't work as an inline function ...

>> + =A0 =A0 unsigned long __loops =3D tb_ticks_per_usec * timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 unsigned long __start =3D get_tbl(); =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 while ((rc =3D (condition)) && (tb_ticks_since(__start) <=3D _=
_loops)) \

There's no way to pass a expression to an inline function.  It has to
be a macro.  Here, the loop evaluates "condition" at every pass.  If
this were an inline function, "condition" would be evaluated once when
the function were called, and never again.

--=20
Timur Tabi
Linux kernel developer at Freescale
