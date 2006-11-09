Return-Path: <mgreer@mvista.com>
Date: Wed, 8 Nov 2006 17:52:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Remove arch/powerpc/boot/zImage file.
Message-ID: <20061109005225.GB10072@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bootwrapper Makefile does not clean up the 'zImage' file that
may be left laying around.  This patch removes it when cleaning that
directory.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index df1e1df..f077ef8 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -76,7 +76,7 @@ $(obj)/zImage.lds $(obj)/zImage.coff.lds
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		empty.c zImage.coff.lds zImage.lds zImage.sandpoint
+		empty.c zImage zImage.coff.lds zImage.lds zImage.sandpoint
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
