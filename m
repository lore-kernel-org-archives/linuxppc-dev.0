Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 123B81A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 17:27:39 +1000 (AEST)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28CA514028E
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 17:27:37 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 03:27:35 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6FAF138C804F
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 03:27:31 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t697RVmC49152050
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2015 07:27:31 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t697RVvq005027
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2015 03:27:31 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 2/2] powerpc/kexec: Reset HILE before kexec_sequence
In-Reply-To: <1436406020.18682.1.camel@ellerman.id.au>
References: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
 <1436330233-28489-2-git-send-email-sam.mj@au1.ibm.com>
 <1436333865.17490.4.camel@ellerman.id.au>
 <m3fv4z16sj.fsf@oc8180480414.ibm.com>
 <1436406020.18682.1.camel@ellerman.id.au>
Date: Thu, 09 Jul 2015 17:26:58 +1000
Message-ID: <m3zj35zt8d.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
>> > I think a better API would be that opal_return_cpu() deals with this under the
>> > covers. I think we talked about that, so maybe there was some reason that
>> > wasn't possible.
>> 
>> opal_return_cpu() acts on current CPU which if we started flipping HILE
>> there we'd hit PowerISA 2.07 Section 2.11:
>> "The contents of the HILE bit must be the same for all
>> threads under the control of a given instance of the
>> hypervisor; otherwise all results are undefined."
>> 
>> so we'd have to do something kind of funny in opal_return_cpu() to work
>> out what's going on. Keeping in mind that opal_return_cpu() is also used
>> in the fsp code update path (which I haven't gone and really looked at
>> in this context though).
>> 
>> I'm not convinced that opal_return_cpu() doing the HILE switch is
>> safe when we'd be relying on the kernel to pretty much do this all at
>> the same time (when we really have opal_reinit_cpus to do that)
>
> Yeah I agree.
>
> What I meant is that after you return a cpu to OPAL, when you (or actually
> someone else) restart it, at that point it should be put into a well defined
> state, including HILE.

I'll go and try and investigate exactly what's going on here with the
hardware, it's possible some of the hardware documentation is Anton
Blanchard and that needs to make it into documents rather than just
skiboot source. Especially around what makes sense for all-at-a-time
(reinit_cpu with HILE switch) versus one at a time (start
cpu/return_cpu).

Of course, that's a skiboot problem rather than a Linux one.

I think Sam is looking at doing the opal call in real mode somewhere in
kexec_sequence just before we jump into the new kernel. This should make
it so that everything works on existing OPAL APIs, while at the same
time we can go and check if there's a sensible/valid way we can deal
with the hardware to get a broader well defined state after certain
calls.

I'm in favor of using existing calls rather than making a firmware
upgrade a requirement though.
