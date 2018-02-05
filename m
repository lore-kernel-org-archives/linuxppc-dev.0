Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zb0hc6nzRzF0Sy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 08:14:24 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w15LE5Pq070105
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Feb 2018 16:14:22 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fxubn8xm5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Feb 2018 16:14:21 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 5 Feb 2018 16:14:20 -0500
Subject: Re: Kernel 4.15 lost set_robust_list support on POWER 9
To: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, mpe@ellerman.id.au
Cc: Florian Weimer <fweimer@redhat.com>, Jiri Slaby <jslaby@suse.cz>
References: <3ef0c599-0285-e77a-c002-e21152823fb8@redhat.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 5 Feb 2018 19:14:14 -0200
MIME-Version: 1.0
In-Reply-To: <3ef0c599-0285-e77a-c002-e21152823fb8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d5f533cf-bd97-794a-38e8-6b6d8c005023@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nick, Michael,

On 02/05/2018 10:48 AM, Florian Weimer wrote:
> 7041  set_robust_list(0x7fff93dc3980, 24) = -1 ENOSYS (Function not 
> implemented)

The regression was introduced by commit 371b8044 ("powerpc/64s: 
Initialize ISAv3 MMU registers before setting partition table").

The problem is Radix MMU specific (does not occur with 'disable_radix'),
and does not occur with that code reverted (ie do not set PIDR to zero).

Do you see any reasons why?
(wondering if at all related to access_ok() in include/asm/uaccess.h)

with:

     # strace -e set_robust_list -f ./test
     set_robust_list(0x7fffa4b03910, 24)     = -1 ENOSYS (Function not 
implemented)
     +++ exited with 1 +++

     # uname -r
     4.15.0

without:

     # strace -e set_robust_list -f ./test
     set_robust_list(0x7fff889c3910, 24)     = 0
     +++ exited with 0 +++

     # uname -r
     4.15.0.nopidr
