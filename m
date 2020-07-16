Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57AC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 22:02:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B702076D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 22:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B702076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B77XY5w1yzDqYS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 08:02:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B77Tf51FKzDr6P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 08:00:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4B77Tf3DHPz9CMZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 08:00:06 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4B77Tf1YyCz9sRW; Fri, 17 Jul 2020 08:00:06 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=bauerman@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B77Td4J8jz9sRN
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2020 08:00:05 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06GLlGmP086747; Thu, 16 Jul 2020 18:00:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32792xnkqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2020 18:00:01 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GL3CvL087521;
 Thu, 16 Jul 2020 18:00:00 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32792xnkpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2020 18:00:00 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GLioHt021034;
 Thu, 16 Jul 2020 21:59:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 327urt51sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2020 21:59:59 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06GLxxdt54067484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2020 21:59:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C560AC064;
 Thu, 16 Jul 2020 21:59:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72C2FAC059;
 Thu, 16 Jul 2020 21:59:54 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.8.110])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2020 21:59:54 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466088775.24747.1248185448154277951.stgit@hbathini.in.ibm.com>
 <87365t8pse.fsf@morokweng.localdomain>
 <0582476e-415e-3f60-2bb2-6199d0340156@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 04/12] ppc64/kexec_file: avoid stomping memory used by
 special regions
In-reply-to: <0582476e-415e-3f60-2bb2-6199d0340156@linux.ibm.com>
Date: Thu, 16 Jul 2020 18:59:49 -0300
Message-ID: <878sfjce96.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-16_11:2020-07-16,
 2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 suspectscore=0
 mlxlogscore=-1000 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=100 malwarescore=0 bulkscore=0
 mlxscore=100 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160140
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
Cc: Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
 Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 15/07/20 8:09 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>
> <snip>
>  
>>> +/**
>>> + * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
>>> + *                              in the memory regions between buf_min & buf_max
>>> + *                              for the buffer. If found, sets kbuf->mem.
>>> + * @kbuf:                       Buffer contents and memory parameters.
>>> + * @buf_min:                    Minimum address for the buffer.
>>> + * @buf_max:                    Maximum address for the buffer.
>>> + *
>>> + * Returns 0 on success, negative errno on error.
>>> + */
>>> +static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
>>> +				      u64 buf_min, u64 buf_max)
>>> +{
>>> +	int ret = -EADDRNOTAVAIL;
>>> +	phys_addr_t start, end;
>>> +	u64 i;
>>> +
>>> +	for_each_mem_range_rev(i, &memblock.memory, NULL, NUMA_NO_NODE,
>>> +			       MEMBLOCK_NONE, &start, &end, NULL) {
>>> +		if (start > buf_max)
>>> +			continue;
>>> +
>>> +		/* Memory hole not found */
>>> +		if (end < buf_min)
>>> +			break;
>>> +
>>> +		/* Adjust memory region based on the given range */
>>> +		if (start < buf_min)
>>> +			start = buf_min;
>>> +		if (end > buf_max)
>>> +			end = buf_max;
>>> +
>>> +		start = ALIGN(start, kbuf->buf_align);
>>> +		if (start < end && (end - start + 1) >= kbuf->memsz) {
>> 
>> This is why I dislike using start and end to express address ranges:
>> 
>> While struct resource seems to use the [address, end] convention, my
>
> struct crash_mem also uses [address, end] convention.
> This off-by-one error did not cause any issues as the hole start and size we try to find
> are at least page aligned.
>
> Nonetheless, I think fixing 'end' early in the loop with "end -= 1" would ensure
> correctness while continuing to use the same convention for structs crash_mem & resource.

Sounds good.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
