Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D92441A3CB6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 17:18:46 +1000 (AEST)
Message-ID: <1442819926.354.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Kconfig.cputype: Disallow TUNE_CELL on LE systems
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 boqun.feng@gmail.com
Date: Mon, 21 Sep 2015 17:18:46 +1000
In-Reply-To: <1442585820-18623-1-git-send-email-thuth@redhat.com>
References: <1442585820-18623-1-git-send-email-thuth@redhat.com>
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

On Fri, 2015-09-18 at 16:17 +0200, Thomas Huth wrote:
> It looks somewhat weird that you can enable TUNE_CELL on little
> endian systems, so let's disable this option with CPU_LITTLE_ENDIAN.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I first thought that it might be better to make this option depend
>  on PPC_CELL instead ... but I guess it's a bad idea to depend a
>  CPU option on a platform option? Alternatively, would it make
>  sense to make it depend on (GENERIC_CPU || CELL_CPU) instead?

Hmm, it's a little backward, but I think it would be fine, and less confusing
for users. Both PS3 and Cell select PPC_CELL, so it would work in both those
cases.

cheers
