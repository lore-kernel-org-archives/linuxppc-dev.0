Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFzvW4QXFzDqVq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 05:37:59 +1000 (AEST)
Date: Thu, 26 May 2016 14:37:28 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Align hot loops of some string functions
Message-ID: <20160526193728.GA883@gate.crashing.org>
References: <20160526083813.0f96a454@kryten> <20160526083955.3f7deda4@kryten>
 <14a46745-dd1e-2963-1c1a-7daafa5aed4b@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14a46745-dd1e-2963-1c1a-7daafa5aed4b@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 26, 2016 at 09:24:51AM +0200, Christophe Leroy wrote:
> Wouldn't it be better to add nops before the function entry in order to 
> get the hot loop aligned, instead of adding nops in the middle of the 
> function ?

Why would that be better?  The nops are executed once per function call
in either case, there are the same number of nops in either case, and
on most CPUs nops aren't actually executed anyway (they are decoded and
the thrown away).


Segher
