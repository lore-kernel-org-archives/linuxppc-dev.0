Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCCAADE09E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 05:42:44 +1000 (EST)
Message-ID: <49DBAC7C.5040405@freescale.com>
Date: Tue, 07 Apr 2009 14:41:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Sauce.Cheng" <chmhou@sina.com>
Subject: Re: issue at the beginning of kernel booting
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>	<22840131.post@talk.nabble.com>	<20090402161209.GA19088@ld0162-tx32.am.freescale.net>
	<22930588.post@talk.nabble.com>
In-Reply-To: <22930588.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sauce.Cheng wrote:
>>> i tried 
>>> CONFIG_PPC_EARLY_DEBUG_CPM=y 
>>> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xf00000008	
>>> how can i make sure CPM_ADDR, 0xf0000008 is default value 
> 
>> Look at the u-boot source, or dump the memory and see if it looks like a
>> ring buffer.
> 
> sorry, i mean that CPM_ADDR is address of what? address of CPM registers or
> something?

It's the address of a transmit descriptor for the serial port.  It's 
typically in DPRAM, but the exact position depends on where u-boot put 
it.  Try 0xf0000088.

>> This is a dts-v0 tree, which implies it's fairly old.
> dose later dts be used in corresponding kernel version ?

Yes, current kernels use dts-v1.

> in addition, there is one more question. 
> my RAM size is 32MBytes, my "vmlinux" size is 30MBytes, "vmlinux.o" size is
> 58MBytes. so , will there be something wrong at uncompressing time ?

That's just debugging information; it won't end up in the uImage.  Use 
the "size" utility in your toolchain to see how big the actual code and 
data are.

-Scott
