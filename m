Return-Path: <leosilva@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E227D1A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 02:50:25 +1000 (AEST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leosilva@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 13:50:20 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 51FD91DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 12:49:15 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6DGobp54554844
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 13:50:38 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6DGoETr011566
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 12:50:15 -0400
Date: Mon, 13 Jul 2015 13:50:14 -0300
From: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>,
 pfsmorigo@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/2] Uncomment VSX enable routine for instructions access
Message-ID: <20150713165011.GA3356@bluepex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

enable_kernel_vsx() was commented since anything was using
it. It changes with vmx_crypto driver that call VSX instructions
and need kernel_vsx enabled in order to do it properly. Without
a way to enable VSX instruction vmx_crypto fails into an exception.

These patches uncomment enable_kernel_vsx() rountine and put it
available for use. Also adds it in vmx_crypto in order to
enable kernel_vsx before use VSX instructions.

Leonidas S. Barbosa (2):
  Uncomment and make enable_kernel_vsx() routine available
  Adding enable_kernel_vsx() to access VSX instructions

 arch/powerpc/include/asm/switch_to.h | 1 +
 arch/powerpc/kernel/process.c        | 3 ---
 drivers/crypto/vmx/aes.c             | 3 +++
 drivers/crypto/vmx/aes_cbc.c         | 3 +++
 drivers/crypto/vmx/aes_ctr.c         | 3 +++
 drivers/crypto/vmx/ghash.c           | 4 ++++
 6 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.1.0
