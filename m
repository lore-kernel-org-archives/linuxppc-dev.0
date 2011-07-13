Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C230B6F65
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 23:20:12 +1000 (EST)
Received: by wwf10 with SMTP id 10so5131253wwf.21
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 06:20:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110713130208.GA15267@crust.elkhashab.com>
References: <20110713130208.GA15267@crust.elkhashab.com>
Date: Wed, 13 Jul 2011 09:20:08 -0400
Message-ID: <CA+5PVA4DZ6EfuO7_dQ-zc5=xBs14G8hHV4rm=c=G91pfuvMANQ@mail.gmail.com>
Subject: Re: grasping why mpt2sas fails with BITS_PER_LONG conditional
From: Josh Boyer <jwboyer@gmail.com>
To: Ayman El-Khashab <ayman@elkhashab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2011 at 9:02 AM, Ayman El-Khashab <ayman@elkhashab.com> wro=
te:
> I've had problems with the mpt2sas driver
> (drivers/scsi/mpt2sas/mpt2sas_base.c) when using it on my
> ppc44x. =A0Basically, there is a check in the code for
> BITS_PER_LONG and certain code is executed if it is 64 vs 32
> bit. =A0I am guessing it is a problem with the driver but it
> only shows up on powerpc. =A0If i force it to take the 64 bit
> path it works fine, but if I let the preprocessor decide it
> will take the 32 bit path and fail later. =A0I am not
> configuring my kernel as 64 bit, but I am guessing this has
> to do with the 36 bit plb bus on these parts.

That seems like a good theory to me.

> can somebody enlighten me as to what the right thing to do
> here is?

I'd suggest changing the check in the driver away from BITS_PER_LONG
and try making the conditionals based on CONFIG_ARCH_DMA_ADDR_T_64BIT
instead.  On machines with 36-bit physical addressing, that gets set
and it should fall into the code paths you say work.

josh
