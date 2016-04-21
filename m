Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrDg01FrwzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:56:43 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Always use STRICT_MM_TYPECHECKS
Date: Thu, 21 Apr 2016 11:56:21 +0200
Message-ID: <4231376.YDJ7xlGR0L@wuerfel>
In-Reply-To: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
References: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 21 April 2016 13:37:59 Michael Ellerman wrote:
> Testing done by Paul Mackerras has shown that with a modern compiler
> there is no negative effect on code generation from enabling
> STRICT_MM_TYPECHECKS.
> 
> So remove the option, and always use the strict type definitions.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 

I recently ran into the same thing on ARM and have checked the history
on the symbol. It seems that some architectures cannot pass structures
in registers as function arguments, but powerpc can, so it was never
needed in the first place.

	Arnd
