Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 711B1DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:15:18 +1000 (EST)
Message-Id: <68A81421-0CE8-446D-99B8-C4E7DE750456@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080523163906.GG16137@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 7/7] [POWERPC] qe_lib: switch to the cpm_muram
	implementation
Date: Tue, 10 Jun 2008 11:15:07 -0500
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163906.GG16137@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 11:39 AM, Anton Vorontsov wrote:

> This is very trivial patch. We're transitioning to the cpm_muram_*
> calls. That's it.
>
> Less trivial changes:
> - BD_SC_* defines were defined in the cpm.h and qe.h, so to avoid  
> redefines
>  we remove BD_SC from the qe.h and use cpm.h along with cpm_muram_*
>  prototypes;
> - qe_muram_dump was unused and thus removed;
> - added some code to the cpm_common.c to support legacy QE bindings
>  (data-only node name).
> - For convenience, define qe_* calls to cpm_*. So drivers need not  
> to be
>  changed.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/Makefile     |    1 +
> arch/powerpc/sysdev/cpm_common.c |   16 +++++-
> arch/powerpc/sysdev/qe_lib/qe.c  |   92  
> --------------------------------------
> include/asm-powerpc/cpm.h        |    1 +
> include/asm-powerpc/qe.h         |   36 +++-----------
> 5 files changed, 23 insertions(+), 123 deletions(-)

applied.

- k
