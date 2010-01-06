Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 65329B6EF3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 16:08:55 +1100 (EST)
Message-ID: <4B441AD8.4050709@elkhashab.com>
Date: Tue, 05 Jan 2010 23:08:40 -0600
From: Ayman El-Khashab <ayman@elkhashab.com>
MIME-Version: 1.0
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: How to set GPIO state in the dts or in platform
References: <4B440EDC.3060805@elkhashab.com> <4B4413DA.7010704@billgatliff.com>
In-Reply-To: <4B4413DA.7010704@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/5/2010 10:38 PM, Bill Gatliff wrote:
> Ayman El-Khashab wrote:
>   
>> I've got a custom board akin to the walnut.  I've successfully got
>> u-boot,
>> the kernel, and a working filesystem.  The only thing I lack is a
>> clear idea
>> of how to set a GPIO.
>>     
>
> Isn't that the "flags" parameter, e.g.:
>
> gpios = <phandle gpioid flags>
>
> ?
>
> If you are passing a 0 for the flags, try a 1.  I know of at least one
> driver that interprets that to mean a polarity inversion.  Maybe you'll
> get lucky.  :)
>
>   
Possibly, I saw that in the documentation directory, but didn't quite 
follow the explanation that
was given.  Below is what I was using as  a reference, but is it as 
simple as that?  Do the flags encode
just the state or also, the open drain, hi-z and everything else?  In my 
case, I want the GPIO 3 actively
driven high.


Example of the node using GPIOs:
20	
21		node {
22			gpios = <&qe_pio_e 18 0>;
23		};
24	
25	In this example gpio-specifier is "18 0" and encodes GPIO pin number,
26	and empty GPIO flags as accepted by the "qe_pio_e" gpio-controller.
