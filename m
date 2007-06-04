Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4E91DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 11:11:04 +1000 (EST)
Subject: Re: [PATCH 3/3] consolidate do_signal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <1180828765.14025.34.camel@localhost.localdomain>
References: <20070602102143.GA21707@lst.de>
	<1180828765.14025.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 11:10:53 +1000
Message-Id: <1180919453.31677.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-06-03 at 09:59 +1000, Benjamin Herrenschmidt wrote:
> > +             if ((ka.sa.sa_flags & SA_ONSTACK) &&
> > +                 current->sas_ss_size && !
> on_sig_stack(regs->gpr[1]))
> > +                     newsp = current->sas_ss_sp +
> current->sas_ss_size;
> > +             else
> > +                     newsp = regs->gpr[1];
> 
> Hrm... some gratuituous differences in the signal stack handling.. I
> wonder if that hides a bug in one of the implementations...

Ok, so, that bit is actually a bit nicer on 64 bits, where there's a
get_sigframe() that handles this and is called by setup_rt_frame (which
you renamed to handle_rt_signal64).

(Though the actual implementation of get_sigframe() could use some
cleanup).

I'll do a patch on top of yours making that bit common.

Cheers,
Ben.
