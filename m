Return-Path: <penberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 313DAB71AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 14:48:42 +1000 (EST)
Received: from mail-bw0-f219.google.com (mail-bw0-f219.google.com
	[209.85.218.219]) by ozlabs.org (Postfix) with ESMTP id 3559BDDDA0
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 14:48:38 +1000 (EST)
Received: by bwz19 with SMTP id 19so3271204bwz.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 21:48:36 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <20090621183658.2b408e69@lappy.seanm.ca>
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
	<20090620194250.5a3e826f@lappy.seanm.ca>
	<200906210628.35553.elendil@planet.nl>
	<84144f020906210320n2984807dw2d4b4fb38afd22cf@mail.gmail.com>
	<1245623104.16880.26.camel@pasglop>
	<20090621183658.2b408e69@lappy.seanm.ca>
Date: Mon, 22 Jun 2009 07:48:35 +0300
Message-ID: <84144f020906212148y77a05be6k8f96beb3cf31da2b@mail.gmail.com>
Subject: Re: Badness on the Warp
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sean,

On Mon, Jun 22, 2009 at 1:36 AM, Sean MacLennan<smaclennan@pikatech.com> wrote:
> On Mon, 22 Jun 2009 08:25:04 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> Right, our interrupt controllers need those fixes, they are low
>> on my priority list since it's a reasonably harmless warning and I'm
>> still chasing some actual breakage (though maybe not directly related
>> to your patches).
>>
>> Kumar already submitted a couple, Frans, feel free to beat me
>> at converting UIC (just use kmalloc directly in there instead
>> of alloc_bootmem).
>
> I can make the changes to UIC if you want. They badness is harmless (it
> ends up calling kzalloc anyway), but hard to explain to our PV (Product
> Verification) department that they can ignore what looks like a crash ;)

Right. We can also wrap the WARN_ON() in CONFIG_DEBUG_BOOTMEM or
something too but I'd prefer a proper fix here.

                                   Pekka
