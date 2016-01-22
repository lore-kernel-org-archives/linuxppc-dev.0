Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B73E11A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 10:44:00 +1100 (AEDT)
Date: Fri, 22 Jan 2016 15:43:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org,
 mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz,
 rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in
 kallsyms address table
Message-Id: <20160122154358.e6491d6a963747b449731eb9@linux-foundation.org>
In-Reply-To: <20160122153428.8422f42877c7707dbcba0259@linux-foundation.org>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160122153428.8422f42877c7707dbcba0259@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 22 Jan 2016 15:34:28 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > Support for the above is enabled by default for all architectures except
> > IA-64, whose symbols are too far apart to capture in this manner.
> 
> scripts/kallsyms.c: In function 'record_relative_base':
> scripts/kallsyms.c:744: error: 'ULLONG_MAX' undeclared (first use in this function)
> scripts/kallsyms.c:744: error: (Each undeclared identifier is reported only once
> scripts/kallsyms.c:744: error: for each function it appears in.)
> 
> That's with (ancient) glibc-headers-2.5-3.  It appears that limits.h's
> ULLONG_MAX requires "#ifdef __USE_ISOC99".  I'm not sure what's the
> correct way of turning this on.

Actually, how about we replace it with -1ULL and get on with life.
