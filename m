Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2B84DE084
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:01:45 +1100 (EST)
Message-Id: <2E8B027E-CE92-48CC-8143-D23D8CD252C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <B13201@freescale.com>
In-Reply-To: <11972628522442-git-send-email-b13201@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix rounding bug in emulation for double float operating
Date: Thu, 13 Dec 2007 23:01:36 -0600
References: <11972628522442-git-send-email-b13201@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2007, at 11:00 PM, Liu Yu wrote:

>
> This patch fixes rounding bug in emulation for double float  
> operating on PowerPC platform.
>
> When pack double float operand, it need to truncate the tail due to  
> the limited precision.
> If the truncated part is not zero, the last bit of work bit (totally  
> 3 bits) need to '|' 1.
>
> This patch is completed in _FP_FRAC_SRS_2(X,N,sz) (arch/powerpc/math- 
> emu/op-2.h).
> Originally the code leftwards rotates the operand to just keep the  
> truncated part,
> then check whether it is zero. However, the number it rotates is not  
> correct when
> N is not smaller than _FP_W_TYPE_SIZE, and it will cause the work  
> bit '|' 1 in the improper case.
>
> This patch fixes this issue.
>
> Signed-off-by: Liu Yu <b13201@freescale.com>
>
> ---
> arch/powerpc/math-emu/op-2.h |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

applied.

- k
