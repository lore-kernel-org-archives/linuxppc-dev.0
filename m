Message-ID: <20011016035912.51739.qmail@web20102.mail.yahoo.com>
Date: Mon, 15 Oct 2001 20:59:12 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Re: [Ppcboot-users] Software watchdog timer doesn't work for 860P , using ppcboot and 2.4 linux 
To: Wolfgang Denk <wd@denx.de>
Cc: ppcboot-users@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20011015185144.30C8F10887@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[ Sorry to bother you all good folks with my troubles
related to software watchdog, I have spent some time
going through 8xx manual couple times, still don't get
it ;( ]

--- Wolfgang Denk <wd@denx.de> wrote:
> In message
> <20011015174632.68318.qmail@web20109.mail.yahoo.com>
> you wrote:
> >
> > Thanks for the pointer, I downloaded that patch
> > however even with that patch my board resets right
> > after it
> > prints the message --
> > "Transferring control to Linux (at address
> 00000000 )
> > ..."
>
> Are you sure it works without the watchdog enabled?
> Even with the  WD
> you  should have somthing like 2 seconds before it
> resets - more than
> enough time to spit out some boot messages.

Yes the board boots and linux works for hours, without
any problems, if  I put #undef CONFIG_WATCHDOG in my
board_config.h for ppcboot.

>
> > I printed value of SYPCR just before this printf
> and
> > SYPCR is set at 0xFFFFFF8F does this value look
> > correct?
> >
> > This value indicates that SWTC is 0xFF and
> > SWE, SWF, SWRI, SWP bits are all set to 1s.
>
> Looks good to me.
>

Just to see why the board was getting reset I modified
the code of ppcboot to print value of RCR register of
8xx.  ANd here is what I am seeing

When I initially power up the system, RCR comes out as
0xC0000000

Now if I let the board download kernel and ramdisk and
boot. Upon reset RCR's value is set to 0xD0000000
which indicates that board was reset due to Software
watchdog reset.


Now I wonder if something is wrong with my clock
settings?

This is what is in my board_config.h

#define CFG_PLPRCR_MF   (20-1)
                /* 8 * 4 MHz = 32 MHz Clock */
#define CFG_PLPRCR
             ( (CFG_PLPRCR_MF << PLPRCR_MF_SHIFT) | \
                PLPRCR_SPLSS | PLPRCR_TEXPS |
PLPRCR_TMIST)

#define CONFIG_8xx_GCLK_FREQ
                    ((CFG_PLPRCR_MF+1) * 4000000)


When PPCBoot starts up it prints message

CPU: XPC860xxZPnnD4 at 80 Mhzl 16 kB I-Cache 8kB
D-cache FEC present

I have also tried setting baud rate to 38400 and
changing the kernel logging level from 7 to 1, the
board still resets.
Any other 8xx register I should be looking at?

HELP!!

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
