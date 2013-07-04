Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 148562C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 18:31:51 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 18602-04 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  4 Jul 2013 09:31:47 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] Emulate sync instruction variants
Date: Thu, 4 Jul 2013 09:31:19 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72CA@saturn3.aculab.com>
In-Reply-To: <1372886807-12109-1-git-send-email-James.Yang@freescale.com>
References: <1372886807-12109-1-git-send-email-James.Yang@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <James.Yang@freescale.com>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Reserved fields of the sync instruction have been used for other
> instructions (e.g. lwsync).  On processors that do not support =
variants
> of the sync instruction, emulate it by executing a sync to subsume the
> effect of the intended instruction.
...
> +	/* Emulate sync instruction variants */
> +	if ((instword & PPC_INST_SYNC_MASK) =3D=3D PPC_INST_SYNC) {
> +		PPC_WARN_EMULATED(sync, regs);
> +		asm volatile ("sync");
> +		return 0;
> +	}

Do you need to execute 'sync' here?
It is worth checking whether the trap entry/exit doesn't
do an implicit one for you.

	David
