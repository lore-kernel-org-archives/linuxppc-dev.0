Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAED61A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 22:12:49 +1100 (AEDT)
Message-ID: <54479130.5060904@ozlabs.org>
Date: Wed, 22 Oct 2014 19:12:48 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powernv: Use _GLOBAL_TOC for opal wrappers
References: <1413948772.62479.492398078454.1.gpush@pablo>
 <1413955870.9754.3.camel@concordia>
In-Reply-To: <1413955870.9754.3.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

>> Currently, we can't call opal wrappers from modules when using the LE
>> ABIv2, which requires a TOC init.
> 
> What happens if we try? Build failure or run time bug?

We'll get an arbitrary memory dereference (two, actually) in the opal
wrappers, when we try to load the opal entry point & return address from
the TOC, as r2 may not point to a valid TOC for the kernel.

>> This change uses the _GLOBAL_TOC() macro (rather than _GLOBAL) for the
>> opal wrappers, so that we can do non-local calls to them.
> 
> Are we doing that now, or we would like to?

We'd like to; although we do EXPORT_SYMBOL on another wrapper
(opal_invalid_call()) already. From the call name though, I figure it's
not in any mission-critical usage :)

Cheers,


Jeremy
