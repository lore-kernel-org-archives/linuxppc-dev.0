Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD23E2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Dec 2013 07:59:13 +1100 (EST)
Message-ID: <1386449914.21910.109.camel@pasglop>
Subject: Re: [PATCH] powerpc 8xx: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Date: Sun, 08 Dec 2013 07:58:34 +1100
In-Reply-To: <52A2ECE4.3050407@c-s.fr>
References: <20131127110406.6DC8E1A504F@localhost.localdomain>
 <1386356996.7375.120.camel@snotra.buserror.net> <52A2ECE4.3050407@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-12-07 at 10:39 +0100, christophe leroy wrote:
> Function setup_initial_memory_limit() in mm/init_32.c defines the
> limits 
> based on the parameters given by the bootloader.
> As far as I know, the 8xx doesn't do speculative access just because
> an area is loaded in a TLB Entry.

Speculative accesses are ... speculative :-) The address used for such
an access can be anything really. So yes, architecturally, powerpc
processors can access *anything* speculatively just because there's a
valid non-garded translation.

Whether the 8xx does it at all, I don't know. 44x originally did but
that was so buggy that we had to force G on all mappings (until later
versions of the core just burned the feature out). Pretty much all other
powerpc's do it.

Cheers,
Ben.
