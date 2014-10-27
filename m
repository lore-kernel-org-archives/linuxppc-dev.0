Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9CFF1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 03:45:18 +1100 (AEDT)
Message-ID: <1414428304.23458.13.camel@snotra.buserror.net>
Subject: Re: What is the reel purpose of in_beXX() and out_beXX() fonctions ?
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Mon, 27 Oct 2014 11:45:04 -0500
In-Reply-To: <544E3FF6.7090300@c-s.fr>
References: <544E3FF6.7090300@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-27 at 13:52 +0100, leroy christophe wrote:
> Many drivers use in_be16(), in_be32(), out_be16(), out_be32(), etc .... 
> to access to registrers in IO mapped memory.
> 
> What is the real purpose of those functions, and are they really needed ?
> 
> ioremap() maps the related areas as GUARDED, which means that accesses 
> can't be speculative. So what is the benefit of using in_beXX() and 
> out_beXX() over simple memory accesses in the area ?

Speculative accesses aren't the only issue -- there's also hardware
reordering (some implementations may not do this on guarded regions, but
I don't think it's architecturally guaranteed), and of course you need
to make sure the compiler doesn't do anything funny.

-Scott
