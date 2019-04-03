Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CCC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:01:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071402133D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071402133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZNQB3G8hzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 11:01:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZNNF1Xt7zDqJH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 10:59:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44ZNNF0JhPz8svw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 10:59:25 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44ZNND6rrrz9sSW; Thu,  4 Apr 2019 10:59:24 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44ZNND1641z9sSR
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Apr 2019 10:59:22 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x33Nx78A086460
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Apr 2019 19:59:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rn40eq8k9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Apr 2019 19:59:19 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 4 Apr 2019 00:59:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 4 Apr 2019 00:59:15 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x33NxEga61079794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Apr 2019 23:59:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F54D11C04C;
 Wed,  3 Apr 2019 23:59:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCBF611C04A;
 Wed,  3 Apr 2019 23:59:13 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  3 Apr 2019 23:59:13 +0000 (GMT)
Received: from [9.81.197.148] (unknown [9.81.197.148])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 00BAFA01B5;
 Thu,  4 Apr 2019 10:59:10 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/xmon: add read-only mode
To: Christopher M Riedl <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
References: <20190329042153.25698-1-cmr@informatik.wtf>
 <81765ce2-af34-6776-a5f6-f69d265cd3c2@au1.ibm.com>
 <302206558.18553.1554296553840@privateemail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 4 Apr 2019 10:59:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <302206558.18553.1554296553840@privateemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040323-4275-0000-0000-000003240208
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040323-4276-0000-0000-000038330AE4
Message-Id: <a14d4f76-7769-6978-978b-68eca45b547e@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-03_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030159
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/4/19 12:02 am, Christopher M Riedl wrote:
> 
>> On March 29, 2019 at 12:49 AM Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:
>>
>>
>> On 29/3/19 3:21 pm, cmr wrote:
>>> Operations which write to memory should be restricted on secure systems
>>> and optionally to avoid self-destructive behaviors.
>>
>> For reference:
>>    - https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_linuxppc_issues_issues_219&d=DwICaQ&c=jf_iaSHvJObTbx-siA1ZOg&r=-pHOU8dm1U-U1crivyxKr_-xvZrIBB8YUqvA3el0Ee0&m=zNkGBUKLoTqdSUy_VUpM8VLTEqy7sJfIXpWU-ujc6Rc&s=9jgy61R_p5jvtwOKCMFfnhmJegzCIIomcf4I1BRvBPg&e=
>>    - https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_linuxppc_issues_issues_232&d=DwICaQ&c=jf_iaSHvJObTbx-siA1ZOg&r=-pHOU8dm1U-U1crivyxKr_-xvZrIBB8YUqvA3el0Ee0&m=zNkGBUKLoTqdSUy_VUpM8VLTEqy7sJfIXpWU-ujc6Rc&s=fFYm1ZTaEp6HbeZMV5JEmlbBtDwdehfiW1H3shFoFMM&e=
>>
>> Perhaps clarify what is meant here by "secure systems".
>>
>> Otherwise commit message looks good.
>>
> 
> I will reword this for the next patch to reflect the verbiage in the referenced
> github issue -- ie. Secure Boot and not violating secure boot integrity by using xmon.

Sounds good.

> 
>>
>>> ---
>>>    arch/powerpc/Kconfig.debug |  7 +++++++
>>>    arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
>>>    2 files changed, 31 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>>> index 4e00cb0a5464..33cc01adf4cb 100644
>>> --- a/arch/powerpc/Kconfig.debug
>>> +++ b/arch/powerpc/Kconfig.debug
>>> @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
>>>    	  to say Y here, unless you're building for a memory-constrained
>>>    	  system.
>>>    
>>> +config XMON_RO
>>> +	bool "Set xmon read-only mode"
>>> +	depends on XMON
>>> +	default y
>>> +	help
>>> +	  Disable state- and memory-altering write operations in xmon.
>>
>> The meaning of this option is a bit unclear.
>>
>>   From the code - it looks like what this option actually does is enable
>> RO mode *by default*. In which case it should probably be called
>> XMON_RO_DEFAULT and the description should note that RW mode can still
>> be enabled via a cmdline option.
>>
> 
> Based on Christophe's feedback the default will change for this option in the
> next patch. I will also add the cmdline options to the description for clarity.
> 

Yep, adding a description of the cmdline options is also a good idea.

>>
>>> +
>>>    config DEBUGGER
>>>    	bool
>>>    	depends on KGDB || XMON
>>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>>> index a0f44f992360..c13ee73cdfd4 100644
>>> --- a/arch/powerpc/xmon/xmon.c
>>> +++ b/arch/powerpc/xmon/xmon.c
>>> @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
>>>    #endif
>>>    static unsigned long in_xmon __read_mostly = 0;
>>>    static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
>>> +static int xmon_ro = IS_ENABLED(CONFIG_XMON_RO);
>>>    
>>>    static unsigned long adrs;
>>>    static int size = 1;
>>> @@ -1042,6 +1043,8 @@ cmds(struct pt_regs *excp)
>>>    			set_lpp_cmd();
>>>    			break;
>>>    		case 'b':
>>> +			if (xmon_ro == 1)
>>> +				break;
>>
>> For all these cases - it would be much better to print an error message
>> somewhere when we abort due to read-only mode.
>>
> 
> I included print messages initially but then thought about how xmon is intended
> for "power" users. I can add print statements to avoid confusion and frustration
> since the operations are just "silently" dropped -- *if* that aligns with xmon's
> "philosophy".
> 

Power users often want a straightforward self-explanatory UX more than 
anyone :)


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

