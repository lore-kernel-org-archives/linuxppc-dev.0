Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC7mS5xVhzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 12:22:48 +1100 (AEDT)
Date: Mon, 30 Jan 2017 19:22:33 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] powerpc/32: fix handling of stack protector with
 recent GCC
Message-ID: <20170131012233.GC21840@gate.crashing.org>
References: <20170116090031.4843668B50@localhost.localdomain>
 <alpine.DEB.2.20.999.1701301611590.3270@trent.utfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.999.1701301611590.3270@trent.utfs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2017 at 04:12:53PM -0800, Christian Kujau wrote:
> On Mon, 16 Jan 2017, Christophe Leroy wrote:
> > Since 2005, powerpc GCC doesn't manage anymore __stack_chk_guard as
> > a global variable but as some value located at -0x7008(r2)
> 
> Is this still an "RFC" or is there a chance that this will land in 4.10?

Older GCC (i.e. not ancient, but < 7 currently; the new options will be
backported to 5 and 6) doesn't always use TLS stack canaries either: it
depends on how your GCC is configured.  The kernel will have to detect
if the GCC it uses knows the new options, and if not, if it still wants
to use SSP it has to detect what GCC uses to get at the canary.

This patch as-is won't work.


Segher
