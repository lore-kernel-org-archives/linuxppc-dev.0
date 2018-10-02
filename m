Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C782CC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFE2206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFE2206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PjNt33XgzF3J3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:14:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Phtw4ZJCzF3HS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:51:52 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w92Eo9I0046643
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2018 10:51:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mvanc8dr3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 10:51:50 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 2 Oct 2018 10:51:48 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Oct 2018 10:51:44 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w92EphE428639428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Oct 2018 14:51:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C3D2AC05E;
 Tue,  2 Oct 2018 10:51:01 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBA9CAC05B;
 Tue,  2 Oct 2018 10:50:58 -0400 (EDT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.212])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Oct 2018 10:50:58 -0400 (EDT)
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michal Hocko <mhocko@kernel.org>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
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
Date: Tue, 2 Oct 2018 09:51:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100214-2213-0000-0000-000002FB17B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009809; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096827; UDB=6.00567181; IPR=6.00876869; 
 MB=3.00023590; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 14:51:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100214-2214-0000-0000-00005BC16C93
Message-Id: <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-02_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020144
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
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

See below.

On 10/01/2018 06:20 PM, Tyrel Datwyler wrote:
> On 10/01/2018 01:27 PM, Michal Hocko wrote:
>> On Mon 01-10-18 13:56:25, Michael Bringmann wrote:
>>> In some LPAR migration scenarios, device-tree modifications are
>>> made to the affinity of the memory in the system.  For instance,
>>> it may occur that memory is installed to nodes 0,3 on a source
>>> system, and to nodes 0,2 on a target system.  Node 2 may not
>>> have been initialized/allocated on the target system.
>>>
>>> After migration, if a RTAS PRRN memory remove is made to a
>>> memory block that was in node 3 on the source system, then
>>> try_offline_node tries to remove it from node 2 on the target.
>>> The NODE_DATA(2) block would not be initialized on the target,
>>> and there is no validation check in the current code to prevent
>>> the use of a NULL pointer.
>>
>> I am not familiar with ppc and the above doesn't really help me
>> much. Sorry about that. But from the above it is not clear to me whether
>> it is the caller which does something unexpected or the hotplug code
>> being not robust enough. From your changelog I would suggest the later
>> but why don't we see the same problem for other archs? Is this a problem
>> of unrolling a partial failure?
>>
>> dlpar_remove_lmb does the following
>>
>> 	nid = memory_add_physaddr_to_nid(lmb->base_addr);
>>
>> 	remove_memory(nid, lmb->base_addr, block_sz);
>>
>> 	/* Update memory regions for memory remove */
>> 	memblock_remove(lmb->base_addr, block_sz);
>>
>> 	dlpar_remove_device_tree_lmb(lmb);
>>
>> Is the whole operation correct when remove_memory simply backs off
>> silently. Why don't we have to care about memblock resp
>> dlpar_remove_device_tree_lmb parts? In other words how come the physical
>> memory range is valid while the node association is not?
>>
> 
> I think the issue here is a race between the LPM code updating affinity and PRRN events being processed. Does your other patch[1] not fix the issue? Or is it that the LPM affinity updates don't do any of the initialization/allocation you mentioned?

This patch addresses the specific case where PRRN changes to CPU or memory are occurring on a system that also observes affinity changes during migration.  Yes,  there is a race condition -- if the PRRN events reliably occurred before the device-tree was updated, this error would not occur.  However, they overlap or occur after the changes during most LPMs observed.

When the device-tree affinity attributes have changed for memory, the 'nid' affinity calculated points to a different node for the memory block than the one used to install it, previously on the source system.  The newly calculated 'nid' affinity may not yet be initialized on the target system.  The current memory tracking mechanisms do not record the node to which a memory block was associated when it was added.  Nathan is looking at adding this feature to the new implementation of LMBs, but it is not there yet, and won't be present in earlier kernels without backporting a significant number of changes.

My other patch[1] is more intended to address locking and CPU update dependencies between PRRN changes and RTAS requests which did not necessarly involve memory updates.  The node to memory association problem after migration would be present even with this issue resolved.

> 
> -Tyrel
> 
> [1] https://lore.kernel.org/linuxppc-dev/20181001185603.11373.61650.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com/T/#u
> 

Michael

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

