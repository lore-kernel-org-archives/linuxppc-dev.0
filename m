Return-Path: <dgibson@ozlabs.org>
Date: Mon, 10 Dec 2007 15:56:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yu <b13201@freescale.com>
Subject: Re: [PATCH] Fix rounding bug in emulation for double float operating
Message-ID: <20071210045616.GC29611@localhost.localdomain>
References: <11972628522442-git-send-email-b13201@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11972628522442-git-send-email-b13201@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, Dec 10, 2007 at 01:00:52PM +0800, Liu Yu wrote:
> 
> This patch fixes rounding bug in emulation for double float operating on PowerPC platform.
> 
> When pack double float operand, it need to truncate the tail due to the limited precision.
> If the truncated part is not zero, the last bit of work bit (totally 3 bits) need to '|' 1.
> 
> This patch is completed in _FP_FRAC_SRS_2(X,N,sz) (arch/powerpc/math-emu/op-2.h).
> Originally the code leftwards rotates the operand to just keep the truncated part,
> then check whether it is zero. However, the number it rotates is not correct when
> N is not smaller than _FP_W_TYPE_SIZE, and it will cause the work bit '|' 1 in the improper case.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Liu Yu <b13201@freescale.com>

Wow someone deciphered the hideous macro hell of the math emulation
code enough to fix a bug.  I don't suppose you'd care to fix the
millions of warnings that the math-emu code generates...?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
