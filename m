Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Pdn96tvnzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 07:31:25 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id j8-v6so16459265lfb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 14:31:25 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.LRH.2.21.1807011844470.19761@math.ut.ee>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com>
 <alpine.LRH.2.21.1807011844470.19761@math.ut.ee>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Jul 2018 23:31:21 +0200
Message-ID: <CAK8P3a29rNtWCcgKeJK57C5CPPi74wc1o1cnPJM=Qe+eMKFYjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
To: Meelis Roos <mroos@linux.ee>
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 1, 2018 at 5:47 PM, Meelis Roos <mroos@linux.ee> wrote:
> A patch for the subject is now upstream. That made me finally take some
> time to test it on my PowerMac G4. Tha date is OK but I get two warnings
> with backtrace on bootup. Full dmesg below.

Thanks for testing this, and sorry for the slow reply.

> [    4.026490] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/powermac/time.c:154 pmu_get_time+0x7c/0xc8
> [    4.032261] Modules linked in:
> [    4.037878] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         4.18.0-rc2-00223-g1904148a361a #88
> [    4.043750] NIP:  c0021354 LR: c0021308 CTR: 00000000
> [    4.049585] REGS: ef047cd0 TRAP: 0700   Tainted: G        W          (4.18.0-rc2-00223-g1904148a361a)
> [    4.055572] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 44000222  XER: 20000000
> [    4.061620]
>                GPR00: c0021308 ef047d80 ef048000 00000000 00d7029c 00000004 00000001 0000009c
>                GPR08: 00d70000 00000001 00000200 c06a0000 24000228 00000000 c0004c9c 00000000
>                GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0670000 c0601a38
>                GPR24: 00000008 c0630f18 c062a40c c05fc10c ef047e50 ef273800 ef047e50 ef047e50
> [    4.092393] NIP [c0021354] pmu_get_time+0x7c/0xc8
> [    4.098596] LR [c0021308] pmu_get_time+0x30/0xc8

I don't see how the WARN_ON() triggered unless the PMU time is
actually before 1970.

> [    4.104779] Call Trace:
> [    4.110909] [ef047d80] [c0021308] pmu_get_time+0x30/0xc8 (unreliable)
> [    4.117209] [ef047df0] [c00213e8] pmac_get_rtc_time+0x28/0x40
> [    4.123470] [ef047e00] [c000bc04] rtc_generic_get_time+0x20/0x34
> [    4.129770] [ef047e10] [c03aca34] __rtc_read_time+0x5c/0xe0
> [    4.136060] [ef047e20] [c03acafc] rtc_read_time+0x44/0x7c
> [    4.142356] [ef047e40] [c061e000] rtc_hctosys+0x64/0x11c
> [    4.148616] [ef047ea0] [c0004aa4] do_one_initcall+0x4c/0x1a8
> [    4.154866] [ef047f00] [c06022f0] kernel_init_freeable+0x12c/0x1f4
> [    4.161123] [ef047f30] [c0004cb4] kernel_init+0x18/0x130
> [    4.167359] [ef047f40] [c00121c4] ret_from_kernel_thread+0x14/0x1c
> [    4.173610] Instruction dump:
> [    4.179766] 8941002e 5484c00e 5508801e 88e1002f 7c844214 554a402e 7c845214 7c843a14
> [    4.186076] 7d244810 7d294910 7d2948f8 552907fe <0f090000> 3d2083da 80010074 38210070
> [    4.192388] ---[ end trace 2e01ad9337fe08fd ]---
> [    4.198643] rtc-generic rtc-generic: hctosys: unable to read the hardware clock

The last message here happens exactly in that case as well: tm_year is before
1970:

int rtc_valid_tm(struct rtc_time *tm)
{
        if (tm->tm_year < 70
                || ((unsigned)tm->tm_mon) >= 12
                || tm->tm_mday < 1
                || tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
                || ((unsigned)tm->tm_hour) >= 24
                || ((unsigned)tm->tm_min) >= 60
                || ((unsigned)tm->tm_sec) >= 60)
                return -EINVAL;

        return 0;
}

The most likely explanation I have here is that the RTC was indeed set to an
incorrect date, either because of a depleted battery (not unlikely for
a ~15 year
old box) or because it was previously stored incorrectly. You say that the
time is correct, but that could also be the case if the machine is connected to
the network and synchronized using NTP. It should not have gotten the
time from the RTC after that error.

If you have the time to do another test, can you boot the machine with
its network disconnected, see if the warning persists (it may have been
repaired after the correct time got written into the RTC during shutdown),
what the output of 'sudo hwclock' is, and whether anything changes after
you set the correct time using 'hwclock --systohc' and reboot?

         Arnd
