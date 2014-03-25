Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 10/33] powerpc: Ignore TOC relocations
Date: Tue, 25 Mar 2014 22:44:16 +1100
Message-Id: <1395747879-5948-11-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The linker fixes up TOC. relocations, so prom_init_check.sh should
ignore them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/prom_init_check.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index b0c263d..77aa1e9 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -23,7 +23,7 @@ strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry
 boot_command_line __prom_init_toc_start __prom_init_toc_end
-btext_setup_display"
+btext_setup_display TOC."
 
 NM="$1"
 OBJ="$2"
-- 
1.8.3.2
