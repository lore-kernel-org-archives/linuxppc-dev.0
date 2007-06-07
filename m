Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A9C4DDF07
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 01:20:26 +1000 (EST)
Message-ID: <46682233.7060601@freescale.com>
Date: Thu, 07 Jun 2007 10:20:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: MPC8349ea Random Device Generator driver
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
	<46673009.6000109@freescale.com> <20070606222456.GA28225@lixom.net>
	<466735F3.7040504@freescale.com> <20070606235440.GA28400@lixom.net>
	<466814E7.3090101@freescale.com> <20070607152041.GA2851@lixom.net>
In-Reply-To: <20070607152041.GA2851@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> No. in_le16 exists so you can read a little-endian 16 bit register on
> a device, and store it to a regular 16-bit integer variable. It
> has nothing to do with assignment.

What?  Reading from a register and storing the value into a variable *is* assignment.  If 
I have code like this:

	A = B;

I'm assigning B to A.

For the record, I understand the concepts you're talking about, I'm only confused about 
about some of things I'm reading.

> __le16 is just a type with hints for the programmer: "Hey, this is a
> 16-bit variable, but we're storing it in little-endian format. So if you
> need to use it as a native data type, you need to swap it by hand first",
> and sparse is able to help you find places where you didn't.

I understand that.

> If you use the accessors to read/write hardware (as you are supposed to
> do), then you don't need special types in your structs, just make sure
> you use the right accessors.

Ok, I understand that, too.  I just don't understand absolutist statements like "you can 
never assign a __le16 type to any other integer type" when our code is full of example of 
doing just that.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
