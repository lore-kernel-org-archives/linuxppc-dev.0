Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.43037.407086.355772@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 09:41:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: alignment exceptionhandler sleeps in invalid context
In-Reply-To: <27BDABD8-B970-4F2C-AA0A-07D55A9D3303@kernel.crashing.org>
References: <20060424173246.GA22318@suse.de>
	<17489.63055.968862.256370@cargo.ozlabs.ibm.com>
	<20060428111942.GA15646@suse.de>
	<27BDABD8-B970-4F2C-AA0A-07D55A9D3303@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> I was going to ask how this was actually hit.  It seems odd that we  
> would have an alignment error in the network stack.  From the oops  
> can we determine what the instruction was that faulted and what  
> address it was trying to access.

No, it's not particularly odd, given that our get_unaligned() and
put_unaligned() in include/asm-powerpc/unaligned.h just do a single
access.  That makes the common case (address is actually aligned, or
cpu handles it in hardware) fast at the expense of occasionally taking
an alignment exception.

Paul.
