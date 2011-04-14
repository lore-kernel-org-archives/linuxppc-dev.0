Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E558B6FE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 07:25:47 +1000 (EST)
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com
	[172.25.149.3]) by smtp-out.google.com with ESMTP id p3ELPbXf015386
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2011 14:25:43 -0700
Received: from ywf7 (ywf7.prod.google.com [10.192.6.7])
	by hpaq3.eem.corp.google.com with ESMTP id p3ELPFjc013494
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2011 14:25:33 -0700
Received: by ywf7 with SMTP id 7so21620ywf.13
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 14:25:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302771756.15520.100.camel@thor.local>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop>
	<1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
	<1302736869.28876.91.camel@pasglop>
	<BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>
	<1302771756.15520.100.camel@thor.local>
Date: Thu, 14 Apr 2011 14:25:31 -0700
Message-ID: <BANLkTimykvKp=bwsFyNE9fWqcE9Ffws6bA@mail.gmail.com>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: Hugh Dickins <hughd@google.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <jaxboe@fusionio.com>, linux-kernel@vger.kernel.org,
	kevin diggs <diggskevin38@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2011 at 2:02 AM, Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
> On Mit, 2011-04-13 at 18:43 -0500, kevin diggs wrote:
>>
>> On Wed, Apr 13, 2011 at 6:21 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Wed, 2011-04-13 at 12:52 -0500, kevin diggs wrote:
>> >> > Actually I do get a crash in X later on... something in the radeon
>> >> DRM
>> >> > interrupt code is getting what looks like a NULL dereference. I'll
>> >> try
>> >> > to dig that one later on. I don't know if it's related to your
>> >> problem
>> >> > at all though.
>> >> >
>> >> In this context, what does 'crash' mean? The X thingy goes down? Or
>> >> the whole OS?
>> >
>> > Depends, with xmon enabled you get into xmon :-) Dunno if the oops is
>> > fatal but it could be.
>> >
>> > Cheers,
>> > Ben.
>> >
>> >
>>
>> As I think I have the same hardware as you (7,3, radeon 9600) If you
>> can tell me how to reproduce it maybe I can poke around a little.
>> Thus, at least temporarily, freeing you up for other stuff.
>>
>> I kinda need a break from fighting with GCC.
>
> FWIW, the problem Ben refers to might be fixed in current mainline by
> commit d87dfdbfc91c5e37288e7e8f7afdd992ba61a60d which reverts
> 69a07f0b117a40fcc1a479358d8e1f41793617f2 .

Mikael,

Something worth trying: turn off CONFIG_IDE.  That's what I need to
boot 2.6.39-rc[1-3] on PowerPC G5.

I know Jens has been fixing problems with IDE versus his plug/unplug
changes, but it's still not fixed for me in rc3.

In other mail http://lkml.org/lkml/2011/4/14/614
I see Linus recommending his post-rc3 commit 6631e635c65d
but I've not tried that myself yet.

Hugh
