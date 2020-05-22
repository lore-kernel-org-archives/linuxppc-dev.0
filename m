Return-Path: <SRS0=CBJl=7E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049B7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 10:10:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3A32065C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 10:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3A32065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49T2LF5WKKzDr3k
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 20:10:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49T2JM6FhFzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 20:08:51 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04MA397p131619; Fri, 22 May 2020 06:08:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mktfqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 06:08:47 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04MA3IFP132696;
 Fri, 22 May 2020 06:08:47 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mktfpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 06:08:47 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04MA5Imh015672;
 Fri, 22 May 2020 10:08:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma05fra.de.ibm.com with ESMTP id 313x4xk19p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 10:08:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04MA8gwZ42533016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 10:08:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 611864C052;
 Fri, 22 May 2020 10:08:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E6864C04E;
 Fri, 22 May 2020 10:08:40 +0000 (GMT)
Received: from [9.85.70.225] (unknown [9.85.70.225])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2020 10:08:40 +0000 (GMT)
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Mikulas Patocka <mpatocka@redhat.com>
References: <20200513034705.172983-3-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
 <87v9kspk3x.fsf@linux.ibm.com>
 <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com>
 <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
 <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com>
 <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com>
 <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
 <alpine.LRH.2.02.2005211442290.22894@file01.intranet.prod.int.rdu2.redhat.com>
 <20200522093127.GY25173@kitsune.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <23e57565-be2a-a45c-f4d4-d8eca7262dea@linux.ibm.com>
Date: Fri, 22 May 2020 15:38:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522093127.GY25173@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-22_05:2020-05-22,
 2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220082
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 alistair@popple.id.au, Jeff Moyer <jmoyer@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/22/20 3:01 PM, Michal Suchánek wrote:
> On Thu, May 21, 2020 at 02:52:30PM -0400, Mikulas Patocka wrote:
>>
>>
>> On Thu, 21 May 2020, Dan Williams wrote:
>>
>>> On Thu, May 21, 2020 at 10:03 AM Aneesh Kumar K.V
>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>
>>>>> Moving on to the patch itself--Aneesh, have you audited other persistent
>>>>> memory users in the kernel?  For example, drivers/md/dm-writecache.c does
>>>>> this:
>>>>>
>>>>> static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
>>>>> {
>>>>>        if (WC_MODE_PMEM(wc))
>>>>>                wmb(); <==========
>>>>>           else
>>>>>                   ssd_commit_flushed(wc, wait_for_ios);
>>>>> }
>>>>>
>>>>> I believe you'll need to make modifications there.
>>>>>
>>>>
>>>> Correct. Thanks for catching that.
>>>>
>>>>
>>>> I don't understand dm much, wondering how this will work with
>>>> non-synchronous DAX device?
>>>
>>> That's a good point. DM-writecache needs to be cognizant of things
>>> like virtio-pmem that violate the rule that persisent memory writes
>>> can be flushed by CPU functions rather than calling back into the
>>> driver. It seems we need to always make the flush case a dax_operation
>>> callback to account for this.
>>
>> dm-writecache is normally sitting on the top of dm-linear, so it would
>> need to pass the wmb() call through the dm core and dm-linear target ...
>> that would slow it down ... I remember that you already did it this way
>> some times ago and then removed it.
>>
>> What's the exact problem with POWER? Could the POWER system have two types
>> of persistent memory that need two different ways of flushing?
> 
> As far as I understand the discussion so far
> 
>   - on POWER $oldhardware uses $oldinstruction to ensure pmem consistency
>   - on POWER $newhardware uses $newinstruction to ensure pmem consistency
>     (compatible with $oldinstruction on $oldhardware)

Correct.

>   - on some platforms instead of barrier instruction a callback into the
>     driver is issued to ensure consistency 

This is virtio-pmem only at this point IIUC.


> 
> None of this is reflected by the dm driver.
> 

-aneesh
