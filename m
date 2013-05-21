Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E01892C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 05:35:52 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 22 May 2013 05:25:28 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 786E22BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 05:35:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4LJLUP221430438
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 05:21:30 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4LJZklr025056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 05:35:46 +1000
Message-ID: <519BCBE0.5020904@linux.vnet.ibm.com>
Date: Wed, 22 May 2013 01:02:48 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Subject: Re: Build failure with 3.9.3 (Regression 3.9.2->3.9.3)
References: <20130520151411.GD27420@os.inf.tu-dresden.de>
In-Reply-To: <20130520151411.GD27420@os.inf.tu-dresden.de>
Content-Type: text/plain; charset=UTF-8
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2013 08:44 PM, Adam Lackorzynski wrote:
> Hi,
> 
> 3.9.3 introduced the following build failure:
> 
>   CC      arch/powerpc/kernel/rtas.o
> arch/powerpc/kernel/rtas.c: In function ‘rtas_cpu_state_change_mask’:
> arch/powerpc/kernel/rtas.c:843:4: error: implicit declaration of function ‘cpu_down’ [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/rtas.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
> 
> My kernel config has CONFIG_HOTPLUG_CPU off, that's why cpu_down is not
> defined. Shall CONFIG_HOTPLUG_CPU just be enabled or should the code in
> rtas.c be adapted?
> 

I think we should just enable CONFIG_HOTPLUG_CPU. I don't see any other
solution to this problem. The changelog of the below (untested) patch
explains the reasoning. (BTW, I'm not sure if this is the best way to
alter the Kconfig in order to enable both HOTPLUG and HOTPLUG_CPU. If
there is a better way to do it, let's go for it).

Also, this patch applies on current mainline. We need a separate backport
for 3.9 (because current mainline has a new line - "select HAVE_CONTEXT_TRACKING"
which is not present in 3.9, and this interferes with the patch).

Regards,
Srivatsa S. Bhat

-------------------------------------------------------------------------


From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Enable CONFIG_HOTPLUG_CPU on PPC_PSERIES SMP builds

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
---

 arch/powerpc/platforms/pseries/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 023b288..4459eff 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -19,6 +19,8 @@ config PPC_PSERIES
 	select ZLIB_DEFLATE
 	select PPC_DOORBELL
 	select HAVE_CONTEXT_TRACKING
+	select HOTPLUG if SMP
+	select HOTPLUG_CPU if SMP
 	default y
 
 config PPC_SPLPAR
