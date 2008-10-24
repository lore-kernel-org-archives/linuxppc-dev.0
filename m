Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 72877DDE0F
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 09:17:43 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so578182qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 15:17:41 -0700 (PDT)
Message-ID: <49024986.5030406@genesi-usa.com>
Date: Fri, 24 Oct 2008 17:17:42 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
	<20081024164120.GA14350@oksana.dev.rtsoft.ru>
	<20081024170128.GA20577@oksana.dev.rtsoft.ru>
In-Reply-To: <20081024170128.GA20577@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Anton Vorontsov wrote:
> On Fri, Oct 24, 2008 at 08:41:20PM +0400, Anton Vorontsov wrote:
> [...]
>>> Would we suggest a node;
>>>
>>> gpio-header {
>>> 	compatible = "bplan,efika-gpio";
>>> 	gpios = <&gpio-standard 16 0 17 0>;
>>> };
>>>
>>> gpio-header2 {
>>> 	compatible = "bplan,efika-gpio-wkup";
>>> 	gpios = <&gpio-wkup 18 0>;
>>> };
>> IMO this looks very reasonable. You properly describe the hardware:
>> physical device (header) and its resources.
> 
> If there are actually two headers, that is. If you use two nodes
> just to specify which gpio is wkup, that is's a bit ugly... Why not
> 
> gpio-header {
> 	compatible = "bplan,<board>-gpio-header";
> 	gpios = <&standard 16 0
> 		 &standard 17 0
> 		 &wakeup 18 0>;
> }
> 
> And the driver whould know that on this particular <board>
> third gpio is the wakeup one?

Good point, I concede to your much better plan :D

Back to the other discussion, where we give individual GPIOs some
names so they are detectable and not just programmable as a bank,
do you have any ideas about that? :/

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
