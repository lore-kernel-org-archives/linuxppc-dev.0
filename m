Return-Path: <pmiscml@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 4BDF6DDEE0
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 23:20:37 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so1058581pyb
	for <linuxppc-dev@ozlabs.org>; Sun, 06 May 2007 06:20:35 -0700 (PDT)
Date: Sun, 6 May 2007 16:20:35 +0300
From: Paul Sokolovsky <pmiscml@gmail.com>
Message-ID: <1258712175.20070506162035@gmail.com>
To: Bodo Eggert <7eggert@gmx.de>, Anton Vorontsov <cbou@mail.ru>
Subject: Re: Correct location for ADC/DAC drivers
In-Reply-To: <E1Hkfia-0000cJ-18@be1.lrz>
References: <8fZXU-3EI-11@gated-at.bofh.it> <8haHG-6zd-19@gated-at.bofh.it>
	<8hd2U-1Ca-39@gated-at.bofh.it> <8heii-3GM-37@gated-at.bofh.it>
	<E1Hkfia-0000cJ-18@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Robin Getz <rgetz@blackfin.uclinux.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Bodo,

Sunday, May 6, 2007, 3:19:59 PM, you wrote:

> Robin Getz <rgetz@blackfin.uclinux.org> wrote:
>> On Fri 4 May 2007 16:52, Robert Schwebel pondered:
>>> On Fri, May 04, 2007 at 02:21:50PM -0400, Robin Getz wrote:

>>> > We also have DAC and ADC drivers (up to 16 bits @ 64MS/s, via DMA),
>>> > that would be nice to put in the "right" place  - I don't think that
>>> > drivers/char is the right place, nor drivers/misc - I also don't think
>>> > that /adc is a descriptive place for DAC or mixed signal front ends
>>> > (MxFE).
>>>
>>> What userspace interface do your drivers have?
>> 
>> Right now, it is a little rudimentary char interface, it needs a little care
>> to be a bit more general purpose, but it suited needs of what the people who
>> were using it.

> [...]

>> I would be interested in having a detailed discussion/random thoughts on
>> this - what is the best way to expose these types of devices?

> Since you ask for random thoughts:

> IO of data streams from or to a DAC/ADC is essentially what soundcards do.
> I'm wondering if these cards are similar enough to use alsa, and if using
> that interface would ease or hinder programming the driver.


        FYI, within handhelds.org kernel project, we also saw the need
for consistent ADC infrastructure, and developed such, based on
classdev concept, on todo to be submitted for review. Our
API/userspace interface however optimized for individual (or
fixed-batch) readings over stream operations, our target usage
are touchscreen, battery, hwmon drivers.




-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com
