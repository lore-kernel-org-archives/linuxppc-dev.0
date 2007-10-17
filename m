Return-Path: <aph@littlepinkcloud.COM>
Received: from zebedee.littlepinkcloud.COM
	(cpc1-cmbg8-0-0-cust558.cmbg.cable.ntl.com [82.6.106.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53A74DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:58:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18198.5489.890128.317389@zebedee.pink>
Date: Wed, 17 Oct 2007 15:00:17 +0100
From: Andrew Haley <aph@redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] powerpc: Fix 64 bits vDSO dwarf info for CR register
In-Reply-To: <20071017135055.GP5451@devserv.devel.redhat.com>
References: <1192595210.11899.149.camel@pasglop>
	<20071017135055.GP5451@devserv.devel.redhat.com>
Cc: Deepak Bhole <dbhole@redhat.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jakub Jelinek writes:
 > On Wed, Oct 17, 2007 at 02:26:50PM +1000, Benjamin Herrenschmidt wrote:
 > > Unfortunately, a bug in gcc cause it to not quite work either, but that
 > > is being fixed separately with something around the lines of:
 > > 
 > > linux-unwind.h:
 > > 
 > >      fs->regs.reg[R_CR2].loc.offset = (long) &regs->ccr - new_cfa;
 > > +    /* CR? regs are just 32-bit and PPC is big-endian.  */
 > > +    fs->regs.reg[R_CR2].loc.offset += sizeof (long) - 4;
 > 
 > Small correction.  If vdso is present, then fixing the vdso is all that is
 > needed, the above mentioned code is used only if the vdso is not present
 > (or if glibc doesn't support the vdso).

Perhaps we should test this change with a hacked libgcc, just to make
sure it fixes the bug.

Andrew.

-- 
Red Hat UK Ltd, Amberley Place, 107-111 Peascod Street, Windsor, Berkshire, SL4 1TE, UK
Registered in England and Wales No. 3798903
