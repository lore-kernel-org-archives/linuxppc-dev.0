Return-Path: <SRS0=ZD8a=WX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36159C3A5A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 06:04:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47712173E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 06:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47712173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Hdd31bXqzDqfy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Hdb113GQzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 16:03:08 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7R634st118538
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 02:03:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2umxur04cy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 02:03:05 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 27 Aug 2019 07:03:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Aug 2019 07:02:59 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7R62wDS31981766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Aug 2019 06:02:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30FBEA4054;
 Tue, 27 Aug 2019 06:02:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A15C2A4062;
 Tue, 27 Aug 2019 06:02:53 +0000 (GMT)
Received: from [9.109.217.45] (unknown [9.109.217.45])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 27 Aug 2019 06:02:53 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/fadump: sysfs for fadump memory reservation
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
References: <20190810175905.7761-1-sourabhjain@linux.ibm.com>
 <53311fa4-2cce-1eb6-1aae-0c835e06eb24@linux.ibm.com>
 <cf4fdb60-438c-bc4e-d759-1fbb27364c50@linux.ibm.com>
 <f53e4cfe-57cb-d8a6-385a-fa6243940573@linux.ibm.com>
 <f8e9cbdd-1926-081d-c8e6-f9d55408fe51@linux.ibm.com>
 <87sgpn2t2w.fsf@concordia.ellerman.id.au>
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Tue, 27 Aug 2019 11:32:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87sgpn2t2w.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082706-0016-0000-0000-000002A35EF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082706-0017-0000-0000-00003303A7E9
Message-Id: <b3540b13-20f9-6995-831e-b7f88121fd1f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-26_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270068
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
Cc: linux-doc@vger.kernel.org, mahesh@linux.vnet.ibm.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 27/08/19 8:49 AM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
>> On 26/08/19 4:14 PM, Sourabh Jain wrote:
>>> On 8/26/19 3:46 PM, Sourabh Jain wrote:
>>>> On 8/26/19 3:29 PM, Hari Bathini wrote:
>>>>> On 10/08/19 11:29 PM, Sourabh Jain wrote:
>>>>>> Add a sys interface to allow querying the memory reserved by
>>>>>> fadump for saving the crash dump.
>>>>>>
>>>>>> Add an ABI doc entry for new sysfs interface.
>>>>>>    - /sys/kernel/fadump_mem_reserved
>>>>>>
>>>>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>> v1 -> v2:
>>>>>>   - Added ABI doc for new sysfs interface.
>>>>>>
>>>>>> v2 -> v3:
>>>>>>   - Updated the ABI documentation.
>>>>>> ---
>>>>>>
>>>>>>  Documentation/ABI/testing/sysfs-kernel-fadump    |  6 ++++++
>>>>>
>>>>> Shouldn't this be Documentation/ABI/testing/sysfs-kernel-fadump_mem_reserved?
>>>
>>> How about documenting fadump_mem_reserved and other sysfs attributes suggested
>>> by you in a single file Documentation/ABI/testing/sysfs-kernel-fadump?
>>
>> I wouldn't mind that but please do check if it is breaking a convention..
> 
> AIUI a file named like that would hold the documentation for the files
> inside a directory called /sys/kernel/fadump.
> 
> And in fact that's probably where these files should live, rather than
> just dropped directly into /sys/kernel.
Michael, could that be corrected now by introducing new sysfs files for FADump in
/sys/kernel/fadump/.

Also, duplicating current /sys/kernel/fadump_* files as /sys/kernel/fadump/* files
& eventually dropping /sys/kernel/fadump_* files sometime later..

- Hari

