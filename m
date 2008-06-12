Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id E26FBDDFC5
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:16:11 +1000 (EST)
Date: Thu, 12 Jun 2008 15:16:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] one kbuild fix for powerpc
Message-ID: <20080612131650.GA13702@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus.

Following fix has been late as I have been sloppy to look into this.
Kumar has patiently reminded me and tested the follwing fix.

I could have made the patch a few lines smaller - but decided to add
a helper function and moved the obvious candidates to the helper function.

Please pull from:

    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-fixes.git


	Sam 


 scripts/mod/modpost.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)


commit 82e93ceaa5b55a8eb2b9b5454b2904b60781c763
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Thu Jun 12 15:02:55 2008 +0200

    kbuild: ignore powerpc specific symbols in modpost
    
    Kumar Gala <galak@kernel.crashing.org> wrote:
    We have a case in powerpc in which we want to link some library
    routines with all module objects.  The routines are intended for
    handling out-of-line function call register save/restore so having
    them as EXPORT_SYMBOL() is counter productive (we do also need to
    link the same "library" code into the kernel).
    
    Without this patch a powerpc build would error out and fail
    to build modules with the added register save/restore module.
    
    There were two obvious solutions:
    1) To link the .o file before the modpost stage
    2) To ignore the symbols in modpost
    
    Option 1) was ruled out because we do not have any separate
    linking stage for single file modules.
    
    This patch implements option 2 - and do so only for powerpc.
    
    The symbols we ignore are all undefined symbols named:
    _restgpr_*, _savegpr_*, _rest32gpr_*, _save32gpr_*
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Cc: Kumar Gala <galak@kernel.crashing.org>
    Cc: Paul Mackerras <paulus@samba.org>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 508c589..b763aba 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -467,6 +467,26 @@ static void parse_elf_finish(struct elf_info *info)
 	release_file(info->hdr, info->size);
 }
 
+static int ignore_undef_symbol(struct elf_info *info, const char *symname)
+{
+	/* ignore __this_module, it will be resolved shortly */
+	if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
+		return 1;
+	/* ignore global offset table */
+	if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
+		return 1;
+	if (info->hdr->e_machine == EM_PPC)
+		/* Special register function linked on all modules during final link of .ko */
+		if (strncmp(symname, "_restgpr_", sizeof("_restgpr_") - 1) == 0 ||
+		    strncmp(symname, "_savegpr_", sizeof("_savegpr_") - 1) == 0 ||
+		    strncmp(symname, "_rest32gpr_", sizeof("_rest32gpr_") - 1) == 0 ||
+		    strncmp(symname, "_save32gpr_", sizeof("_save32gpr_") - 1) == 0) {
+			return 1;
+	}
+	/* Do not ignore this symbol */
+	return 0;
+}
+
 #define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
 #define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
 
@@ -493,11 +513,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
 		    ELF_ST_BIND(sym->st_info) != STB_WEAK)
 			break;
-		/* ignore global offset table */
-		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
-			break;
-		/* ignore __this_module, it will be resolved shortly */
-		if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
+		if (ignore_undef_symbol(info, symname))
 			break;
 /* cope with newer glibc (2.3.4 or higher) STT_ definition in elf.h */
 #if defined(STT_REGISTER) || defined(STT_SPARC_REGISTER)
