Return-Path: <baruch@tkos.co.il>
Received: from mx.tkos.co.il (guitar.tcltek.co.il [192.115.133.116])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlRPQ1tWxzDqxF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 15:43:38 +1000 (AEST)
Date: Thu, 7 Jul 2016 08:37:10 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 kernel-hardening@lists.openwall.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
 Christoph Lameter <cl@linux.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PaX Team <pageexec@freemail.hu>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>,
 Vitaly Wool <vitalywool@gmail.com>, David Rientjes <rientjes@google.com>,
 Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 Brad Spengler <spender@grsecurity.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Pekka Enberg <penberg@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/9] mm: Hardened usercopy
Message-ID: <20160707053710.GH2118@tarshish>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467843928-29351-2-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kees,

On Wed, Jul 06, 2016 at 03:25:20PM -0700, Kees Cook wrote:
> +#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR

Should be CONFIG_HARDENED_USERCOPY to match the slab/slub implementation 
condition.

> +const char *__check_heap_object(const void *ptr, unsigned long n,
> +				struct page *page);
> +#else
> +static inline const char *__check_heap_object(const void *ptr,
> +					      unsigned long n,
> +					      struct page *page)
> +{
> +	return NULL;
> +}
> +#endif

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
