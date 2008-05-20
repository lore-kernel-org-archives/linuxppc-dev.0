Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18783DDFFB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 07:37:13 +1000 (EST)
Message-ID: <483344C0.3020703@freescale.com>
Date: Tue, 20 May 2008 16:38:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>
In-Reply-To: <1211318219.8297.177.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-05-20 at 13:40 -0700, Trent Piepho wrote:
>> There was some discussion on a Freescale list if the powerpc I/O accessors
>> should be strictly ordered w.r.t.  normal memory.  Currently they are not.  It
>> does not appear as if any other architecture's I/O accessors are strictly
>> ordered in this manner.  memory-barriers.txt explicitly states that the I/O
>> space (inb, outw, etc.) are NOT strictly ordered w.r.t. normal memory
>> accesses and it's implied the other I/O accessors (e.g., writel) are the same.
>>
>> However, it is somewhat harder to program for this model, and there are almost
>> certainly a number of drivers using coherent DMA which have subtle bugs because
>> the do not include the necessary barriers.
>>
>> But clearly and change to this would be a subject for a different patch.
> 
> The current accessors should provide all the necessary ordering
> guarantees...

It looks like we rely on -fno-strict-aliasing to prevent reordering 
ordinary memory accesses (such as to DMA descriptors) past the I/O 
access.  It won't prevent reordering of memory reads around an I/O read, 
though, which could be a problem if the I/O read result determines the 
validity of the DMA buffer.  IMHO, a memory clobber would be better.

-Scott
