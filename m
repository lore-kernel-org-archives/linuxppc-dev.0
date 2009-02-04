Return-Path: <alan@nishioka.com>
Received: from pro34.abac.com (pro34.abac.com [66.226.64.35])
	by ozlabs.org (Postfix) with ESMTP id 45E69DDEDD
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 06:48:02 +1100 (EST)
Message-ID: <4989E8FC.9090002@nishioka.com>
Date: Wed, 04 Feb 2009 11:14:04 -0800
From: Alan Nishioka <alan@nishioka.com>
MIME-Version: 1.0
To: mike_timmons@trimble.com
Subject: Re: kernel 2.6.24 USB wi fi device firmware loading issue(s):
	rt73.bin...
References: <4989C635.1050605@trimble.com>
In-Reply-To: <4989C635.1050605@trimble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

request_firmware uses the hotplug code so the kernel doesn't have any 
sourceless binaries compiled into it.  on init, the driver requests the 
firmware, user mode hotplug daemon loads the firmware from disk and 
gives the driver a pointer to it.

since this is a short term problem, i would suggest converting rt73.bin 
to a header file and compiling it into the kernel.  you have to make a 
few minor changes to where request_firmware is called, but in the end 
firmware is just an array of bytes with a pointer to it.  this is what i 
did when i was testing usb wifi a little while ago.

i am probably going to open source hell for suggesting this, but i'm a 
hardware engineer, so i am in hell already.

alan nishioka


Mike Timmons wrote:
> I received great help last week in getting a USB wi fi device working. 
> Thanks again, but can someone read below and advise me on kernel 
> 2.6.24? The best out-of-the box solution for me was 2.6.27.8, for 
> which I needed a Denx eldx toolchain in place of the toolchain I was 
> using to compile 2.6.24. The significance of all this is that I did 
> get  USB wi fi working, but...
>
> I'm not in a position to upgrade from 2.6.24 at this time. I need to 
> get the USB wi wi (Linksys WUSB54GC) working under 2.6.24.
