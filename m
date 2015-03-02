Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [65.49.60.145])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2E471A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 09:09:25 +1100 (AEDT)
Date: Mon, 2 Mar 2015 17:09:24 -0500
From: Martin Hicks <mort@bork.org>
To: Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
Message-ID: <20150302220923.GC30523@darwin.bork.org>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com> <54F475A8.6030105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54F475A8.6030105@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Martin Hicks <mort@bork.org>,
 linux-crypto@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, Mar 02, 2015 at 03:37:28PM +0100, Milan Broz wrote:
> 
> If crypto API allows to encrypt more sectors in one run
> (handling IV internally) dmcrypt can be modified of course.
> 
> But do not forget we can use another IV (not only sequential number)
> e.g. ESSIV with XTS as well (even if it doesn't make much sense, some people
> are using it).

Interesting, I'd not considered using XTS with an IV other than plain/64.
The talitos hardware would not support aes/xts in any mode other than
plain/plain64 I don't think...Although perhaps you could push in an 8-byte
IV and the hardware would interpret it as the sector #.

> Maybe the following question would be if the dmcrypt sector IV algorithms
> should moved into crypto API as well.
> (But because I misused dmcrypt IVs hooks for some additional operations
> for loopAES and old Truecrypt CBC mode, it is not so simple...)

Speaking again with talitos in mind, there would be no advantage for this
hardware.  Although larger requests are possible only a single IV can be
provided per request, so for algorithms like AES-CBC and dm-crypt 512byte IOs
are the only option (short of switching to 4kB block size).

mh

-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
