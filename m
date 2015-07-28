Return-Path: <thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
To: slof@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru
Cc: gkurz@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [SLOF PATCH 1/2] fbuffer: Improve invert-region helper
Date: Tue, 28 Jul 2015 12:19:54 +0200
Message-Id: <1438078795-14360-2-git-send-email-thuth@redhat.com>
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

The introduction of invert-region already speeded up the cursor
drawing very much. But there is still space for improvement:
So far invert-region is accessing the memory only byte by byte,
but with some additional logic that checks the alignment of the
address and the length of the area, we can also make this function
to access the memory with half-word, word or long-word accesses.
With this additional logic, invert-region-x is also no longer
necessary and thus can be removed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 board-js2x/slof/helper.fs | 13 ++++++++-----
 board-qemu/slof/helper.fs | 14 ++++++++++----
 slof/fs/fbuffer.fs        |  2 +-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/board-js2x/slof/helper.fs b/board-js2x/slof/helper.fs
index 6030330..5941315 100644
--- a/board-js2x/slof/helper.fs
+++ b/board-js2x/slof/helper.fs
@@ -28,9 +28,12 @@
 ;
 
 : invert-region ( addr len -- )
-   0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
-;
-
-: invert-region-x ( addr len -- )
-   /x / 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP drop
+   2dup or 7 and CASE
+      0 OF 3 rshift 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP ENDOF
+      2 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
+      4 OF 2 rshift 0 ?DO dup dup rl@ -1 xor swap rl! la1+ LOOP ENDOF
+      6 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
+      dup OF 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP ENDOF
+   ENDCASE
+   drop
 ;
diff --git a/board-qemu/slof/helper.fs b/board-qemu/slof/helper.fs
index c807bc6..6613782 100644
--- a/board-qemu/slof/helper.fs
+++ b/board-qemu/slof/helper.fs
@@ -33,10 +33,16 @@
   swap -
 ;
 
-: invert-region ( addr len -- )
-   over swap 0 swap 1 hv-logical-memop drop
+: invert-region-cs ( addr len cellsize -- )
+   >r over swap r@ rshift r> swap 1 hv-logical-memop drop
 ;
 
-: invert-region-x ( addr len -- )
-   over swap /x / 3 swap 1 hv-logical-memop drop
+: invert-region ( addr len -- )
+   2dup or 7 and CASE
+      0 OF 3 invert-region-cs ENDOF
+      2 OF 1 invert-region-cs ENDOF
+      4 OF 2 invert-region-cs ENDOF
+      6 OF 1 invert-region-cs ENDOF
+      dup OF 0 invert-region-cs ENDOF
+   ENDCASE
 ;
diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
index fcdd2fa..0128c07 100644
--- a/slof/fs/fbuffer.fs
+++ b/slof/fs/fbuffer.fs
@@ -170,7 +170,7 @@ CREATE bitmap-buffer 400 4 * allot
 ;
 
 : fb8-invert-screen ( -- )
-	frame-buffer-adr screen-height screen-width * screen-depth * invert-region-x
+	frame-buffer-adr screen-height screen-width * screen-depth * invert-region
 ;
 
 : fb8-blink-screen ( -- ) fb8-invert-screen fb8-invert-screen ;
-- 
1.8.3.1
