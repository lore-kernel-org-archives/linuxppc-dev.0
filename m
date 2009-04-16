Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDC43DE238
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 18:05:44 +1000 (EST)
In-Reply-To: <8BE09C31-40E4-41C2-A6D8-EE9C7DA0B625@kernel.crashing.org>
References: <OF2E7A8F65.EA7B7D26-ONC1257599.004624DB-C1257599.0046F2EB@transmode.se>
	<20090415130844.GB3301@pengutronix.de>
	<8BE09C31-40E4-41C2-A6D8-EE9C7DA0B625@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: OF PCI howto?
Message-ID: <OF08A8F393.64CD0E94-ONC125759A.00276611-C125759A.002C76B2@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Thu, 16 Apr 2009 10:05:40 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> wrote on 15/04/2009 17:20:21:
> On Apr 15, 2009, at 8:08 AM, Wolfram Sang wrote:
> 
> > On Wed, Apr 15, 2009 at 02:54:57PM +0200, Joakim Tjernlund wrote:
> >
> >> dts fragment correct for my setup? If not, is there a better 
> >> example I can
> >> look at?
> >
> > Maybe this message/thread can help you:
> >
> > http://ozlabs.org/pipermail/devicetree-discuss/2009-March/000597.html
> 
> You may also want to take a look at ePAPR on the power.org site

Thanks guys

Looking in ePAPR I see I should read the IDSEL like this:
                /* IDSEL 0x11 AD17 */
                0x8800 0x0 0x0 0x1 &ipic 20 0x8 /* INTA */
                0x8800 0x0 0x0 0x2 &ipic 21 0x8 /* INTB */
                0x8800 0x0 0x0 0x3 &ipic 22 0x8 /* INTC */
                0x8800 0x0 0x0 0x4 &ipic 23 0x8 /* INTD */

grouping the first line into:
"0x8800 0x0 0x0" "0x1" "&ipic" "20 0x8" /* INTA */

"0x8800 0x0 0x0" = child unit address
"0x1" = child interrupt specifier = INTA
"&ipic" = interrupt parent
"20 0x8" = parent interrupt specifier

Questions:
 MPC832x appears to only have INTA so why are the INTB,INTC 
 and INTD lines there?

 I don't understand how IDSEL values are decided. Are IDSEL 0x11-0x18 
randomly
 selected or are they fixed for MPC832x?

What I really trying to understand is what fields I might need to change
and what to change them to.
So far the "interrupt-map" and the "ranges" items looks like they might 
need
some tweaking, but I really don't know at this point.
Any pointers in this area is much appreciated.

 Jocke
