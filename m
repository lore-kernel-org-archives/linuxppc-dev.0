Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B361B1A197E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 16:07:31 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 22:07:29 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BC88D3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 22:07:25 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F57PmK32702502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 05:07:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F55wg6032619
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 00:07:25 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V3] powerpc/powernv: Add a kmsg_dumper that flushes console
 output on panic
In-Reply-To: <1452600325.20985.4.camel@ellerman.id.au>
References: <20160111091402.BDBAB1402DE@ozlabs.org>
 <87wprfea1n.fsf@linux.vnet.ibm.com> <1452572253.1433.4.camel@russell.cc>
 <1452600325.20985.4.camel@ellerman.id.au>
Date: Fri, 15 Jan 2016 15:59:56 +1100
Message-ID: <87a8o78mk3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
>> > > Applied to powerpc next, thanks.
>> > > 
>> > > https://git.kernel.org/powerpc/c/affddff69c55eb68969448f35f
>> > 
>> > The firmware interface changed slightly since this kernel patch[1], it
>> > added a parameter to OPAL_CONSOLE_FLUSH which accepted the terminal
>> > number to flush, theoretically allowing this to be plumbed into TTY
>> > layer or something too.
>> > 
>> > So, we'll either have to update this patch or replace it with an updated
>> > one.
>> > 
>> > [1] i'm pushing the accepted skiboot patch now.
>> > 
>> I'm working on an updated kernel patch to use the new parameter and additional
>> return values, so I suppose it's up to mpe whether or not this patch gets
>> merged now and another gets sent later to amend it, or if this patch gets
>> reverted in next and I can send a V4 adding the new stuff.
>
> Doh. I'd rather not revert it, unless we have to.
>
> Basically we're passing junk in r3, which skiboot is expecting to be the
> terminal number.

and skiboot will just return OPAL_PARAMETER and the kernel code ignores
the return value, so all will be *fine*. It may even work by accident sometimes.

> So running the current kernel code on the updated skiboot shouldn't crash and
> burn, it just won't actually work the way it's supposed to.

Right, it'll just do nothing.

> So my preference would be just an incremental patch ASAP to fix the kernel to
> do the right thing with the new interface.

I see that's merged now, which is great! Even if someone is bisecting
back, things will be fine too.

-- 
Stewart Smith
OPAL Architect, IBM.
