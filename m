Message-ID: <3E52B7E6.9060903@mvista.com>
Date: Tue, 18 Feb 2003 15:47:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel /proc/sys/kernel/l3cr patch
Content-Type: multipart/mixed;
 boundary="------------090008010403040409050108"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090008010403040409050108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch that does the following:

a) Adds /proc/sys/kernel/l3cr which provides the same functionality as
/proc/sys/kernel/l2cr but for the L3CR register.
b) Accounts for the differences in the L2CR register between the
75x/74x0 and 745x processors.
c) Updates 'clockstrings[]' for the 74x0 processor in proc_dol2crvec()
(i.e., adds +3.5 & +4 clock).

I do have a question...should I add 'KERN_PPC_L3CR=57' to
include/linux/sysctl.h the way that I did or should I move it behind
'KERN_PPC_L2CR=31' and renumber the following entries??

Mark
--

--------------090008010403040409050108
Content-Type: text/plain;
 name="proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.patch"

===== arch/ppc/kernel/ppc_htab.c 1.30 vs edited =====
--- 1.30/arch/ppc/kernel/ppc_htab.c	Sun Nov  4 05:02:40 2001
+++ edited/arch/ppc/kernel/ppc_htab.c	Tue Feb 18 14:55:16 2003
@@ -444,18 +444,18 @@
     }
 }

+#define TMPBUFLEN 512
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp)
 {
 	int vleft, first=1, len, left, val;
-	#define TMPBUFLEN 256
 	char buf[TMPBUFLEN], *p;
 	static const char *sizestrings[4] = {
 		"2MB", "256KB", "512KB", "1MB"
 	};
 	static const char *clockstrings[8] = {
-		"clock disabled", "+1 clock", "+1.5 clock", "reserved(3)",
-		"+2 clock", "+2.5 clock", "+3 clock", "reserved(7)"
+		"clock disabled", "+1 clock", "+1.5 clock", "+3.5 clock",
+		"+2 clock", "+2.5 clock", "+3 clock", "+4 clock"
 	};
 	static const char *typestrings[4] = {
 		"flow-through burst SRAM", "reserved SRAM",
@@ -511,22 +511,177 @@
 				*p++ = '\t';
 			val = _get_L2CR();
 			p += sprintf(p, "0x%08x: ", val);
-			p += sprintf(p, " %s", (val >> 31) & 1 ? "enabled" :
+			p += sprintf(p, " L2 %s", (val >> 31) & 1 ? "enabled" :
 				     	"disabled");
 			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
-			p += sprintf(p, ", %s", sizestrings[(val >> 28) & 3]);
-			p += sprintf(p, ", %s", clockstrings[(val >> 25) & 7]);
-			p += sprintf(p, ", %s", typestrings[(val >> 23) & 2]);
-			p += sprintf(p, "%s", (val>>22)&1 ? ", data only" : "");
-			p += sprintf(p, "%s", (val>>20)&1 ? ", ZZ enabled": "");
-			p += sprintf(p, ", %s", (val>>19)&1 ? "write-through" :
-					"copy-back");
-			p += sprintf(p, "%s", (val>>18)&1 ? ", testing" : "");
-			p += sprintf(p, ", %sns hold",holdstrings[(val>>16)&3]);
-			p += sprintf(p, "%s", (val>>15)&1 ? ", DLL slow" : "");
-			p += sprintf(p, "%s", (val>>14)&1 ? ", diff clock" :"");
-			p += sprintf(p, "%s", (val>>13)&1 ? ", DLL bypass" :"");
+
+			/* 75x & 74x0 have different L2CR than 745x */
+			if (!(cur_cpu_spec[0]->cpu_features &
+						CPU_FTR_SPEC7450)) {
+				p += sprintf(p, ", %s",
+					sizestrings[(val >> 28) & 3]);
+				p += sprintf(p, ", %s",
+					clockstrings[(val >> 25) & 7]);
+				p += sprintf(p, ", %s",
+					typestrings[(val >> 23) & 3]);
+				p += sprintf(p, "%s", (val>>22)&1 ?
+					", data only" : "");
+				p += sprintf(p, "%s", (val>>20)&1 ?
+					", ZZ enabled": "");
+				p += sprintf(p, ", %s", (val>>19)&1 ?
+					"write-through" : "copy-back");
+				p += sprintf(p, "%s", (val>>18)&1 ?
+					", testing" : "");
+				p += sprintf(p, ", %sns hold",
+					holdstrings[(val>>16)&3]);
+				p += sprintf(p, "%s", (val>>15)&1 ?
+					", DLL slow" : "");
+				p += sprintf(p, "%s", (val>>14)&1 ?
+					", diff clock" :"");
+				p += sprintf(p, "%s", (val>>13)&1 ?
+					", DLL bypass" :"");
+			} else { /* 745x */
+				p += sprintf(p, ", %sinstn only", (val>>20)&1 ?
+					"" : "no ");
+				p += sprintf(p, ", %sdata only", (val>>16)&1 ?
+					"" : "no ");
+				p += sprintf(p, ", %s replacement",
+					(val>>12)&1 ?  "secondary" : "default");
+			}
+
+			p += sprintf(p,"\n");

+			len = strlen(buf);
+			if (len > left)
+				len = left;
+			if(copy_to_user(buffer, buf, len))
+				return -EFAULT;
+			left -= len;
+			buffer += len;
+			break;
+		}
+	}
+
+	if (!write && !first && left) {
+		if(put_user('\n', (char *) buffer))
+			return -EFAULT;
+		left--, buffer++;
+	}
+	if (write) {
+		p = (char *) buffer;
+		while (left) {
+			char c;
+			if(get_user(c, p++))
+				return -EFAULT;
+			if (!isspace(c))
+				break;
+			left--;
+		}
+	}
+	if (write && first)
+		return -EINVAL;
+	*lenp -= left;
+	filp->f_pos += *lenp;
+	return 0;
+}
+
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp)
+{
+	int vleft, first=1, len, left, val;
+	char buf[TMPBUFLEN], *p;
+	static const char *clockstrings[8] = {
+		"+6 clock", "reserved(1)", "+2 clock", "+2.5 clock",
+		"+3 clock", "+3.5 clock", "+4 clock", "+5 clock"
+	};
+	static const char *clocksampstrings[4] = {
+		"2 clock", "3 clock", "4 clock", "5 clock"
+	};
+	static const char *pclocksampstrings[8] = {
+		"0 P-clock", "1 P-clock", "2 P-clock", "3 P-clock",
+		"4 P-clock", "5 P-clock", "reserved(6)", "reserved(7)"
+	};
+	static const char *typestrings[4] = {
+		"MSUG2 DDR SRAM",
+		"Pipelined synchronous late-write SRAM",
+		"Reserved", "PB2 SRAM"
+	};
+
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR))
+		return -EFAULT;
+
+	if ( /*!table->maxlen ||*/ (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	vleft = table->maxlen / sizeof(int);
+	left = *lenp;
+
+	for (; left /*&& vleft--*/; first=0) {
+		if (write) {
+			while (left) {
+				char c;
+				if(get_user(c,(char *) buffer))
+					return -EFAULT;
+				if (!isspace(c))
+					break;
+				left--;
+				((char *) buffer)++;
+			}
+			if (!left)
+				break;
+			len = left;
+			if (len > TMPBUFLEN-1)
+				len = TMPBUFLEN-1;
+			if(copy_from_user(buf, buffer, len))
+				return -EFAULT;
+			buf[len] = 0;
+			p = buf;
+			if (*p < '0' || *p > '9')
+				break;
+			val = simple_strtoul(p, &p, 0);
+			len = p-buf;
+			if ((len < left) && *p && !isspace(*p))
+				break;
+			buffer += len;
+			left -= len;
+			_set_L3CR(val);
+		} else {
+			p = buf;
+			if (!first)
+				*p++ = '\t';
+			val = _get_L3CR();
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " L3 %s", (val >> 31) & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", %sdata parity", (val>>30)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %saddr parity", (val>>29)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %s", (val>>28)&1 ? "2MB" : "1MB");
+			p += sprintf(p, ", clocks %s", (val>>27)&1 ? "enabled" :
+					"disabled");
+			p += sprintf(p, ", %s", clockstrings[(val >> 23) & 7]);
+			p += sprintf(p, ", %sinstn only", (val>>22)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %ssample point override",
+					(val>>18)&1 ? "" : "no ");
+			p += sprintf(p, ", %s sample point",
+					clocksampstrings[(val>>16)&3]);
+			p += sprintf(p, ", %s sample point",
+					pclocksampstrings[(val>>13)&7]);
+			p += sprintf(p, ", %s replacement", (val>>12)&1 ?
+					"secondary" : "default");
+			p += sprintf(p, ", %s", typestrings[(val >> 8) & 3]);
+			p += sprintf(p, ", %sclock cntl", (val>>7)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %sdata only", (val>>6)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", private mem %s", (val>>2)&1 ?
+					"enabled" : "disabled");
+			p += sprintf(p, ", %sprivate mem", val&1 ? "2MB " :
+					"1MB ");
 			p += sprintf(p,"\n");

 			len = strlen(buf);
===== include/linux/sysctl.h 1.18 vs edited =====
--- 1.18/include/linux/sysctl.h	Tue Jan 28 12:44:31 2003
+++ edited/include/linux/sysctl.h	Tue Feb 18 14:26:51 2003
@@ -125,6 +125,9 @@
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
  	KERN_CORE_PATTERN=56,	/* string: pattern for core-files */
+
+	KERN_PPC_L3CR=57,       /* l3cr register on PPC */
+
 };


===== kernel/sysctl.c 1.28 vs edited =====
--- 1.28/kernel/sysctl.c	Tue Jan  7 04:00:12 2003
+++ edited/kernel/sysctl.c	Tue Feb 18 14:27:38 2003
@@ -91,6 +91,8 @@
 extern int powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		   void *buffer, size_t *lenp);
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		   void *buffer, size_t *lenp);
 #endif

 #ifdef CONFIG_BSD_PROCESS_ACCT
@@ -193,6 +195,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_PPC_L2CR, "l2cr", NULL, 0,
 	 0644, NULL, &proc_dol2crvec},
+	{KERN_PPC_L3CR, "l3cr", NULL, 0,
+	 0644, NULL, &proc_dol3crvec},
 #endif
 	{KERN_CTLALTDEL, "ctrl-alt-del", &C_A_D, sizeof(int),
 	 0644, NULL, &proc_dointvec},

--------------090008010403040409050108--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
