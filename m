Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E533CC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:16:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1972C20838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1972C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yhXW1Zp5zDqQW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 21:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yhVb3Ld8zDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 21:15:02 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1BAEGRQ042820
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 05:15:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qk507wvxb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 05:15:00 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 11 Feb 2019 10:14:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 11 Feb 2019 10:14:56 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1BAEtxI4587944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Feb 2019 10:14:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D4DEAE045;
 Mon, 11 Feb 2019 10:14:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20E79AE056;
 Mon, 11 Feb 2019 10:14:54 +0000 (GMT)
Received: from [9.124.31.81] (unknown [9.124.31.81])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 11 Feb 2019 10:14:53 +0000 (GMT)
Subject: Re: [RFC PATCH 5/5] powerpc: sstep: Add selftests for addc[.]
 instruction
To: Daniel Axtens <dja@axtens.net>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
 <9460deae6525f983b6ab44e3e35c1bbbd79d3ef5.1549253769.git.sandipan@linux.ibm.com>
 <878syn3zqz.fsf@dja-thinkpad.axtens.net>
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Mon, 11 Feb 2019 15:44:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <878syn3zqz.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021110-0028-0000-0000-000003471845
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021110-0029-0000-0000-0000240532BD
Message-Id: <91145f12-2ff1-3bc8-89ef-b969c385b413@linux.ibm.com>
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



On 11/02/19 6:30 AM, Daniel Axtens wrote:
> Hi Sandipan,
> 
>> +			{
>> +				.descr = "RA = LONG_MIN | INT_MIN, RB = LONG_MIN | INT_MIN",
>> +				.instr = PPC_INST_ADDC | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
>> +				.regs =
>> +				{
>> +					.gpr[21] = LONG_MIN | (uint) INT_MIN,
>> +					.gpr[22] = LONG_MIN | (uint) INT_MIN,
>> +				}
>> +			}
> I don't know what this bit pattern is supposed to represent - is it
> supposed to be the smallest 32bit integer and the smallest 64bit
> integer 8000000080000000 - so you test 32 and 64 bit overflow at the
> same time? 
> 

Yes, exactly.

> 
> For the series:
> Tested-by: Daniel Axtens <dja@axtens.net> # Power8 LE
> 
> I notice the output is quite verbose, and doesn't include a line when it
> starts:
> 
> [    0.826181] Running code patching self-tests ...
> [    0.826607] Running feature fixup self-tests ...
> [    0.826615] nop     : R0 = LONG_MAX                                      [PASS]
> [    0.826617] add     : RA = LONG_MIN, RB = LONG_MIN                       [PASS]
> 
> Maybe it would be good to include a line saying "Running single-step
> emulation self-tests" and perhaps by default on printing when there is a
> failure.
> 

That makes sense. Will include it in the next revision.

> Finally, I think you might be able to squash patches 1 and 2 and patches
> 4 and 5, but that's just my personal preference.
> 
> Regards,
> Daniel
> 

