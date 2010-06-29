Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 12:43:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc: turn CONFIG_OF into a select
Message-Id: <20100629124334.8f3678e5.sfr@canb.auug.org.au>
In-Reply-To: <20100629123843.5f94d477.sfr@canb.auug.org.au>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
	David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

so that we can make CONFIG_OF global and remove it from
the architecture Kconfig files later.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 328774b..3697231 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -120,6 +120,8 @@ config ARCH_NO_VIRT_TO_BUS
 config PPC
 	bool
 	default y
+	select OF
+	select OF_FLATTREE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
@@ -173,8 +175,7 @@ config PPC_OF
 	def_bool y
 
 config OF
-	def_bool y
-	select OF_FLATTREE
+	bool
 
 config PPC_UDBG_16550
 	bool
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
