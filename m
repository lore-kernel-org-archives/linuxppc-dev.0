Return-Path: <wen.pu@powercore.com.cn>
Received: from smtpbg64.qq.com (smtpbg64.qq.com [103.7.28.238])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D8F01A1045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 19:56:57 +1100 (AEDT)
From: Wen Pu <wen.pu@powercore.com.cn>
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/opal: add warning for unimplemented OPAL message
 type
Date: Wed, 09 Dec 2015 16:56:38 +0800
Message-ID: <2291635.sPXjXnnyi0@pw-vbox>
In-Reply-To: <1449620232.6028.5.camel@ellerman.id.au>
References: <20151208153012239673106@powercore.com.cn>
 <1449620232.6028.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wednesday, December 09, 2015 11:17:12 AM Michael Ellerman wrote:
> Hi Wen,
> 
> Thanks for the patch.
> 
> On Tue, 2015-12-08 at 15:30 +0800, wen.pu@powercore.com.cn wrote:
> > I found that there are unimplemented OPAL message types "OPAL_MSG_EPOW"
> > and
> > "OPAL_MSG_DPO" in PowerNV Platform. If skiboot send such messages to
> > kernel, nothing will happen(notifier_call_chain() will silently drop it).
> > So I add a warning to inform what has happened, is it necessary?
> 
> What kernel version are you using?
The kernel version is v4.2.1-openpower2, from the newest version at 
https://github.com/open-power/linux.

> 
> Looking at mainline (4.4-rc4), I do see handlers registered for EPOW and
> DPO:
> 
>  
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/p
> owerpc/platforms/powernv/opal-power.c?#n82
> 
> That code was merged in 4.3.
I do find that EPOW and DPO are registered in kernel 4.3. So maybe in the near 
future it will be merged into open-power/linux.

> 
> 
> In general I don't think we want to warn for unhandled message types,
> because we support old kernels running on new skiboot. In that case if we
> warned on every unhandled message we'd potentially spam the console with
> warnings.
> 
> But perhaps we can come up with something smarter, that only warns once for
> each unhandled message type, or something like that? Did you have a bug that
> would have been easier to debug with a warning here?
Yes, I think it is a good idea that only warns once, or warns every a few 
seconds. 
I found that EPOW and DPO only used in IBM FSP platform, not in Habanero 
platform that I had. So I modified the skiboot code and sent a EPOW/DPO message 
to kernel, and found that kernel warn nothing. I have no bug with a warning 
here, and just get a log message via dmesg.

> 
> cheers

Thanks!
Wen Pu
