Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BE071A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 22:46:13 +1000 (AEST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 6 May 2015 13:46:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E2BA1B08023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 13:46:49 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t46Ck6Ix61014158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 12:46:06 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t467eA1m019685
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 03:40:10 -0400
Message-ID: <554A0D0D.8090209@de.ibm.com>
Date: Wed, 06 May 2015 14:46:05 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] kvm/powerpc: report guest steal time in host
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
 <c0db7eafdd13fcec26a0398e2ad0b7225c3998e9.1430913088.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <c0db7eafdd13fcec26a0398e2ad0b7225c3998e9.1430913088.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: ego@linux.vnet.ibm.com, agraf@suse.de, mingo@redhat.com, paulus@samba.org,
 warrier@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 06.05.2015 um 13:56 schrieb Naveen N. Rao:
> On powerpc, kvm tracks both the guest steal time as well as the time
> when guest was idle and this gets sent in to the guest through DTL. The
> guest accounts these entries as either steal time or idle time based on
> the last running task. Since the true guest idle status is not visible
> to the host, we can't accurately expose the guest steal time in the
> host.
> 
> However, tracking the guest vcpu cede status can get us a reasonable
> (within 5% variation) vcpu steal time since guest vcpus cede the
> processor on entering the idle task. To do this, we introduce a new
> field ceded_st in kvm_vcpu_arch structure to accurately track the guest
> vcpu cede status (this is needed since the existing ceded field is
> modified before we can use it). During DTL entry creation, we check this
> flag and account the time as stolen if the guest vcpu had not ceded.

I think this is more or less a question about the semantic:

What would happen if you use  current->sched_info.run_delay like x86 also
on power? How far are the numbers away? My feeling is, that the semantics
of "steal time" inside the guest is somewhat different on each platform. 

This brings me to a 2nd question:
Do you need to match the host view of guest steal time with the guest view
or do we want to have a host view that translates as "this is the time that
the guest was runnable but we were too busy to schedule him"?
For the former x86 has the best solution, as the host tells the guest its
understanding of steal - so both match. For the latter we actually try to
give guest steal a meaning in the host context  - the overload.
Would /proc/<pid>/schedstat value 2 (time spent waiting on a runqueue)
meet your requirements from the cover-letter?

Christian
