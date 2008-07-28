Return-Path: <kkeil@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28809DDED7
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 21:15:05 +1000 (EST)
Date: Mon, 28 Jul 2008 13:14:58 +0200
From: Karsten Keil <kkeil@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: mISDN still breaking the allmodconfig build...
Message-ID: <20080728111458.GA26604@pingi.kke.suse.de>
References: <20080727.170235.97056809.davem@davemloft.net>
	<1217204022.11188.139.camel@pasglop>
	<20080727204805.59f55dda@lappy.seanm.ca>
	<20080728102009.5fb3df6b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080728102009.5fb3df6b@lxorguk.ukuu.org.uk>
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 10:20:09AM +0100, Alan Cox wrote:
> On Sun, 27 Jul 2008 20:48:05 -0400
> Sean MacLennan <smaclennan@pikatech.com> wrote:
> 
> > On Mon, 28 Jul 2008 10:13:42 +1000
> > "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> > 
> > > On Sun, 2008-07-27 at 17:02 -0700, David Miller wrote:
> > > > More fallout from the premature mISDN driver merge:
> > > > 
> > > > drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not
> > > > running on big endian machines now"
> > > 
> > > Lovely...
> > 
> > mISDN is notoriously bad on big endian machines.
> 

This only affect the hardware IO layer of some cards and I think
it will be fixed very soon, I did not remove the very old
#error line, because I did not had the hardware to verify that it is
OK now.
I already reserved a PPC machine now (will get it today or tomorrow) and
will test the endian robustness this week.

> In which case it really should not be in Linus tree but in linux-next.
> Karsten - will you ask Linus to revert mISDN so it can go into linux-next
> instead and get cleaned up in the right place ?
> 

This was my original plan and my fault, that I only included the
pull URL and sent it to Linus diectely, I did not know that in this case
Linus will pull it without further discussion, but I'm still glad that it
is in and only show few issues (I'm very unhappy that I did not find
these before, I did builds on all our architectures, but not with the
all*config, only with subsets).
The good thing is, that this brought back the ENDIAN issue back on my
radar and on my near time TODO list :-)

-- 
Karsten Keil
SuSE Labs
ISDN and VOIP development
SUSE LINUX Products GmbH, Maxfeldstr.5 90409 Nuernberg, GF: Markus Rex, HRB 16746 (AG Nuernberg)
