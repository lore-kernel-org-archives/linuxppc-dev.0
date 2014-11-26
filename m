Return-Path: <bergner@vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E40981A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 15:22:12 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Wed, 26 Nov 2014 18:50:33 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D1693C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 18:42:33 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQNoT1920250676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 23:50:29 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQNoTKj011883
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 18:50:29 -0500
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
From: Peter Bergner <bergner@vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <1417041497.12952.2.camel@concordia>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 Nov 2014 17:50:27 -0600
Message-ID: <1417045827.16862.32.camel@otta>
Mime-Version: 1.0
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

On Thu, 2014-11-27 at 09:38 +1100, Michael Ellerman wrote:
> On Thu, 2014-11-27 at 08:11 +1100, Anton Blanchard wrote:
> > I used some 64 bit instructions when adding the 32 bit getcpu VDSO
> > function. Fix it.
> 
> Ouch. The symptom is a SIGILL I presume?

Nope, you don't get a SIGILL when executing 64-bit instructions in
32-bit mode, so it'll happily just execute the instruction, doing
a full 64-bit compare.  I'm guessing that the upper 32-bits of both
r3 and r4 contain zeros, so we're probably just getting lucky.


> Could we catch this by forcing -m32 in the CFLAGS for vdso32 ?

As Segher mentioned, GCC passing -many down to the assembler means
-m32 won't help.  It was due to Anton disabling that gcc "feature",
that this was caught.

Peter
