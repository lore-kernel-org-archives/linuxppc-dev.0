Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id BF8C22BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 02:29:05 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647450@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'wd@denx.de'" <wd@denx.de>, "'Tom Rini'" <trini@kernel.crashing.org>,
	"'Dan Malek'" <dan@embeddededge.com>
Date: Wed, 5 Jan 2005 10:28:54 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: watchdog vs inflate  in zlib
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I just have found while searching the web the old Linux 2.4 posting by Jan
Roelens ... and 
I am experiencing (but on newer Linux 2.6) exactly the same problem (on PPC
880) as he has mentioned:

> the linux statup code encounters
> a watchdog timeout (and thus a reset), somewhere when it is decompressing
> the ramdisk image.

I got confirmation from my board "vendor" that:
"The watch dog is enabled by the boot monitor, so it must be handled by the
loader and by the kernel too."

Also I just got addional info from my  "vendor" that: "The  timeout period
of the watchdog is 800msec."
The "vendor" also suggested that "to be sure", the watchdog should be reset
each 100msec ...

The boot monitor used is custom modified (by the board "vendor") pSOS
bootloader for which I do not have the code.
The compressed kernel image for Linux 2.6 is considerably larger than for
Linux 2.4 (which works fine with several watch dog reset calls put into
"while" loops within zlib decompression functions) - perhaps I need to put
more watch dog resets into zlib code ... ? - Any advise on where to put
those extra resets, etc. ?

Could I use the fix, posted - see below - by Jan Rowlens - have anyone tried
it on Linux 2.6 ?
What are suggested modifications I need to do to bring this fix to 2.6 ?

Thanks,
Best Regards,
I will Highly Appreciate replies,
Alex
********************************************************

FROM: Jan Roelens
DATE: 07/26/2001 11:06:54
SUBJECT: RE:  [Ppcboot-users] Can we use watchdog timer with Linux? 

The following code changes to the kernel work:

arch/ppc/kernel/m8xx-setup.c:

+/* added this function, called from arch/ppc/kernel/time.c*/
+void m8xx_reset_watchdog(void)
+{
+        ((volatile immap_t *)IMAP_ADDR)->im_siu_conf.sc_swsr = 0x556c;
+        ((volatile immap_t *)IMAP_ADDR)->im_siu_conf.sc_swsr = 0xaa39;
+}

in m8xx_init():

        ppc_md.time_init      = NULL;
        ppc_md.set_rtc_time   = m8xx_set_rtc_time;
        ppc_md.get_rtc_time   = m8xx_get_rtc_time;
        ppc_md.calibrate_decr = m8xx_calibrate_decr;
+        ppc_md.reset_watchdog = m8xx_reset_watchdog;

arch/ppc/kernel/time.c:

+unsigned long sched_watchdog_counter = 0;

void timer_interrupt(struct pt_regs * regs)
{
        int dval, d;
        unsigned long cpu = smp_processor_id();
.
.
.


+   if ((++sched_watchdog_counter&0x3F)==0) /*every 640msec */
+      ppc_md.reset_watchdog();

        hardirq_exit(cpu);
}

in include/asm-ppc/machdep.h:

struct machdep_calls {
        void            (*setup_arch)(unsigned long * memory_start_p,
                                unsigned long * memory_end_p);
        /* Optional, may be NULL. */
        int             (*setup_residual)(char *buffer);
        /* Optional, may be NULL. */
        int             (*get_cpuinfo)(char *buffer);
        /* Optional, may be NULL. */
        unsigned int    (*irq_cannonicalize)(unsigned int irq);
        void            (*init_IRQ)(void);
        void            (*do_IRQ)(struct pt_regs *regs, int cpu, int
isfake);

        /* A general init function, called by ppc_init in init/main.c.
           May be NULL. */
        void            (*init)(void);

        void            (*restart)(char *cmd);
        void            (*power_off)(void);
        void            (*halt)(void);

        void            (*time_init)(void); /* Optional, may be NULL */
        int             (*set_rtc_time)(unsigned long nowtime);
        unsigned long   (*get_rtc_time)(void);
        void            (*calibrate_decr)(void);
+   void        (*reset_watchdog)(void);

************************************************************************
Jan Roelens wrote:

> Hi,
>
> I'm using ppcboot-1.0.1 on a board with an MPC860.
>
> I'm loading and running Linux-2.2.14.
>
> This works fine if ppcboot disables the watchdog timer of the 860.
>
> If ppcboot enables the watchdog timer, the linux statup code encounters
> a watchdog timeout (and thus a reset), somewhere when it is decompressing
> the ramdisk image.
>
> The watchdog timeout is set to its maximum : with a 50MHz clock and a
> 2048 prescaler and a SWTC of 0xFFFF, that's a timeout of about 2.68
seconds.
>
> Can we use the watchdog timer with Linux?
>
> Thanks,
>
> --
> Jan Roelens
> <EMAIL: PROTECTED>
>
> _______________________________________________
> Ppcboot-users mailing list
> <EMAIL: PROTECTED>
> http://lists.sourceforge.net/lists/listinfo/ppcboot-users

--
Jan Roelens

-----Original Message-----
From: Povolotsky, Alexander 
Sent: Wednesday, January 05, 2005 8:58 AM
To: 'wd@denx.de'; 'Tom Rini'; 'Dan Malek'
Cc: linuxppc-embedded@ozlabs.org
Subject: watchdog vs inflate in zlib


Hi,

I got confirmation from my board "vendor" that:
"The watch dog is enabled by the boot monitor, so it must be handled by the
loader and by the kernel too."
At this point I do not know the watch dog's time out period.
The boot monitor is custom modified (by the board "vendor") pSOS bootloader
for which I do not have the code.
The compressed kernel image for Linux 2.6 is considerably larger than for
Linux 2.4 (which works fine) - perhaps I need to put more watch dog resets
into zlib code ... ? - Any advise on where to put those resets, etc. ?

Thanks,
Best Regards,
Alex
-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: Thursday, December 30, 2004 6:09 PM
To: Povolotsky, Alexander
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?


Hi Alex,

in message
<313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.co
m> you wrote:
> 
> After few days of wondering through debugging (and with 
> great help) I fixed (by inserting watch dog resets into 
> beginning of while loops in zlib functions) my first problem > - strange
reboot failures during decompression of

You know why I recommended U-Boot :-)

> Now I am getting "controlled" failure (during the same 
> decompression as described above):
> 
> I_BAD
> return Z_DATA_ERROR
> after zlib_inflate
> inflate returned FFFFFFFD
> exit
> 
> what does this error exactly mean ?

Most probably it means that the areas where the compressed  image  is stored
and   to  where  you  copy  the  uncompressed  code  to  are over-lapping.
Try storing the compressed image at  a  higher  address
(like 0x400000 or so).

Best regards,

Wolfgang Denk
-----Original Message-----
From: Nigel Cunningham [mailto:Nigel.Cunningham@cyclades.com]
Sent: Thursday, December 30, 2004 5:45 PM
To: Povolotsky, Alexander
Cc: linuxppc-embedded@ozlabs.org; linuxppc-embedded-bounces@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?

Hi.

linuxppc-embedded-bounces@ozlabs.org wrote on 31/12/2004 09:27:53:

> Hi,
>
> After few days of wondering through debugging (and with
> great help) I fixed (by inserting watch dog resets into 
> beginning of  while loops in zlib functions) my first 
> problem -strange reboot failures during decompression of
> the kernel image by the bootloader.
> However my luck expired beyond this fix so far ... ;-).
> Now I am getting "controlled" failure (during the same 
> decompression as described above):
>
> I_BAD
> return Z_DATA_ERROR
> after zlib_inflate
> inflate returned FFFFFFFD
> exit
>
> what does this error exactly mean ?

Going from include/linux/zlib.h, it is a data error: your compressed stream
has somehow been corrupted?

Regards,

Nigel
-- 
