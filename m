Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E086D2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 18:20:17 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 3 Jul 2013 18:10:25 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 20D212BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 18:20:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6385CI657933948
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 18:05:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r638KAms004333
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 18:20:10 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] powerpc/mm: Fix fallthrough bug in  hpte_decode
Date: Wed,  3 Jul 2013 13:50:03 +0530
Message-Id: <1372839603-8308-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1372839603-8308-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1372839603-8308-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We should not fallthrough different case statements in hpte_decode. Add
break statement to break out of the switch. The regression is introduced by
dcda287a9b26309ae43a091d0ecde16f8f61b4c0 "powerpc/mm: Simplify hpte_decode"

Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 0de15fc..e1f9b82 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -560,6 +560,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			seg_off |= vpi << shift;
 		}
 		*vpn = vsid << (SID_SHIFT - VPN_SHIFT) | seg_off >> VPN_SHIFT;
+		break;
 	case MMU_SEGSIZE_1T:
 		/* We only have 40 - 23 bits of seg_off in avpn */
 		seg_off = (avpn & 0x1ffff) << 23;
@@ -569,6 +570,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			seg_off |= vpi << shift;
 		}
 		*vpn = vsid << (SID_SHIFT_1T - VPN_SHIFT) | seg_off >> VPN_SHIFT;
+		break;
 	default:
 		*vpn = size = 0;
 	}
-- 
1.8.1.2
