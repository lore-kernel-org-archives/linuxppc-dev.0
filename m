Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A40DC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 10:26:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD2C20817
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 10:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD2C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4340Lz2tMDzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 21:26:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4340J25HqhzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 21:24:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARAJsha091331
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 05:24:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p141r88yy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 05:24:00 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 27 Nov 2018 10:23:57 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Nov 2018 10:23:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wARANtjK58785914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Nov 2018 10:23:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F00E0A404D;
 Tue, 27 Nov 2018 10:23:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97C9DA4055;
 Tue, 27 Nov 2018 10:23:53 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.171.204])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 27 Nov 2018 10:23:53 +0000 (GMT)
Date: Tue, 27 Nov 2018 02:23:50 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87efbqqze4.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18112710-0016-0000-0000-0000022D4FF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112710-0017-0000-0000-00003285A841
Message-Id: <20181127102350.GA5795@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-27_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270092
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 01:00:19PM +0100, Florian Weimer wrote:
> * Ram Pai:
> 
> > On Thu, Nov 08, 2018 at 09:23:35PM +0100, Florian Weimer wrote:
> >> * Ram Pai:
> >> 
> >> > Florian,
> >> >
> >> > 	I can. But I am struggling to understand the requirement. Why is
> >> > 	this needed?  Are we proposing a enhancement to the sys_pkey_alloc(),
> >> > 	to be able to allocate keys that are initialied to disable-read
> >> > 	only?
> >> 
> >> Yes, I think that would be a natural consequence.
> >> 
> >> However, my immediate need comes from the fact that the AMR register can
> >> contain a flag combination that is not possible to represent with the
> >> existing PKEY_DISABLE_WRITE and PKEY_DISABLE_ACCESS flags.  User code
> >> could write to AMR directly, so I cannot rule out that certain flag
> >> combinations exist there.
> >> 
> >> So I came up with this:
> >> 
> >> int
> >> pkey_get (int key)
> >> {
> >>   if (key < 0 || key > PKEY_MAX)
> >>     {
> >>       __set_errno (EINVAL);
> >>       return -1;
> >>     }
> >>   unsigned int index = pkey_index (key);
> >>   unsigned long int amr = pkey_read ();
> >>   unsigned int bits = (amr >> index) & 3;
> >> 
> >>   /* Translate from AMR values.  PKEY_AMR_READ standing alone is not
> >>      currently representable.  */
> >>   if (bits & PKEY_AMR_READ)
> >
> > this should be
> >    if (bits & (PKEY_AMR_READ|PKEY_AMR_WRITE))
> 
> This would return zero for PKEY_AMR_READ alone.
> 
> >>     return PKEY_DISABLE_ACCESS;
> >
> >
> >>   else if (bits == PKEY_AMR_WRITE)
> >>     return PKEY_DISABLE_WRITE;
> >>   return 0;
> >> }
> 
> It's hard to tell whether PKEY_DISABLE_ACCESS is better in this case.
> Which is why I want PKEY_DISABLE_READ.
> 
> >> And this is not ideal.  I would prefer something like this instead:
> >> 
> >>   switch (bits)
> >>     {
> >>       case PKEY_AMR_READ | PKEY_AMR_WRITE:
> >>         return PKEY_DISABLE_ACCESS;
> >>       case PKEY_AMR_READ:
> >>         return PKEY_DISABLE_READ;
> >>       case PKEY_AMR_WRITE:
> >>         return PKEY_DISABLE_WRITE;
> >>       case 0:
> >>         return 0;
> >>     }
> >
> > yes.
> >  and on x86 it will be something like:
> >    switch (bits)
> >      {
> >        case PKEY_PKRU_ACCESS :
> >          return PKEY_DISABLE_ACCESS;
> >        case PKEY_AMR_WRITE:
> >          return PKEY_DISABLE_WRITE;
> >        case 0:
> >          return 0;
> >      }
> 
> x86 returns the PKRU bits directly, including the nonsensical case
> (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE).
> 
> > But for this to work, why do you need to enhance the sys_pkey_alloc()
> > interface?  Not that I am against it. Trying to understand if the
> > enhancement is really needed.
> 
> sys_pkey_alloc performs an implicit pkey_set for the newly allocated key
> (that is, it updates the PKRU/AMR register).  It makes sense to match
> the behavior of the userspace implementation.

Here is a untested patch. Does this meet your needs?
It defines the new flags. Each architecture will than define the set of flags
it supports through PKEY_ACCESS_MASK.


Signed-off-by: Ram Pai <linuxram@us.ibm.com>

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 92a9962..724ef43 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -21,11 +21,6 @@
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 			    VM_PKEY_BIT3 | VM_PKEY_BIT4)
 
-/* Override any generic PKEY permission defines */
-#define PKEY_DISABLE_EXECUTE   0x4
-#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS | \
-				PKEY_DISABLE_WRITE  | \
-				PKEY_DISABLE_EXECUTE)
 
 static inline u64 pkey_to_vmflag_bits(u16 pkey)
 {
diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index 65065ce..76237b3 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -31,9 +31,9 @@
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
 
 /* Override any generic PKEY permission defines */
-#define PKEY_DISABLE_EXECUTE   0x4
 #undef PKEY_ACCESS_MASK
 #define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
 				PKEY_DISABLE_WRITE  |\
+				PKEY_DISABLE_READ  |\
 				PKEY_DISABLE_EXECUTE)
 #endif /* _UAPI_ASM_POWERPC_MMAN_H */
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 4860acd..c8b2540 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -62,14 +62,6 @@ int pkey_initialize(void)
 	int os_reserved, i;
 
 	/*
-	 * We define PKEY_DISABLE_EXECUTE in addition to the arch-neutral
-	 * generic defines for PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE.
-	 * Ensure that the bits a distinct.
-	 */
-	BUILD_BUG_ON(PKEY_DISABLE_EXECUTE &
-		     (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
-
-	/*
 	 * pkey_to_vmflag_bits() assumes that the pkey bits are contiguous
 	 * in the vmaflag. Make sure that is really the case.
 	 */
@@ -259,6 +251,8 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		new_amr_bits |= AMR_RD_BIT | AMR_WR_BIT;
 	else if (init_val & PKEY_DISABLE_WRITE)
 		new_amr_bits |= AMR_WR_BIT;
+	else if (init_val & PKEY_DISABLE_READ)
+		new_amr_bits |= AMR_RD_BIT;
 
 	init_amr(pkey, new_amr_bits);
 	return 0;
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index d4a8d04..e9b121b 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -24,6 +24,11 @@
 		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
 		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+
+/* Override any generic PKEY permission defines */
+#undef PKEY_ACCESS_MASK
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
+				PKEY_DISABLE_WRITE)
 #endif
 
 #include <asm-generic/mman.h>
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index e7ee328..61168e4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -71,7 +71,8 @@
 
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
-#define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-				 PKEY_DISABLE_WRITE)
-
+#define PKEY_DISABLE_EXECUTE	0x4
+#define PKEY_DISABLE_READ	0x8
+#define PKEY_ACCESS_MASK	0x0	/* arch can override and define its own
+					   mask bits */
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */

