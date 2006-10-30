Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 4FBB367C86
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 19:23:07 +1100 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GeSQD-0006n0-1i
	for linuxppc-embedded@ozlabs.org; Mon, 30 Oct 2006 09:23:05 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
	<609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
	<87lknadbbl.fsf@sleipner.barco.com>
	<877iylreca.fsf@sleipner.barco.com> <4542CE8A.9030904@dlasys.net>
Date: Mon, 30 Oct 2006 09:23:05 +0100
In-Reply-To: <4542CE8A.9030904@dlasys.net> (David H. Lynch, Jr.'s message of
	"Fri, 27 Oct 2006 23:29:14 -0400")
Message-ID: <87pscap5zq.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

David>     There is a substantial time/code difference between the
David> time ulite_console_setup() is called and the time the platform
David> device is initiallized.

Huh?

(gdb) br ulite_probe
Breakpoint 2 at 0xc00f7530: file drivers/serial/uartlite.c, line 397.
(gdb) br ulite_console_setup
Breakpoint 3 at 0xc00f7454: file drivers/serial/uartlite.c, line 342.
(gdb) c
Continuing.

Breakpoint 2, ulite_probe (pdev=0xc00ddb50) at drivers/serial/uartlite.c:397
397                     return -EINVAL;
(gdb) c
Continuing.

Breakpoint 3, ulite_console_setup (co=0xc00e2f14, options=0xc00fe00f "115200")
    at drivers/serial/uartlite.c:342
342             if (co->index < 0 || co->index >= ULITE_NR_UARTS)

_probe get's called before console_setup, so we have all the
information to output console data right away.

David>     But for now, if you are not going to bother making
David> console_settup() work you might as well not put the rest of the
David> early serial code in at all.

Not going to make it work? What doesn't work?

-- 
Bye, Peter Korsgaard
