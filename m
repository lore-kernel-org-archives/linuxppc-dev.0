Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C78DC1A0742
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 20:27:58 +1100 (AEDT)
Message-ID: <1445246877.30407.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/prom: Avoid reference to potentially freed
 memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Date: Mon, 19 Oct 2015 20:27:57 +1100
In-Reply-To: <1445031525-20086-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1444976055-19148-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <1445031525-20086-1-git-send-email-christophe.jaillet@wanadoo.fr>
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

On Fri, 2015-10-16 at 23:38 +0200, Christophe JAILLET wrote:

> of_get_property() is used inside the loop, but then the reference to the
> node is dropped before dereferencing the prop pointer, which could by then
> point to junk if the node has been freed.
> 
> Instead use of_property_read_u32() to actually read the property
> value before dropping the reference.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Fix missing '{'
> *** COMPILE-TESTED ONLY ***

Thanks, this looks good. I'll test it on real hardware.

Can you send me a follow up which does the of_get_next_parent() conversion?

cheers
