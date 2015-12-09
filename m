Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 022D61A1043
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 11:17:13 +1100 (AEDT)
Message-ID: <1449620232.6028.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/opal: add warning for unimplemented OPAL
 message type
From: Michael Ellerman <mpe@ellerman.id.au>
To: "wen.pu@powercore.com.cn" <wen.pu@powercore.com.cn>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 09 Dec 2015 11:17:12 +1100
In-Reply-To: <20151208153012239673106@powercore.com.cn>
References: <20151208153012239673106@powercore.com.cn>
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

Hi Wen,

Thanks for the patch.

On Tue, 2015-12-08 at 15:30 +0800, wen.pu@powercore.com.cn wrote:
> I found that there are unimplemented OPAL message types "OPAL_MSG_EPOW" and 
> "OPAL_MSG_DPO" in PowerNV Platform. If skiboot send such messages to kernel, 
> nothing will happen(notifier_call_chain() will silently drop it). So I add a warning 
> to inform what has happened, is it necessary? 

What kernel version are you using?

Looking at mainline (4.4-rc4), I do see handlers registered for EPOW and DPO:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/powernv/opal-power.c?#n82

That code was merged in 4.3.


In general I don't think we want to warn for unhandled message types, because
we support old kernels running on new skiboot. In that case if we warned on
every unhandled message we'd potentially spam the console with warnings.

But perhaps we can come up with something smarter, that only warns once for
each unhandled message type, or something like that? Did you have a bug that
would have been easier to debug with a warning here?

cheers
