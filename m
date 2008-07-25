Return-Path: <ntl@pobox.com>
Date: Fri, 25 Jul 2008 17:50:30 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: can't boot mpc5200, powerpc: Enable AT_BASE_PLATFORM aux vector
Message-ID: <20080725225030.GJ9594@localdomain>
References: <9e4733910807251451s623b87cetcf7ed5ff6a12f012@mail.gmail.com>
	<20080725220038.GI9594@localdomain>
	<1217024108.11188.117.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1217024108.11188.117.camel@pasglop>
Cc: ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 9115d13453dee22473a1e8cacc90a8d64a9c4bc9 ("powerpc: Enable
AT_BASE_PLATFORM aux vector") broke boot on 32-bit powerpc systems; we
have to use PTRRELOC to initialize powerpc_base_platform this early in
boot.

Bug reported by Jon Smirl.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
Benjamin Herrenschmidt wrote:
> if (RELOC(powerpc_base_platform))
> 	RELOC(powerpc_base_platform) = t->platform;
> 
> try that.

Maybe this?  (RELOC isn't defined in any header AFAICT).

 arch/powerpc/kernel/cputable.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 25a052c..25c273c 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1660,8 +1660,8 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 			 * Set the base platform string once; assumes
 			 * we're called with real pvr first.
 			 */
-			if (powerpc_base_platform == NULL)
-				powerpc_base_platform = t->platform;
+			if (*PTRRELOC(&powerpc_base_platform) == NULL)
+				*PTRRELOC(&powerpc_base_platform) = t->platform;
 
 #if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
 			/* ppc64 and booke expect identify_cpu to also call
-- 
1.5.6.2
