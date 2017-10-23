Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLPh24yJ1zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 05:14:58 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NID8CY007084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 14:14:54 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsjy2y97w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 14:14:54 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 12:14:53 -0600
Date: Mon, 23 Oct 2017 11:14:45 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
 <87po9e8alz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87po9e8alz.fsf@linux.vnet.ibm.com>
Message-Id: <20171023181445.GD5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 23, 2017 at 03:11:28PM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Total 32 keys are available on power7 and above. However
> > pkey 0,1 are reserved. So effectively we  have  30 pkeys.
> 
> When you say reserved, reserved by whom? Is that part of ISA or PAPR ?
> Also do you expect that to change. If not why all these indirection?
> Can we have the mask as a #define for 4K and 64K page size
> config?

The reserved keys cannot be determined
statically. It depends on the platform and the key info exported to us
by the device-tree.  Hence it cannot be macro'd.

One of the subsequent patch, reads the device tree and sets pkeys_total
appropriately. FYI.

BTW: key 0 is reserved by the ISA.  key 1 is reserved, but its nebulous.
There is a programming note in the ISA to avoid key 1. Also testing
and experimentation with key 1 lead to unpredicatable behavior on
powervm. Key 31 may or may not be used by the hypervisor. The device
tree has to be referred to determine that.

Bottomline, the mask can be determined only during runtime.

RP
