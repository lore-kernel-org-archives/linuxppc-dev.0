Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D55CCDDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:30:59 +1000 (EST)
In-Reply-To: <464DCD0E.9000706@freescale.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<8183195dad79296e3986f561bf929067@kernel.crashing.org>	<464CADBB.9050500@freescale.com>
	<20070518172711.2db7fc92@hyperion.delvare>
	<464DCD0E.9000706@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A0D2D068-D990-4FBB-B28C-620DDC71CD32@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Fri, 18 May 2007 11:29:19 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2007, at 10:58 AM, Scott Wood wrote:

> Jean Delvare wrote:
>> Hi Scott,
>>
>> On Thu, 17 May 2007 14:32:11 -0500, Scott Wood wrote:
>>
>>> (and the
>>> i2c code in Linux should be fixed to allow drivers to specify  
>>> multiple
>>> match names).
>>
>>
>> Back when David proposed his new-style i2c code, I had the same
>> objection. But we addressed the need differently. If you look at  
>> struct
>> i2c_board_info, you'll see two string fields, driver_name and  
>> type. The
>> former specifies the driver name, the second specifies the exact  
>> device
>> variant. For drivers which support several device variants, the
>> platform code should fill both fields.
>
> But that still requires the platform to know the driver name, rather
> than matching any driver which knows about the type.  This prevents  
> the
> use of OS-independent device trees (such as in Open Firmware), which
> cannot know specific Linux driver names, without something hacky  
> like a
> type-to-driver table in the device tree code.

And this is why I don't think there is any value in trying to put I2C  
devices in the device tree.  The linux mechanism is specific to  
Linux, and is based on Linux created names.  To provide something  
more generic someone would have to take on the task of providing a  
more global registry of names for devices and I just don't see anyone  
doing that.

Can someone explain to me why setting up i2c_board_info in the board  
specific code isn't sufficient?

- k
