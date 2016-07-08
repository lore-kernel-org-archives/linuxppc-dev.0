Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm94t0Tv3zDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 20:01:49 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arvind Yadav' <arvind.yadav.cs@gmail.com>, "leoli@freescale.com"
 <leoli@freescale.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Need proper type casting before assignment, Remove
 compilation Warning.
Date: Fri, 8 Jul 2016 09:59:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4F3647@AcuExch.aculab.com>
References: <1467916674-8418-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1467916674-8418-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arvind Yadav
> Sent: 07 July 2016 19:38
> -Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
> assigned in ucc_fast_tx_virtual_fifo_base_offset and
> ucc_fast_rx_virtual_fifo_base_offset. These variable are 'unsigned int'.
> So before assginment need a proper type casting.

Are you sure, seems to me that the type of one of the fields is wrong.
The casts you are adding do not aid readability at all.

> -Passing value in IS_ERR_VALUE() is wrong, as they pass an 'int'
> into a function that takes an 'unsigned long' argument.This happens
> to work because the type is sign-extended on 64-bit architectures
> before it gets converted into an unsigned type.
>=20
> -Passing an 'unsigned short' or 'unsigned int'argument into
> IS_ERR_VALUE() is guaranteed to be broken, as are 8-bit integers
> and types that are wider than 'unsigned long'.

Signed 8 and 16 bit values will be sign extended to 'int' before being
used in any arithmetic operation.
Unsigned ones get zero extended to 'int'.

That probably means you shouldn't be using IS_ERR_VALUE().

	David
