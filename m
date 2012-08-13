Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 338752C0093
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2012 23:18:40 +1000 (EST)
Date: Mon, 13 Aug 2012 15:18:28 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] [RESEND] powerpc: fix personality handling in
 ppc64_personality()
Message-ID: <alpine.LNX.2.00.1208131515550.29827@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Directly comparing current->personality against PER_LINUX32 doesn't work 
in cases when any of the personality flags stored in the top three bytes 
are used.

Directly forcefully setting personality to PER_LINUX32 or PER_LINUX 
discards any flags stored in the top three bytes

Use personality() macro to compare only PER_MASK bytes and make sure that 
we are setting only the bits that should be set, instead of overwriting 
the whole value.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Resned of patch sent on Thu, 2 Aug 2012 09:10:03 +0200 (CEST)

 arch/powerpc/kernel/syscalls.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index f2496f2..dc1558e 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -107,11 +107,11 @@ long ppc64_personality(unsigned long personality)
 	long ret;
 
 	if (personality(current->personality) == PER_LINUX32
-	    && personality == PER_LINUX)
-		personality = PER_LINUX32;
+	    && personality(personality) == PER_LINUX)
+		personality = (personality & ~PER_MASK) | PER_LINUX32;
 	ret = sys_personality(personality);
-	if (ret == PER_LINUX32)
-		ret = PER_LINUX;
+	if (personality(ret) == PER_LINUX32)
+		ret = (ret & ~PER_MASK) | PER_LINUX;
 	return ret;
 }
 #endif

-- 
Jiri Kosina
SUSE Labs
