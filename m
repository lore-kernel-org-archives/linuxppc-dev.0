Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D365DDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 13:21:05 +1000 (EST)
In-Reply-To: <11872134502476-git-send-email-timur@freescale.com>
References: <11872134502476-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
Date: Wed, 15 Aug 2007 22:22:36 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 15, 2007, at 4:30 PM, Timur Tabi wrote:

> This patch adds the setmaskedbits_xxx() macros, which are used to  
> set a
> multiple-bit bit pattern in a register.  The macros include a mask,  
> which
> zeros the respective bits before applying the value via a bitwise-OR.
> There are big-endian and little-endian versions for 8, 16, 32, and  
> 64 bits.
>
> These new macros are useful because the setbits macros can only be  
> used
> to set single-bit fields.  For example, if you have a 32-bit register
> where bits 17-20 need to be set to 0100, you would do
> setmaskedbits_be32(p, 4 << 11, 0xF << 11).
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Updated the changelog to include a reason why you'd want these macros.
> I have a number of new SOC device drivers coming up that will use  
> these
> macros, if this patch is accepted.

Can you post a driver that uses this.  I'm interested in seeing what  
the readability is really like using these macros.

- k
