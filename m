Message-ID: <37B83FFE.9078AA56@agelectronics.co.uk>
Date: Mon, 16 Aug 1999 17:44:46 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: New temperature patch
Content-Type: multipart/mixed;
 boundary="------------5D209C069824AABAC11BED8F"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5D209C069824AABAC11BED8F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've written yet another temperature patch for the 750, and I'd like
some volunteers to try it out.

The main feature is a thermal calibration value in machdep.h, which no
current machine can actually use, but which may well come in handy
later. Motorola 750s I've tested have been within about 10C of the
correct temperature, but there are no guarantees about the calibration
values of future silicon.

- Adrian Cox, AG Electronics
--------------5D209C069824AABAC11BED8F
Content-Type: text/plain; charset=us-ascii;
 name="temp.patch"
Content-Disposition: inline;
 filename="temp.patch"
Content-Transfer-Encoding: 7bit

--- linuxppc-2.2.10/arch/ppc/kernel/setup.c	Thu Aug  5 17:38:13 1999
+++ linux/arch/ppc/kernel/setup.c	Mon Aug 16 17:13:37 1999
@@ -72,6 +78,9 @@
 unsigned long ISA_DMA_THRESHOLD;
 unsigned long DMA_MODE_READ, DMA_MODE_WRITE;
 
+/* Default value is impossible */
+int ppc_temperature_calibration = 99999;
+
 /* Temporary hacks until machdep.h is fully done. */
 int _machine = 0;
 /* do we have OF? */
@@ -169,31 +178,50 @@
 
 unsigned long cpu_temp(void)
 {
-	unsigned char thres = 0;
-	
-#if 0
-	/* disable thrm2 */
-	_set_THRM2( 0 );
-	/* threshold 0 C, tid: exceeding threshold, tie: don't generate interrupt */
-	_set_THRM1( THRM1_V );
-
-	/* we need 20us to do the compare - assume 300MHz processor clock */
-	_set_THRM3(0);
-	_set_THRM3(THRM3_E | (300*30)<<18 );
-
-	udelay(100);
-	/* wait for the compare to complete */
-	/*while ( !(_get_THRM1() & THRM1_TIV) ) ;*/
-	if ( !(_get_THRM1() & THRM1_TIV) )
-		printk("no tiv\n");
-	if ( _get_THRM1() & THRM1_TIN )
-		printk("crossed\n");
-	/* turn everything off */
-	_set_THRM3(0);
+        static int never_again = 0;
+	unsigned t_lower;
+	unsigned t_upper;
+
+        if (never_again)
+            return -1;
+        
 	_set_THRM1(0);
-#endif
-		
-	return thres;
+	_set_THRM2(0);
+        
+        /* Converge on the correct value by moving in the boundaries */
+	t_lower = 0;
+	t_upper = 127;
+
+	while (t_upper - t_lower > 1)
+	{
+            unsigned long start_time;
+	    int t_1;
+
+	    t_1 = (t_lower + t_upper) / 2;
+	    _set_THRM1((t_1 << 23) | THRM1_TID | THRM1_V);
+            _set_THRM3(0x00003f69);
+            /* Wait for settling of value */
+            start_time = jiffies;
+	    while (!(_get_THRM1() & THRM1_TIV))
+		if (jiffies - start_time > HZ/2)
+                {
+                    never_again = 1;
+                    printk(KERN_CRIT "Thermal unit did not stabilise in 0.5s\n");
+                    return -1;
+                }
+
+	    /* Temperature less than t_1 */
+	    if (_get_THRM1() & THRM1_TIN)
+		t_upper = t_1;
+	    else
+		t_lower = t_1;
+
+	}
+        _set_THRM1(0);
+        _set_THRM3(0);
+        
+    
+	return t_upper;
 }
 
 int get_cpuinfo(char *buffer)
@@ -241,8 +275,15 @@
 			break;
 		case 8:
 			len += sprintf(len+buffer, "750\n");
-			len += sprintf(len+buffer, "temperature \t: %lu C\n",
-				       cpu_temp());
+                        {
+                            int temp = cpu_temp();
+                            if (ppc_temperature_calibration != 99999)
+                                temp += ppc_temperature_calibration;
+			    len += sprintf(len+buffer, "temperature \t: %lu C%s\n",
+				            temp, 
+                                    (ppc_temperature_calibration = 99999) ?
+                                     " (uncalibrated)" : "");
+                        }
 			break;
 		case 9:
 			len += sprintf(len+buffer, "604e\n");
--- linuxppc-2.2.10/include/asm-ppc/machdep.h	Mon Jul  5 15:53:58 1999
+++ linux/include/asm-ppc/machdep.h	Mon Aug 16 15:58:14 1999
@@ -72,5 +72,6 @@
 extern char cmd_line[512];
 
 extern void setup_pci_ptrs(void);
+extern int ppc_temperature_calibration;
 
 #endif /* _PPC_MACHDEP_H */
--- linuxppc-2.2.10/include/asm-ppc/processor.h	Mon Jul  5 15:53:55 1999
+++ linux/include/asm-ppc/processor.h	Mon Aug 16 15:43:36 1999
@@ -148,13 +150,13 @@
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
+#define THRM1_TIN (1<<31)
+#define THRM1_TIV (1<<30)
+#define THRM1_THRES (0x7f<<23)
+#define THRM1_TID (1<<2)
+#define THRM1_TIE (1<<1)
+#define THRM1_V   (1)
+#define THRM3_E   (1)
 
 /* Segment Registers */
 #define SR0	0

--------------5D209C069824AABAC11BED8F--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
