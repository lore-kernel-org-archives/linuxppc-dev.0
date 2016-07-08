Return-Path: <cl@linux.com>
Received: from resqmta-ch2-06v.sys.comcast.net
 (resqmta-ch2-06v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmGF070KNzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 23:54:12 +1000 (AEST)
Date: Fri, 8 Jul 2016 08:45:54 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Kees Cook <keescook@chromium.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Jan Kara <jack@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Linux-MM <linux-mm@kvack.org>,
 sparclinux <sparclinux@vger.kernel.org>, linux-ia64@vger.kernel.org,
 Andrea Arcangeli <aarcange@redhat.com>,
 linux-arch <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, PaX Team <pageexec@freemail.hu>,
 Borislav Petkov <bp@suse.de>, lin <ux-arm-kernel@lists.infradead.org>,
 Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Rik van Riel <riel@redhat.com>, David Rientjes <rientjes@google.com>,
 Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 Brad Spengler <spender@grsecurity.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 Case y Schauf ler <casey@schaufler-ca.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [kernel-hardening] Re: [PATCH 9/9] mm: SLUB hardened usercopy
 support
In-Reply-To: <577f7e55.4668420a.84f17.5cb9SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <alpine.DEB.2.20.1607080844370.3379@east.gentwo.org>
References: <577f7e55.4668420a.84f17.5cb9SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 8 Jul 2016, Michael Ellerman wrote:

> > I wonder if this code should be using size_from_object() instead of s->size?
>
> Hmm, not sure. Who's SLUB maintainer? :)

Me.

s->size is the size of the whole object including debugging info etc.
ksize() gives you the actual usable size of an object.
