Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CB892BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 11:16:05 +1100 (EST)
In-Reply-To: <OFF3BFC73F.53C5A7DE-ONC1256F4D.00564648-C1256F4D.0058DF9F@axxessit.no>
References: <OFF3BFC73F.53C5A7DE-ONC1256F4D.00564648-C1256F4D.0058DF9F@axxessit.no>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <11C15E9E-3765-11D9-A70B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 15 Nov 2004 19:18:41 -0500
To: morten.banzon@axxessit.no
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 15, 2004, at 11:10 AM, morten.banzon@axxessit.no wrote:

> I am using 2.6.9 for a mpc8280 project, and am having trouble using 
> dpram1
> from offset zero, which I need for a mcc hdlc driver.

Why does it have to start at zero?

>  In the file include/asm-ppc/cpm2.h there is a constant 
> CPM_DATAONLY_BASE
> In the same file the code comment say that the first 128 bytes are used
> for SMC1 and SMC2.

Yes, it is.

> When I examine the smc (cpm_uart) driver i do not find any reference to
> this region of the dpram1.

It's there somewhere, hardcoded with values 0, then sizeof() something 
is
probably added to it.

> I have replaced the calls to cpm_dpalloc with cpm_dpalloc_fixed and an
> adress way up in the dpram1 region.

Very bad idea.

> My question is; do you know which code is using the dpram1 addresses 
> below
> CPM_DATAONLY_BASE ?

The SMC1 and SMC2 peripherals, just like the comment says.

> This region must be used by something (smc ?), because when I clear 
> from
> offset 0x00 to 0x80 the serial port stop responding.

Yep.


	-- Dan
