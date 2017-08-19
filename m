Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZCt01mDKzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 18:34:15 +1000 (AEST)
Message-ID: <1503131026.12059.5.camel@kernel.crashing.org>
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org
Date: Sat, 19 Aug 2017 18:23:46 +1000
In-Reply-To: <20170818224957.GA5565@ram.oc3035372033.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com>
 <87a836csdl.fsf@concordia.ellerman.id.au>
 <20170817171408.GF5505@ram.oc3035372033.ibm.com>
 <878tihqy5c.fsf@concordia.ellerman.id.au>
 <20170818170410.GC5545@ram.oc3035372033.ibm.com>
 <20170818224957.GA5565@ram.oc3035372033.ibm.com>
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

On Fri, 2017-08-18 at 15:49 -0700, Ram Pai wrote:
> Coming back to the your main question, "why we need to provide the
> contents of AMR register to the signal handler?" --   the only reason
> i can see is, probably tools like gdb and ptrace may find it useful.
> 
> And since it was suggested that content of IAMR is also useful to the
> application, the value of which cannot be accessed from userspace,
> it may make sense to provide both the contents.

I'd rather you added ptrace calls to obtain & set it. I don't think we
need to touch the signal frame, it's too much of an ABI compatibility
burden.

Cheers,
Ben.
