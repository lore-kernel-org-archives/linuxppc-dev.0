Return-Path: <chris.elston@radstone.co.uk>
Received: from mail14.messagelabs.com (mail14.messagelabs.com [212.125.75.19])
	by ozlabs.org (Postfix) with SMTP id 4DA1767A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 18:42:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 8 Apr 2005 09:43:57 +0100
Message-ID: <F38DEABE0E171746B133C1ABBD142D9703691AEC@radmail.Radstone.Local>
From: "Chris Elston" <chris.elston@radstone.co.uk>
To: <akpm@osdl.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.12-rc2 2/2] ppc32: add rtc hooks in PPC7D platform file
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This=20patch=20adds=20the=20hooks=20into=20the=20PPC7D=20platforms=20file=20=
to
support=20the=20DS1337=20RTC=20device=20as=20the=20clock=20device=20for=20=
the=20
PPC7D=20board.

Signed-off-by:=20Chris=20Elston=20<chris.elston@radstone.co.uk>

---=20linux-2.6.12-rc2/arch/ppc/platforms/radstone_ppc7d.c
2005-04-07=2012:31:43.000000000=20+0100
+++=20linux-2.6.12-rc2-cde/arch/ppc/platforms/radstone_ppc7d.c
2005-04-07=2012:28:51.000000000=20+0100
@@=20-68,6=20+68,7=20@@
=20#define=20PPC7D_RST_PIN=09=09=0917=20=09/*=20GPP17=20*/
=20
=20extern=20u32=20mv64360_irq_base;
+extern=20spinlock_t=20rtc_lock;
=20
=20static=20struct=20mv64x60_handle=20bh;
=20static=20int=20ppc7d_has_alma;
@@=20-75,6=20+76,11=20@@
=20extern=20void=20gen550_progress(char=20*,=20unsigned=20short);
=20extern=20void=20gen550_init(int,=20struct=20uart_port=20*);
=20
+/*=20FIXME=20-=20move=20to=20h=20file=20*/
+extern=20int=20ds1337_do_command(int=20id,=20int=20cmd,=20void=20*arg);
+#define=20DS1337_GET_DATE=20=20=20=20=20=20=20=20=200
+#define=20DS1337_SET_DATE=20=20=20=20=20=20=20=20=201
+
=20/*=20residual=20data=20*/
=20unsigned=20char=20__res[sizeof(bd_t)];
=20
@@=20-1236,6=20+1248,38=20@@
=20=09printk(KERN_INFO=20"Radstone=20Technology=20PPC7D\n");
=20=09if=20(ppc_md.progress)
=20=09=09ppc_md.progress("ppc7d_setup_arch:=20exit",=200);
+
+}
+
+/*=20Real=20Time=20Clock=20support.
+=20*=20PPC7D=20has=20a=20DS1337=20accessed=20by=20I2C.
+=20*/
+static=20ulong=20ppc7d_get_rtc_time(void)
+{
+=20=20=20=20=20=20=20=20struct=20rtc_time=20tm;
+=20=20=20=20=20=20=20=20int=20result;
+
+=20=20=20=20=20=20=20=20spin_lock(&rtc_lock);
+=20=20=20=20=20=20=20=20result=20=3D=20ds1337_do_command(0,=20DS1337_GET_=
DATE,=20&tm);
+=20=20=20=20=20=20=20=20spin_unlock(&rtc_lock);
+
+=20=20=20=20=20=20=20=20if=20(result=20=3D=3D=200)
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20result=20=3D=20mktime(tm.=
tm_year,=20tm.tm_mon,=20tm.tm_mday,
tm.tm_hour,=20tm.tm_min,=20tm.tm_sec);
+
+=20=20=20=20=20=20=20=20return=20result;
+}
+
+static=20int=20ppc7d_set_rtc_time(unsigned=20long=20nowtime)
+{
+=20=20=20=20=20=20=20=20struct=20rtc_time=20tm;
+=20=20=20=20=20=20=20=20int=20result;
+
+=20=20=20=20=20=20=20=20spin_lock(&rtc_lock);
+=20=20=20=20=20=20=20=20to_tm(nowtime,=20&tm);
+=20=20=20=20=20=20=20=20result=20=3D=20ds1337_do_command(0,=20DS1337_SET_=
DATE,=20&tm);
+=20=20=20=20=20=20=20=20spin_unlock(&rtc_lock);
+
+=20=20=20=20=20=20=20=20return=20result;
=20}
=20
=20/*=20This=20kernel=20command=20line=20parameter=20can=20be=20used=20to=20=
have=20the=20target
@@=20-1293,6=20+1337,10=20@@
=20=09data8=20|=3D=200x07;
=20=09outb(data8,=20PPC7D_CPLD_LEDS);
=20
+=20=20=20=20=20=20=20=20/*=20Hook=20up=20RTC.=20We=20couldn't=20do=20this=
=20earlier=20because=20we=20need=20the
I2C=20subsystem=20*/
+=20=20=20=20=20=20=20=20ppc_md.set_rtc_time=20=3D=20ppc7d_set_rtc_time;
+=20=20=20=20=20=20=20=20ppc_md.get_rtc_time=20=3D=20ppc7d_get_rtc_time;
+
=20=09pr_debug("%s:=20exit\n",=20__FUNCTION__);
=20}


________________________________________________________________________
This=20e-mail=20has=20been=20scanned=20for=20all=20viruses=20by=20Star.=20=
The
service=20is=20powered=20by=20MessageLabs.=20For=20more=20information=20on=
=20a=20proactive
anti-virus=20service=20working=20around=20the=20clock,=20around=20the=20gl=
obe,=20visit:
http://www.star.net.uk
________________________________________________________________________
