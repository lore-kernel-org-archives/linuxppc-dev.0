Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7A8FCDDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 04:03:54 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v2]
From: James Hsiao <jhsiao@amcc.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20081029105413.895d5cdb.kim.phillips@freescale.com>
References: <1225237276.1850.13.camel@jhsiao-usb>
	<20081028205132.255e674d@zod.rchland.ibm.com>
	<1225246700.1850.61.camel@jhsiao-usb>
	<20081029105413.895d5cdb.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 10:04:59 -0700
Message-Id: <1225299899.4841.7.camel@jhsiao-usb>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: jhsiao@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kim,

Thanks for comments.
Please see inline.

James
On Wed, 2008-10-29 at 10:54 -0500, Kim Phillips wrote:
> On Tue, 28 Oct 2008 19:18:20 -0700
> James Hsiao <jhsiao@amcc.com> wrote:
> 
> > On Tue, 2008-10-28 at 20:51 -0400, Josh Boyer wrote:
> > > - The question on ABLKCIPHER kconfig was ignored
> > Is ABLKCIPHER a sub set of BLKCIPHER? So, if BLKCIPHER is selected then
> > if ABLKCIPHER is present, it will use ABLKCIPHER otherwise using
> > BLKCIPHER algorithm? Correct?
> 
> this is my bad, commit 653ebd9c8510a7d647ed23e66e1338f848ebdbab
> "blkcipher: Merge ablkcipher and blkcipher into one option/module"
> renders CRYPTO_ABLKCIPHER obsolete in favour of CRYPTO_BLKCIPHER.
> 
Ok. 

> > > - Marking functions static
> > We have more than one file, that is why some of the function are not
> > static.
> 
> have one file then?

This is our first round of patch. We will support many more algorithms
and it will have much more files. I am afraid one file will be way too
big.

> 
> > > - Global lsec_core variable which doesn't allow for more than one
> > > device
> > We only support single incidence of device.
> 
> it's also a matter of unnecessarily polluting global namespace.
> 

I look into modify this.

> > > - Complete lack of locking code, how do you enforce mutually exclusive
> > > access to the device?
> > 
> > The crypto engine have couple bits 'command ready' and 'packet done',
> > which servers as semaphore here. So, software don't need extra locking.
> 
> know if it's applicable at all, but I imagine it's not SMP safe.

No, it's not SMP safe. This driver only support single core processors.
> 
> Kim
