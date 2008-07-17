Return-Path: <jreiser@BitWagon.com>
Received: from jade.aracnet.com (jade.aracnet.com [216.99.193.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB2BADDF84
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 09:44:07 +1000 (EST)
Message-ID: <487FD74C.4080603@BitWagon.com>
Date: Thu, 17 Jul 2008 16:35:40 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] elf loader support for auxvec base platform string
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>	<1216166331-14810-2-git-send-email-ntl@pobox.com>	<1216276539.7740.309.camel@pasglop>	<20080717000951.5f8cab37.akpm@linux-foundation.org>	<20080717221932.GL9594@localdomain>
	<20080717154218.8981035c.akpm@linux-foundation.org>
In-Reply-To: <20080717154218.8981035c.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, torvalds@linux-foundation.org,
	roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> On Thu, 17 Jul 2008 17:19:32 -0500
> Nathan Lynch <ntl@pobox.com> wrote:
> 
> 
>> [snip]
>> A new aux vector entry, AT_BASE_PLATFORM, will denote the actual hardware.
[snip]

> OK.
> 
> But it conflicts directly with the already-queued
> execve-filename-document-and-export-via-auxiliary-vector.patch

[snip]

It seems to me that most of the patch conflicts are mechanical
and could be merged mechanically.

However I believe that the documentation change to this comment is important:
-----
>  #ifdef __KERNEL__
> -#define AT_VECTOR_SIZE_BASE (14 + 2) /* NEW_AUX_ENT entries in auxiliary table */
> +#define AT_VECTOR_SIZE_BASE 17 /* NEW_AUX_ENT entries in auxiliary table */
> +  /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
>  #endif
-----
I scratched my head for a while to figure out that AT_NOTELF also was
a subtraction as far as AT_VECTOR_SIZE_BASE was concerned.


-- 
John Reiser, jreiser@BitWagon.com
