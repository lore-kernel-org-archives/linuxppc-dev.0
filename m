Message-ID: <398934C7.663E6BD9@wanadoo.fr>
Date: Thu, 03 Aug 2000 11:00:55 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
References: <200008022249.XAA32651@hyperion.valhalla.net>
Content-Type: multipart/mixed;
 boundary="------------D406740818560C9929615480"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D406740818560C9929615480
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Iain Sandoe wrote:
>
> Hi,
>
> under 2.2.17pre15ben1
>
> rtc does not give me the right answer when built in - what am I doing wrong?
>
> It won't build load as a module right now 'cos I forgot to check ppc_ksyms
> before doing the build :-( .... (I remembered for 2.4.0).
>
> under 2.4.0-test5 it seems to be fine as a module (haven't tried built in).

I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
don't give the same time, and I think it is the one in 2.4.0 that is
right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
shift by 2 hours, but the discrepancy remains.

The following patch for bitkeeper linuxppc_2_2 fixes this problem for
me. It brings 2.2.17pre13 in line with 2.4.0-test5 (and MacOS). I cannot
test the VIAPMU part, so maybe there the offset is necessary, but for
the VIACUDA part, it seems wrong.

--
Martin
--------------D406740818560C9929615480
Content-Type: text/plain; charset=us-ascii;
 name="pmac_time.patch"
Content-Disposition: inline;
 filename="pmac_time.patch"
Content-Transfer-Encoding: 7bit

--- arch/ppc/kernel/pmac_time.c~	Mon Jun 26 09:09:05 2000
+++ arch/ppc/kernel/pmac_time.c	Thu Aug  3 09:22:36 2000
@@ -78,7 +78,6 @@
 unsigned long pmac_get_rtc_time(void)
 {
 	struct adb_request req;
-	int offset = sys_tz.tz_minuteswest * 60;

 	/* Get the time from the RTC */
 	if (adb_controller == 0)
@@ -95,7 +94,7 @@
 			printk(KERN_ERR "pmac_get_rtc_time: got %d byte reply\n",
 			       req.reply_len);
 		return (req.reply[3] << 24) + (req.reply[4] << 16)
-			+ (req.reply[5] << 8) + req.reply[6] - RTC_OFFSET + offset;
+			+ (req.reply[5] << 8) + req.reply[6] - RTC_OFFSET;
 	case ADB_VIAPMU:
 		if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0) {
 			printk("pmac_read_rtc_time: pmu_request failed\n");
@@ -107,7 +106,7 @@
 			printk(KERN_ERR "pmac_get_rtc_time: got %d byte reply\n",
 			       req.reply_len);
 		return (req.reply[1] << 24) + (req.reply[2] << 16)
-			+ (req.reply[3] << 8) + req.reply[4] - RTC_OFFSET + offset;
+			+ (req.reply[3] << 8) + req.reply[4] - RTC_OFFSET;
 	default:
 		return 0;
 	}


--------------D406740818560C9929615480--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
