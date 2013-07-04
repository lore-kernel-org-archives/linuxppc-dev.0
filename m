Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBA592C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 04:58:10 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Thu, 4 Jul 2013 15:58:05 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 2AAD13520027
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 14:58:03 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r64IumcQ25428022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 15:56:49 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r64Iw23q026821
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 15:58:02 -0300
Received: from [9.8.8.205] ([9.8.8.205])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r64Iw2pn026818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 15:58:02 -0300
Message-ID: <51D5C5B9.4070005@linux.vnet.ibm.com>
Date: Thu, 04 Jul 2013 15:58:01 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 8/8] powerpc/perf: Add power8 EBB support
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
 <51CABB56.9010105@linux.vnet.ibm.com> <1372333965.29229.26.camel@concordia>
 <51CD0DC7.7020702@linux.vnet.ibm.com>
In-Reply-To: <51CD0DC7.7020702@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

I believe you forgot to add the cpu_user_features2 bit to announce the EBB support
for P8, patch following:

Signed-off-by: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cputable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2a45d0f..5f0c80a 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -105,6 +105,7 @@ extern void __restore_cpu_e6500(void);
                                 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER2_POWER8    (PPC_FEATURE2_ARCH_2_07 | \
                                 PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \
+                                PPC_FEATURE2_EBB | \
                                 PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR)
 #define COMMON_USER_PA6T       (COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
                                 PPC_FEATURE_TRUE_LE | \


On 28-06-2013 01:15, Anshuman Khandual wrote:
> On 06/27/2013 05:22 PM, Michael Ellerman wrote:
>> On Wed, 2013-06-26 at 15:28 +0530, Anshuman Khandual wrote:
>>>> @@ -117,6 +117,7 @@
>>>>  	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
>>>>  	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
>>>>  	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
>>>> +	 (1ull		       << EVENT_CONFIG_EBB_SHIFT)	|	\
>>> We should define this macro like EVENT_MARKED_MASK
>>>
>>> #define EVENT_EBB_MASK       0x1
>>>
>>> Numeric value of "1ull" stands out odd in the scheme.
>> Yeah I guess.
>>
>> Would you like it in blue? :)
>>
> :) No, I meant probably a macro definition would be cool.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
