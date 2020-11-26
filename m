Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CCCC63697
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 10:37:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D76620BED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I9eGZyby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D76620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChZ2t6NBPzDr6f
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 21:37:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=I9eGZyby; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChZ1B6DyCzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 21:36:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AQAWMGB092560; Thu, 26 Nov 2020 05:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2LUsCQl66Y1vYv5Y7WzLnvbqMQUNc8k9N0f/hS+dBhc=;
 b=I9eGZybyy1cvPoZSMOwE9bPIM8R5/2NuLlZkwcqNaHMjSmDHgKiG5juXWkSAI6xcOEt7
 XmPUf1URQoYy2hhj2F3yfCR4Z5R/ZNo6W+ijLwJ3zprdoHPezsWZClG9QYVAXLOAocby
 vjbinhAhXuLcfJrR5WGO3HiV4W5poCme36in1unBtSDlvRt1jM0ghD5L6s9eo1DSMCVD
 0HvhEhV14McypR0BsUQXzyah5QRBotCHr7Bitl/y9cmBhiHkqsvAon4qCPrB0E1Il1yc
 co9WCsIjomSfQAoMYJFbK2x7h+GykC3Z78j14xWYY+v/uO5JarS4bpBymLSqz8vP+fAx Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3527yrvnyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 05:36:08 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AQAWgaf093553;
 Thu, 26 Nov 2020 05:36:08 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3527yrvnx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 05:36:08 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQASJcT021019;
 Thu, 26 Nov 2020 10:36:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 34xth8dhcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 10:36:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0AQAa3c137552634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2020 10:36:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3215852054;
 Thu, 26 Nov 2020 10:36:03 +0000 (GMT)
Received: from [9.199.35.78] (unknown [9.199.35.78])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 569D952050;
 Thu, 26 Nov 2020 10:36:01 +0000 (GMT)
Subject: Re: [PATCH 1/2] powerpc: sstep: Fix load and update instructions
To: Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au
References: <20201119054139.244083-1-sandipan@linux.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <a2268afc-ab6e-9f94-ef47-c38198854a28@linux.ibm.com>
Date: Thu, 26 Nov 2020 16:06:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201119054139.244083-1-sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-26_03:2020-11-26,
 2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260060
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, jniethe5@gmail.com,
 paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/19/20 11:11 AM, Sandipan Das wrote:
> The Power ISA says that the fixed-point load and update
> instructions must neither use R0 for the base address (RA)
> nor have the destination (RT) and the base address (RA) as
> the same register. In these cases, the instruction is
> invalid. This applies to the following instructions.
>    * Load Byte and Zero with Update (lbzu)
>    * Load Byte and Zero with Update Indexed (lbzux)
>    * Load Halfword and Zero with Update (lhzu)
>    * Load Halfword and Zero with Update Indexed (lhzux)
>    * Load Halfword Algebraic with Update (lhau)
>    * Load Halfword Algebraic with Update Indexed (lhaux)
>    * Load Word and Zero with Update (lwzu)
>    * Load Word and Zero with Update Indexed (lwzux)
>    * Load Word Algebraic with Update Indexed (lwaux)
>    * Load Doubleword with Update (ldu)
>    * Load Doubleword with Update Indexed (ldux)
> 
> However, the following behaviour is observed using some
> invalid opcodes where RA = RT.
> 
> An userspace program using an invalid instruction word like
> 0xe9ce0001, i.e. "ldu r14, 0(r14)", runs and exits without
> getting terminated abruptly. The instruction performs the
> load operation but does not write the effective address to
> the base address register. Attaching an uprobe at that
> instruction's address results in emulation which writes the
> effective address to the base register. Thus, the final value
> of the base address register is different.
> 
> To remove any inconsistencies, this adds an additional check
> for the aforementioned instructions to make sure that they
> are treated as unknown by the emulation infrastructure when
> RA = 0 or RA = RT. The kernel will then fallback to executing
> the instruction on hardware.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

For the series:
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
