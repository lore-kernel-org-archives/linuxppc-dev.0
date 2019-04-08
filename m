Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E967C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:40:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8433120880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8433120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d5583BCdzDqDc
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d53J1rxVzDqDc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 19:39:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x389SkF0091829
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 05:39:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rr1nrq2qr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 05:39:03 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 8 Apr 2019 10:39:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Apr 2019 10:38:57 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x389cuWp56688680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Apr 2019 09:38:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACFBD42049;
 Mon,  8 Apr 2019 09:38:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1190842041;
 Mon,  8 Apr 2019 09:38:55 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.31.209])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  8 Apr 2019 09:38:54 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] fs/dax: deposit pagetable even when installing zero
 page
In-Reply-To: <CAPcyv4irZP2F1acuco7UVbvTARzn5SXvCAWstFYtP7ygLRSXTg@mail.gmail.com>
References: <20190309120721.21416-1-aneesh.kumar@linux.ibm.com>
 <8736nrnzxm.fsf@linux.ibm.com> <20190313095834.GF32521@quack2.suse.cz>
 <CAPcyv4irZP2F1acuco7UVbvTARzn5SXvCAWstFYtP7ygLRSXTg@mail.gmail.com>
Date: Mon, 08 Apr 2019 15:08:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19040809-0020-0000-0000-0000032D6DD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040809-0021-0000-0000-0000217F8DDF
Message-Id: <87r2acn8eq.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-08_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080088
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Ross Zwisler <zwisler@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


 Hi Dan,

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, Mar 13, 2019 at 2:58 AM Jan Kara <jack@suse.cz> wrote:
>>
>> On Wed 13-03-19 10:17:17, Aneesh Kumar K.V wrote:
>> >
>> > Hi Dan/Andrew/Jan,
>> >
>> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> >
>> > > Architectures like ppc64 use the deposited page table to store hardware
>> > > page table slot information. Make sure we deposit a page table when
>> > > using zero page at the pmd level for hash.
>> > >
>> > > Without this we hit
>> > >
>> > > Unable to handle kernel paging request for data at address 0x00000000
>> > > Faulting instruction address: 0xc000000000082a74
>> > > Oops: Kernel access of bad area, sig: 11 [#1]
>> > > ....
>> > >
>> > > NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
>> > > LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
>> > > Call Trace:
>> > >  hash_page_mm+0x43c/0x740
>> > >  do_hash_page+0x2c/0x3c
>> > >  copy_from_iter_flushcache+0xa4/0x4a0
>> > >  pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
>> > >  dax_copy_from_iter+0x40/0x70
>> > >  dax_iomap_actor+0x134/0x360
>> > >  iomap_apply+0xfc/0x1b0
>> > >  dax_iomap_rw+0xac/0x130
>> > >  ext4_file_write_iter+0x254/0x460 [ext4]
>> > >  __vfs_write+0x120/0x1e0
>> > >  vfs_write+0xd8/0x220
>> > >  SyS_write+0x6c/0x110
>> > >  system_call+0x3c/0x130
>> > >
>> > > Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
>> > > Reviewed-by: Jan Kara <jack@suse.cz>
>> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> >
>> > Any suggestion on which tree this patch should got to? Also since this
>> > fix a kernel crash, we may want to get this to 5.1?
>>
>> I think this should go through Dan's tree...
>
> I'll merge this and let it soak in -next for a week and then submit for 5.1-rc2.

Any update on this? Did you get to merge this?

-aneesh

