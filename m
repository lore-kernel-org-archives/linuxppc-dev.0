Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 78D63DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:51:13 +1000 (EST)
Date: Wed, 17 Oct 2007 09:50:55 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Fix 64 bits vDSO dwarf info for CR register
Message-ID: <20071017135055.GP5451@devserv.devel.redhat.com>
References: <1192595210.11899.149.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192595210.11899.149.camel@pasglop>
Cc: Deepak Bhole <dbhole@redhat.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Haley <aph-gcc@littlepinkcloud.COM>,
	Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@bigpond.net.au>
Reply-To: Jakub Jelinek <jakub@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 17, 2007 at 02:26:50PM +1000, Benjamin Herrenschmidt wrote:
> Unfortunately, a bug in gcc cause it to not quite work either, but that
> is being fixed separately with something around the lines of:
> 
> linux-unwind.h:
> 
>      fs->regs.reg[R_CR2].loc.offset = (long) &regs->ccr - new_cfa;
> +    /* CR? regs are just 32-bit and PPC is big-endian.  */
> +    fs->regs.reg[R_CR2].loc.offset += sizeof (long) - 4;

Small correction.  If vdso is present, then fixing the vdso is all that is
needed, the above mentioned code is used only if the vdso is not present
(or if glibc doesn't support the vdso).

	Jakub
