Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGwsT4WbGzDrF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 13:26:05 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id y184so1799482pgd.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 19:26:04 -0700 (PDT)
Date: Wed, 18 Oct 2017 13:25:48 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
Message-ID: <20171018132548.1170ba58@firefly.ozlabs.ibm.com>
In-Reply-To: <20170818223655.GE5545@ram.oc3035372033.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com>
 <87a836csdl.fsf@concordia.ellerman.id.au>
 <20170817171408.GF5505@ram.oc3035372033.ibm.com>
 <878tihqy5c.fsf@concordia.ellerman.id.au>
 <20170818170410.GC5545@ram.oc3035372033.ibm.com>
 <1503093260.5164.11.camel@kernel.crashing.org>
 <20170818223655.GE5545@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 18 Aug 2017 15:36:55 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Sat, Aug 19, 2017 at 07:54:20AM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2017-08-18 at 10:04 -0700, Ram Pai wrote:  
> > > Assume two threads of a task.
> > > 
> > > T1:  mprotect_key(foo, PAGE_SIZE, pkey=4);
> > > T1:  set AMR to disable access for pkey 4;
> > > T1:  key fault
> > >     T2: set AMR to enable access to pkey 4;
> > > T1:  fault handler called.
> > >         This fault handler will see the new AMR and not the
> > >         one at the time of the fault.  
> > 
> > You aren't context switching AMR with the threads ? Ugh... something is
> > very wrong then.  
> 
> I do store and restore AMR accross context switch. So nevermind; the
> above problem cannot happen.
>

I think the assumption is that pkey_alloc() will do the right thing
while allocating keys across threads

Balbir Singh.
