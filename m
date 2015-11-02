Return-Path: <linuxram@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AC9D1A0CC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 05:41:29 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 2 Nov 2015 11:41:26 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8844F19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 11:29:32 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2IfNXn32964626
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 11:41:23 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2IfL2X014933
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 11:41:23 -0700
Date: Mon, 2 Nov 2015 10:41:17 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, nacc@us.ibm.com,
 Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH] nx-842: Ignore bit 3 of condition register returned by
 icswx
Message-ID: <20151102184117.GC22547@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20151030223120.GA22550@ram.oc3035372033.ibm.com>
 <1446427416.31303.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446427416.31303.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 02, 2015 at 12:23:36PM +1100, Michael Ellerman wrote:
> On Fri, 2015-10-30 at 15:31 -0700, Ram Pai wrote:
> > icswx occasionally under heavy load sets bit 3 of condition register 0.
> 
> Why?

The hardware manual says that bit is undefined, though it is set under some conditions.

> 
> Also you seem to be using IBM bit numbering, so please be explicit about that,
> or use normal bit numbering.

Ok. 


> 
> > It has no software implication.
> 
> What does it mean? You might be right but you don't give me enough info to
> decide.

The software is not supposed to interpret the bit since its meaning is
undefined. 

> 
> > Currently that bit is interpreted by the driver as a failure, when
> > it should have calmly ignored it.
> 
> Should the fix be in icswx or the driver? Please justify your choice.

Yes there are two solutions. One is icswx macro should not expose that
bit to its consumers.  Or the driver/consumers can ignore that bit.  I
think it makes more sense to contain it in one place, which is icswx
instruction. Drivers or whoever calls icswx should not know
more than what they need to know. This patch uses the first approach.

> 
> This sounds like it's fixing a bug so shouldn't the patch go to stable? And if
> so which version(s) should it apply to?

It should go to stable v4.2.  I will tag it to stable, in my next
version.

RP
