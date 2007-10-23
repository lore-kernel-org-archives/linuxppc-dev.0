Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18206.32904.672941.222334@cargo.ozlabs.ibm.com>
Date: Wed, 24 Oct 2007 09:15:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
In-Reply-To: <200710222012.20316.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
	<E0BC0C69-03B1-4F7A-9DEC-0EA9DAC92FB7@kernel.crashing.org>
	<200710222012.20316.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yuri Tikhonov writes:

>  No it isn't the violation.
> 
>  As stated in "System V ABI. PowerPC processor supplement"
> (on which the "Linux Standard Base Core Specification for PPC32"
> is based): " ... Virtual addresses and file offsets for the PowerPC processor family 
> segments are congruent modulo 64 Kbytes (0x10000) or larger powers of 2...".

I'm afraid it is a violation.

In the "Operating System Interface" chapter, "Page Size" section (page
3-23 in the copy I have), it says: "Currently, the only valid hardware
page size for the PowerPC Architecture is 4096 bytes (4 Kbytes), but
this ABI allows the underlying operating system to cluster pages into
logical power-of-two page sizes up to 65536 bytes (64 Kbytes)."

The section you quoted says that ELF binaries may use a larger
congruency, not that the OS may use a larger page size.  In fact the
largest page size that the OS may use is the *smallest* congruency
that ELF binaries may use.

Of course, nothing says that you can't use kernels and binaries that
are not SVR4-compliant on your own machines.  But not being
SVR4-compliant certainly limits their general usefulness.

Paul.
