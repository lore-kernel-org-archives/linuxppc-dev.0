Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E3D31A03F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 09:24:35 +1100 (AEDT)
Message-ID: <1446503074.31246.1.camel@ellerman.id.au>
Subject: Re: [PATCH] nx-842: Ignore bit 3 of condition register returned by
 icswx
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, nacc@us.ibm.com, Dan
 Streetman <ddstreet@ieee.org>
Date: Tue, 03 Nov 2015 09:24:34 +1100
In-Reply-To: <20151102184117.GC22547@ram.oc3035372033.ibm.com>
References: <20151030223120.GA22550@ram.oc3035372033.ibm.com>
 <1446427416.31303.1.camel@ellerman.id.au>
 <20151102184117.GC22547@ram.oc3035372033.ibm.com>
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

On Mon, 2015-11-02 at 10:41 -0800, Ram Pai wrote:
> On Mon, Nov 02, 2015 at 12:23:36PM +1100, Michael Ellerman wrote:
> > On Fri, 2015-10-30 at 15:31 -0700, Ram Pai wrote:
> > > icswx occasionally under heavy load sets bit 3 of condition register 0.
> >
> > Why?
>
> The hardware manual says that bit is undefined, though it is set under some
> conditions.

Which hardware manual?

Last I checked none of this was documented anywhere public. But the out of date
RFC I have does define bit zero to mean something.

> > > Currently that bit is interpreted by the driver as a failure, when
> > > it should have calmly ignored it.
> > 
> > Should the fix be in icswx or the driver? Please justify your choice.
> 
> Yes there are two solutions. One is icswx macro should not expose that
> bit to its consumers.  Or the driver/consumers can ignore that bit.  I
> think it makes more sense to contain it in one place, which is icswx
> instruction. Drivers or whoever calls icswx should not know
> more than what they need to know. This patch uses the first approach.

Yep, I'm fine with doing it in icswx if we're 100% sure the bit is always
undefined.

> > This sounds like it's fixing a bug so shouldn't the patch go to stable? And if
> > so which version(s) should it apply to?
> 
> It should go to stable v4.2.  I will tag it to stable, in my next version.

Thanks.

cheers
