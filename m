Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AAC6EDE1C7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:33:17 +1000 (EST)
Subject: Re: issues w/init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:33:08 +0200
Message-Id: <1239953588.7443.40.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 13:21 -0500, Kumar Gala wrote:
> Ben,
> 
> The following patch is causing me issues w/init SEGV on boot.  This is  
> a pretty old version of init and I'm wondering what the commit you had  
> related to old ABI breakage:

Can you test if the binary is trying to execute something that is
in a program section that isn't marked executable ? It could be
that it's build with a very old and broken toolchains.

(Note that when we finally add proper per-page exec permission support,
this will -also- break there even if we avoid that test below).

Maybe we can make a .config option for supporting obsolete crap that
tries to execute out of non executable sections ?

Cheers,
Ben.

> commit 8d30c14cab30d405a05f2aaceda1e9ad57800f36
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Feb 10 16:02:37 2009 +0000
> 
>      powerpc/mm: Rework I$/D$ coherency (v3)
> 
>      This patch reworks the way we do I and D cache coherency on  
> PowerPC.
> 
> 
> ---
>                  /*
>                   * Allow execution from readable areas if the MMU  
> does not
>                   * provide separate controls over reading and  
> executing.
> +                *
> +                * Note: That code used to not be enabled for 4xx/BookE.
> +                * It is now as I/D cache coherency for these is done at
> +                * set_pte_at() time and I see no reason why the test
> +                * below wouldn't be valid on those processors. This - 
> may-
> +                * break programs compiled with a really old ABI though.
>                   */
> 
> - k
