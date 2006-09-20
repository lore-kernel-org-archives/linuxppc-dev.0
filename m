Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3495567B83
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:35:22 +1000 (EST)
Subject: Re: Hang with isync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manoj Sharma <manoj.shar@gmail.com>
In-Reply-To: <d6dada100609191816q75d1455cobeb1e0bd21dab8a8@mail.gmail.com>
References: <d6dada100609181828j1804f4f5ic0d1dd8a225980c@mail.gmail.com>
	<d6dada100609191816q75d1455cobeb1e0bd21dab8a8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 07:35:11 +1000
Message-Id: <1158788111.6002.310.camel@localhost.localdomain>
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

On Tue, 2006-09-19 at 18:16 -0700, Manoj Sharma wrote:
>         Hi,
>         
>         We use linux kernel 2.4.20 on ppc405 and the system hangs once
>         in a while when isync gets called in this function: 
>         
>         _GLOBAL(_nmask_and_or_msr)
>             mfmsr   r0      /* Get current msr */
>             andc    r0,r0,r3    /* And off the bits set in r3 (first
>         parm) */ 
>             or  r0,r0,r4    /* Or on the bits in r4 (second parm) */
>             sync            /* Some chip revs have problems here... */
>             isync
>             mtmsr   r0      /* Update machine state */
>             isync
>             blr         /* Done */ 
>         
>          2.5 onwards, I find that "sync; isync" has been replaced by a
>         macro SYNC (defined only for 601). I don't find it in any
>         changelog and reason for the change.
>         
>         Can someone give some information on this change? 

Regardless of the change... on 2.4, _nmask_and_or_msr() was used for a
number of things. We would need to know where it was called from with
what values as arguments to have an idea of what's going wrong. It's
probably not dying on the isync, but rather on the following mtmsr due
to a problem with the values passed in....

Ben.
