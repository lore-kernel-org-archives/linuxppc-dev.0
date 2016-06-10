Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQplL2r1XzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 14:16:30 +1000 (AEST)
Message-ID: <1465532189.26682.9.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh
 <bsingharora@gmail.com>, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 10 Jun 2016 14:16:29 +1000
In-Reply-To: <87oa7a8ica.fsf@skywalker.in.ibm.com>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
 <1461721589.3586.0.camel@kernel.crashing.org>
 <87mvofedtd.fsf@skywalker.in.ibm.com>
 <1465445571.2948.29.camel@kernel.crashing.org>
 <87oa7a8ica.fsf@skywalker.in.ibm.com>
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

On Thu, 2016-06-09 at 21:28 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > On Wed, 2016-04-27 at 12:30 +0530, Aneesh Kumar K.V wrote:
> 
> So how early can we call jump_label_init() ? What is the reason why we
> do the existing feature fixups in setup_system and not before that ?.
> The previous patch series did end up moving jump_label_init() to
> 
>  @@ -250,6 +250,8 @@ void __init early_setup(unsigned long dt_ptr)
>          /* Initialize lockdep early or else spinlocks will blow */
>          lockdep_init();
> 
>  	jump_label_init();
> 
>         /* -------- printk is now safe to use ------- */
> 
> is that safe to do ?
 
Maybe. Maybe not.

It depends what that function does. It might work now, but it could break later
when someone changes the jump label code, and it might work on some platforms
but not others.

That is *really* early. We haven't looked at the device tree yet, we haven't
even enabled early debug.

So I'd rather we did it later, but that has other issues I guess.

cheers
