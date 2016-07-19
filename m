Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rttn66NTqzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 18:41:30 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6J8dMun030362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 04:41:28 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r7j1d7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 04:41:28 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 19 Jul 2016 09:41:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2A4DA17D8069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 09:42:53 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6J8fN6g1245634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 08:41:23 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6J8fMQm019767
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 04:41:23 -0400
Subject: Re: [PATCH V4 5/5] powerpc/kvm/stats: Implement existing and add new
 halt polling vcpu stats
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com
References: <1468915977-26929-1-git-send-email-sjitindarsingh@gmail.com>
 <1468915977-26929-5-git-send-email-sjitindarsingh@gmail.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, agraf@suse.com,
 rkrcmar@redhat.com, dmatlack@google.com
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Jul 2016 10:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <1468915977-26929-5-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <578DE7B1.4000506@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2016 10:12 AM, Suraj Jitindar Singh wrote:

> Also add new vcpu stats: halt_poll_success_ns, halt_poll_fail_ns and
> halt_wait_ns to be used to accumulate the total time spend polling
> successfully, polling unsuccessfully and waiting respectively, and
> halt_successful_wait to accumulate the number of times the vcpu waits.
> Given that halt_poll_success_ns, halt_poll_fail_ns and halt_wait_ns are
> expressed in nanoseconds it is necessary to represent these as 64-bit
> quantities, otherwise they would overflow after only about 4 seconds.


Paolo, would these new kvm_stats also be useful for the base implementation?
