Date: Thu, 6 Jan 2000 09:24:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Naoki Takebayashi <ntakebay@bio.indiana.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: enhanced RTC and SMP on PowerMac
In-Reply-To: <Pine.SOL.4.10.10001051648140.262-100000@sunflower.bio.indiana.edu>
Message-ID: <Pine.LNX.4.05.10001060924220.9276-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 5 Jan 2000, Naoki Takebayashi wrote:
> Is enhanced RTC supposed to work on PowerMac?  When I compile with
> CONFIG_RTC, the kernel doesn't boot up and dies when it hits the following
> line:
> 
>    /* Initialize periodic freq. to CMOS reset default, which is 1024Hz */
>    CMOS_WRITE(((CMOS_READ(RTC_FREQ_SELECT) & 0xF0) | 0x06), RTC_FREQ_SELECT);
> 
> in the function, __initfunc(int rtc_init(void)), in
> linux/drivers/char/rtc.c.
> 
> I'm using 2.2.14 on PowerSurge board (UMAX S900).
> 
> I was looking at the linux/arch/ppc/kernel/pmac_time.c and prep_time.c.
> And I noticed, that PReP machine uses CMOS_WRITE to access RTC, but
> PowerMac uses cuda to access RTC instead of CMOS_WRITE.  So I'm guessing
> that enhanced RTC doesn't work on the PowerMacs, right now.

To use enhanced RTC (/dev/rtc) on anything without a PC RTC, you have to write
a specific driver for your hardware first.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
