Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy6wr4kJ0zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 22:00:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
In-Reply-To: <20170330071613.GE4762@naverao1-tp.localdomain>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <87mvc6b575.fsf@concordia.ellerman.id.au>
 <20170328102109.GC4762@naverao1-tp.localdomain>
 <87a884jow3.fsf@concordia.ellerman.id.au>
 <20170330071613.GE4762@naverao1-tp.localdomain>
Date: Tue, 04 Apr 2017 22:00:07 +1000
Message-ID: <874ly4v0vs.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> (generic) is with Matt's arch-independent patches applied. Profiling 
> indicates that most of the overhead is actually with the lzo 
> decompression...
>
> Also, with a simple module to memset64() a 1GB vmalloc'ed buffer, here 
> are the results:
> generic:	0.245315533 seconds time elapsed	( +-  1.83% )
> optimized:	0.169282701 seconds time elapsed	( +-  1.96% )

Great, that's pretty conclusive.

I'm pretty sure I can take these 2 patches independently of Matt's
series, they just won't be used by much until his series goes in, so
I'll do that unless someone yells.

cheers
