Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 82AF7474C2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 04:49:30 +1100 (EST)
Date: Thu, 18 Dec 2008 20:49:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v1] Add support for getting device platform data to I2C
	device
Message-ID: <20081218174927.GA16574@oksana.dev.rtsoft.ru>
References: <1229566451-29411-1-git-send-email-Mingkai.hu@freescale.com>
	<20081218165946.GA4029@oksana.dev.rtsoft.ru>
	<494A8643.1030105@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <494A8643.1030105@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.hu@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 11:20:03AM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
>> On Thu, Dec 18, 2008 at 10:14:11AM +0800, Mingkai Hu wrote:
>>> There is no standard way of getting device platform data from
>>> dts file to the I2C device when it's probed. This patch adds
>>> a function pointer to the of_modalias_table to get such bindings
>>> properties into device's platform data.
>>
>> Unfortunately this approach leads to inability to make the bindings
>> modular.
>
> True, but I think it's fine for now while a better mechanism is worked  
> out -- especially for things that are mainly used in embedded situations  
> where modular builds aren't as necessary.

Exactly, this matters for non-embedded case. Why would I want totally
unneeded I2C bindings built-in into my iBook kernel? ;-)

>> And the solution that everybody seem to agree with (SPI driver example):
>> http://lkml.org/lkml/2008/10/30/393
>
> Hmm, that doesn't seem to allow for any binding mechanism other than  
> internal and OF

Yeah, not without hacks (though, we can do some sort of chained pdata
handlers, thus we can allow other bindings mechanisms). But so far we
don't have anything other than OF and "board files"/raw bindings (I can't
actually imagine any other option).

Both approaches have their cons, sure. The difference is: for the
$subject approach we'll see the cons immediately, while in my approach
the cons are theoretical.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
