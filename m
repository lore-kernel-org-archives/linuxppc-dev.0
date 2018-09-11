Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428jSk0tmmzF37t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:32:37 +1000 (AEST)
Date: Tue, 11 Sep 2018 06:32:28 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 1/2] powerpc/boot: Fix crt0.S syntax for clang
Message-ID: <20180911113228.GF23155@gate.crashing.org>
References: <20180910085714.4834-1-joel@jms.id.au>
 <20180910085714.4834-2-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910085714.4834-2-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 06:57:13PM +1000, Joel Stanley wrote:
> Clang's assembler does not like the syntax of the cmpdi:
> 
>  arch/powerpc/boot/crt0.S:168:22: error: unexpected modifier on variable reference
>          cmpdi   12,RELACOUNT@l
>                               ^
>  arch/powerpc/boot/crt0.S:168:11: error: unknown operand
>          cmpdi   12,RELACOUNT@l
>                    ^
> Enclosing RELACOUNT in () makes it is happy. Tested with GCC 8 and Clang
> 8 (trunk).

Is clang going to fix this?  You also might want to add a comment that
this is a workaround for that broken assembler.


Segher
