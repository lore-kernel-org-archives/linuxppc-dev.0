Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A92CDDFEC
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 09:36:19 +1000 (EST)
In-Reply-To: <4862AA19.3030502@freescale.com>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<762468c24d365ca8397b5833aa172b95@kernel.crashing.org>
	<4862AA19.3030502@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
Date: Thu, 26 Jun 2008 01:35:57 +0200
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It returns 2 for both "i2c-1" and "i2c-2".
>
> Well, I'm assuming that the alias property names will follow the 
> current
> convention of xxxxnn where xxxx is a name and nn is a number.  No 
> dashes or
> other punctuation.

Well, yes, your suggested code doesn't allow punctuation either; but
that wasn't my point, it doesn't allow numbers in names.  Why don't
you just parse a number from the end?

>> Also, alias names do not have any significance in general, they are
>> just handy shortcut names for humans to use; it would be better not
>> to overload this.  What do you want to use this for?
>
> As an alternative to cell-index or device-id for enumerating devices.  
> The
> consensus from the '"cell-index" vs. "index" vs. no index in I2C 
> device nodes'
> thread is that aliases are to be used to enumerate devices.

Erm, no.  That wasn't the consensus as I remember it; besides, it's
not a good plan.

Pretty much all busses can be enumerated without anything like this.
There was consensus on this.

Overloading "cell-index" is a bad plan.  There was consensus on this,
as well.

The only thing a platform should ever use aliases for is if it needs
to (for whatever purpose) find a specific device, that it cannot
identify otherwise (via "reg", ...).  And then that platform code
should look up the device by the alias, not look up the alias by the
device -- there is no 1-1 mapping from device to alias!


Segher
