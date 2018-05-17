Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mtv23pC1zF28B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 00:27:58 +1000 (AEST)
Date: Thu, 17 May 2018 09:27:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/32be: use stmw/lmw for registers
 save/restore in asm
Message-ID: <20180517142732.GU17342@gate.crashing.org>
References: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
 <a94e38e1dbe0c38ce5b363fac29ab6e65fd9985a.1523984745.git.christophe.leroy@c-s.fr>
 <87zi0ymqj6.fsf@concordia.ellerman.id.au>
 <20180517131550.GR17342@gate.crashing.org>
 <74ce3f30-6c06-e884-f1ea-1539edbf1a74@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <74ce3f30-6c06-e884-f1ea-1539edbf1a74@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 17, 2018 at 03:27:37PM +0200, Christophe LEROY wrote:
> Le 17/05/2018 à 15:15, Segher Boessenkool a écrit :
> >>I guess we've been enabling this for all 32-bit targets for ever so it
> >>must be a reasonable option.
> >
> >On 603, load multiple (and string) are one cycle slower than doing all the
> >loads separately, and store is essentially the same as separate stores.
> >On 7xx and 7xxx both loads and stores are one cycle slower as multiple
> >than as separate insns.
> 
> That's in theory when the instructions are already in the cache.
> 
> But loading several instructions into the cache takes time.

Yes, of course, that's why I wrote:

> >load/store multiple are nice for saving/storing registers.

:-)


Segher
