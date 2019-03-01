Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E267C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C30220857
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JEyoc1et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C30220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449xrL3HnZzDqVJ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 04:54:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=mike.kravetz@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="JEyoc1et"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449xpf1XRczDqTQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 04:52:51 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x21Hn5jo062465;
 Fri, 1 Mar 2019 17:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NpucD7YBrSs74vzv0AXK91DfS+GP9Fp13cRwteMq25o=;
 b=JEyoc1et9IUl4twUIN7FXN5HbH3g9uCVH6yniiL/mlA6a0Njg1bpBZ3TlW/+rOgFgtnF
 ko5cw+9Y4gGEflsAEaeReQSQLLwb2eggXY+2FMlDTVmt6CYjXsVNDeFG98zGMtCKt5Yk
 Fq4OLiaoXpNOX1gKniCDuEEuTulYVV8O4rJtPTOzt7Zmk+uIuAf9vwbyJJP62RWCqIT5
 LOD5TRMphV1Ye90VpvGC3k6o0NTQHttJ9NOYRiULbbMt/NfT8zOxJp1fnVOccCAGJLOO
 ID0LYvleQ2Yn00z94C+aNxpOC9QHc40ZkLvYPu8TkCUHlAEp+QFfTOy1fisakExP8i21 Sg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qtupervyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2019 17:52:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x21HpwU5007124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Mar 2019 17:51:58 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x21Hpqdx018558;
 Fri, 1 Mar 2019 17:51:53 GMT
Received: from [192.168.1.164] (/50.38.38.67)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 01 Mar 2019 09:51:52 -0800
Subject: Re: [PATCH v4 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
To: Alexandre Ghiti <alex@ghiti.fr>
References: <20190228063604.15298-1-alex@ghiti.fr>
 <20190228063604.15298-5-alex@ghiti.fr>
 <9a385cc8-581c-55cf-4a85-10b5c4dd178c@intel.com>
 <31212559-d397-88fb-eaec-60f6417436c8@oracle.com>
 <6c842251-1bed-4d79-bf6d-997006ec72e2@intel.com>
 <6ea4119a-0ecb-511d-3aab-269004245a08@oracle.com>
 <1cfaca88-a219-d057-3ab8-37fb1c1687d6@ghiti.fr>
 <f7c94eb5-d496-7e24-d44f-17eaff287012@ghiti.fr>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0d3de196-bd71-3ec9-00cd-f8274c9c5f53@oracle.com>
Date: Fri, 1 Mar 2019 09:51:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f7c94eb5-d496-7e24-d44f-17eaff287012@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9182
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903010124
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
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/1/19 5:21 AM, Alexandre Ghiti wrote:
> On 03/01/2019 07:25 AM, Alex Ghiti wrote:
>> On 2/28/19 5:26 PM, Mike Kravetz wrote:
>>> On 2/28/19 12:23 PM, Dave Hansen wrote:
>>>> On 2/28/19 11:50 AM, Mike Kravetz wrote:
>>>>> On 2/28/19 11:13 AM, Dave Hansen wrote:
>>>>>>> +    if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>>>>>>> +        spin_lock(&hugetlb_lock);
>>>>>>> +        if (count > persistent_huge_pages(h)) {
>>>>>>> +            spin_unlock(&hugetlb_lock);
>>>>>>> +            return -EINVAL;
>>>>>>> +        }
>>>>>>> +        goto decrease_pool;
>>>>>>> +    }
>>>>>> This choice confuses me.  The "Decrease the pool size" code already
>>>>>> works and the code just falls through to it after skipping all the
>>>>>> "Increase the pool size" code.
>>>>>>
>>>>>> Why did did you need to add this case so early?  Why not just let it
>>>>>> fall through like before?
>>>>> I assume you are questioning the goto, right?  You are correct in that
>>>>> it is unnecessary and we could just fall through.
>>>> Yeah, it just looked odd to me.
> 
>> I'd rather avoid useless checks when we already know they won't
>> be met and I think that makes the code more understandable.
>>
>> But that's up to you for the next version.

I too find some value in the goto.  It tells me this !CONFIG_CONTIG_ALLOC
case is special and we are skipping the normal checks.  But, removing the
goto is not a requirement for me.

>>>>> However, I wonder if we might want to consider a wacky condition that the
>>>>> above check would prevent.  Consider a system/configuration with 5 gigantic
...
>>
>> If I may, I think that this is the kind of info the user wants to have and we should
>> return an error when it is not possible to allocate runtime huge pages.
>> I already noticed that if someone asks for 10 huge pages, and only 5 are allocated,
>> no error is returned to the user and I found that surprising.

Upon further thought, let's not consider this wacky permanent -> surplus ->
permanent case.  I just can't see it being an actual use case.

IIUC, that 'no error' behavior is somewhat expected.  I seem to recall previous
discussions about changing with the end result to leave as is.

>>>> @@ -2428,7 +2442,9 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>>>       } else
>>>>           nodes_allowed = &node_states[N_MEMORY];
>>>>   -    h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
>>>> +    err = set_max_huge_pages(h, count, nodes_allowed);
>>>> +    if (err)
>>>> +        goto out;
>>>>         if (nodes_allowed != &node_states[N_MEMORY])
>>>>           NODEMASK_FREE(nodes_allowed);
>>> Do note that I beleive there is a bug the above change.  The code after
>>> the out label is:
>>>
>>> out:
>>>          NODEMASK_FREE(nodes_allowed);
>>>          return err;
>>> }
>>>
>>> With the new goto, we need the same
>>> if (nodes_allowed != &node_states[N_MEMORY]) before NODEMASK_FREE().
>>>
>>> Sorry, I missed this in previous versions.
>>
>> Oh right, I'm really sorry I missed that, thank you for noticing.

This is the only issue I have with the code in hugetlb.c.  For me, the
goto can stay or go.  End result is the same.
-- 
Mike Kravetz
