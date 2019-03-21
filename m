Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:37:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDAA2077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDAA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q8Wv2gKLzDqTv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 01:37:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=farosas@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q8VG3fypzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 01:36:06 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2LEXPaB062594
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 10:36:04 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rc9fa136s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 10:36:03 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <farosas@linux.ibm.com>;
 Thu, 21 Mar 2019 14:36:01 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Mar 2019 14:35:56 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2LEZu7I31260894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2019 14:35:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0DA47805C;
 Thu, 21 Mar 2019 14:35:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91AB278060;
 Thu, 21 Mar 2019 14:35:56 +0000 (GMT)
Received: from localhost (unknown [9.86.27.221])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Mar 2019 14:35:56 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] KVM: PPC: Report single stepping capability
In-Reply-To: <c15b17c8-6ef5-00b4-c762-8b1627ca5f18@ozlabs.ru>
References: <20190320183951.29537-1-farosas@linux.ibm.com>
 <20190320183951.29537-2-farosas@linux.ibm.com>
 <c15b17c8-6ef5-00b4-c762-8b1627ca5f18@ozlabs.ru>
Date: Thu, 21 Mar 2019 11:35:54 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19032114-0016-0000-0000-000009957C96
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177580; UDB=6.00616030; IPR=6.00958277; 
 MB=3.00026091; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-21 14:35:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032114-0017-0000-0000-00004287E69D
Message-Id: <87va0ce1md.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-21_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=44 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=749 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210103
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, pbonzini@redhat.com,
 linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> In the cover letter (which is not really required for a single patch)
> you say the capability will be present for BookE and PR KVM (which
> Book3s) but here it is BookE only, is that intentional?

A few lines below (falling through) we have:

        /* We support this only for PR */
        r = !hv_enabled;

> Also, you need to update Documentation/virtual/kvm/api.txt for the new
> capability. After reading which I started wondering could not we just
> use existing KVM_CAP_GUEST_DEBUG_HW_BPS?

We _could_, but I think that would conflate two different
concepts. Single stepping does not necessarily makes use of hardware
breakpoints (e.g. Trace Interrupt on Book3s PR).

I also think we should use KVM_CAP_GUEST_DEBUG_HW_BPS in the future to
let QEMU know about: i) the lack of hardware breakpoints in Book3s and
ii) BookE's hardware breakpoints (Instruction Address Compare) that are
currently not being reported via HW_BPS.

