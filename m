Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E5E12BF16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 18:53:31 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Date: Wed, 12 Jan 2005 08:53:17 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEMEPMCPAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> As the code stands currently, there is a bug in the 2.4 and 2.6 handling
> of I-TLB Miss and Error exceptions on 8xx.  The problem is that since we
> treat both of them as the same exception when we hit do_page_fault,
> there is a case where we can incorrectly find that a protection fault
> has occured, when it hasn't.  This is because we check bit 4 of SRR1 in
> both cases, but in the case of an I-TLB Miss, this bit is always set,
> and it only indicates a protection fault on an I-TLB Error.

Patch looks good to me, but I want to ask when this error
can be triggered in practice?

I have never seen it happen and it makes me wonder if the test
for a null pte in the I-TLB Miss handler is needed?

In linuxppc-2.4 there is a special case for pinned tlbs were
one could remove 4 instructions if the test for null ptes is removed.

I belive SPRG2 is free in 2.6 and if combined with the special case for pinned
tlbs in linuxppc-2.4 one can remove all memory references used for temporary
storage in the I-TLB Miss handler. That will save a cache line load&store.

 Jocke
