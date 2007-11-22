Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id A880BDE000
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:25 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:23 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/10] powerpc: Fix bogus crash kernel messages
Message-ID: <20071122154623.GA26499@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit edd8ce67, Use extended crashkernel command line on ppc64,
resulted in reserve_crashkernel() attempting to reserve a 1 byte
crashkernel area when no no crashkernel reservation is requested.
This results in the following bogus messages:
    Crash kernel location must be 0x2000000
    Reserving 0MB of memory at 32MB for crashkernel

The problem is that when crashk_res.start and crashk_res.end are
both 0, the crash_size is computed to be 1 byte.

Revert back to using the value of crashk_res.start to determine
if crashkernel memory is being reserved, rather than the computed
crash_size.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/kernel/machine_kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 691dba7..38c1c1a 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -84,7 +84,7 @@ void __init reserve_crashkernel(void)
 		crash_size = crashk_res.end - crashk_res.start + 1;
 	}
 
-	if (crash_size == 0)
+	if (crashk_res.start == 0)
 		return;
 
 	/* We might have got these values via the command line or the
-- 
1.5.3.4
