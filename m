Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB4C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 00:37:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12842146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 00:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12842146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wbq854xvzDqCB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 11:37:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wbnJ6zYHzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 11:35:32 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x180XR9n137401
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2019 19:35:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qgy8kg73k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:35:29 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 8 Feb 2019 00:35:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 8 Feb 2019 00:35:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x180ZOPo6029598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 00:35:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18883A4053;
 Fri,  8 Feb 2019 00:35:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EFBAA404D;
 Fri,  8 Feb 2019 00:35:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  8 Feb 2019 00:35:23 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8CCBAA0190;
 Fri,  8 Feb 2019 11:35:21 +1100 (AEDT)
Subject: Re: [PATCH 1/2] powerpc/64s: Work around spurious warning on old gccs
 with -fsanitize-coverage
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
 <20190207063736.GS14180@gate.crashing.org>
 <630e392b-e9a7-6b1e-e3d8-c5382f94e5d7@au1.ibm.com>
 <20190207074947.GT14180@gate.crashing.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 8 Feb 2019 11:34:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207074947.GT14180@gate.crashing.org>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19020800-0012-0000-0000-000002F3194C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020800-0013-0000-0000-0000212A80A8
Message-Id: <e1e1fc85-6ab6-ba91-c91f-21c3f51ee6ee@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-07_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080002
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
Cc: syzkaller@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(+ Nick)

On 7/2/19 6:49 pm, Segher Boessenkool wrote:
> On Thu, Feb 07, 2019 at 05:59:48PM +1100, Andrew Donnellan wrote:
>> On 7/2/19 5:37 pm, Segher Boessenkool wrote:
>>> On Thu, Feb 07, 2019 at 04:33:23PM +1100, Andrew Donnellan wrote:
>>>> Some older gccs (<GCC 7), when invoked with -fsanitize-coverage=trace-pc,
>>>> cause a spurious uninitialised variable warning in dt_cpu_ftrs.c:
>>>>
>>>>    arch/powerpc/kernel/dt_cpu_ftrs.c: In function
>>>>    ‘cpufeatures_process_feature’:
>>>>    arch/powerpc/kernel/dt_cpu_ftrs.c:686:7: warning: ‘m’ may be used
>>>>    uninitialized in this function [-Wmaybe-uninitialized]
>>>>      if (m->cpu_ftr_bit_mask)
>>>
>>> It seems to me the warning is correct?  If enable_unknown is false and no
>>> cpu_feature is found, it will in
>>>
>>> 	if (m->cpu_ftr_bit_mask)
>>> 		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
>>>
>>> enable random features (whatever was last in the table), or indeed access
>>> via NULL if the table is length 0?  So maybe this should be
>>>
>>> 	if (known && m->cpu_ftr_bit_mask)
>>> 		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
>>>
>>> instead?  (The code would be much clearer if all the known vs. !known
>>> codepath was fully separated here).
>>
>> The table is never length 0, it's a statically defined array.
> 
> Sure, and presumably that is why newer GCC doesn't warn.  But what about
> the other point?  Is this code ever correct?  Enabling random features
> (in cur_cpu_spec->cpu_features) when the name isn't found seems wrong.

Now that I'm replying without being 2 minutes before a meeting :)

The warning is still spurious, but the logic looks very suspicious.

I think your solution looks correct, though the whole function could be 
cleaned up a bit.

I also notice that if enable_unknown == false, then I think an unknown 
feature will still print "enabling" and return true, which seems wrong.

How does something like the following look, which I could send instead 
and will probably solve the spurious warnings issues anyway?

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c 
b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 2192b2114513..0f13048dc0dd 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -658,40 +658,31 @@ static void __init cpufeatures_setup_start(u32 isa)

  static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
  {
-       const struct dt_cpu_feature_match *m = NULL;
-       bool known = false;
+       const struct dt_cpu_feature_match *m;
         int i;

         for (i = 0; i < ARRAY_SIZE(dt_cpu_feature_match_table); i++) {
                 m = &dt_cpu_feature_match_table[i];
                 if (!strcmp(f->name, m->name)) {
-                       known = true;
-                       if (m->enable(f))
-                               break;
-
-                       pr_info("not enabling: %s (disabled or 
unsupported by kernel)\n",
-                               f->name);
-                       return false;
-               }
-       }
-
-       if (!known && enable_unknown) {
-               if (!feat_try_enable_unknown(f)) {
-                       pr_info("not enabling: %s (unknown and 
unsupported by kernel)\n",
-                               f->name);
-                       return false;
+                       if (!m->enable(f)) {
+                               pr_info("not enabling: %s (disabled or 
unsupported by kernel)\n",
+                                       f->name);
+                               return false;
+                       }
+                       pr_debug("enabling: %s\n", f->name);
+                       cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
+                       return true;
                 }
         }

-       if (m->cpu_ftr_bit_mask)
-               cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
-
-       if (known)
-               pr_debug("enabling: %s\n", f->name);
-       else
+       if (enable_unknown && feat_try_enable_unknown(f)) {
                 pr_debug("enabling: %s (unknown)\n", f->name);
-
-       return true;
+               return true;
+       } else {
+               pr_info("not enabling: %s (unknown and unsupported by 
kernel)\n",
+                       f->name);
+               return false;
+       }
  }

  static __init void cpufeatures_cpu_quirks(void)


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

