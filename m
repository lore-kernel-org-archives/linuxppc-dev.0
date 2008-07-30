Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 49DE1DDF81
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 00:42:27 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so12178yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 07:42:25 -0700 (PDT)
Date: Wed, 30 Jul 2008 08:42:02 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
Message-ID: <20080730144202.GB21958@secretlab.ca>
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<20080727001119.GB12191@secretlab.ca>
	<9e4733910807262205l2db8d662u9dd2e517282686f8@mail.gmail.com>
	<fa686aa40807262235l47bff0bfi15d86a6e171d6775@mail.gmail.com>
	<9e4733910807270721h5777bb80u9f3d25413a62883c@mail.gmail.com>
	<77a246d166f3eafb4d6a5d899ff86945@kernel.crashing.org>
	<9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
	<043095cdcd52bb7af5cf4373b249b302@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <043095cdcd52bb7af5cf4373b249b302@kernel.crashing.org>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 09:47:21AM +0200, Segher Boessenkool wrote:
>>>  A reasonable "compatible" value would be something like
>>> "serial-eeprom-24c32".
>>>  You can go a little bit more generic than that, if you write up in
>>>  your binding how the driver should figure out the device size and
>>>  the protocol used.
>>
>> Matching on "serial-eeprom-24c32" requires me to convince the at24
>> authors to add that string as an alias binding for their driver.
>
> No, it requires the IIC subsystem to get fixed and not use OF
> "compatible" values as module alias names.

Indeed; the device tree is just a data structure with a well defined
usage model.  It is the kernel's job to adapt that data into a form that
it can use.

>> How
>> about "serial-eeprom,24c32" or "generic,24x32"?
>
> Neither "serial-eeprom" nor "generic" is the name of a vendor, so
> no.  The comma has a well-defined meaning.  Why would a comma be
> easier than a dash for your device matching code, anyway?

Just to add my voice; I 100% agree.  If it is not documented, and it
doesn't fit with established conventions, then it shouldn't be used in
the compatible field.

g.
