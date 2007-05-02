Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7079DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 07:24:31 +1000 (EST)
In-Reply-To: <4638F734.2040809@freescale.com>
References: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
	<F1B250DD-A472-470F-B3D0-EBB2F042E454@kernel.crashing.org>
	<4638F0C4.2000406@freescale.com>
	<FA9554A4-5A7D-4E03-BE28-C4B6B80D9DB9@kernel.crashing.org>
	<4638F734.2040809@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41B347BE-06AA-4346-BEFB-19DFB52AC533@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] gianfar: Add I/O barriers when touching buffer
	descriptor ownership.
Date: Wed, 2 May 2007 16:23:42 -0500
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


On May 2, 2007, at 3:40 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On May 2, 2007, at 3:12 PM, Scott Wood wrote:
>>> wmb() is a sync, smp_wmb() is an eieio.  Andy told me he would  
>>> not  accept a sync in those spots.
>> Sorry, was looking at the iobarrier code.
>>> And the driver is already ppc-specific; it uses in/out_be32.
>> True, but its hidden behind the gfar_read/write accessors.
>> Your change is a bit more blatant.
>
> Well, Segher doesn't want me to use iobarrier (because it's not I/ 
> O). Andy doesn't want me to use wmb() (because it's sync).  I don't  
> think something like gfar_wmb() would be appropriate.  So the  
> remaining options are either eieio(), or a new non-arch-specific,  
> non-driver-specific mem_wmb() (or whatever).
>
> While I like the latter option, I don't think this bugfix should  
> have to wait for it.

Ok, I've resigned to the eieio's.  If we end up respinning the patch  
again for any reason I'd like to see something in the commit comment  
to the fact that we are adding ppc specific sync operations.

Why doesn't marking the bdp pointer volatile resolve the issue in  
gfar_clean_rx_ring() to ensure load ordering?

- k
