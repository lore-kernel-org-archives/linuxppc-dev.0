Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0941ADDE9B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:27:08 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8SKQrYN007464
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 16:26:53 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8SKQrLN497678
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 14:26:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8SKQqkU030362
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 14:26:52 -0600
Date: Fri, 28 Sep 2007 15:26:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 01/18] Virtex: Add uartlite bootwrapper driver
Message-ID: <20070928152651.2e185d15@weaponx.rchland.ibm.com>
In-Reply-To: <fa686aa40709281304p62fe5e66k99ea934a4896d876@mail.gmail.com>
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
	<200709282145.09411.arnd@arndb.de>
	<fa686aa40709281304p62fe5e66k99ea934a4896d876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Sep 2007 14:04:04 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On 9/28/07, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 28 September 2007, Grant Likely wrote:
> > > +static void uartlite_putc(unsigned char c)
> > > +{
> > > +while ((in_be32(reg_base + 0x8) & 0x08) != 0); /* spin */
> > > +out_be32(reg_base + 0x4, c);
> > > +}
> >
> > When coding a spin-loop, it's better to do a cpu_relax() between
> > each attempt.
> 
> Is cpu_relax even implemented in the bootwrapper?

No.  And it doesn't need to be :)

josh
