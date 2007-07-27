Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 87D5BDDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 20:24:19 +1000 (EST)
Date: Fri, 27 Jul 2007 14:23:49 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] mpc832x_rdb.c: prevent using uninitialized variable
Message-ID: <20070727102349.GA10419@localhost.localdomain>
References: <20070726140139.GA5709@localhost.localdomain>
	<20070726164833.GC28491@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070726164833.GC28491@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 11:48:33AM -0500, Scott Wood wrote:
> On Thu, Jul 26, 2007 at 06:01:39PM +0400, Anton Vorontsov wrote:
> > If CONFIG_PCI undefined, np will be used uninitialized, thereby
> > find_node_by_name(np, "par_io") will fail.
> 
> This is the wrong fix -- you should be passing NULL to the par_io call
> rather than np.  Otherwise, if the par_io is earlier in the tree than the
> pci, you won't find it.

Oops. Right you are, thanks!

I hope this is proper fix.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC] mpc832x_rdb.c: prevent using uninitialized variable

If CONFIG_PCI undefined, np will be used uninitialized, thereby
find_node_by_name(np, "par_io") will fail.

of_find_node_by_name(np, "par_io") isn't used inside loop,
thus we can safely pass NULL instead of np.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index b2b28a4..93ba957 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -56,7 +56,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
 
-	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
+	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
 
-- 
1.5.0.6
