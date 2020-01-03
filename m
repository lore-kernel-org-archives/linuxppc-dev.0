Return-Path: <SRS0=LLvc=2Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8DCC3276C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jan 2020 00:34:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D51E2085B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jan 2020 00:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D51E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pmBJ1FCfzDqC8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jan 2020 11:34:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sukadev@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pm8D1T5TzDq9W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2020 11:32:43 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0030RSOs176678; Thu, 2 Jan 2020 19:32:37 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x87mrftnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jan 2020 19:32:37 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0030V8KF013219;
 Fri, 3 Jan 2020 00:32:36 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02dal.us.ibm.com with ESMTP id 2x5xp77xbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2020 00:32:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0030WZQM54723014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jan 2020 00:32:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71393B2064;
 Fri,  3 Jan 2020 00:32:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54189B205F;
 Fri,  3 Jan 2020 00:32:35 +0000 (GMT)
Received: from suka-w540.localdomain (unknown [9.70.94.45])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jan 2020 00:32:35 +0000 (GMT)
Received: by suka-w540.localdomain (Postfix, from userid 1000)
 id AFA5F2E0ED7; Thu,  2 Jan 2020 16:32:33 -0800 (PST)
Date: Thu, 2 Jan 2020 16:32:33 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH V3 2/2] KVM: PPC: Implement H_SVM_INIT_ABORT hcall
Message-ID: <20200103003233.GA16216@us.ibm.com>
References: <20191215021104.GA27378@us.ibm.com>
 <20191215021208.GB27378@us.ibm.com>
 <20200103001814.GD5556@oc0525413822.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103001814.GD5556@oc0525413822.ibm.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_08:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=606 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030003
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
Cc: kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ram Pai [linuxram@us.ibm.com] wrote:
> > +unsigned long kvmppc_h_svm_init_abort(struct kvm *kvm)
> > +{
> > +	int i;
> > +
> > +	if (!(kvm->arch.secure_guest & KVMPPC_SECURE_INIT_START))
> > +		return H_UNSUPPORTED;
> 
> It should also return H_UNSUPPORTED when 
> (kvm->arch.secure_guest & KVMPPC_SECURE_INIT_DONE) is true.

If KVMPPC_SECURE_INIT_DONE is set, KVMPPC_SECURE_INIT_START is also
set - we never clear KVMPPC_SECURE_INIT_START right?

Sukadev
