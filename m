Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19E556816B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 10:56:51 +1000 (EST)
Date: Wed, 7 Sep 2005 21:51:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050908005135.GA8882@dmt.cnet>
References: <20050907230324.GC7513@dmt.cnet> <1126139332.29803.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126139332.29803.0.camel@gaston>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 08, 2005 at 10:28:52AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2005-09-07 at 20:03 -0300, Marcelo Tosatti wrote:
> > Hi,
> > 
> > The following patch adds big endian version of ld_/st_ macros 
> > and converts core 8xx code to use them.
> > 
> > Other than making IO accesses explicit (which is a plus for
> > readability), a common set of macros provides a unified place for the
> > volatile flag to constraint compiler code reordering.
> > 
> > There are several unlucky places at the moment which lack the 
> > volatile flag.
> 
> I'm not fan of the approach. You should use in_/out_ macros for IOs. If
> you don't need eieio on 8xx , then just #ifdef it out of the
> implementation of these.

The reason for that is that in_/out_ are supposed to be the standard 
IO macros (conformance)? In practice most drivers using the std macros
can benefit from the change. 

A common routine is shared by all architectures. Doing something like

/*
 * 8, 16 and 32 bit, big and little endian I/O operations, with barrier.
 */
extern inline int in_8(volatile unsigned char __iomem *addr)
{
        int ret;

        __asm__ __volatile__(
                "lbz%U1%X1 %0,%1;\n"
#ifndef CONFIG_8xx
                "twi 0,%0,0;\n"
                "isync" : "=r" (ret) : "m" (*addr));
#else
                : "=r" (ret) : "m" (*addr));
#endif
        return ret;
}

Seems somewhat ugly?
