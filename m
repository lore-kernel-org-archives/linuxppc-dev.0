Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtv273bMTzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 18:52:47 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6J8nLU3019790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 04:52:45 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495s8tfyc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 04:52:44 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 19 Jul 2016 09:52:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A020A2190023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 09:52:08 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6J8qeK921823818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 08:52:40 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6J8qeOD022916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 02:52:40 -0600
Subject: Re: [PATCH V4 4/5] kvm/stats: Add provisioning for ulong vm stats and
 u64 vcpu stats
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1468915977-26929-1-git-send-email-sjitindarsingh@gmail.com>
 <1468915977-26929-4-git-send-email-sjitindarsingh@gmail.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, pbonzini@redhat.com,
 agraf@suse.com, rkrcmar@redhat.com, dmatlack@google.com
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Jul 2016 10:52:39 +0200
MIME-Version: 1.0
In-Reply-To: <1468915977-26929-4-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <578DEA57.70002@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2016 10:12 AM, Suraj Jitindar Singh wrote:
> vms and vcpus have statistics associated with them which can be viewed
> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
> vm_stat_get() functions that all of these statistics are represented as
> u32s, however the next patch adds some u64 vcpu statistics.
> 
> Change all vcpu statistics to u64 and modify vcpu_stat_get() accordingly.
> Since vcpu statistics are per vcpu, they will only be updated by a single
> vcpu at a time so this shouldn't present a problem on 32-bit machines
> which can't atomically increment 64-bit numbers. However vm statistics
> could potentially be updated by multiple vcpus from that vm at a time.
> To avoid the overhead of atomics make all vm statistics ulong such that
> they are 64-bit on 64-bit systems where they can be atomically incremented
> and are 32-bit on 32-bit systems which may not be able to atomically
> increment 64-bit numbers. Modify vm_stat_get() to expect ulongs.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
