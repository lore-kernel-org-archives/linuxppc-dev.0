Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: powerpc/cell/oprofile: avoid double free of profile buffer
Date: Mon, 11 Aug 2008 09:25:43 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<18591.30474.127939.243247@cargo.ozlabs.ibm.com>
	<200808110918.57293.arnd@arndb.de>
In-Reply-To: <200808110918.57293.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808110925.44243.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sf.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Carl Love <cel@us.ibm.com>

If an error occurs on opcontrol start, the event and per cpu buffers
are released.  If later opcontrol shutdown is called then the free
function will be called again to free buffers that no longer
exist.  This results in a kernel oops.  The following changes
prevent the call to delete buffers that don't exist.

Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/oprofile/cpu_buffer.c   |    4 +++-
 drivers/oprofile/event_buffer.c |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/oprofile/cpu_buffer.c b/drivers/oprofile/cpu_buffer.c
index b8601dc..366b5d2 100644
--- a/drivers/oprofile/cpu_buffer.c
+++ b/drivers/oprofile/cpu_buffer.c
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
diff --git a/drivers/oprofile/event_buffer.c b/drivers/oprofile/event_buffer.c
index e7fbac5..8d692a5 100644
--- a/drivers/oprofile/event_buffer.c
+++ b/drivers/oprofile/event_buffer.c
@@ -93,6 +93,8 @@ out:
 void free_event_buffer(void)
 {
 	vfree(event_buffer);
+
+	event_buffer = NULL;
 }
 
  
-- 
1.5.4.3
