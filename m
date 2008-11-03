Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id B5B73DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 09:55:20 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2660528rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Nov 2008 14:55:19 -0800 (PST)
Message-ID: <fa686aa40811031455l184ce184w529bf2f36c23cd9e@mail.gmail.com>
Date: Mon, 3 Nov 2008 15:55:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Wolfram Sang" <w.sang@pengutronix.de>
Subject: Re: [PATCH] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
In-Reply-To: <20081103221546.GA16244@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<490F73B5.6010004@genesi-usa.com>
	<20081103221546.GA16244@pengutronix.de>
Cc: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 3, 2008 at 3:15 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Mon, Nov 03, 2008 at 03:57:09PM -0600, Matt Sealey wrote:
>
>> > Optionally you can further
>>> reduce impact by checking if CONFIG_PPC_MPC5200_BUGFIX is defined.
>>
>> I would much prefer this.
>
> I submitted a patch to enable pipelining on a MPC5200B recently. It was
> disabled because of a bug in the MPC5200. The first version of this
> patch used MPC5200_BUGFIX and it was mentioned, that some people might
> want to run the same kernel on both kind of processors. So, the patch
> that went mainline checks for the PVR. Maybe we should stick to this
> here, too?

Of the two solutions:
1. Run-time selection must be done.
2. Compile-time removal of the bug fix path can also be done to lessen
runtime impact for kernels never run on older chips

My view is that #1 is non-negotiable.  #2 is a nice to have, but if it
doesn't incur any cost when disabled at runtime then I don't care.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
