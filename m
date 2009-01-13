Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id EE2DDDE0DE
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 03:19:51 +1100 (EST)
Date: Tue, 13 Jan 2009 17:19:46 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re[2]: mal_probe crash
In-Reply-To: <1515542773.20090113015150@emcraft.com>
Message-ID: <Pine.LNX.4.64.0901131718120.1391@vixen.sonytel.be>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
	<200901091602.05730.matthias.fuchs@esd-electronics.com>
	<Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
	<1231536613.2142.74.camel@pasglop> <aday6xknnp2.fsf@cisco.com>
	<Pine.LNX.4.64.0901121421140.13607@vixen.sonytel.be>
	<1231796192.22571.30.camel@pasglop>
	<1515542773.20090113015150@emcraft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: Roland Dreier <rdreier@cisco.com>, Sean MacLennan <smaclennan@pikatech.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Jan 2009, Yuri Tikhonov wrote:
> On Tuesday, January 13, 2009 you wrote:
> > On Mon, 2009-01-12 at 14:37 +0100, Geert Uytterhoeven wrote:
> >> On Fri, 9 Jan 2009, Roland Dreier wrote:
> >> >  > Can you double check that the e1000 isn't copying the PCI resources into
> >> >  > a unsigned long before ioremap'ing the result, thus cropping the top
> >> >  > bits ?
> >> > 
> >> > as far as I can see, e1000 is using pci_ioremap_bar(), which should do
> >> > the right thing as long as resource_size_t is the right type (which it
> >> > looks like it is on PowerPC 44x).
> >> 
> >> Indeed, the full 36-bit address is passed to __ioremap() via pci_ioremap_bar(),
> >> as evidenced from the additional debug output below (see [1]).
> >> 
> >> As I don't have any other 3.3V PCI Ethernet cards, I plugged in a 3.3V PCI USB
> >> 2.0 card in the second PCI slot, and got a similar crash (see [2]).
> >> 
> >> Are the PCI slots on the Sequoia known broken under recent Linux kernels? I've
> >> never used them before...
> 
> > Hrm, something is indeed wrong, hard to say what tho. My canyonlands
> > works fine (460EPx) and I can try a Taishan one of these days (440GX
> > iirc). What is in sequoia ? I think it's a GX no ?
> 
>  Sequoia is equipped with 440EPx.
> 
>  I observe the 'mal_probe' crash on the Katmai board too (based on 
> 440SPe):

Do PCI cards in the Katmai's PCI-X slot work?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
