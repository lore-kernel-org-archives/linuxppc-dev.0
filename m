Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C6B32BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 07:10:46 +1100 (EST)
In-Reply-To: <1101236780.41a38a2c7f44f@webmail.televes.com:443>
References: <1101236780.41a38a2c7f44f@webmail.televes.com:443>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2515D492-3D8C-11D9-B8D4-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 23 Nov 2004 15:13:31 -0500
To: alebas@televes.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6 hangs at m82xx_board_init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 23, 2004, at 2:06 PM, alebas@televes.com wrote:

> When this code is executed, the kernel jumps directly to another
> address, 0xc000984c,

I suspect the MMU isn't yet set up to map the address of the BCSR.
Access the address causes a fault, and the "jump" you see is the
result of executing a bunch of exception handler instructions that
you won't single step due to the exception priorities.



	-- Dan
