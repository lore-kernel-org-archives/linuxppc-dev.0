Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F362DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:25:53 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] sysctl:  Kill binary sysctl KERN_PPC_L2CR
References: <20080123140352.e19900d7.akpm@linux-foundation.org>
Date: Thu, 24 Jan 2008 02:18:34 -0700
In-Reply-To: <20080123140352.e19900d7.akpm@linux-foundation.org> (Andrew
	Morton's message of "Wed, 23 Jan 2008 14:03:52 -0800")
Message-ID: <m1sl0ninth.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> From: Stefan Roese <sr@denx.de>
> Subject: ppc: 4xx: sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
>
> I'm seeing this error message when booting an recent arch/ppc kernel on
> 4xx platforms (tested on Ocotea and other 4xx platforms). Booting NFS
> rootfs still works fine, but this message kind of makes me "nervous".
> This is not seen on 4xx arch/powerpc platforms. Here the bootlog:

Because the data field was never filled and a binary sysctl handler
was never written this sysctl has never been usable through the
sys_sysctl interface.  So just remove the binary sysctl number.
Making the kernel sanity checks happy.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ppc/kernel/ppc_htab.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
index aa07b63..9ed36dd 100644
--- a/arch/ppc/kernel/ppc_htab.c
+++ b/arch/ppc/kernel/ppc_htab.c
@@ -436,7 +436,6 @@ int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
  */
 static ctl_table htab_ctl_table[]={
 	{
-		.ctl_name	= KERN_PPC_L2CR,
 		.procname	= "l2cr",
 		.mode		= 0644,
 		.proc_handler	= &proc_dol2crvec,
-- 
1.5.3.rc6.17.g1911
