Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17680.31951.464796.856782@cargo.ozlabs.ibm.com>
Date: Wed, 20 Sep 2006 09:27:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: Fw: [PATCH] Remove powerpc specific parts of 3c509 driver
In-Reply-To: <20060919184243.GL29167@austin.ibm.com>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	netdev@vger.kernel.org, jgarzik@pobox.com,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> The rest of this patch might indeed be correct, but the above comment 
> bothers me. The "ns" versions of routines are supposed to be
> non-byte-swapped versions of the insl/outsl routines (which would
> byte-swap on big-endian archs such as powerpc.)

If it were true that in/outsw and in/outsl were actually used to
transfer arrays of 16-bit data items or 32-bit data items to/from an
I/O device, I would agree with you, but they aren't.  They are
universally used to transfer arrays of bytes, with the optimization of
doing so 2 or 4 bytes at a time.  That is why in/outsw and in/outsl
don't (and shouldn't) do byte swapping.

Paul.
