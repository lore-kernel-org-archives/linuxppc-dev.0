Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 126DEDDEB6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 20:20:44 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BAF0@az33exm25.fsl.freescale.net>
References: <20070213061026.5837FDDDE9@ozlabs.org><e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org><20070214002210.GE11491@localhost.localdomain><45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org><20070214231734.GC16279@localhost.localdomain><90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org><E1HHhCD-0004Hf-QT@jdl.com>
	<865018a527ef1056f628250167301e64@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BAF0@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1425bda02491ec9f112b43ccebb8127e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony 
Date: Fri, 16 Feb 2007 10:20:34 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 1275 specifies whitespace inbetween, but isn't this due to
> the way they are describing things for the forth / stack-based
> operations?

Sure, since for true OF d# etc. are Forth words and thus
are whitespace delimited.

> I would prefer in the DTS files to have no whitespace in
> between--  <d#1234 #h5678> seems much more readable
> than <d# 1234 #h 5678>.

[h# not #h] Sure, make it optional, that should work just fine.

> Or even better-- just use standard C notation
>     <1234 0x5678>

Right now no prefix means hexadecimal.  So you need a prefix
that means decimal, and C has none.

> That is very readable.  Why bring unnecessary complexity into
> this?

It's all historical accident I suppose.  Since the DTS
format tries to look like C it should have used 0x all
along.  It's not too late too change btw, the DTS is not
the actual interface, the binary blob that is passed
around doesn't care what number base you used in the
source code.


Segher
