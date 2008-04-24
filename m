Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fa04652a54c3f4645eb6450e5b9bdd3b5eab5c08.1209013992.git.michael@ellerman.id.au>
In-Reply-To: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
References: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/5] Mark udbg console as CON_ANYTIME,
	ie. callable early in boot
Date: Thu, 24 Apr 2008 15:13:14 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The udbg console should be safe to call basically at any time after boot.
It does not need any per-cpu resources or for the cpu to be online, as
long as there is a udbg_putc routine hooked up it should work. So mark it
as CON_ANYTIME.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/udbg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 9ac5f3a..7d6c9bb 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -154,7 +154,7 @@ static void udbg_console_write(struct console *con, const char *s,
 static struct console udbg_console = {
 	.name	= "udbg",
 	.write	= udbg_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT,
+	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
 	.index	= 0,
 };
 
-- 
1.5.5
