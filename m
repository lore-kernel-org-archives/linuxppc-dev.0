Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0F6667A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 11:30:40 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Date: Wed, 19 Jan 2005 01:30:31 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHGECDCKAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20050118200944.GN28724@smtp.west.cox.net>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] Handle I-TLB Error and Miss separately on 8xx
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Fri, Jan 14, 2005 at 08:51:44PM +0100, Joakim Tjernlund wrote:
> 
> > BTW, there is a simpler fix to the TLB Miss problem.
> > In the TLB Miss handlers, just move the 2: label a few instr. upwards to
> > the same line as the "li	r21, 0x00f0". That way you will force a 
> > TLB error. You can do this for both Data and Instr. Miss handlers.
> > The code after where the 2: label used to be can be deleted. 
> 
> Like this?  Only lightly tested on my rpxlite on 2.6:

Something related I wonder about. Is it necessary to update the ACCESSED
	ori	r10, r10, _PAGE_ACCESSED
	stw	r10, 0(r11)
bit in the pte? 2 instr. and a cache line write will be saved in each TLB Miss handler
if this step can be omitted. Any MM gurus around?

 Jocke
