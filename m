Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf4845Q6WzDqwG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:58:28 +1000 (AEST)
In-Reply-To: <1467088857-14477-2-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, sjitindarsingh@gmail.com
Subject: Re: [V4,
 2/3] powerpc/opal: Add #define to get rc from an ASYNC_COMP opal_msg
Message-Id: <3rf48446rPz9sD5@ozlabs.org>
Date: Tue, 28 Jun 2016 21:58:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-28-06 at 04:40:56 UTC, Suraj Jitindar Singh wrote:
> An opal_msg of type OPAL_MSG_ASYNC_COMP contains the return code in the
> params[1] struct member. However this isn't intuitive or obvious when
> reading the code and requires that a user look at the skiboot
> documentation or opal-api.h to verify this.
> 
> Add a #define to get the return code from an opal_msg and update call
> sites accordingly.

Thanks for cleaning this up.

Two gripes though :)

>  arch/powerpc/include/asm/opal-api.h            | 4 ++++

opal-api.h is supposed to be a subset of the skiboot version.

So something like this should go in the kernel's opal.h, which has all the
kernel prototypes etc. which aren't part of the OPAL API. I think this routine
should fall under that.

> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 9bb8ddf..7433cf0 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -387,6 +387,10 @@ struct opal_msg {
>  	__be64 params[8];
>  };
>  
> +#define GET_OPAL_MSG_ASYNC_COMP_RC(msg)	(msg.msg_type == OPAL_MSG_ASYNC_COMP ? \
> +					be64_to_cpu(msg.params[1]) : \
> +					OPAL_PARAMETER)
> +

You forgot the 7th commandment!

 "Never use a #define when a static inline would work"

:)

A few reasons:
  - it's less shouty.
  - you get type checking.
  - you don't have to wrap lines with \
    etc.

cheers
