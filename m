Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411KKm6lz1zF31L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 06:00:44 +1000 (AEST)
Date: Wed, 6 Jun 2018 15:00:20 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 2/4] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20180606200020.GT17342@gate.crashing.org>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-3-git-send-email-wei.guo.simon@gmail.com>
 <20180528110558.GZ17342@gate.crashing.org>
 <20180530081402.GB5951@simonLocalRHEL7.x64>
 <20180530083540.GG17342@gate.crashing.org>
 <20180530090321.GE5951@simonLocalRHEL7.x64>
 <20180606064227.GB7342@simonLocalRHEL7.x64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180606064227.GB7342@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2018 at 02:42:27PM +0800, Simon Guo wrote:
> I now felt unformatable to use mcrf like:
> mcrf    7,0
> 
> since I cannot 100% confident that compiler will not use CR7 or other
> CR# in exit_vmx_ops().

It wasn't clear to me this macro boils down to a function call.

You can use CR2,CR3,CR4, but you'll need to save and restore those at
the start and end of function then, which is just as nasty.

Better is to restructure some code so you don't need that CR field
there anymore.

> Can we switch back to mfocrf/mtocrf with correct CR0 value?
>        mfocrf  r5,128
>         ...
>        mtocrf  128,r5

Sure, I'm not your boss ;-)  It seems a shame to me to have this 12 or
whatever cycle delay here, since the whole point of the patch is to
make things faster, that's all (but it still is faster, right, you
tested it).


Segher
