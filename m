Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 416F9DDF93
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 06:21:13 +1000 (EST)
In-Reply-To: <4638F0C4.2000406@freescale.com>
References: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
	<F1B250DD-A472-470F-B3D0-EBB2F042E454@kernel.crashing.org>
	<4638F0C4.2000406@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA9554A4-5A7D-4E03-BE28-C4B6B80D9DB9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] gianfar: Add I/O barriers when touching buffer
	descriptor ownership.
Date: Wed, 2 May 2007 15:20:25 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2007, at 3:12 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> I'd rather see a wmb() instead of eieio() to keep this code non- 
>> ppc  specific.  (also, we implement wmb as eieio, so I don't keep  
>> the  comment about it being too heavy, unless you mean generically).
>
> wmb() is a sync, smp_wmb() is an eieio.  Andy told me he would not  
> accept a sync in those spots.

Sorry, was looking at the iobarrier code.

> And the driver is already ppc-specific; it uses in/out_be32.

True, but its hidden behind the gfar_read/write accessors.

Your change is a bit more blatant.

- k
