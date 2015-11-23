Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B06A1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:22:06 +1100 (AEDT)
Message-ID: <1448320926.3018.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Standardise on NR_syscalls rather than
 __NR_syscalls.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Rashmica Gupta
 <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Nov 2015 10:22:06 +1100
In-Reply-To: <5652B0CE.40704@linux.vnet.ibm.com>
References: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
 <5652B0CE.40704@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-23 at 11:53 +0530, Anshuman Khandual wrote:

> On 11/19/2015 11:34 AM, Rashmica Gupta wrote:

> > Most architectures use NR_syscalls as the #define for the number of syscalls.
> > 
> > We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.
> > 
> > __NR_syscalls is not used outside arch code, whereas NR_syscalls is. So as
> > NR_syscalls must be defined and __NR_syscalls does not, replace __NR_syscalls
> > with NR_syscalls.
> > 
> > Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> > 
> > diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
> > index 6d8f8023ac27..05bf34296144 100644
> > --- a/arch/powerpc/include/asm/unistd.h
> > +++ b/arch/powerpc/include/asm/unistd.h
> > @@ -12,10 +12,9 @@
> >  #include <uapi/asm/unistd.h>
> >  
> >  
> > -#define __NR_syscalls		378
> > +#define NR_syscalls		378
> 
> This does not apply any more because of Michael's recent mlock2() system
> call enablement commit. Please do rebase and resend.

That's fine, I can fix up trivial conflicts like that myself.

cheers
