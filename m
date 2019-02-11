Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B041BC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:18:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3881620838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3881620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yhZG50B1zDqRK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yhWc1rV3zDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 21:15:56 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1BAE3A1138693
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 05:15:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qk550wmt1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 05:15:53 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 11 Feb 2019 10:15:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 11 Feb 2019 10:15:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1BAFl1Z59769052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Feb 2019 10:15:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E51DAAE051;
 Mon, 11 Feb 2019 10:15:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8DB7AE04D;
 Mon, 11 Feb 2019 10:15:45 +0000 (GMT)
Received: from [9.124.31.81] (unknown [9.124.31.81])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 11 Feb 2019 10:15:45 +0000 (GMT)
Subject: Re: [RFC PATCH 3/5] powerpc: sstep: Add instruction emulation
 selftests
To: Daniel Axtens <dja@axtens.net>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
 <196d2330aef453b4eb3cb66febeb79110aadd567.1549253769.git.sandipan@linux.ibm.com>
 <87bm3j40cv.fsf@dja-thinkpad.axtens.net>
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Mon, 11 Feb 2019 15:45:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87bm3j40cv.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021110-4275-0000-0000-0000030E0044
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021110-4276-0000-0000-0000381C10D5
Message-Id: <47476580-2027-da7e-ad9e-162f91af49b7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110081
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
Cc: naveen.n.rao@linux.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/02/19 6:17 AM, Daniel Axtens wrote:
> Hi Sandipan,
> 
> I'm not really confident to review the asm, but I did have a couple of
> questions about the C:
> 
>> +#define MAX_INSNS	32
> This doesn't seem to be used...
> 

True. Thanks for pointing this out.

>> +int execute_instr(struct pt_regs *regs, unsigned int instr)
>> +{
>> +	extern unsigned int exec_instr_execute[];
>> +	extern int exec_instr(struct pt_regs *regs);
> 
> These externs sit inside the function scope. This feels less than ideal
> to me - is there a reason not to have these at global scope?
> 

Currently, execute_instr() is the only consumer. So, I thought I'd keep
them local for now.

>> +
>> +	if (!regs || !instr)
>> +		return -EINVAL;
>> +
>> +	/* Patch the NOP with the actual instruction */
>> +	patch_instruction(&exec_instr_execute[0], instr);
>> +	if (exec_instr(regs)) {
>> +		pr_info("execution failed, opcode = 0x%08x\n", instr);
>> +		return -EFAULT;
>> +	}
>> +
>> +	return 0;
>> +}
> 
>> +late_initcall(run_sstep_tests);
> A design question: is there a reason to run these as an initcall rather
> than as a module that could either be built in or loaded separately? I'm
> not saying you have to do this, but I was wondering if you had
> considered it?
> 

I did. As of now, there are some existing tests in test_emulate_step.c
which use the same approach. So, I thought I'd stick with that approach
to start off. This is anyway controlled by a Kconfig option.

> Lastly, snowpatch reports some checkpatch issues for this and your
> remaining patches: https://patchwork.ozlabs.org/patch/1035683/ (You are
> allowed to violate checkpatch rules with justification, FWIW)
> 

Will look into them.

> Regards,
> Daniel
>> -- 
>> 2.19.2
> 

