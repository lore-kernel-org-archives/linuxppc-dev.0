Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 1E7D6DE743
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 03:05:50 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so2913125hsz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:05:49 -0700 (PDT)
Message-ID: <fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
Date: Wed, 21 May 2008 11:05:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <20080521164841.GA17813@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 10:48 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Wed, May 21, 2008 at 06:24:58PM +0200, Guennadi Liakhovetski wrote:
>> On Wed, 21 May 2008, Anton Vorontsov wrote:
>>
>> > On Wed, May 21, 2008 at 05:56:33PM +0200, Guennadi Liakhovetski wrote:
>> > >
>> > > Hm, I might well misunderstand something here, but it looks to me like you
>> > > are again trying to use both OF _and_ platform (spi_board_info) bindings
>> > > for your SPI setup?
>> >
>> > Yes, you didn't misunderstand. ;-)
>> >
>> > > And this is exactly what we are trying to avoid in
>> > > Grant's series of patches...
>> >
>> > I didn't find other way... The show stopper is "master" argument,
>> > drivers don't know about masters (and should not, since if they should,
>> > then this implies that masters should be registered prior to devices,
>> > and that complicates everything).
>> >
>> > What is the problem with board infos, btw? I missed that part. Board
>>
>> In short: board infos are not bad as such. I find it bad if you have to
>> use both OF and platform bindings to describe _one_ piece of hardware.

Sonething to note:  'platform bindings' is the wrong terminology.  I'd
like to be careful here because the term 'platform' is already
overloaded and leads to confusion.  Specifically, the 'platform bus'
doesn't come into play at all here and 'platform code' simply refers
to the board specific code in arch/powerpc/platforms.  Really, the
discussion is between using 'board info' to pass data vs. using the OF
api.

>
> This particular discussion isn't about describing hardware (since
> we're describing it via device tree), but about implementation
> details, such as:
>
> 1. Passing platform_data to the drivers;
> 2. Creating "SPI Linux devices" from the OF description.
>
> I see there ways:
>
> 1. Grant Likely's approach (works great for simple drivers which don't
>   need SPI platform_data).
> 2. Old board infos approach, there we can do whatever we want.
> 3. Implementing OF bindings for the every SPI driver that needs
>   platform_data.

or perhaps: 4. allow platform code to pass supplementary board info to
specific spi devices when appropriate (so the '1.' path is always
used, but it can also parse a board info structure if one is provided.
 This is different from '2.' which short circuits the spi_of path
entirely).

I concede that sometimes platform code just has to pass data to the
driver that cannot be described in the device tree.  callback pointers
being the most significant example and we do need a sane way to do so.

That being said; in most cases I'd much rather see code added to the
driver itself to extract data from the device tree.  This has the
advantage that the data transformation code stays with the driver
where it belongs and it keeps code common as much as possible
(discourage duplication of code in the platform directories).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
