Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854FDC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:36:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5022089F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5022089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44psYp5NFszDqXt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44psWd5HtQzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 17:34:05 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3O7VGRM054917
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 03:34:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s2gpjqpn5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 03:34:02 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Wed, 24 Apr 2019 08:33:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Apr 2019 08:33:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3O7XluQ58458312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2019 07:33:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 351E1A4053;
 Wed, 24 Apr 2019 07:33:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C72CFA4059;
 Wed, 24 Apr 2019 07:33:44 +0000 (GMT)
Received: from [9.145.184.124] (unknown [9.145.184.124])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2019 07:33:44 +0000 (GMT)
Subject: Re: [PATCH v12 00/31] Speculative page faults
To: Peter Zijlstra <peterz@infradead.org>,
 Michel Lespinasse <walken@google.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
 <20190423093851.GJ11158@hirez.programming.kicks-ass.net>
From: Laurent Dufour <ldufour@linux.ibm.com>
Date: Wed, 24 Apr 2019 09:33:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423093851.GJ11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042407-0016-0000-0000-00000272C3E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042407-0017-0000-0000-000032CF3377
Message-Id: <05df6720-7130-62fe-a71f-074b6fafff3e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-24_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240065
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
Cc: Jan Kara <jack@suse.cz>, sergey.senozhatsky.work@gmail.com,
 Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Punit Agrawal <punitagrawal@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Haiyan Song <haiyanx.song@intel.com>, Nick Piggin <npiggin@gmail.com>,
 sj38.park@gmail.com, Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net,
 kemi.wang@intel.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 23/04/2019 à 11:38, Peter Zijlstra a écrit :
> On Mon, Apr 22, 2019 at 02:29:16PM -0700, Michel Lespinasse wrote:
>> The proposed spf mechanism only handles anon vmas. Is there a
>> fundamental reason why it couldn't handle mapped files too ?
>> My understanding is that the mechanism of verifying the vma after
>> taking back the ptl at the end of the fault would work there too ?
>> The file has to stay referenced during the fault, but holding the vma's
>> refcount could be made to cover that ? the vm_file refcount would have
>> to be released in __free_vma() instead of remove_vma; I'm not quite sure
>> if that has more implications than I realize ?
> 
> IIRC (and I really don't remember all that much) the trickiest bit was
> vs unmount. Since files can stay open past the 'expected' duration,
> umount could be delayed.
> 
> But yes, I think I had a version that did all that just 'fine'. Like
> mentioned, I didn't keep the refcount because it sucked just as hard as
> the mmap_sem contention, but the SRCU callback did the fput() just fine
> (esp. now that we have delayed_fput).

I had to use a refcount for the VMA because I'm using RCU in place of 
SRCU and only protecting the RB tree using RCU.

Regarding the file pointer, I decided to release it synchronously to 
avoid the latency of RCU during the file closing. As you mentioned this 
could delayed the umount but not only, as Linus Torvald demonstrated by 
the past [1]. Anyway, since the file support is not yet here there is no 
need for that currently.

Regarding the file mapping support, the concern is to ensure that 
vm_ops->fault() will not try to release the mmap_sem. This is true for 
most of the file system operation using the generic one, but there is 
currently no clever way to identify that except by checking the 
vm_ops->fault pointer. Adding a flag to the vm_operations_struct 
structure is another option.

that's doable as far as the underlying fault() function is not dealing 
with the mmap_sem, and I made a try by the past but was thinking that 
first the anonymous case should be accepted before moving forward this way.

[1] 
https://lore.kernel.org/linux-mm/alpine.LFD.2.00.1001041904250.3630@localhost.localdomain/

