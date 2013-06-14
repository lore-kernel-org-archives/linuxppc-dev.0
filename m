Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C17292C016F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 12:40:01 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [Trivial PATCH 12/33] macintosh: Convert use of typedef ctl_table to
 struct ctl_table
Date: Thu, 13 Jun 2013 19:37:37 -0700
Message-Id: <2884936fcfd6463d116ba108b8b174dd822c8547.1371177118.git.joe@perches.com>
In-Reply-To: <cover.1371177118.git.joe@perches.com>
References: <cover.1371177118.git.joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This typedef is unnecessary and should just be removed.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/macintosh/mac_hid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 6a82388..80d30e8 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -181,7 +181,7 @@ static void mac_hid_stop_emulation(void)
 	mac_hid_destroy_emumouse();
 }
 
-static int mac_hid_toggle_emumouse(ctl_table *table, int write,
+static int mac_hid_toggle_emumouse(struct ctl_table *table, int write,
 				   void __user *buffer, size_t *lenp,
 				   loff_t *ppos)
 {
@@ -214,7 +214,7 @@ static int mac_hid_toggle_emumouse(ctl_table *table, int write,
 }
 
 /* file(s) in /proc/sys/dev/mac_hid */
-static ctl_table mac_hid_files[] = {
+static struct ctl_table mac_hid_files[] = {
 	{
 		.procname	= "mouse_button_emulation",
 		.data		= &mouse_emulate_buttons,
@@ -240,7 +240,7 @@ static ctl_table mac_hid_files[] = {
 };
 
 /* dir in /proc/sys/dev */
-static ctl_table mac_hid_dir[] = {
+static struct ctl_table mac_hid_dir[] = {
 	{
 		.procname	= "mac_hid",
 		.maxlen		= 0,
@@ -251,7 +251,7 @@ static ctl_table mac_hid_dir[] = {
 };
 
 /* /proc/sys/dev itself, in case that is not there yet */
-static ctl_table mac_hid_root_dir[] = {
+static struct ctl_table mac_hid_root_dir[] = {
 	{
 		.procname	= "dev",
 		.maxlen		= 0,
-- 
1.8.1.2.459.gbcd45b4.dirty
