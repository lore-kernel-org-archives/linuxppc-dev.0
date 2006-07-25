Return-Path: <amodra@bigpond.net.au>
Received: from qsrv03ps.mx.bigpond.com (qsrv03ps.mx.bigpond.com
	[144.140.82.183]) by ozlabs.org (Postfix) with ESMTP id E157467B62
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 12:59:11 +1000 (EST)
Date: Tue, 25 Jul 2006 11:45:58 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Jonathan Bartlett <johnnyb@eskimo.com>
Subject: Re: Why the "opd" section?
Message-ID: <20060725021558.GG6872@bubble.grove.modra.org>
References: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 23, 2006 at 09:01:38PM -0700, Jonathan Bartlett wrote:
> I'm learning PPC64 assembly language, and I found the existence of the
> "opd" sections containing function descriptors quite odd.  What is the use
> of these?  Are they used by the linker?  Why are they needed in the 64-bit
> ELF platforms and not the 32-bit ones?

OPD is an array of function pointers.  Function pointers on powerpc64
are not just simple pointers to some code;  They specify the code entry
point, the TOC pointer, and the static chain pointer (unused by C).
To call a function, you need to know all these values because functions
do not initialise their own TOC pointer.  This allows for more efficient
code.  The compiler/linker can omit the TOC pointer load when both
caller and callee are known to share the same TOC.  (In many ways, the
TOC is like the powerpc32 GOT.  powerpc32 -fpic/PIC code initialises the
GOT pointer on entry to every function, even when caller and callee are
known to have the same GOT pointer.)

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
