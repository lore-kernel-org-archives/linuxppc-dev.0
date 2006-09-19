Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 119EA67A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:57:19 +1000 (EST)
In-Reply-To: <20060919193020.GN29167@austin.ibm.com>
References: <20060919193020.GN29167@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <72674737-8325-48FA-B04F-C4ADCA2E2BF9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc: clarify use of twi/isync in io macros
Date: Tue, 19 Sep 2006 21:57:11 +0200
To: linas@austin.ibm.com (Linas Vepstas)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> + *
> + * Read operations have additional twi & isync to make sure the read
> + * is actually performed (i.e. the data has come back) before we  
> start
> + * executing any following instructions.
> + *
> + * A data-dependent branch followed by an isync ensures that no
> + * instructions after the isync in program order will be
> + * (speculatively) executed

..."before the isync has completed, and it won't complete until
the branch is resolved;"...

> so the load that the twi depends
> + * on has to complete before anything else is executed; in
> + * particular, it's a barrier to keep MMIO reads ordered before
> + * main-storage accesses.
>   */

You shouldn't post my test and put your signed-off on it, esp.
if I forgot to type half a sentence :-)  Here, have one though:

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>



Segher
