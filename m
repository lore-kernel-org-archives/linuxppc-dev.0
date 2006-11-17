Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7D8BB67A39
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 08:28:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
Date: Fri, 17 Nov 2006 22:28:02 +0100
References: <200611171033.kAHAXV97013086@toshiba.co.jp>
In-Reply-To: <200611171033.kAHAXV97013086@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611172228.02576.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 November 2006 11:33, Ishizaki Kou wrote:
> We don't think that standard binding for SPE exists. Do you have any
> proposal? If you have, please send us your binding.
>
> On our device tree, property "reg" has unit number. Addresses are in
> property "priv2", "problem" and "local-store". Because of LPAR
> environment, property "priv1" does not exist.

Unfortunately, we don't have any official binding documents for this,
but you can look at how both methods are used in the source code now.

There should not be any priv2, problem or local-store properties
any more. We have chosen the order of these register areas in the
"reg" property to be "local-store", "problem", "priv2", "priv1",
where the last one is optional so you don't need to provide one
in a hypervisor.

Similarly, there should no longer be a single "isrc" property,
but rather a standard "interrupts" property with three values
that can be mapped to an interrupt number each, for class
0, 1 and 2 interrupts.

	Arnd <><
