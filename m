Return-Path: <olof@lixom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75C59B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 01:01:25 +1000 (EST)
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2F1A7DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 01:01:23 +1000 (EST)
Date: Sun, 19 Jul 2009 10:08:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs
Message-ID: <20090719150817.GA22099@lixom.net>
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
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Signed-off-by: Olof Johansson <olof@lixom.net>

Tested OK here on an electra. Thanks for fixing this!


-Olof
