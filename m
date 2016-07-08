Return-Path: <cl@linux.com>
Received: from resqmta-ch2-07v.sys.comcast.net
 (resqmta-ch2-07v.sys.comcast.net [69.252.207.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmKY81cL3zDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 02:23:23 +1000 (AEST)
Date: Fri, 8 Jul 2016 11:20:47 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Kees Cook <keescook@chromium.org>
cc: Michael Ellerman <mpe@ellerman.id.au>,
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
In-Reply-To: <CAGXu5jKE=h32tHVLsDeaPN1GfC+BB3YbFvC+5TE5TK1oR-xU3A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607081119170.6192@east.gentwo.org>
References: <577f7e55.4668420a.84f17.5cb9SMTPIN_ADDED_MISSING@mx.google.com>
 <alpine.DEB.2.20.1607080844370.3379@east.gentwo.org>
 <CAGXu5jKE=h32tHVLsDeaPN1GfC+BB3YbFvC+5TE5TK1oR-xU3A@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 8 Jul 2016, Kees Cook wrote:

> Is check_valid_pointer() making sure the pointer is within the usable
> size? It seemed like it was checking that it was within the slub
> object (checks against s->size, wants it above base after moving
> pointer to include redzone, etc).

check_valid_pointer verifies that a pointer is pointing to the start of an
object. It is used to verify the internal points that SLUB used and
should not be modified to do anything different.
