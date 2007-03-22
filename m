Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74131DDF88
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 23:06:14 +1100 (EST)
In-Reply-To: <1174544624.10836.24.camel@localhost.localdomain>
References: <1174544624.10836.24.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Always use -mno-string
Date: Thu, 22 Mar 2007 13:06:06 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Akinobu Mita <mita@fixstars.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Ok, let's keep load/store multiple, they are only used on 32 bits
> and are actually useful. string instructions are not though.

Sure they are.  They are used for 64-bit integers (and
structs) on lots of 32-bit code compiled by GCC.  As long
as they are 32-bit aligned, they aren't slow on e.g. PPC750
either.

Just tell GCC what CPU model you want to compile for and
it will try to do the best thing.  Don't actively work
against it :-)


Segher
