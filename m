Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72D7C1A06F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:23:29 +1100 (AEDT)
Date: Wed, 26 Nov 2014 17:23:18 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
Message-ID: <20141126232318.GA6567@gate.crashing.org>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417041497.12952.2.camel@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2014 at 09:38:17AM +1100, Michael Ellerman wrote:
> On Thu, 2014-11-27 at 08:11 +1100, Anton Blanchard wrote:
> > I used some 64 bit instructions when adding the 32 bit getcpu VDSO
> > function. Fix it.
> 
> Ouch. The symptom is a SIGILL I presume?
> 
> Could we catch this by forcing -m32 in the CFLAGS for vdso32 ?

GCC has added -many to the assembler flags for over ten years now, so
no that will not work.  You can use -mppc or similar with the assembler
if you invoke it correctly (use  $(CC) -print-prog-name=as  to figure
out how to call the assembler, if you want to stay sane and use the
same one as the rest of the toolchain you use).


Segher
