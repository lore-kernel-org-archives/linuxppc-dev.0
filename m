Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVff51GNDzDr1M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 06:27:08 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0TJDudm027657
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 14:27:06 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ft873kvyy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 14:27:05 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 29 Jan 2018 14:27:05 -0500
Subject: Re: [PATCH RESEND V2 ] powerpc/numa: Invalidate numa_cpu_lookup_table
 on cpu remove
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <151699561194.20320.12952014708209986173.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87po5v3cgl.fsf@concordia.ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 13:27:02 -0600
MIME-Version: 1.0
In-Reply-To: <87po5v3cgl.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <148c9729-da6f-8c84-25fa-a6336d175415@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/27/2018 02:58 AM, Michael Ellerman wrote:
> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> 
>> When DLPAR removing a CPU, the unmapping of the cpu from a node in
>> unmap_cpu_from_node() should also invalidate the CPUs entry in the
>> numa_cpu_lookup_table. There is not a guarantee that on a subsequent
>> DLPAR add of the CPU the associativity will be the same and thus
>> could be in a different node. Invalidating the entry in the
>> numa_cpu_lookup_table causes the associativity to be read from the
>> device tree at the time of the add.
> 
> This last part seems to contradict the change log of commit d4edc5b6c480
> ("powerpc: Fix the setup of CPU-to-Node mappings during CPU online"),
> which seems to say that we shouldn't be looking at the device tree.
> 
> Can you explain to me what I'm missing?

The commit you refer to addresses CPU online/offline behavior and is correct
that we shouldn't reference the device tree. The cpu-to-node mapping shouldn't
change across a offline/online operation since the CPU remains assigned to
the partition the entire time.

This patch addresses CPUs that have been DLPAR removed, and as such the CPU
is no longer assigned to the partition. Given this we don't have a guarantee
that the CPU will have the same node-to-cpu mapping when it is assigned
back to the partition on a subsequent DLPAR add operation.

Without this patch, the CPU is put back in the node it was in previously
which may not match the node firmware states it belongs to.

> 
> Also when did this break, always? Which commit should I mark this as
> fixing?
As far as I know this has always been broken. I've looked the the git logs
for the numa and pseries cpu hotplug code and don't see a specific
commit I can point at for breaking this.

-Nathan
