Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1D81B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 13:11:19 +1100 (EST)
Message-ID: <1322705472.3729.11.camel@pasglop>
Subject: Re: [PATCH] powerpc/nvram: Add spinlock to oops_to_nvram to prevent
 oops in compression code.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 01 Dec 2011 13:11:12 +1100
In-Reply-To: <20111201124645.24c6e54f@kryten>
References: <20111201124645.24c6e54f@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@us.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 12:46 +1100, Anton Blanchard wrote:
> When issuing a system reset we almost always oops in the oops_to_nvram
> code because multiple CPUs are using the deflate work area. Add a
> spinlock to protect it.
> 
> To play it safe I'm using trylock to avoid locking up if the NVRAM
> code oopses. This means we might miss multiple CPUs oopsing at exactly
> the same time but I think it's best to play it safe for now. Once we
> are happy with the reliability we can change it to a full spinlock.

How would we miss ?

trylock does loop on stwcx. failure, it doesn't loop if the lock is
-taken-, so if the lock is only used for actually dealing with the oops
the only "miss" is because somebody already got it... or am I missing
something ?

Cheers,
Ben.
