Message-Id: <200101291656.IAA26096@mail.turbolinux.com>
Date: Mon, 29 Jan 2001 17:04:10 -0000
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] setting clock
From: Brad Midgley <brad@turbolinux.com>
Reply-To: brad@turbolinux.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi

negative/large times are undefined or poorly defined. i found out the hard way that strange
problems crop up if the time isn't set (ie the machine thinks it's 1904... yes it's wrong to have
the date unset but let's not add insult and fail to work).

make can't tell if 1904 is in the future or the past:

make: *** Warning: File `include/config/MARKER' has modification time in the future (1904-07-04
17:45:40 > 2001-01-29 09:12:24)

and other things fail (at least java does -- the VM won't initialize)

the patch is online

 http://redcloud.uccs.edu/~bcmidgle/linux/time.patch

and here

diff -ur linux-bk-dma/arch/ppc/kernel/pmac_time.c linux/arch/ppc/kernel/pmac_time.c
--- linux-bk-dma/arch/ppc/kernel/pmac_time.c    Tue Jan 23 18:25:21 2001
+++ linux/arch/ppc/kernel/pmac_time.c   Mon Jan 29 09:15:30 2001
@@ -83,7 +83,7 @@
 {
 #if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU)
        struct adb_request req;
-       unsigned long now;
+       unsigned long now = 0;
 #endif

        /* Get the time from the RTC */
@@ -99,7 +99,7 @@
                               req.reply_len);
                now = (req.reply[3] << 24) + (req.reply[4] << 16)
                        + (req.reply[5] << 8) + req.reply[6];
-               return now - RTC_OFFSET;
+               break;
 #endif /* CONFIG_ADB_CUDA */
 #ifdef CONFIG_ADB_PMU
        case SYS_CTRLER_PMU:
@@ -112,11 +112,14 @@
                               req.reply_len);
                now = (req.reply[1] << 24) + (req.reply[2] << 16)
                        + (req.reply[3] << 8) + req.reply[4];
-               return now - RTC_OFFSET;
+               break;
 #endif /* CONFIG_ADB_PMU */
        default: ;
        }
-       return 0;
+       if(now < RTC_OFFSET)
+         return 0;
+       else
+         return now - RTC_OFFSET;
 }

 int pmac_set_rtc_time(unsigned long nowtime)

--
Brad
brad@turbolinux.com      http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
