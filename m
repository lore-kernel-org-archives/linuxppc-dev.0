To: Geoff Wyche <GWyche@DATUM.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SELF/busybox problems? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 05 Nov 2001 15:30:32 PST."
             <607BF0A2B4F3D411A09500508BC225427E833F@mailctx.datum.com>
Date: Tue, 06 Nov 2001 00:55:10 +0100
Message-Id: <20011105235516.2087A10CDD@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Geoff,

in message <607BF0A2B4F3D411A09500508BC225427E833F@mailctx.datum.com> you wrote:
>
> I'm currently using this little patch of my own in arch/ppc/8xx_io/uart.c:
>
> #define CONFIG_SERIAL_CONSOLE_PORT 1
> #if 1
> static struct serial_state rs_table[] = {
>         /* UART CLK   PORT          IRQ      FLAGS  NUM   */
>         { 0,     0, PROFF_SCC1, CPMVEC_SCC1,   0,    (NUM_IS_SCC | 0) },
> /* SCC1 ttyS0 */
>         { 0,     0, PROFF_SCC2, CPMVEC_SCC2,   0,    (NUM_IS_SCC | 1) },
> /* SCC2 ttyS1 */
> };
> #else
> ...

Should be fine if your console is on SCC2 = /dev/ttyS1

> First, when I run the SELF distribution with a dynamically linked BusyBox,
> it crashes with a "software check" at address 0x30015f78.  I haven't been
> able to figure out what's loaded at linear address 0x30000000.  My guess is
> there's something wrong with my glibc-2.2.3
>
> If I then recompile busybox with DO_STATIC=true, the CPU seems to hang, but
> my debugger (visionCLICK 7.0 under windows NT via BDM port) is no longer
> able to communicate with the processor.  If I then issue a CPU reset via the
> BDM, the CPU reboots after a bit (software watchdog timeout?) and runs past
> where it would hang before.

AFAIK visionCLICK does not support the MMU - I  guess  it  just  gets
mighty  confused with all these strange virtual addresses ;-) You may
consider to get a BDI2000 instead...

> I then get a proper busybox shell prompt.  This sequence (boot, hang, issue
> reset, boot, nohang) happens repeatably.  It hangs very shortly after
> starting /sbin/init, but the second time, it runs.  Always.

Did you try running your board without visionCLICK attached?

> The second problem is with the serial console line.  Once per second, BB's
> init program wakes up and checks for respawns or respawns something.
> Whatever that something is (/bin/application?) opens and closes the console.

Well - modify your inittab so it just starts an interactive shell  on
the console, and nothing else.

> Every time it opens and closes the console, it somehow steals characters
> from the serial port buffer.

I guess you have your console definitions (SCC1 / SCC2 ?) mixed up...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"No matter where you go, there you are..."          - Buckaroo Banzai

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
