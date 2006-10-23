Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5815967C1A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 02:50:26 +1000 (EST)
In-Reply-To: <11892067.4322551161617453238.JavaMail.root@vms069.mailsrvcs.net>
References: <11892067.4322551161617453238.JavaMail.root@vms069.mailsrvcs.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F886CBFA-4710-4185-AA99-92EDEE3F2FE8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Mon, 23 Oct 2006 18:49:58 +0200
To: mrz5149@acm.org
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> ll a sync tells you is that an I/O made it out of the CPU. The  
> problem is, there may be other places a write could get hung up.  
> For instance, sometimes devices sit behind a bridge with a write  
> FIFO. In such a scenario, you can't be sure a write has made it to  
> the device until you do a read to flush the FIFO.

It's not enough that a write made it to the device even -- you
have to make sure the device has acted on it.

> If you're trying to figure out the minimum thing to do (eieio,  
> sync, read-back, etc.) you have to understand what your system is  
> doing between the store and the bits going into the register.

What the system is doing, and also what exactly you want to
accomplish (what ordering and what completion you depend on).

> It may be that a sync is enough, but you won't know until you fully  
> understand the system's bus/bridge topolgy between the CPU and the  
> device.

If a sync after an MMIO write is enough, then (in almost all
cases) so is an eieio.


Segher
