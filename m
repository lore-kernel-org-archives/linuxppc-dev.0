Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73777B6F15
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 21:12:01 +1000 (EST)
Message-ID: <57727.84.105.60.153.1277464103.squirrel@gate.crashing.org>
In-Reply-To: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
Date: Fri, 25 Jun 2010 13:08:23 +0200 (CEST)
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Jakub Jelinek" <jakub@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -		stw%U0%X0 %L2,%1"
> -	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> +		stw%U1%X1 %L2,%1"
> +	: "=m<>" (*ptep), "=m<>" (*((unsigned char *)ptep+4))
>  	: "r" (pte) : "memory");

This still isn't correct -- the constraint says that a byte
is written, but the insn changes a word.  Probably should just
be ptep[1] ?


Segher
