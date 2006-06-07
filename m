Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17542.28107.683504.207147@cargo.ozlabs.ibm.com>
Date: Wed, 7 Jun 2006 16:10:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
   linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] Add a prctl to change the endianness of a process.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

This new prctl is intended for changing the execution mode of the
processor, on processors that support both a little-endian mode and a
big-endian mode.  It is intended for use by programs such as
instruction set emulators (for example an x86 emulator on PowerPC),
which may find it convenient to use the processor in an alternate
endianness mode when executing translated instructions.

Note that this does not imply the existence of a fully-fledged ABI for
both endiannesses, or of compatibility code for converting system
calls done in the non-native endianness mode.  The program is expected
to arrange for all of its system call arguments to be presented in the
native endianness.

Switching between big and little-endian mode will require some care in
constructing the instruction sequence for the switch.  Generally the
instructions up to the instruction that invokes the prctl system call
will have to be in the old endianness, and subsequent instructions
will have to be in the new endianness.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Andrew: if you are OK with this patch, I will put it in the
powerpc.git tree along with the next 2 patches in this series, and
merge them to Linus after 2.6.17 is released.

diff --git a/include/linux/prctl.h b/include/linux/prctl.h
index bf022c4..52a9be4 100644
--- a/include/linux/prctl.h
+++ b/include/linux/prctl.h
@@ -52,4 +52,11 @@ # define PR_TIMING_TIMESTAMP    1       
 #define PR_SET_NAME    15		/* Set process name */
 #define PR_GET_NAME    16		/* Get process name */
 
+/* Get/set process endian */
+#define PR_GET_ENDIAN	19
+#define PR_SET_ENDIAN	20
+# define PR_ENDIAN_BIG		0
+# define PR_ENDIAN_LITTLE	1	/* True little endian mode */
+# define PR_ENDIAN_PPC_LITTLE	2	/* "PowerPC" pseudo little endian */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 0b6ec0e..12d2d75 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -57,6 +57,12 @@ #endif
 #ifndef GET_FPEXC_CTL
 # define GET_FPEXC_CTL(a,b)	(-EINVAL)
 #endif
+#ifndef GET_ENDIAN
+# define GET_ENDIAN(a,b)	(-EINVAL)
+#endif
+#ifndef SET_ENDIAN
+# define SET_ENDIAN(a,b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2057,6 +2063,13 @@ asmlinkage long sys_prctl(int option, un
 				return -EFAULT;
 			return 0;
 		}
+		case PR_GET_ENDIAN:
+			error = GET_ENDIAN(current, arg2);
+			break;
+		case PR_SET_ENDIAN:
+			error = SET_ENDIAN(current, arg2);
+			break;
+
 		default:
 			error = -EINVAL;
 			break;
