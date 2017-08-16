Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXSlf213xzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:07:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/17] powerpc/vas: Define macros,
 register fields and structures
In-Reply-To: <20170814191409.GA24096@us.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <877ey6sp03.fsf@concordia.ellerman.id.au>
 <20170814160522.4f9b517a@roar.ozlabs.ibm.com>
 <20170814191409.GA24096@us.ibm.com>
Date: Wed, 16 Aug 2017 22:07:38 +1000
Message-ID: <87ziazsol1.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Nicholas Piggin [npiggin@gmail.com] wrote:
>> On Mon, 14 Aug 2017 15:21:48 +1000
>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> 
>> > Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> 
>> > >  arch/powerpc/include/asm/vas.h       |  35 ++++
>> > >  arch/powerpc/include/uapi/asm/vas.h  |  25 +++  
>> > 
>> > I thought we weren't exposing VAS to userspace yet?
>> > 
>> > If we are then we need to get things straight WRT copy/paste abort.
...
>
> In the FTW case, there is no data transfer from user space to the hardware.
> i.e the copy/paste submit a NULL CRB and hardware will be configured (see
> ->fifo_disable setting in winctx) to ignore any data they specify in the CRB.

I thought the copy did copy a cacheline, but then the paste to the VAS
window just ignores the contents, and doesn't allow userspace to get the
content in any way?

Which means we have two thirds of a covert channel, ie. something can be
copied into the copy buffer by one process, and then a second process
can paste it, but because it can only paste to foreign memory, and the
only foreign memory it can get is a VAS FTW window, it can't actually
see the content of the copy buffer.

> Would we be able to allow copy/paste from user space in that case?

Yeah I think so, but it is all a bit fragile.

cheers
