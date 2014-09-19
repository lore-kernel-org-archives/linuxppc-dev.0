Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 5A9FE1A0497
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Sep 2014 01:46:45 +1000 (EST)
In-Reply-To: <20140919135756.A060D1AB26D@localhost.localdomain>
References: <20140919135756.A060D1AB26D@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] powerpc32: add support for csum_add()
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF808E087E.AC49C5B7-ONC1257D58.0055AC30-C1257D58.0056ACBD@transmode.se>
Date: Fri, 19 Sep 2014 17:46:42 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/09/19 15:57:56:

> +#define HAVE_ARCH_CSUM_ADD
> +static inline __wsum csum_add(__wsum csum, __wsum addend)
> +{
> +    __asm__("\n\
> +   addc %0,%0,%1 \n\
> +   addze %0,%0 \n\
> +   "
> +   : "=r" (csum)
> +   : "r" (addend), "0"(csum));

hmm, I wonder if not this is better written as:
: "+r" (csum): "r" (addend))

  Jocke
