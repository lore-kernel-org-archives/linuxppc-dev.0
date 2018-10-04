Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83427C00449
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 01:04:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AC22098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 01:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AC22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QZRb5dwZzF3BN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 11:04:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QZPK423dzF380
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 11:02:44 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w940sF4H035416
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 21:02:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mw6sgbvs6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 21:02:42 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 3 Oct 2018 19:02:41 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Oct 2018 19:02:37 -0600
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9412aIv52625436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Oct 2018 18:02:36 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ADC9C6055;
 Wed,  3 Oct 2018 19:02:36 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AE9BC605B;
 Wed,  3 Oct 2018 19:02:33 -0600 (MDT)
Received: from oc5000245537.ibm.com (unknown [9.80.203.154])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  3 Oct 2018 19:02:33 -0600 (MDT)
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michal Hocko <mhocko@kernel.org>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
 <20181002145922.GZ18290@dhcp22.suse.cz>
 <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
 <20181002160446.GA18290@dhcp22.suse.cz>
 <e7dd66c1-d196-3a14-0115-acdaf538ebfd@linux.vnet.ibm.com>
 <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
 <17781f9e-abfb-8c1e-eb18-39571d1b5cd6@linux.vnet.ibm.com>
 <e7c0f7cc-02a4-47ff-9d7c-0b63f106932e@gmail.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Wed, 3 Oct 2018 20:02:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e7c0f7cc-02a4-47ff-9d7c-0b63f106932e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100401-0004-0000-0000-00001496C58D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009817; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097510; UDB=6.00567591; IPR=6.00877552; 
 MB=3.00023603; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-04 01:02:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100401-0005-0000-0000-00008907B7E4
Message-Id: <571d56e7-bfa9-5da1-c321-15adfffaba69@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-03_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040008
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/03/2018 06:05 PM, Tyrel Datwyler wrote:
> On 10/03/2018 06:27 AM, Michael Bringmann wrote:
>> On 10/02/2018 02:45 PM, Tyrel Datwyler wrote:
>>> On 10/02/2018 11:13 AM, Michael Bringmann wrote:
>>>>
>>>>
>>>> On 10/02/2018 11:04 AM, Michal Hocko wrote:
>>>>> On Tue 02-10-18 10:14:49, Michael Bringmann wrote:
>>>>>> On 10/02/2018 09:59 AM, Michal Hocko wrote:
>>>>>>> On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
>>>>>>> [...]
>>>>>>>> When the device-tree affinity attributes have changed for memory,
>>>>>>>> the 'nid' affinity calculated points to a different node for the
>>>>>>>> memory block than the one used to install it, previously on the
>>>>>>>> source system.  The newly calculated 'nid' affinity may not yet
>>>>>>>> be initialized on the target system.  The current memory tracking
>>>>>>>> mechanisms do not record the node to which a memory block was
>>>>>>>> associated when it was added.  Nathan is looking at adding this
>>>>>>>> feature to the new implementation of LMBs, but it is not there
>>>>>>>> yet, and won't be present in earlier kernels without backporting a
>>>>>>>> significant number of changes.
>>>>>>>
>>>>>>> Then the patch you have proposed here just papers over a real issue, no?
>>>>>>> IIUC then you simply do not remove the memory if you lose the race.
>>>>>>
>>>>>> The problem occurs when removing memory after an affinity change
>>>>>> references a node that was previously unreferenced.  Other code
>>>>>> in 'kernel/mm/memory_hotplug.c' deals with initializing an empty
>>>>>> node when adding memory to a system.  The 'removing memory' case is
>>>>>> specific to systems that perform LPM and allow device-tree changes.
>>>>>> The powerpc kernel does not have the option of accepting some PRRN
>>>>>> requests and accepting others.  It must perform them all.
>>>>>
>>>>> I am sorry, but you are still too cryptic for me. Either there is a
>>>>> correctness issue and the the patch doesn't really fix anything or the
>>>>> final race doesn't make any difference and then the ppc code should be
>>>>> explicit about that. Checking the node inside the hotplug core code just
>>>>> looks as a wrong layer to mitigate an arch specific problem. I am not
>>>>> saying the patch is a no-go but if anything we want a big fat comment
>>>>> explaining how this is possible because right now it just points to an
>>>>> incorrect API usage.
>>>>>
>>>>> That being said, this sounds pretty much ppc specific problem and I
>>>>> would _prefer_ it to be handled there (along with a big fat comment of
>>>>> course).
>>>>
>>>> Let me try again.  Regardless of the path to which we get to this condition,
>>>> we currently crash the kernel.  This patch changes that to a WARN_ON notice
>>>> and continues executing the kernel without shutting down the system.  I saw
>>>> the problem during powerpc testing, because that is the focus of my work.
>>>> There are other paths to this function besides powerpc.  I feel that the
>>>> kernel should keep running instead of halting.
>>>
>>> This is still basically a hack to get around a known race. In itself this patch is still worth while in that we shouldn't crash the kernel on a null pointer dereference. However, I think the actual problem still needs to be addressed. We shouldn't run any PRRN events for the source system on the target after a migration. The device tree update should have taken care of telling us about new affinities and what not. Can we just throw out any queued PRRN events when we wake up on the target?
>>
>> We are not talking about queued events provided on the source system, but about
>> new PRRN events sent by phyp to the kernel on the target system to update the
>> kernel state after migration.  No way to predict the content.
> 
> Okay, but either way shouldn't your other proposed patches to update memory affinity by re-adding memory and changing the time topology updates are stopped to include the post-mobility updates put things in the right nodes? Or, am I missing something? I would assume a PRRN on the target would assume the target was up-to-date with respect to where things are supposed to be located.

This bug only recently came to our attention in a defect on a SLES12 SP3 platform running PHYP Memory Mover concurrently with LPM.  Not a normal test case.

> 
> -Tyrel

Michael

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

