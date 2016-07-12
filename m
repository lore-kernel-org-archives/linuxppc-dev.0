Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpTFP4JvnzDqyM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 14:17:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Enable VMX crypto
In-Reply-To: <20160712094149.21a28e0d@kryten>
References: <1468279521-9720-1-git-send-email-anton@ozlabs.org>
 <20160712093317.0c3ab74e@canb.auug.org.au> <20160712094149.21a28e0d@kryten>
Date: Tue, 12 Jul 2016 14:17:11 +1000
Message-ID: <87bn23cwxk.fsf@@concordia.ellerman.id.au>
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

Anton Blanchard <anton@samba.org> writes:

> Hi Steven,
>
>> Not in ppc64_defconfig?
>
> Good point. The recent addition of powernv_defconfig made me forget
> about ppc64_defconfig. We could do with some rationalisation here.

Understatement of the century.

> pseries isn't really pseries, perhaps we should call it ibm_defconfig,
> or maybe server_deconfig.

pseries should be just pseries, and nothing else.

> ppc64_defconfig continues to be the lower end defconfig.

ppc64_defconfig *should* be the primary config. And similarly ppc64le
when building little endian.

The reason being that 'make defconfig' will give you one of those
depending on uname (when building native).

I think the only thing disqualifying it from that role at the moment is
that it builds 4K pages.

But I think we should just change that. We can add ppc64_4K_defconfig
for anyone who wants it (G5 users mainly I would guess).

We'd also need to make sure ppc64/ppc64le have all the modern options
enabled.

cheers
