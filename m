Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68241B70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:32 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 4DB7EDE005
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 05:08:52 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so167799qwd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 12:08:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910906301133n4928cfc4h3ce4ee2aef53fa73@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
	<9e4733910906301133n4928cfc4h3ce4ee2aef53fa73@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 30 Jun 2009 13:08:30 -0600
Message-ID: <fa686aa40906301208p38f5c8deqc21ad8e423f0f4a8@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
To: Jon Smirl <jonsmirl@gmail.com>
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

On Tue, Jun 30, 2009 at 12:33 PM, Jon Smirl<jonsmirl@gmail.com> wrote:
> On Tue, Jun 30, 2009 at 12:50 PM, Grant Likely<grant.likely@secretlab.ca>=
 wrote:
>> On Tue, Jun 30, 2009 at 12:18 AM, Wolfram Sang<w.sang@pengutronix.de> wr=
ote:
>>>> +
>>>> + =A0 =A0 /* Force clear the data valid bit */
>>>> + =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
>>>> +
>>>
>>> No mutex involved here. I think this is either a separate patch or it n=
eeds at
>>> least to be mentioned in the patch description.
>>
>> Oops, that was sloppy. =A0Yes, I'll put this into a separate patch. =A0T=
hanks.
>
> Now that you have added the mutexes, do you ever need to force clear
> the valid bit?
> Maybe log an error if this happens so that we can track down why.

I know exactly why it happened.  spin_event_timeout() had a bug that
would cause it to report a false positive timeout.  The bug is fixed
and queued for merging.

However, I still think this explicit clear should be applied.  It is
just a cheap register read and it prevents the driver from getting
wedged after a timeout does event, for whatever reason.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
