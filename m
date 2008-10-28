Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 78D34DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 11:47:41 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so564216ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 17:47:40 -0700 (PDT)
Message-ID: <4906612A.1010503@genesi-usa.com>
Date: Mon, 27 Oct 2008 19:47:38 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
	<20081026234747.GD22339@yookeroo.seuss>
	<4905E0DC.104@genesi-usa.com>
	<20081027183421.GA1009@oksana.dev.rtsoft.ru>
	<49060EC3.1070704@genesi-usa.com>
	<20081027201023.GA18642@oksana.dev.rtsoft.ru>
	<49063929.3060900@genesi-usa.com>
	<20081027231221.GA22008@oksana.dev.rtsoft.ru>
	<20081027234014.GA7112@oksana.dev.rtsoft.ru>
In-Reply-To: <20081027234014.GA7112@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Anton Vorontsov wrote:
> On Tue, Oct 28, 2008 at 02:12:21AM +0300, Anton Vorontsov wrote:
> [...]
>>> *   How do you stop GPIOLIB from blindly approving requests to use
>>>     pins marked X, without making it "controller-specific"?
> 
> Btw, as for pins marked X... If the gpio controller has some register
> that specify which pins are not available to use as GPIOs, then just read
> that register, check its value and return -ENODEV from the .request()
> gpiolib callback.

It doesn't. At least not close by.

> This is easily doable for QE/CPM gpio controllers (they have option
> registers), but nobody cares to check them.

There are plenty of examples where this information is encoded somewhere
else in the chip and Ben Herrenschmidt et al. have recommended that it
be put in the device tree so that drivers do not have to go and check
registers in other units to get that information.

However there is no standard way to expose it. And people just grab a
pin they "know" is free on their particular board.

Are you sure you do NOT see any shortcomings here?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
