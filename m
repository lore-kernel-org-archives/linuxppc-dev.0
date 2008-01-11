Return-Path: <jbeulich@novell.com>
Received: from public.id2-vpn.continvity.gns.novell.com
	(public.id2-vpn.continvity.gns.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "SERVICES2" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 56E7EDDFB6
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 20:33:44 +1100 (EST)
Message-Id: <4787415E.76E4.0078.0@novell.com>
Date: Fri, 11 Jan 2008 09:13:50 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <paulus@samba.org>
Subject: [PATCH, ppc64] improve dedotify()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This completely untested patch is intended to be a suggestion only:
Code inspection for an entirely different purpose made me stumble
across this, and I think that modifying the string table of an ELF
object is a bad idea, since there's nothing disallowing a linker to
merge strings inside the table, which would result in this code
possibly, but unintentionally screwing up other symbol names.
Besides that, the presented alternative is both smaller and faster.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 arch/powerpc/kernel/module_64.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.24-rc7/arch/powerpc/kernel/module_64.c	2007-02-04 =
19:44:54.000000000 +0100
+++ 2.6.24-rc7-ppc64-dedotify/arch/powerpc/kernel/module_64.c	2008-01-08 =
13:32:33.000000000 +0100
@@ -154,16 +154,14 @@ static void dedotify_versions(struct mod
 }
=20
 /* Undefined symbols which refer to .funcname, hack to funcname */
-static void dedotify(Elf64_Sym *syms, unsigned int numsyms, char *strtab)
+static void dedotify(Elf64_Sym *syms, unsigned int numsyms, const char =
*strtab)
 {
 	unsigned int i;
=20
 	for (i =3D 1; i < numsyms; i++) {
-		if (syms[i].st_shndx =3D=3D SHN_UNDEF) {
-			char *name =3D strtab + syms[i].st_name;
-			if (name[0] =3D=3D '.')
-				memmove(name, name+1, strlen(name));
-		}
+		if (syms[i].st_shndx =3D=3D SHN_UNDEF
+		    && strtab[syms[i].st_name] =3D=3D '.')
+			syms[i].st_name++;
 	}
 }
=20
