To: "Jeff David" <jdavid@amperion.com>
Cc: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Real time clock seems stuck 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Oct 2002 07:45:41 EST."
             <C6D44AA99ECEB540A5498F15F92DA07D228E3C@amperion01.amperion.com>
Date: Thu, 31 Oct 2002 14:04:14 +0100
Message-Id: <20021031130419.E106D10158@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <C6D44AA99ECEB540A5498F15F92DA07D228E3C@amperion01.amperion.com> you wrote:
>
> You may be loading the code too low.  See the comments for the
> CFG_BOOTMAPSZ parameter in CONFIG_WALNUT405.h and cmd_bootm.c.  Try
> loading at 0x800000 instead.

No; loading at 400000 (= 4 MB) leaves enough room for the  kernel  to
uncompress; also, the kernel is booting fine until it get's stuck.

> > Kernel command line: console=ttyS0,9600 root=/dev/ram
> > Warning: real time clock seems stuck!

This is a common problem on boards that don't have a RTC at  all,  or
only  one which becomes available only later during the boot process,
for example after loading the I2C drivers.

You can find a fix in rev. 1.6 of kernel/time.c in the  2.4.4  source
tree  on  our  CVS  server;  here is the relevant pert (omitting many
lines  that  only  contain  white  space  changes  due  to   changing
indentation):


Index: kernel/time.c
===================================================================
RCS file: /cvsroot/linux-2.4/arch/ppc/kernel/time.c,v
retrieving revision 1.5
retrieving revision 1.6
diff -u -w -r1.5 -r1.6
--- kernel/time.c       16 Apr 2001 19:29:07 -0000      1.5
+++ kernel/time.c       11 Jun 2002 22:05:26 -0000      1.6
@@ -310,6 +310,7 @@
         * makes things more complex. Repeatedly read the RTC until the
         * next second boundary to try to achieve some precision...
         */
+       if (ppc_md.get_rtc_time) {
        stamp = get_native_tbl();
        sec = ppc_md.get_rtc_time();
        elapsed = 0;
@@ -331,6 +332,8 @@
        /* No update now, we just read the time from the RTC ! */
        last_rtc_update = xtime.tv_sec;
        write_unlock_irqrestore(&xtime_lock, flags);
+       }
+
        /* Not exact, but the timer interrupt takes care of this */
        set_dec(tb_ticks_per_jiffy);


Then make sure that your board sets ppc_md.get_rtc_time to NULL.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Am I your nanny? The kernel is there to support  user  programs,  but
it's a _resource_ handler, not a baby feeder.     - Linus Torvalds in
      <Pine.LNX.3.91.960425074845.22041C-100000@linux.cs.Helsinki.FI>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
