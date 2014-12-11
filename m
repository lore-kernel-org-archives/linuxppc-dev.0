Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0144.outbound.protection.outlook.com [157.56.111.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8681D1A011B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 11:07:32 +1100 (AEDT)
Message-ID: <1418256437.5581.51.camel@freescale.com>
Subject: Re: [PATCH 2/4] powerpc32: properly clear page table when 0 is not
 a good default PTE value
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 10 Dec 2014 18:07:17 -0600
In-Reply-To: <20141210180037.C46001A5D62@localhost.localdomain>
References: <20141210180037.C46001A5D62@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-10 at 19:00 +0100, Christophe Leroy wrote:
> Some HW invert some PTE bits. In some case, __pte(0) is not 0 so the PTEs shall
> be properly set prior to being used.

__pte(0) is always zero.  If that changes in a future patch, that patch
is not doing the right thing.  The __pte()/pte_val() accesors should not
do anything beyond boxing/unboxing the value in a struct.  The right
place for special 8xx handling of the inverted bit is in pte_mkwrite()
and such.

I don't see any other architecture using __pte()/pte_val() this way.

-Scott
