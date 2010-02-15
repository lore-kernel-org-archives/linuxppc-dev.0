Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77938B7C06
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 10:13:25 +1100 (EST)
Message-ID: <4B79C775.1050903@zytor.com>
Date: Mon, 15 Feb 2010 14:15:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: register long sp asm("r1") incorrect
References: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>	
	<1265866273.16346.34.camel@pasglop>	
	<20100215073405.GB20456@atrey.karlin.mff.cuni.cz>	
	<1266263992.16346.125.camel@pasglop>
	<20100215202854.GA21601@elf.ucw.cz>
	<1266267898.16346.135.camel@pasglop>
In-Reply-To: <1266267898.16346.135.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Pavel Machek <pavel@ucw.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2010 01:04 PM, Benjamin Herrenschmidt wrote:
> 
> It's true that most other use of it we have are global scope (local_paca
> in r13, glibc use of r2/r13, etc...) afaik, but since r1 itself is the
> stack pointer always, I think they pretty much guarantee it works.
> 

It should work, because r1, being the stack pointer, is already marked a
reserved register in gcc.

The reference Pavel is citing bascially states that gcc won't globally
reserve the register, which is true, but it is already reserved anyway.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
