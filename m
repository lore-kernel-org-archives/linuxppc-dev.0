Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B166DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:43:05 +1000 (EST)
Message-ID: <4613E39A.70606@freescale.com>
Date: Wed, 04 Apr 2007 12:42:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
In-Reply-To: <F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I'm concerned the error handling isn't correctly.  What happens if  
> the rheap I'm managing has addresses at 0xf0000000.  When I compare  
> offset to 0, its going to report as an error, even if the offset  
> returned is valid.

The return value is an offset INTO the actual buffer.  Unless you have buffer larger than 
2GB, the return value will never be negative unless it's an error.  So technically, the 
maximum size of the remote heap is 2GB.  It doesn't matter where it was located.

Please keep in mind that I'm not changing the actual numeric values that are being 
returned.  I'm only changing the types, because they were wrong.  rh_alloc() was returning 
a void pointer, but it was NEVER a pointer.  It was always a simple offset.  The first 
time you call rh_alloc(), you will get back a value of 0, because that's the beginning of 
the heap.  This patch doesn't change that.  It changes the types.

Having said that, the code used to support heaps as large as 4GB - 4096, and now it 
supports heaps as large as 2GB.  I don't think that's a problem, but I can add a comment 
to that effect in the changelog.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
