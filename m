Return-Path: <cel@us.ibm.com>
Subject: Re: [PATCH 2/2] Repost  Cell OProfile: SPU mutex lock fix, version 4
From: Carl Love <cel@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808081526.21405.arnd@arndb.de>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808081526.21405.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 15:39:44 -0700
Message-Id: <1218235184.6637.111.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	cbe-oss-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated to address Arnd's comments.

If an error occurs on opcontrol start, the event and per cpu buffers 
are released.  If later opcontrol shutdown is called then the free
function will be called again to free buffers that no longer 
exist.  This results in a kernel oops.  The following changes
prevent the call to delete buffers that don't exist.

Signed-off-by: Carl Love <carll@us.ibm.com>

Index: Cell_kernel_6_26_2008/drivers/oprofile/cpu_buffer.c
===================================================================
--- Cell_kernel_6_26_2008.orig/drivers/oprofile/cpu_buffer.c
+++ Cell_kernel_6_26_2008/drivers/oprofile/cpu_buffer.c
@@ -38,8 +38,10 @@ void free_cpu_buffers(void)
 {
 	int i;
 
-	for_each_online_cpu(i)
+	for_each_online_cpu(i) {
 		vfree(per_cpu(cpu_buffer, i).buffer);
+		per_cpu(cpu_buffer, i).buffer = NULL;
+	}
 }
 
 unsigned long oprofile_get_cpu_buffer_size(void)
Index: Cell_kernel_6_26_2008/drivers/oprofile/event_buffer.c
===================================================================
--- Cell_kernel_6_26_2008.orig/drivers/oprofile/event_buffer.c
+++ Cell_kernel_6_26_2008/drivers/oprofile/event_buffer.c
@@ -93,6 +93,8 @@ out:
 void free_event_buffer(void)
 {
 	vfree(event_buffer);
+
+	event_buffer = NULL;
 }
 
  
