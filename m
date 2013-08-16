Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 895EE2C028C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 07:34:28 +1000 (EST)
Message-ID: <1376688855.31636.297.camel@snotra.buserror.net>
Subject: Re: [RFC] powerpc: put the common parts of the ppc64*defconfigs in
 a Kconfig file
From: Scott Wood <scottwood@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 16 Aug 2013 16:34:15 -0500
In-Reply-To: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
References: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-09 at 16:24 +1000, Stephen Rothwell wrote:
> We cannot put the unsetting of config options in the Kconfig file, nor
> the integer or string options.
> 
> I checked that after this we get the same .config files generated (except
> for the addition of the new PPC64_DEFCONFIG* config options.
> 
> Any thoughts?

Won't this bypass the dependency mechanism?  While the dependencies
should already be satisfied currently, nothing would prevent them from
being switched off later.  Even if you have all the dependencies listed
in the "select", what if dependencies change later?

It seems like it would be better to have a way to apply multiple
defconfigs at once, and/or have one defconfig include another.

-Scott
