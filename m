Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYxh2382bzDqgr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 07:54:42 +1000 (AEST)
Message-ID: <1503093260.5164.11.camel@kernel.crashing.org>
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org
Date: Sat, 19 Aug 2017 07:54:20 +1000
In-Reply-To: <20170818170410.GC5545@ram.oc3035372033.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com>
 <87a836csdl.fsf@concordia.ellerman.id.au>
 <20170817171408.GF5505@ram.oc3035372033.ibm.com>
 <878tihqy5c.fsf@concordia.ellerman.id.au>
 <20170818170410.GC5545@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-18 at 10:04 -0700, Ram Pai wrote:
> Assume two threads of a task.
> 
> T1:  mprotect_key(foo, PAGE_SIZE, pkey=4);
> T1:  set AMR to disable access for pkey 4;
> T1:  key fault
>     T2: set AMR to enable access to pkey 4;
> T1:  fault handler called.
>         This fault handler will see the new AMR and not the
>         one at the time of the fault.

You aren't context switching AMR with the threads ? Ugh... something is
very wrong then.

Ben.
