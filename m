Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 28/33] powerpc: modules: comment about de-dotifying symbols
 when using the ELFv2 ABI.
Date: Tue, 25 Mar 2014 22:44:34 +1100
Message-Id: <1395747879-5948-29-git-send-email-anton@samba.org>
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

From: Rusty Russell <rusty@rustcorp.com.au>

ELFv2 doesn't use function descriptors, so we don't expect symbols to
start with ".".  But because depmod and modpost strip ".", and we have
the special symbol ".TOC.", we still need to do it.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/module_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 34ba326..05b27a5 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -172,6 +172,7 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 	return relocs * sizeof(struct ppc64_stub_entry);
 }
 
+/* Still needed for ELFv2, for .TOC. */
 static void dedotify_versions(struct modversion_info *vers,
 			      unsigned long size)
 {
@@ -182,7 +183,7 @@ static void dedotify_versions(struct modversion_info *vers,
 			memmove(vers->name, vers->name+1, strlen(vers->name));
 }
 
-/* Undefined symbols which refer to .funcname, hack to funcname */
+/* Undefined symbols which refer to .funcname, hack to funcname (or .TOC.) */
 static void dedotify(Elf64_Sym *syms, unsigned int numsyms, char *strtab)
 {
 	unsigned int i;
-- 
1.8.3.2
