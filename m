Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBD5v1PxCzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 21:35:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: Default to enabling STRICT_KERNEL_RWX
In-Reply-To: <20171005190317.GA98302@beast>
References: <20171005190317.GA98302@beast>
Date: Tue, 10 Oct 2017 21:35:30 +1100
Message-ID: <87infnwarx.fsf@concordia.ellerman.id.au>
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

Kees Cook <keescook@chromium.org> writes:

> When available, CONFIG_KERNEL_RWX should be default-enabled for PPC64.
> On PPC32, there is a performance trade-off.

Thanks for prodding us. But I think we need some more test cycles on
this before we make it the default.

As Balbir said it's currently not compatible with RELOCATABLE, which
means most folks aren't enabling it.

We also don't have good numbers on what the performance impact is on
64-bit. So although it almost certainly should be the default in future,
I'd still like us to have some idea of what it's costing us.

I'll try and get some perf numbers.

cheers
