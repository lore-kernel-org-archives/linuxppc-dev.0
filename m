Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQt574JvvzDqPP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:47:07 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: pfsmorigo@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, herbert@gondor.apana.org.au, davem@davemloft.net,
 strosake@austin.ibm.com
Cc: linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] crypto: vmx: Fix ABI detection
Date: Fri, 10 Jun 2016 16:47:02 +1000
Message-Id: <1465541223-17537-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

When calling ppc-xlate.pl, we pass it either linux-ppc64 or
linux-ppc64le. The script however was expecting linux64le, a result
of its OpenSSL origins. This means we aren't obeying the ppc64le
ABIv2 rules.

Fix this by checking for linux-ppc64le.

Fixes: 5ca55738201c ("crypto: vmx - comply with ABIs that specify vrsave as reserved.")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/crypto/vmx/ppc-xlate.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/ppc-xlate.pl b/drivers/crypto/vmx/ppc-xlate.pl
index 9f4994c..b18e67d 100644
--- a/drivers/crypto/vmx/ppc-xlate.pl
+++ b/drivers/crypto/vmx/ppc-xlate.pl
@@ -141,7 +141,7 @@ my $vmr = sub {
 
 # Some ABIs specify vrsave, special-purpose register #256, as reserved
 # for system use.
-my $no_vrsave = ($flavour =~ /aix|linux64le/);
+my $no_vrsave = ($flavour =~ /linux-ppc64le/);
 my $mtspr = sub {
     my ($f,$idx,$ra) = @_;
     if ($idx == 256 && $no_vrsave) {
-- 
2.7.4
