Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C51BB68630
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 13:19:26 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingmar <i2a@gmx.net>
In-Reply-To: <20051031002926.M71008@quicknet.nl>
References: <1130645036.29054.229.camel@gaston>
	<20051031002926.M71008@quicknet.nl>
Content-Type: text/plain; charset=utf-8
Date: Mon, 31 Oct 2005 13:17:58 +1100
Message-Id: <1130725079.29054.320.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: exception vectors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-10-31 at 01:35 +0100, Ingmar wrote:
> Hi all,
> 
> I am trying to overwrite the exception vector space of an ibook G4 :).
> 
> I have set up (for every exception) a small piece of code, that's a prefix of a
> handler to be called. My problem is, that writing the “small” chunks of code to
> the exception vector space gives no problem(so it seams) but writing all the
> pieces of code as one chunk gives a exception [dsi, dsisr 0x42000000], this
> indicates a store problem.
> 
> I have tried different modes of copying, mmu on/off, also chanced the WING bit,
> switched the exception prefix on.
> 
> I don't believe putting the exception vectors to there “place” one by one is the
> right way, in the Linux kernel the kernel get relocated and the code comes into
> place. I have taken this as an example, unfortunately to to result :(..
> 
>  - Am I overlooking something?
>  - Is the a “standard way” to overwrite the exception vector space of a powerpc?

Well, you typically do this with the MMU disabled and making sure you
don't take an exception while copying over them...

Ben.
