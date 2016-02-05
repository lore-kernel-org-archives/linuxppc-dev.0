Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F24671A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 05:58:30 +1100 (AEDT)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 84126140321
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2016 05:58:30 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix dedotify for binutils >= 2.26
CC: linux-kernel@vger.kernel.org
Date: Fri, 05 Feb 2016 19:50:03 +0100
Message-ID: <87bn7vm1pg.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since binutils 2.26 BFD is doing suffix merging on STRTAB sections.  But
dedotify modifies the symbol names in place, which can also modify
unrelated symbols with a name that matches a suffix of a dotted name.  To
remove the leading dot of a symbol name we can just increment the pointer
into the STRTAB section instead.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/module_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index ac64ffd..08b7a40 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -340,7 +340,7 @@ static void dedotify(Elf64_Sym *syms, unsigned int numsyms, char *strtab)
 			if (name[0] == '.') {
 				if (strcmp(name+1, "TOC.") == 0)
 					syms[i].st_shndx = SHN_ABS;
-				memmove(name, name+1, strlen(name));
+				syms[i].st_name++;
 			}
 		}
 	}
-- 
2.7.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
