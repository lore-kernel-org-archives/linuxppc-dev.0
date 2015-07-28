Return-Path: <thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
To: slof@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru
Cc: gkurz@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [SLOF PATCH 2/2] fbuffer: Use a smaller cursor
Date: Tue, 28 Jul 2015 12:19:55 +0200
Message-Id: <1438078795-14360-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1438078795-14360-1-git-send-email-thuth@redhat.com>
References: <1438078795-14360-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drawing the cursor in the frame buffer memory is a very, very
slow operation. So let's simply switch to a "underscore" cursor
instead of the full block cursor to save some precious cycles.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 slof/fs/fbuffer.fs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
index 0128c07..542c431 100644
--- a/slof/fs/fbuffer.fs
+++ b/slof/fs/fbuffer.fs
@@ -98,7 +98,8 @@ CREATE bitmap-buffer 400 4 * allot
 
 : fb8-toggle-cursor ( -- )
 	line# fb8-line2addr column# fb8-columns2bytes +
-	char-height 0 ?DO
+	char-height 3 - screen-width screen-depth * * +
+	3 0 ?DO
 		dup char-width screen-depth * invert-region
 		screen-width screen-depth * +
 	LOOP drop
-- 
1.8.3.1
