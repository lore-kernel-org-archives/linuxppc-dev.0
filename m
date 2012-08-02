Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32D442C009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 17:10:14 +1000 (EST)
Date: Thu, 2 Aug 2012 09:10:03 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2] powerpc: fix personality handling in
 ppc64_personality()
In-Reply-To: <m27gtitfv4.fsf@igel.home>
Message-ID: <alpine.LNX.2.00.1208020907490.14910@pobox.suse.cz>
References: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz>
 <m27gtitfv4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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
we are setting only the bits that should be set, instead of
overwriting the whole value.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

changed since v1: fix the bit ops to reflect the fact that PER_LINUX is 
actually 0

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
+		personality |= PER_LINUX32;
 	ret = sys_personality(personality);
-	if (ret == PER_LINUX32)
-		ret = PER_LINUX;
+	if (personality(ret) == PER_LINUX32)
+		ret &= ~PER_LINUX32;
 	return ret;
 }
 #endif
-- 
1.7.3.1

-- 
Jiri Kosina
SUSE Labs
