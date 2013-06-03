Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE38C2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 16:49:50 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 3 Jun 2013 12:12:01 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7BE0BE0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 12:22:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r536nZu03277266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jun 2013 12:19:36 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r536ndm8017312
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jun 2013 16:49:39 +1000
Message-ID: <51AC3BCB.5000002@linux.vnet.ibm.com>
Date: Mon, 03 Jun 2013 12:16:35 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: gregkh@linuxfoundation.org
Subject: Re: FAILED: patch "[PATCH] powerpc/pseries: Always enable
 CONFIG_HOTPLUG_CPU on PSERIES" failed to apply to 3.9-stable tree
References: <13701231324019@kroah.org>
In-Reply-To: <13701231324019@kroah.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 adam@os.inf.tu-dresden.de, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2013 03:15 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 3.9-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 

Please find the 3.9 backport below. Thank you!

Regards,
Srivatsa S. Bhat


--------------------------------------------------------------------------

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: Always enable CONFIG_HOTPLUG_CPU on PSERIES SMP

commit f274ef8747d3be649bba8708696fb31cb00fa75a upstream.

Adam Lackorzynski reported the following build failure on
!CONFIG_HOTPLUG_CPU configuration:

  CC      arch/powerpc/kernel/rtas.o
arch/powerpc/kernel/rtas.c: In function ‘rtas_cpu_state_change_mask’:
arch/powerpc/kernel/rtas.c:843:4: error: implicit declaration of function ‘cpu_down’ [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[1]: *** [arch/powerpc/kernel/rtas.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

The build fails because cpu_down() is defined only under CONFIG_HOTPLUG_CPU.

Looking further, the mobility code in pseries is one of the call-sites which
uses rtas_ibm_suspend_me(), which in turn calls rtas_cpu_state_change_mask().
And the mobility code is unconditionally compiled-in (it does not fall under
any Kconfig option). And commit 120496ac (powerpc: Bring all threads online
prior to migration/hibernation) which introduced this build regression is
critical for the proper functioning of the migration code. So it appears
that the only solution to this problem is to enable CONFIG_HOTPLUG_CPU if
SMP is enabled on PPC_PSERIES platforms. So make that change in the Kconfig.

Reported-by: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: stable@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/pseries/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 9a0941b..b9fd0d3 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -18,6 +18,8 @@ config PPC_PSERIES
 	select PPC_PCI_CHOICE if EXPERT
 	select ZLIB_DEFLATE
 	select PPC_DOORBELL
+	select HOTPLUG if SMP
+	select HOTPLUG_CPU if SMP
 	default y
 
 config PPC_SPLPAR
