Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt6S423S4zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 00:25:08 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LEOKGP141137
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 10:25:05 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7t1y9nru-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 10:25:05 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 08:25:04 -0600
Subject: Re: [PATCH V6 1/2] powerpc/hotplug: Ensure enough nodes avail for
 operations
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Rashmica Gupta <rashmicy@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <b506c509-45c3-fc17-9b83-24b30110748b@linux.vnet.ibm.com>
 <878tklu0pw.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 09:24:59 -0500
MIME-Version: 1.0
In-Reply-To: <878tklu0pw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <75a86b88-ae0c-93c1-dade-85d5e8315610@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/21/2017 04:52 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU
>> or memory resources, it may occur that the new resources are to be
>> inserted into nodes that were not used for these resources at bootup.
>> In the kernel, any node that is used must be defined and initialized
>> at boot.  In order to meet both needs, this patch adds a new kernel
>> command line option (numnodes=<int>) for use by the PowerPC architecture-
> 
> Sorry, that's a hack.

It is an intermediate step pending the provision of the firmware properties
under discussion that were mentioned by Nathan Fontenot last week.

> I thought you were going to use firmware properties to find the set of
> possible nodes. Did that not work?

Inference based on the current set of firmware properties for associativity
is insufficient.  That is partly the reason for the properties mentioned by
Nathan last week.  The current firmware properties only cover what is known
at boot time.  They do not cover expansions from DLPAR / hot-add operations
which can add up to everything else on the system.

> cheers

Regards,

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
