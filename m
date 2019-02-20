Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:44:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287782089F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287782089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444CPc2B2gzDqFG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:44:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444CMs23VjzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:43:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444CMs18k6z8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:43:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444CMs0hN3z9s7h; Wed, 20 Feb 2019 20:43:21 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mahesh@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444CMr0NhFz9s5R
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 20:43:19 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K9dfnx013559
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:43:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qs35euewe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:43:17 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 20 Feb 2019 09:43:16 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 09:43:13 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K9hCax23986270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 09:43:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FE5852050;
 Wed, 20 Feb 2019 09:43:12 +0000 (GMT)
Received: from in.ibm.com (unknown [9.109.253.165])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 764635204F;
 Wed, 20 Feb 2019 09:43:11 +0000 (GMT)
Date: Wed, 20 Feb 2019 15:13:07 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: Simplify machine check handling
References: <20190220010550.GD5353@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220010550.GD5353@blackberry>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
x-cbid: 19022009-0016-0000-0000-00000258A0F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022009-0017-0000-0000-000032B2E99A
Message-Id: <20190220094307.6hoaqcxzfoqqys2l@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200070
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
Reply-To: mahesh@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2019-02-20 12:05:50 Wed, Paul Mackerras wrote:
> This makes the handling of machine check interrupts that occur inside
> a guest simpler and more robust, with less done in assembler code and
> in real mode.
> 
> Now, when a machine check occurs inside a guest, we always get the
> machine check event struct and put a copy in the vcpu struct for the
> vcpu where the machine check occurred.  We no longer call
> machine_check_queue_event() from kvmppc_realmode_mc_power7(), because
> on POWER8, when a vcpu is running on an offline secondary thread and
> we call machine_check_queue_event(), that calls irq_work_queue(),
> which doesn't work because the CPU is offline, but instead triggers
> the WARN_ON(lazy_irq_pending()) in pnv_smp_cpu_kill_self() (which
> fires again and again because nothing clears the condition).
> 
> All that machine_check_queue_event() actually does is to cause the
> event to be printed to the console.  For a machine check occurring in
> the guest, we now print the event in kvmppc_handle_exit_hv()
> instead.
> 
> The assembly code at label machine_check_realmode now just calls C
> code and then continues exiting the guest.  We no longer either
> synthesize a machine check for the guest in assembly code or return
> to the guest without a machine check.
> 
> The code in kvmppc_handle_exit_hv() is extended to handle the case
> where the guest is not FWNMI-capable.  In that case we now always
> synthesize a machine check interrupt for the guest.  Previously, if
> the host thinks it has recovered the machine check fully, it would
> return to the guest without any notification that the machine check
> had occurred.  If the machine check was caused by some action of the
> guest (such as creating duplicate SLB entries), it is much better to
> tell the guest that it has caused a problem.  Therefore we now always
> generate a machine check interrupt for guests that are not
> FWNMI-capable.

Looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.

