Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 3160267A5C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 05:59:38 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id 2951A806979A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 15:59:40 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26283-03 for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 15:59:33 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id AFBBC8069794
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 15:59:33 -0400 (EDT)
Subject: Re: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
Content-Type: text/plain; charset=iso-8859-13
Date: Tue, 09 May 2006 15:52:24 -0400
Message-Id: <1147204345.3139.11.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-09 at 14:38 -0400, Kenneth Poole wrote:
> In our build, (currently based on 2.6.14.3) we define IMAP_ADDR as
> follows:
>=20
> #define IMAP_ADDR       (((bd_t *)__res)->bi_immr_base)

Yes, this is (part of) what our 2.6.11.7-based patch does.


> With very few exceptions, nearly all driver code that dereferences
> IMAP_ADDR can be used unchanged and the IMMR value is always the value
> passed up from the bootloader. We build one image that runs on
> multiple platforms and some platforms place the IMMR address space at
> different addresses than others. It=FFs not a constant.

Exactly.  I think this kind of "automatic adaption" to the particular
platform is what should be in the vanilla kernel.


> Regardless, I see little reason to ioremap() the IMMR address.

This was the second major part of our 2.6.11.7-based patch.  It
performed a single ioremap(), stored the result in a global pointer, and
then used that pointer in all the drivers instead of using IMAP_ADDR
directly.  Personally, I don't have a strong opinion yet as to whether
this is desirable or not.


> The MMU is set up in such a way that IMMR based locations can be
> accessed directly.

I'm still rather fuzzy on whether one can count on this always being the
case on all PPC variants.  (????)



> Ken Poole, MRV Communications, Inc.


Thanks!

Walt
