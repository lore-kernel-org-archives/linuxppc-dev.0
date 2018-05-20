Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pZ742Zp4zDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 17:59:12 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id d14-v6so1444945pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 00:59:12 -0700 (PDT)
Date: Sun, 20 May 2018 17:58:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Segher Boessenkool
 <segher@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 4/4] powerpc/kbuild: move -mprofile-kernel check to
 Kconfig
Message-ID: <20180520175858.7871aa54@roar.ozlabs.ibm.com>
In-Reply-To: <20180516141458.18996-5-npiggin@gmail.com>
References: <20180516141458.18996-1-npiggin@gmail.com>
 <20180516141458.18996-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 May 2018 00:14:58 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> This eliminates the workaround that requires disabling
> -mprofile-kernel by default in Kconfig.
> 
> [ Note: this depends on https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig-shell-v3 ]
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Here is an incremental patch that brings this up to v4.

https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig-shell-v4

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c7cc482cb660..60b83398b498 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -462,7 +462,7 @@ config LD_HEAD_STUB_CATCH
 
 config MPROFILE_KERNEL
 	depends on PPC64 && CPU_LITTLE_ENDIAN
-	def_bool $(success $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)
+	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)
 
 config IOMMU_HELPER
 	def_bool PPC64
-- 
2.17.0
