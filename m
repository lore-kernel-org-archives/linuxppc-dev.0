From: "D.J. Osguthorpe" <djosg@mgu.bath.ac.uk>
Message-Id: <10009201242.AA11420@mgu.bath.ac.uk> or <11420.10009201242@mgu.bath.ac.uk>
Subject: CPU Temperature Patch
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 20 Sep 2000 13:42:30 +0100 (BST)
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here are two patches that appear to fix the cpu_temp function in setup.c.
They have been applied to a number of Ben Herrenschmidt kernels on a 500 MHz
Pismo powerbook and print reasonable values when you cat /proc/cpuinfo.

Note that the intrinsic resolution of the temperature seems to be 4 degrees
- the values printed are at the mid-point between two 4 degree multiples.

The key document I found for this was a Motorola application note found under

http://www.mot.com/SPS/PowerPC/teksupport/teklibrary/index.html

The specific document is "Programming the Thermal Assist Unit in the MPC750,
Rev.0".

http://www.mot.com/SPS/PowerPC/teksupport/teklibrary/appnotes/an1800.pdf.


The update of processor.h means that everything gets re-compiled after
applying the patch.


David Osguthorpe


--- orig/linux-2.2.17pre13-ben1/include/asm-ppc/processor.h	Sun Jul 23 11:34:51 2000
+++ linux-2.2.17pre13-ben1/include/asm-ppc/processor.h	Mon Aug 14 23:40:36 2000
@@ -163,13 +163,15 @@
 #define THRM1	1020
 #define THRM2	1021
 #define THRM3	1022
-#define THRM1_TIN 0x1
-#define THRM1_TIV 0x2
-#define THRM1_THRES (0x7f<<2)
-#define THRM1_TID (1<<29)
-#define THRM1_TIE (1<<30)
-#define THRM1_V   (1<<31)
-#define THRM3_E   (1<<31)
+/*	these bits were defined in inverted endian sense originally */
+#define THRM1_TIN (1 << 31)
+#define THRM1_TIV (1 << 30)
+#define THRM1_THRES(x) ((x&0x7f)<<23)
+#define THRM3_SITV(x) ((x&0x3fff)<<1)
+#define THRM1_TID (1<<2)
+#define THRM1_TIE (1<<1)
+#define THRM1_V   (1<<0)
+#define THRM3_E   (1<<0)

 /* Segment Registers */
 #define SR0	0


--- orig/linux-2.2.17pre13-ben1/arch/ppc/kernel/setup.c	Fri Jul 14 11:18:18 2000
+++ linux-2.2.17pre13-ben1/arch/ppc/kernel/setup.c	Tue Sep 19 10:16:43 2000
@@ -177,31 +177,69 @@
 }
 #endif

+
+extern int _get_THRM1();
+extern int _get_THRM2();
+extern int _get_THRM3();
+extern int _set_THRM1(int);
+extern int _set_THRM2(int);
+extern int _set_THRM3(int);
+
 unsigned long cpu_temp(void)
 {
 	unsigned char thres = 0;
+	unsigned int othrm1;
+	unsigned int othrm2;
+	unsigned int othrm3;
+	unsigned int thrm1;
+	unsigned int thrm3;
+	unsigned int cnt;
+	unsigned int thresd;
+	unsigned int threst;
+	unsigned int i;

-#if 0
+	othrm1 = _get_THRM1();
+	othrm2 = _get_THRM2();
+	othrm3 = _get_THRM3();
 	/* disable thrm2 */
 	_set_THRM2( 0 );
-	/* threshold 0 C, tid: exceeding threshold, tie: don't generate interrupt */
-	_set_THRM1( THRM1_V );
-
+	_set_THRM1( 0 );
+
 	/* we need 20us to do the compare - assume 300MHz processor clock */
+	/* max value for sitv is 0x3fff - or 16383 */
+	/* this set for 500 MHz Pismo - how do we get access to clock?? */
+	/* 25 usec conversion time - max for 500 Mhz is approx. 32 usec */
 	_set_THRM3(0);
-	_set_THRM3(THRM3_E | (300*30)<<18 );
+	_set_THRM3(THRM3_E | THRM3_SITV(500*25) );

-	udelay(100);
-	/* wait for the compare to complete */
-	/*while ( !(_get_THRM1() & THRM1_TIV) ) ;*/
-	if ( !(_get_THRM1() & THRM1_TIV) )
-		printk("no tiv\n");
-	if ( _get_THRM1() & THRM1_TIN )
-		printk("crossed\n");
+	thresd = 1 << 6;
+	threst = thresd;
+	i =  7;
+	while (i > 1 && thresd > 2)
+		{
+		thrm1 = (THRM1_THRES(threst)) | THRM1_V;
+		_set_THRM1(thrm1);
+		cnt = 10000;
+		while ( !((thrm1=_get_THRM1()) & THRM1_TIV) && cnt ) cnt--;
+		/* printk("THRM1 %8x %d %c %d %d %d\n",thrm1,10000-cnt,(thrm1&THRM1_TIN?'x':' '),threst,thresd,i); */
+		if (cnt == 0)
+			{ printk("THRM1: no interrupt %8x\n",thrm1); threst = 0; break; }
+		else
+			{
+			if ( thrm1 & THRM1_TIN )
+				{ thresd = thresd >> 1; threst += thresd; }
+			else
+				{ thresd = thresd >> 1; threst -= thresd; }
+			i--;
+			}
+		}
+	thres = threst;
+	/* printk("THRM1 %d\n",threst); */
 	/* turn everything off */
-	_set_THRM3(0);
-	_set_THRM1(0);
-#endif
+	_set_THRM3(othrm3);
+	/*_set_THRM1(0);*/
+	_set_THRM1(othrm1);
+	_set_THRM2(othrm2);

 	return thres;
 }

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
