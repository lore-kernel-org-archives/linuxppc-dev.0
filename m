Return-Path: <scottwood@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23186B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Jan 2011 03:57:28 +1100 (EST)
Date: Fri, 28 Jan 2011 10:56:10 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2] gianfar: Fall back to software tcp/udp checksum on
	oldercontrollers
Message-ID: <20110128105610.4a518456@udp111988uds.am.freescale.net>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2E@saturn3.aculab.com>
References: <640295.36173.qm@web37608.mail.mud.yahoo.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2E@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 28 Jan 2011 09:10:46 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

>  
> > +		if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12)
> > +			     && ((unsigned long)fcb % 0x20) > 0x18)) {
> 
> You need to check the generated code, but I think you need:
> 
>     if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12))
> 	     && unlikely(((unsigned long)fcb % 0x20) > 0x18))
> 
> ie unlikely() around both the primitive comparisons.

Is the first condition actually unlikely?  If you've got affected
hardware, you'll hit it every time.

If packets with the problematic alignment are rare, seems like it'd be
better to check that first.

-Scott
