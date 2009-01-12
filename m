Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F29C3DE146
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 09:48:26 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0CMlBsX027507
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 15:47:11 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0CMmMQ4195306
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 15:48:22 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0CMmMqN001332
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 15:48:22 -0700
Date: Mon, 12 Jan 2009 17:48:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mal_probe crash
Message-ID: <20090112224809.GD23097@zod.rchland.ibm.com>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
	<200901091602.05730.matthias.fuchs@esd-electronics.com>
	<Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
	<1231536613.2142.74.camel@pasglop> <aday6xknnp2.fsf@cisco.com>
	<Pine.LNX.4.64.0901121421140.13607@vixen.sonytel.be>
	<1231796192.22571.30.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231796192.22571.30.camel@pasglop>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Roland Dreier <rdreier@cisco.com>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 08:36:32AM +1100, Benjamin Herrenschmidt wrote:
>On Mon, 2009-01-12 at 14:37 +0100, Geert Uytterhoeven wrote:
>> On Fri, 9 Jan 2009, Roland Dreier wrote:
>> >  > Can you double check that the e1000 isn't copying the PCI resources into
>> >  > a unsigned long before ioremap'ing the result, thus cropping the top
>> >  > bits ?
>> > 
>> > as far as I can see, e1000 is using pci_ioremap_bar(), which should do
>> > the right thing as long as resource_size_t is the right type (which it
>> > looks like it is on PowerPC 44x).
>> 
>> Indeed, the full 36-bit address is passed to __ioremap() via pci_ioremap_bar(),
>> as evidenced from the additional debug output below (see [1]).
>> 
>> As I don't have any other 3.3V PCI Ethernet cards, I plugged in a 3.3V PCI USB
>> 2.0 card in the second PCI slot, and got a similar crash (see [2]).
>> 
>> Are the PCI slots on the Sequoia known broken under recent Linux kernels? I've
>> never used them before...
>
>Hrm, something is indeed wrong, hard to say what tho. My canyonlands
>works fine (460EPx) and I can try a Taishan one of these days (440GX
>iirc). What is in sequoia ? I think it's a GX no ?

440EPx.

josh
