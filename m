Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 12:38:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948DC2083D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 12:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948DC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449Bsy47sMzDqMC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 23:38:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449Bp36zYnzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 23:34:51 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1SCU44d100188
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 07:34:49 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qxfhn8q4e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 07:34:49 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 28 Feb 2019 12:34:48 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 12:34:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1SCYi8j23068792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Feb 2019 12:34:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D531B2066;
 Thu, 28 Feb 2019 12:34:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55412B2065;
 Thu, 28 Feb 2019 12:34:41 +0000 (GMT)
Received: from [9.199.36.171] (unknown [9.199.36.171])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 12:34:40 +0000 (GMT)
Subject: Re: [PATCH 1/2] fs/dax: deposit pagetable even when installing zero
 page
To: Jan Kara <jack@suse.cz>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228092101.GA22210@quack2.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 28 Feb 2019 18:04:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228092101.GA22210@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022812-0052-0000-0000-00000392380D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010679; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167573; UDB=6.00609978; IPR=6.00948186; 
 MB=3.00025780; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 12:34:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022812-0053-0000-0000-00005FFF6498
Message-Id: <5c788802-bbf4-2c12-b126-d9b83eea86d5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280087
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Oliver O'Halloran <oohall@gmail.com>, Ross Zwisler <zwisler@kernel.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/28/19 2:51 PM, Jan Kara wrote:
> On Thu 28-02-19 14:05:21, Aneesh Kumar K.V wrote:
>> Architectures like ppc64 use the deposited page table to store hardware
>> page table slot information. Make sure we deposit a page table when
>> using zero page at the pmd level for hash.
>>
>> Without this we hit
>>
>> Unable to handle kernel paging request for data at address 0x00000000
>> Faulting instruction address: 0xc000000000082a74
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> ....
>>
>> NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
>> LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
>> Call Trace:
>>   hash_page_mm+0x43c/0x740
>>   do_hash_page+0x2c/0x3c
>>   copy_from_iter_flushcache+0xa4/0x4a0
>>   pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
>>   dax_copy_from_iter+0x40/0x70
>>   dax_iomap_actor+0x134/0x360
>>   iomap_apply+0xfc/0x1b0
>>   dax_iomap_rw+0xac/0x130
>>   ext4_file_write_iter+0x254/0x460 [ext4]
>>   __vfs_write+0x120/0x1e0
>>   vfs_write+0xd8/0x220
>>   SyS_write+0x6c/0x110
>>   system_call+0x3c/0x130
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> Thanks for the patch. It looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> ---
>> TODO:
>> * Add fixes tag
> 
> Probably this is a problem since initial PPC PMEM support, isn't it?
> 

Considering ppc64 is the only broken architecture here, I guess I will 
use the commit that enabled PPC PMEM support here.

-aneesh

