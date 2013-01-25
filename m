Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 456322C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 19:12:40 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 25 Jan 2013 13:40:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DBAF1394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 13:42:30 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0P8CTTk44498972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 13:42:29 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0P8CTNO013680
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 19:12:29 +1100
Message-ID: <1359101541.2666.59.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [PATCH powerpc] Use VPA subfunction macros instead of numbers for
 vpa calls
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 25 Jan 2013 16:12:21 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use macros in vpa calls. 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index f368668..f35787b 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -58,40 +58,39 @@ static inline long extended_cede_processor(unsigned long latency_hint)
 static inline long vpa_call(unsigned long flags, unsigned long cpu,
 		unsigned long vpa)
 {
-	/* flags are in bits 16-18 (counting from most significant bit) */
-	flags = flags << (63 - 18);
+	flags = flags << H_VPA_FUNC_SHIFT;
 
 	return plpar_hcall_norets(H_REGISTER_VPA, flags, cpu, vpa);
 }
 
 static inline long unregister_vpa(unsigned long cpu)
 {
-	return vpa_call(0x5, cpu, 0);
+	return vpa_call(H_VPA_DEREG_VPA, cpu, 0);
 }
 
 static inline long register_vpa(unsigned long cpu, unsigned long vpa)
 {
-	return vpa_call(0x1, cpu, vpa);
+	return vpa_call(H_VPA_REG_VPA, cpu, vpa);
 }
 
 static inline long unregister_slb_shadow(unsigned long cpu)
 {
-	return vpa_call(0x7, cpu, 0);
+	return vpa_call(H_VPA_DEREG_SLB, cpu, 0);
 }
 
 static inline long register_slb_shadow(unsigned long cpu, unsigned long vpa)
 {
-	return vpa_call(0x3, cpu, vpa);
+	return vpa_call(H_VPA_REG_SLB, cpu, vpa);
 }
 
 static inline long unregister_dtl(unsigned long cpu)
 {
-	return vpa_call(0x6, cpu, 0);
+	return vpa_call(H_VPA_DEREG_DTL, cpu, 0);
 }
 
 static inline long register_dtl(unsigned long cpu, unsigned long vpa)
 {
-	return vpa_call(0x2, cpu, vpa);
+	return vpa_call(H_VPA_REG_DTL, cpu, vpa);
 }
 
 static inline long plpar_page_set_loaned(unsigned long vpa)
-- 
1.7.9.5
