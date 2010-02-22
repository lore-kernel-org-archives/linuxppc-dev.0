Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id 8A247B7CE8
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 04:34:04 +1100 (EST)
Received: by ywh14 with SMTP id 14so979661ywh.15
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 09:34:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201002221705.30700.matthias.fuchs@esd-electronics.com>
References: <201001281448.42965.matthias.fuchs@esd-electronics.com>
	<fa686aa41002161119x6eb41203rb73b888176ce5040@mail.gmail.com>
	<201002221705.30700.matthias.fuchs@esd-electronics.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 22 Feb 2010 10:33:43 -0700
Message-ID: <fa686aa41002220933u40079737je3230ac4cfb4945f@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc512x: Add gpio driver
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
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

On Mon, Feb 22, 2010 at 9:05 AM, Matthias Fuchs
<matthias.fuchs@esd-electronics.com> wrote:
> Hi Grant,
>
> thanks for comments. I will post an updated version soon.
>
>
> On Tuesday 16 February 2010 20:19, Grant Likely wrote:
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +arch_initcall(mpc512x_add_gpiochips);
>>
>> Don't do this. =A0Either make this a proper of_platform device driver,
>> or call mpc512x_add_gpiochips() explicitly from the arch platform
>> setup code. =A0Otherwise, if the kernel is built for multiplatform, this
>> function will get executed regardless of the platform.
> In this case I prefer moving the call to the platform code.
> I tested the driver on one of our 5123 boards. Shall I add it
> to mpc5121_ads.c:mpc5121_ads_setup_arch() also? So it's at least called
> on the reference board? I not sure if there are some LEDs or buttons
> that could use it.

Yes, make sure all 5121 platforms call it.

Thanks,
g.
