Return-Path: <weiyj.lk@gmail.com>
Received: from mail-bk0-x231.google.com (mail-bk0-x231.google.com
 [IPv6:2a00:1450:4008:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3A1F2C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 15:17:35 +1000 (EST)
Received: by mail-bk0-f49.google.com with SMTP id e19so84661bku.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 May 2013 22:17:31 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 May 2013 13:17:31 +0800
Message-ID: <CAPgLHd9S4JbRpB9ipzDyysWqAkismVMu2W=Z2mhuVHzJXv4NrQ@mail.gmail.com>
Subject: [PATCH -next] kvm/ppc/mpic: fix missing unlock in set_base_addr()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: mtosatti@redhat.com, gleb@redhat.com, agraf@suse.de,
 benh@kernel.crashing.org, paulus@samba.org, scottwood@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock before return from function set_base_addr()
when disables the mapping.

Introduced by commit 5df554ad5b7522ea62b0ff9d5be35183494efc21
(kvm/ppc/mpic: in-kernel MPIC emulation)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/kvm/mpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index f3148f8..0047a70 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1475,8 +1475,8 @@ static int set_base_addr(struct openpic *opp, struct kvm_device_attr *attr)
 
 	map_mmio(opp);
 
-	mutex_unlock(&opp->kvm->slots_lock);
 out:
+	mutex_unlock(&opp->kvm->slots_lock);
 	return 0;
 }
 
