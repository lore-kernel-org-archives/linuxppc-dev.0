Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5781EB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:33 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id DD3BDDDEFA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 04:33:20 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so155302qwd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 11:33:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
Date: Tue, 30 Jun 2009 14:33:18 -0400
Message-ID: <9e4733910906301133n4928cfc4h3ce4ee2aef53fa73@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 30, 2009 at 12:50 PM, Grant Likely<grant.likely@secretlab.ca> w=
rote:
> On Tue, Jun 30, 2009 at 12:18 AM, Wolfram Sang<w.sang@pengutronix.de> wro=
te:
>>> +
>>> + =A0 =A0 /* Force clear the data valid bit */
>>> + =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
>>> +
>>
>> No mutex involved here. I think this is either a separate patch or it ne=
eds at
>> least to be mentioned in the patch description.
>
> Oops, that was sloppy. =A0Yes, I'll put this into a separate patch. =A0Th=
anks.

Now that you have added the mutexes, do you ever need to force clear
the valid bit?
Maybe log an error if this happens so that we can track down why.

--=20
Jon Smirl
jonsmirl@gmail.com
