Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFFA000@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Troy Benjegerdes'" <hozer@drgw.net>
Cc: trini@mvista.com, mgreer@mvista.com,
	"'Jim Thompson'" <jim@musenki.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Bogomips and loops_per_jiffy
Date: Wed, 8 May 2002 12:53:39 -0400 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1F6B0.E6EB1E90"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1F6B0.E6EB1E90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Troy,
with the patch, now, it completely hangs.
The reason is that in timer_interrupt()

	while ((next_dec =3D tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0)
{ =20

Now that next_dec is unsigned, this condition is always false.

Here is another patch I suggest to replace yours.
Its in attachement to this email.
I tested it, and it seems OK.

I did not include your modification made to the type of local variables =
in
function do_settimeofday().
I do not see how it is related to our problem.


--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Qu=E9bec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------


------_=_NextPart_000_01C1F6B0.E6EB1E90
Content-Type: application/octet-stream;
	name="patch.time.2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch.time.2"

--- Kernel.orig/arch/ppc/kernel/time.c	Mon Apr 22 12:19:05 2002=0A=
+++ Kernel/arch/ppc/kernel/time.c	Wed May  8 12:46:57 2002=0A=
@@ -99,8 +99,8 @@=0A=
 EXPORT_SYMBOL(rtc_lock);=0A=
 =0A=
 /* Timer interrupt helper function */=0A=
-static inline int tb_delta(unsigned *jiffy_stamp) {=0A=
-	int delta;=0A=
+static inline unsigned tb_delta(unsigned *jiffy_stamp) {=0A=
+	unsigned delta;=0A=
 	if (__USE_RTC()) {=0A=
 		delta =3D get_rtcl();=0A=
 		if (delta < *jiffy_stamp) *jiffy_stamp -=3D 1000000000;=0A=
@@ -150,7 +150,7 @@=0A=
  */=0A=
 int timer_interrupt(struct pt_regs * regs)=0A=
 {=0A=
-	int next_dec;=0A=
+	unsigned next_dec;=0A=
 	unsigned long cpu =3D smp_processor_id();=0A=
 	unsigned jiffy_stamp =3D last_jiffy_stamp(cpu);=0A=
 	extern void do_IRQ(struct pt_regs *);=0A=
@@ -160,7 +160,13 @@=0A=
 =0A=
 	hardirq_enter(cpu);=0A=
 	=0A=
-	while ((next_dec =3D tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < =
0) {=0A=
+	while(1) {=0A=
+		unsigned delta =3D tb_delta(&jiffy_stamp);=0A=
+		if(tb_ticks_per_jiffy >=3D delta) {=0A=
+			next_dec =3D tb_ticks_per_jiffy - delta;=0A=
+			break;=0A=
+		}=0A=
+=0A=
 		jiffy_stamp +=3D tb_ticks_per_jiffy;=0A=
 		if (!user_mode(regs))=0A=
 			ppc_do_profile(instruction_pointer(regs));=0A=

------_=_NextPart_000_01C1F6B0.E6EB1E90--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
