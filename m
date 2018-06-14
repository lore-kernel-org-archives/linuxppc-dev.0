Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416HQw6y5RzF0tP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 07:52:24 +1000 (AEST)
Date: Thu, 14 Jun 2018 16:51:37 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180614215137.GB16221@gate.crashing.org>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
 <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr>
 <20180612145315.GJ27520@gate.crashing.org>
 <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2018 at 07:01:59PM +0200, Christophe LEROY wrote:
> 
> 
> Le 12/06/2018 à 16:53, Segher Boessenkool a écrit :
> >On Tue, Jun 12, 2018 at 09:14:53AM +0000, Christophe Leroy wrote:
> >>---
> >>Not tested on PPC64.
> >
> >It won't be acceptable until that happens.  It also is likely quite bad
> >performance on all 64-bit CPUs from the last fifteen years or so.  Or you
> >did nothing to prove otherwise, at least.
> 
> Will it be as bad as the generic implementation which does it byte per 
> byte ?

Probably not.  But how is it for short inputs, etc.?

The main point is that it needs actual testing _for correctness_.

Btw, GCC 7 and later can expand many memcmp as builtins on PowerPC (just
like memset and memcpy etc.), creating better code, without function call.


Segher
