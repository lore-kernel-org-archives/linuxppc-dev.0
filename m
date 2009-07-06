Return-Path: <olof@lixom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ECDCFB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 00:00:10 +1000 (EST)
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8AC8FDDD1B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 00:00:09 +1000 (EST)
Date: Mon, 6 Jul 2009 08:59:26 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs
Message-ID: <20090706135926.GA16205@lixom.net>
References: <6c9c0889feaceeea55bd2b6fef0c19e408425ef5.1246846125.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c9c0889feaceeea55bd2b6fef0c19e408425ef5.1246846125.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 06, 2009 at 12:08:52PM +1000, Michael Ellerman wrote:
> The workaround enabled by CONFIG_MPIC_BROKEN_REGREAD does not work
> on non-broken MPICs. The symptom is no interrupts being received.
> 
> The fix is twofold. Firstly the code was broken for multiple isus,
> we need to index into the shadow array with the src_no, not the idx.
> Secondly, we always do the read, but only use the VECPRI_MASK and
> VECPRI_ACTIVITY bits from the hardware, the rest of "val" comes
> from the shadow.

I'm travelling without remote access to a machine to test this on. Given
that it changes the errata workaround (subtly), I'd appreciate the chance
to give it a go before it gets merged.

Unfortunately I forgot to make sure that my remote console server was
up before I left. :-)

-Olof
