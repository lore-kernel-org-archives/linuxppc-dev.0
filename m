Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBhXj2VRvzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 15:56:52 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9B4s05l120413
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 00:56:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dhcm1087x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 00:56:50 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 05:56:48 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9B4ujZ520709492
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:56:46 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9B4uiqx023966
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 15:56:44 +1100
Subject: Re: [PATCH] powerpc/modules: Use WARN_ON() in stub_for_addr()
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1507646852-18642-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <87d15uz5j9.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kamalesh@linux.vnet.ibm.com
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 10:26:41 +0530
MIME-Version: 1.0
In-Reply-To: <87d15uz5j9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c2a00841-f514-ef8c-c1be-b053dd84d1b8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 11 October 2017 09:42 AM, Michael Ellerman wrote:
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
> 
>> Use WARN_ON(), while running out of stubs in stub_for_addr()
>> and abort loading of the module instead of BUG_ON().
> 
> Thanks. This looks good in principle. Have you actually tested it to
> make sure we do in fact gracefully fail the module load?
> 

Thanks for the review. I tested with little hackish version of this patch:

+       if (!strncmp(me->name, "live", 4))
+               j = 100;
+       for (i = 0; stub_func_addr(stubs[i].funcdata); i+=j) {
+               if (WARN_ON(i >= num_stubs))
+                       return 0;

and it fails gracefully.

# modprobe livepatch-sample
modprobe: ERROR: could not insert 'livepatch_sample': Unknown symbol in module, or unknown parameter (see dmesg)

# echo $?
1

# dmesg 
------------[ cut here ]------------
WARNING: CPU: 2 PID: 2836 at arch/powerpc/kernel/module_64.c:526 apply_relocate_add+0x71c/0xb00

-- 
cheers,
Kamalesh.
