Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate5.mot.com (motgate5.mot.com [144.189.100.105])
	by ozlabs.org (Postfix) with ESMTP id 8FD2767C60
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 06:14:23 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate5.mot.com (8.12.11/Motgate5) with ESMTP id k5SKEL9L001015
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 13:14:21 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k5SKEKgC007898
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 15:14:20 -0500 (CDT)
Date: Wed, 28 Jun 2006 15:14:19 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: no login prompt with ml403 + uartlite-->major numbers?
In-Reply-To: <mailman.1193.1151524639.11183.linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.WNT.4.61.0606281501300.2872@holyoke.labs.mot.com>
References: <mailman.1193.1151524639.11183.linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On 6/28/06, Robert Zach <rza1@so-logic.co.at> wrote:
>> Hello!
>>
>> I use the "Standart" ml403 Design with the uartlite instead of the
>> uart16550...
>>
>> my kernel parameters are:
>> "console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw"
>>
>> It boots correctly, but i got no login prompt!!
>> getty is started with init.
>> my inittab looks like:
>> ...
>> ::respawn:/sbin/getty 9600 ttl0

At a lower level...are you keeping in mind that the UART-Lite baud rate (and
probably parity, stop bits, # of data bits) is set in hardware?  So any at-
tempt to specify settings in software (e.g. your 'getty' line above, or on
the kernel cmd line) have no effect.  If your console isn't set to match the
UART-Lite's hardware settings you're going to see gibberish, or nothing.

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
