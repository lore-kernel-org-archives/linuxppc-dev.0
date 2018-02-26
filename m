Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqb5p28XxzF1T6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 19:46:22 +1100 (AEDT)
Date: Mon, 26 Feb 2018 02:46:02 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Mathieu Malaterre <malat@debian.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
Message-ID: <20180226084602.GR21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
 <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 07:32:03AM +0100, Christophe LEROY wrote:
> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
> >-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < 
> >max_mapnr)
> >+#define pfn_valid(pfn) \
> >+		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
> 
> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than 
> ARCH_PFN_OFFSET ?

It will work fine.

Say you are asking for  a <= x < b  so (in actual integers, no overflow)
that is  0 <= x-a < b-a  and you also assume x-a overflows, so that we
are actually comparing  x-a+M < b-a  with M = 2**32 or such (the maximum
value in the unsigned integer type plus one).  This comparison is
obviously always false.

(It also works if b < a btw).


Segher
