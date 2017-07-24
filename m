Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0086.outbound.protection.outlook.com [104.47.32.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGWBB4zzkzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:50 +1000 (AEST)
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [RFC Part1 PATCH v3 13/17] x86/io: Unroll string I/O when SEV is
 active
Date: Mon, 24 Jul 2017 14:07:53 -0500
Message-Id: <20170724190757.11278-14-brijesh.singh@amd.com>
In-Reply-To: <20170724190757.11278-1-brijesh.singh@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

Secure Encrypted Virtualization (SEV) does not support string I/O, so
unroll the string I/O operation into a loop operating on one element at
a time.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/io.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e080a39..2f3c002 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -327,14 +327,32 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	asm volatile("rep; outs" #bwl					\
-		     : "+S"(addr), "+c"(count) : "d"(port));		\
+	if (sev_active()) {						\
+		unsigned type *value = (unsigned type *)addr;		\
+		while (count) {						\
+			out##bwl(*value, port);				\
+			value++;					\
+			count--;					\
+		}							\
+	} else {							\
+		asm volatile("rep; outs" #bwl				\
+			     : "+S"(addr), "+c"(count) : "d"(port));	\
+	}								\
 }									\
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	asm volatile("rep; ins" #bwl					\
-		     : "+D"(addr), "+c"(count) : "d"(port));		\
+	if (sev_active()) {						\
+		unsigned type *value = (unsigned type *)addr;		\
+		while (count) {						\
+			*value = in##bwl(port);				\
+			value++;					\
+			count--;					\
+		}							\
+	} else {							\
+		asm volatile("rep; ins" #bwl				\
+			     : "+D"(addr), "+c"(count) : "d"(port));	\
+	}								\
 }
 
 BUILDIO(b, b, char)
-- 
2.9.4
