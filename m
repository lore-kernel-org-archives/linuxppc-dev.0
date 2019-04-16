Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53632C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 21:37:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0B020684
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0B020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kJbw52xfzDqM9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 07:37:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k77L1rwnzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 00:30:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GDkUrN113103
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:46:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwentmu6j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:46:34 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Tue, 16 Apr 2019 14:46:29 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 14:46:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GDkH0i8716466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 13:46:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 662084C040;
 Tue, 16 Apr 2019 13:46:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A03F74C046;
 Tue, 16 Apr 2019 13:46:15 +0000 (GMT)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.33])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 13:46:15 +0000 (GMT)
From: Laurent Dufour <ldufour@linux.ibm.com>
To: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
 kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 sergey.senozhatsky.work@gmail.com, Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Minchan Kim <minchan@kernel.org>, Punit Agrawal <punitagrawal@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, zhong jiang <zhongjiang@huawei.com>,
 Haiyan Song <haiyanx.song@intel.com>,
 Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
 Michel Lespinasse <walken@google.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v12 18/31] mm: protect against PTE changes done by dup_mmap()
Date: Tue, 16 Apr 2019 15:45:09 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041613-4275-0000-0000-000003287653
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041613-4276-0000-0000-00003837A75B
Message-Id: <20190416134522.17540-19-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160093
X-Mailman-Approved-At: Wed, 17 Apr 2019 06:55:24 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, linux-mm@kvack.org, Vinayak Menon <vinmenon@codeaurora.org>,
 paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
 haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Vinayak Menon and Ganesh Mahendran reported that the following scenario may
lead to thread being blocked due to data corruption:

    CPU 1                   CPU 2                    CPU 3
    Process 1,              Process 1,               Process 1,
    Thread A                Thread B                 Thread C

    while (1) {             while (1) {              while(1) {
    pthread_mutex_lock(l)   pthread_mutex_lock(l)    fork
    pthread_mutex_unlock(l) pthread_mutex_unlock(l)  }
    }                       }

In the details this happens because :

    CPU 1                CPU 2                       CPU 3
    fork()
    copy_pte_range()
      set PTE rdonly
    got to next VMA...
     .                   PTE is seen rdonly          PTE still writable
     .                   thread is writing to page
     .                   -> page fault
     .                     copy the page             Thread writes to page
     .                      .                        -> no page fault
     .                     update the PTE
     .                     flush TLB for that PTE
   flush TLB                                        PTE are now rdonly

So the write done by the CPU 3 is interfering with the page copy operation
done by CPU 2, leading to the data corruption.

To avoid this we mark all the VMA involved in the COW mechanism as changing
by calling vm_write_begin(). This ensures that the speculative page fault
handler will not try to handle a fault on these pages.
The marker is set until the TLB is flushed, ensuring that all the CPUs will
now see the PTE as not writable.
Once the TLB is flush, the marker is removed by calling vm_write_end().

The variable last is used to keep tracked of the latest VMA marked to
handle the error path where part of the VMA may have been marked.

Since multiple VMA from the same mm may have the sequence count increased
during this process, the use of the vm_raw_write_begin/end() is required to
avoid lockdep false warning messages.

Reported-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 kernel/fork.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f8dae021c2e5..2992d2c95256 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -462,7 +462,7 @@ EXPORT_SYMBOL(free_task);
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp, *prev, **pprev, *last = NULL;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge;
@@ -581,8 +581,18 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
+		if (!(tmp->vm_flags & VM_WIPEONFORK)) {
+			if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {
+				/*
+				 * Mark this VMA as changing to prevent the
+				 * speculative page fault hanlder to process
+				 * it until the TLB are flushed below.
+				 */
+				last = mpnt;
+				vm_raw_write_begin(mpnt);
+			}
 			retval = copy_page_range(mm, oldmm, mpnt);
+		}
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
@@ -595,6 +605,22 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 out:
 	up_write(&mm->mmap_sem);
 	flush_tlb_mm(oldmm);
+
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {
+		/*
+		 * Since the TLB has been flush, we can safely unmark the
+		 * copied VMAs and allows the speculative page fault handler to
+		 * process them again.
+		 * Walk back the VMA list from the last marked VMA.
+		 */
+		for (; last; last = last->vm_prev) {
+			if (last->vm_flags & VM_DONTCOPY)
+				continue;
+			if (!(last->vm_flags & VM_WIPEONFORK))
+				vm_raw_write_end(last);
+		}
+	}
+
 	up_write(&oldmm->mmap_sem);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
-- 
2.21.0

