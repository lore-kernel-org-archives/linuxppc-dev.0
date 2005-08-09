Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1288667FD2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 01:35:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C59CF6.45DDECC4"
Date: Tue, 9 Aug 2005 10:23:19 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859416@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C59CF6.45DDECC4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

I have discovered that the accuracy of the wallclock (xtime) on ppc is
not very good.
I am running a custom telco board based on a 8266, and the main busclock
is derived off of a T1 reference clock.
I was noticing a huge number of logentries fron OpenNTPD about
adjustiing the clock, so I started to check.
The drift of the walltime was a little over 7 seconds in 15 hours (7
seconds slow) (equals about 130us per s)

When I checked around, I found that xtime is updated in kernel/time.c
and is updated by time_nsec nanoseconds per timer interrupt.=20
This value is hardcoded (through some obscure macros) to be 999848
ns/timertick. Tis is 152ns slow per timertick. This works out to be
152us per second, almos the value I found.

I have tried a few workarounds, and made one that modifies time_nsec
before update_wall_time_one_tick() is called.
With this fix (which is 8260 specific at the time) I have less than 1 ms
drift after 5 days.

The fix works by calculating how many ns and fractions of ns there is in
one timer-tick (one jiffie).
Then, at each timer interrupt, I accumulate the ns fractions, and add
whole ns to the timer when needed.

This is tested on 8266 under 80.00MHz and 82.575360MHz main busclock. It
also works correct if HZ=3D1024 instead of 1000

It is not meant as a patch to be added to the kernel right now, but more
of a possible solution to a problem that it doesn't seem anybody has
noticed before.

Index: arch/ppc/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/ppc/kernel/time.c	(revision 20)
+++ arch/ppc/kernel/time.c	(working copy)
@@ -119,6 +119,11 @@
 EXPORT_SYMBOL(profile_pc);
 #endif
=20
+
+#ifdef CONFIG_8260
+extern unsigned long get_ns_delta(void); /*
arch/ppc/syslib/m8260_setup.c */
+extern unsigned long tick_nsec;          /* kernel/time.c */
+#endif
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
@@ -148,6 +153,10 @@
 		/* We are in an interrupt, no need to save/restore flags
*/
 		write_seqlock(&xtime_lock);
 		tb_last_stamp =3D jiffy_stamp;
+
+#ifdef CONFIG_8260	=09
+		tick_nsec =3D get_ns_delta();
+#endif	=09
 		do_timer(regs);
=20
 		/*
@@ -179,7 +188,7 @@
 		write_sequnlock(&xtime_lock);
 	}
 	if ( !disarm_decr[smp_processor_id()] )
-		set_dec(next_dec);
+		set_dec(next_dec-1);
 	last_jiffy_stamp(cpu) =3D jiffy_stamp;
=20
 	if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
Index: arch/ppc/syslib/m8260_setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/ppc/syslib/m8260_setup.c	(revision 20)
+++ arch/ppc/syslib/m8260_setup.c	(working copy)
@@ -31,6 +31,8 @@
=20
 #include "cpm2_pic.h"
=20
+#include <linux/module.h>   =20
+
 unsigned char __res[sizeof(bd_t)];
=20
 extern void cpm2_reset(void);
@@ -82,16 +84,63 @@
 /* The decrementer counts at the system (internal) clock frequency
  * divided by four.
  */
+unsigned long tb_time_nsec;
+unsigned long tb_frac_nsec;
+unsigned long tb_frac_limit;    =20
+=20
+extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
+=20
 static void __init
 m8260_calibrate_decr(void)
+{   =20
+    bd_t *binfo =3D (bd_t *)__res;
+    int freq, divisor, tick_freq;
+    uint64_t tmp;
+    printk("Calibrating Decrementer\n");
+
+    freq =3D binfo->bi_busfreq;
+    divisor =3D 4;
+   =20
+    /* get rounded off decrementer frequency */
+    tick_freq =3D (freq + 3) / 4;
+   =20
+    /* get number of timebase ticks per jiffy (timerint) */
+    tb_ticks_per_jiffy =3D (tick_freq + (HZ/2)) / HZ;
+    tb_to_us =3D mulhwu_scale_factor(tick_freq, 1000000);
+
+    /* calculate timer interrupt interval in nano seconds */
+    tmp =3D 1000000000ULL * (u64)tb_ticks_per_jiffy;
+    __div64_32(&tmp, tick_freq);
+    tb_time_nsec =3D tmp;
+   =20
+    /* calculate fractions of nanosecons per timer interrupt */
+    tb_frac_limit =3D 100000UL;
+    tmp =3D 1000000000ULL * (u64)tb_ticks_per_jiffy * tb_frac_limit;
+    __div64_32(&tmp, tick_freq);
+    tb_frac_nsec =3D (u32)(tmp - (u64)tb_time_nsec * =
(u64)tb_frac_limit);
+   =20
+    printk("busfreq =3D %u\n", freq);
+    printk("tb_ticks_per_jiffy =3D %u\ntb_to_us =3D %u\n",
tb_ticks_per_jiffy, tb_to_us);
+    printk("tick_freq =3D %u\ntime_nsec =3D %u\ntb_frac_nsec =3D %u\n",
tick_freq, tb_time_nsec, tb_frac_nsec);
+}
+
+unsigned long get_ns_delta(void)
 {
-	bd_t *binfo =3D (bd_t *)__res;
-	int freq, divisor;
+    static uint32_t frac =3D 0;
=20
-	freq =3D binfo->bi_busfreq;
-        divisor =3D 4;
-        tb_ticks_per_jiffy =3D freq / HZ / divisor;
-	tb_to_us =3D mulhwu_scale_factor(freq / divisor, 1000000);
+    unsigned long delta_ns;
+
+    delta_ns =3D tb_time_nsec;
+
+    /* adjust for inaccuracy in calculation */
+    frac +=3D tb_frac_nsec;
+    if (frac >=3D tb_frac_limit)
+    {
+        delta_ns +=3D frac / tb_frac_limit;
+        frac %=3D tb_frac_limit;
+    }
+   =20
+    return delta_ns;
 }
=20
 /* The 8260 has an internal 1-second timer update register that

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

------_=_NextPart_001_01C59CF6.45DDECC4
Content-Type: application/octet-stream;
	name="WallClock-fix"
Content-Transfer-Encoding: base64
Content-Description: WallClock-fix
Content-Disposition: attachment;
	filename="WallClock-fix"

SW5kZXg6IGFyY2gvcHBjL2tlcm5lbC90aW1lLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gYXJjaC9wcGMva2Vy
bmVsL3RpbWUuYwkocmV2aXNpb24gMjApCisrKyBhcmNoL3BwYy9rZXJuZWwvdGltZS5jCSh3b3Jr
aW5nIGNvcHkpCkBAIC0xMTksNiArMTE5LDExIEBACiBFWFBPUlRfU1lNQk9MKHByb2ZpbGVfcGMp
OwogI2VuZGlmCiAKKworI2lmZGVmIENPTkZJR184MjYwCitleHRlcm4gdW5zaWduZWQgbG9uZyBn
ZXRfbnNfZGVsdGEodm9pZCk7IC8qIGFyY2gvcHBjL3N5c2xpYi9tODI2MF9zZXR1cC5jICovCitl
eHRlcm4gdW5zaWduZWQgbG9uZyB0aWNrX25zZWM7ICAgICAgICAgIC8qIGtlcm5lbC90aW1lLmMg
Ki8KKyNlbmRpZgogLyoKICAqIHRpbWVyX2ludGVycnVwdCAtIGdldHMgY2FsbGVkIHdoZW4gdGhl
IGRlY3JlbWVudGVyIG92ZXJmbG93cywKICAqIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZC4KQEAg
LTE0OCw2ICsxNTMsMTAgQEAKIAkJLyogV2UgYXJlIGluIGFuIGludGVycnVwdCwgbm8gbmVlZCB0
byBzYXZlL3Jlc3RvcmUgZmxhZ3MgKi8KIAkJd3JpdGVfc2VxbG9jaygmeHRpbWVfbG9jayk7CiAJ
CXRiX2xhc3Rfc3RhbXAgPSBqaWZmeV9zdGFtcDsKKworI2lmZGVmIENPTkZJR184MjYwCQkKKwkJ
dGlja19uc2VjID0gZ2V0X25zX2RlbHRhKCk7CisjZW5kaWYJCQogCQlkb190aW1lcihyZWdzKTsK
IAogCQkvKgpAQCAtMTc5LDcgKzE4OCw3IEBACiAJCXdyaXRlX3NlcXVubG9jaygmeHRpbWVfbG9j
ayk7CiAJfQogCWlmICggIWRpc2FybV9kZWNyW3NtcF9wcm9jZXNzb3JfaWQoKV0gKQotCQlzZXRf
ZGVjKG5leHRfZGVjKTsKKwkJc2V0X2RlYyhuZXh0X2RlYy0xKTsKIAlsYXN0X2ppZmZ5X3N0YW1w
KGNwdSkgPSBqaWZmeV9zdGFtcDsKIAogCWlmIChwcGNfbWQuaGVhcnRiZWF0ICYmICFwcGNfbWQu
aGVhcnRiZWF0X2NvdW50LS0pCkluZGV4OiBhcmNoL3BwYy9zeXNsaWIvbTgyNjBfc2V0dXAuYwo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBhcmNoL3BwYy9zeXNsaWIvbTgyNjBfc2V0dXAuYwkocmV2aXNpb24gMjAp
CisrKyBhcmNoL3BwYy9zeXNsaWIvbTgyNjBfc2V0dXAuYwkod29ya2luZyBjb3B5KQpAQCAtMzEs
NiArMzEsOCBAQAogCiAjaW5jbHVkZSAiY3BtMl9waWMuaCIKIAorI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPiAgICAKKwogdW5zaWduZWQgY2hhciBfX3Jlc1tzaXplb2YoYmRfdCldOwogCiBleHRl
cm4gdm9pZCBjcG0yX3Jlc2V0KHZvaWQpOwpAQCAtODIsMTYgKzg0LDYzIEBACiAvKiBUaGUgZGVj
cmVtZW50ZXIgY291bnRzIGF0IHRoZSBzeXN0ZW0gKGludGVybmFsKSBjbG9jayBmcmVxdWVuY3kK
ICAqIGRpdmlkZWQgYnkgZm91ci4KICAqLwordW5zaWduZWQgbG9uZyB0Yl90aW1lX25zZWM7Cit1
bnNpZ25lZCBsb25nIHRiX2ZyYWNfbnNlYzsKK3Vuc2lnbmVkIGxvbmcgdGJfZnJhY19saW1pdDsg
ICAgIAorIAorZXh0ZXJuIHVpbnQzMl90IF9fZGl2NjRfMzIodWludDY0X3QgKmRpdmlkZW5kLCB1
aW50MzJfdCBkaXZpc29yKTsKKyAKIHN0YXRpYyB2b2lkIF9faW5pdAogbTgyNjBfY2FsaWJyYXRl
X2RlY3Iodm9pZCkKK3sgICAgCisgICAgYmRfdCAqYmluZm8gPSAoYmRfdCAqKV9fcmVzOworICAg
IGludCBmcmVxLCBkaXZpc29yLCB0aWNrX2ZyZXE7CisgICAgdWludDY0X3QgdG1wOworICAgIHBy
aW50aygiQ2FsaWJyYXRpbmcgRGVjcmVtZW50ZXJcbiIpOworCisgICAgZnJlcSA9IGJpbmZvLT5i
aV9idXNmcmVxOworICAgIGRpdmlzb3IgPSA0OworICAgIAorICAgIC8qIGdldCByb3VuZGVkIG9m
ZiBkZWNyZW1lbnRlciBmcmVxdWVuY3kgKi8KKyAgICB0aWNrX2ZyZXEgPSAoZnJlcSArIDMpIC8g
NDsKKyAgICAKKyAgICAvKiBnZXQgbnVtYmVyIG9mIHRpbWViYXNlIHRpY2tzIHBlciBqaWZmeSAo
dGltZXJpbnQpICovCisgICAgdGJfdGlja3NfcGVyX2ppZmZ5ID0gKHRpY2tfZnJlcSArIChIWi8y
KSkgLyBIWjsKKyAgICB0Yl90b191cyA9IG11bGh3dV9zY2FsZV9mYWN0b3IodGlja19mcmVxLCAx
MDAwMDAwKTsKKworICAgIC8qIGNhbGN1bGF0ZSB0aW1lciBpbnRlcnJ1cHQgaW50ZXJ2YWwgaW4g
bmFubyBzZWNvbmRzICovCisgICAgdG1wID0gMTAwMDAwMDAwMFVMTCAqICh1NjQpdGJfdGlja3Nf
cGVyX2ppZmZ5OworICAgIF9fZGl2NjRfMzIoJnRtcCwgdGlja19mcmVxKTsKKyAgICB0Yl90aW1l
X25zZWMgPSB0bXA7CisgICAgCisgICAgLyogY2FsY3VsYXRlIGZyYWN0aW9ucyBvZiBuYW5vc2Vj
b25zIHBlciB0aW1lciBpbnRlcnJ1cHQgKi8KKyAgICB0Yl9mcmFjX2xpbWl0ID0gMTAwMDAwVUw7
CisgICAgdG1wID0gMTAwMDAwMDAwMFVMTCAqICh1NjQpdGJfdGlja3NfcGVyX2ppZmZ5ICogdGJf
ZnJhY19saW1pdDsKKyAgICBfX2RpdjY0XzMyKCZ0bXAsIHRpY2tfZnJlcSk7CisgICAgdGJfZnJh
Y19uc2VjID0gKHUzMikodG1wIC0gKHU2NCl0Yl90aW1lX25zZWMgKiAodTY0KXRiX2ZyYWNfbGlt
aXQpOworICAgIAorICAgIHByaW50aygiYnVzZnJlcSA9ICV1XG4iLCBmcmVxKTsKKyAgICBwcmlu
dGsoInRiX3RpY2tzX3Blcl9qaWZmeSA9ICV1XG50Yl90b191cyA9ICV1XG4iLCB0Yl90aWNrc19w
ZXJfamlmZnksIHRiX3RvX3VzKTsKKyAgICBwcmludGsoInRpY2tfZnJlcSA9ICV1XG50aW1lX25z
ZWMgPSAldVxudGJfZnJhY19uc2VjID0gJXVcbiIsIHRpY2tfZnJlcSwgdGJfdGltZV9uc2VjLCB0
Yl9mcmFjX25zZWMpOworfQorCit1bnNpZ25lZCBsb25nIGdldF9uc19kZWx0YSh2b2lkKQogewot
CWJkX3QgKmJpbmZvID0gKGJkX3QgKilfX3JlczsKLQlpbnQgZnJlcSwgZGl2aXNvcjsKKyAgICBz
dGF0aWMgdWludDMyX3QgZnJhYyA9IDA7CiAKLQlmcmVxID0gYmluZm8tPmJpX2J1c2ZyZXE7Ci0g
ICAgICAgIGRpdmlzb3IgPSA0OwotICAgICAgICB0Yl90aWNrc19wZXJfamlmZnkgPSBmcmVxIC8g
SFogLyBkaXZpc29yOwotCXRiX3RvX3VzID0gbXVsaHd1X3NjYWxlX2ZhY3RvcihmcmVxIC8gZGl2
aXNvciwgMTAwMDAwMCk7CisgICAgdW5zaWduZWQgbG9uZyBkZWx0YV9uczsKKworICAgIGRlbHRh
X25zID0gdGJfdGltZV9uc2VjOworCisgICAgLyogYWRqdXN0IGZvciBpbmFjY3VyYWN5IGluIGNh
bGN1bGF0aW9uICovCisgICAgZnJhYyArPSB0Yl9mcmFjX25zZWM7CisgICAgaWYgKGZyYWMgPj0g
dGJfZnJhY19saW1pdCkKKyAgICB7CisgICAgICAgIGRlbHRhX25zICs9IGZyYWMgLyB0Yl9mcmFj
X2xpbWl0OworICAgICAgICBmcmFjICU9IHRiX2ZyYWNfbGltaXQ7CisgICAgfQorICAgIAorICAg
IHJldHVybiBkZWx0YV9uczsKIH0KIAogLyogVGhlIDgyNjAgaGFzIGFuIGludGVybmFsIDEtc2Vj
b25kIHRpbWVyIHVwZGF0ZSByZWdpc3RlciB0aGF0Cg==

------_=_NextPart_001_01C59CF6.45DDECC4--
