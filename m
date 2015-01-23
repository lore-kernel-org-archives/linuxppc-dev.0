Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31ACE1A0EA9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 13:47:19 +1100 (AEDT)
Message-ID: <1421981238.24984.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: fix endian problems with LE migration
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>
Date: Fri, 23 Jan 2015 13:47:18 +1100
In-Reply-To: <1421905054.2865.8.camel@cyril>
References: <1421807520-12030-1-git-send-email-cyrilbur@gmail.com>
 <1421811226.4900.3.camel@ellerman.id.au> <1421905054.2865.8.camel@cyril>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-22 at 16:37 +1100, Cyril Bur wrote:
> On Wed, 2015-01-21 at 14:33 +1100, Michael Ellerman wrote:
> > On Wed, 2015-01-21 at 13:32 +1100, Cyril Bur wrote:
> > > The need to handle ibm,suspend_me specially from within ppc_rtas has left an
> > > endian bug exposed as rtas_ibm_suspend_me actually performs HCALLs and should
> > > have its params in CPU endian.
> > 
> > That needs a much better explanation.

> I've tried to write that out neatly and orderly. Here's how that went:

Yep that's much better.

Minor points of style that I like are to use "()" on functions to make it
clear, eg. ppc_rtas(), and to put strings in quotes, eg. "ibm,suspend_me".

I've fixed it up and incorporated your testing notes, end result is:

Author: cyrilbur@gmail.com <cyrilbur@gmail.com>
Date:   Wed Jan 21 13:32:00 2015 +1100

    powerpc/pseries: Fix endian problems with LE migration
    
    RTAS events require arguments be passed in big endian while hypercalls
    have their arguments passed in registers and the values should therefore
    be in CPU endian.
    
    The "ibm,suspend_me" 'RTAS' call makes a sequence of hypercalls to setup
    one true RTAS call. This means that "ibm,suspend_me" is handled
    specially in the ppc_rtas() syscall.
    
    The ppc_rtas() syscall has its arguments in big endian and can therefore
    pass these arguments directly to the RTAS call. "ibm,suspend_me" is
    handled specially from within ppc_rtas() (by calling rtas_ibm_suspend_me())
    which has left an endian bug on little endian systems due to the
    requirement of hypercalls. The return value from rtas_ibm_suspend_me()
    gets returned in cpu endian, and is left unconverted, also a bug on
    little endian systems.
    
    rtas_ibm_suspend_me() does not actually make use of the rtas_args that
    it is passed. This patch removes the convoluted use of the rtas_args
    struct to pass params to rtas_ibm_suspend_me() in favour of passing what
    it needs as actual arguments. This patch also ensures the two callers of
    rtas_ibm_suspend_me() pass function parameters in cpu endian and in the
    case of ppc_rtas(), converts the return value.
    
    migrate_store() (the other caller of rtas_ibm_suspend_me()) is from a
    sysfs file which deals with everything in cpu endian so this function
    only underwent cleanup.
    
    This patch has been tested with KVM both LE and BE and on PowerVM both
    LE and BE. Under QEMU/KVM the migration happens without touching these
    code pathes.
    
    For PowerVM there is no obvious regression on BE and the LE code path
    now provides the correct parameters to the hypervisor.
    
    Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
