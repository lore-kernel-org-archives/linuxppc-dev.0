Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBDA9687E7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 06:05:49 +1100 (EST)
Date: Wed, 23 Nov 2005 13:02:59 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20051123185523.GC8336@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0511231253050.4255-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Add support for building uImages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Nov 2005, Sam Ravnborg wrote:

> On Wed, Nov 23, 2005 at 12:43:15PM -0600, Kumar Gala wrote:
> > +
> > +$(obj)/uImage: $(obj)/vmlinux.gz
> > +	$(Q)rm -f $@
> > +	$(call if_changed,uimage)
> > +	@echo -n '  Image: $@ '
> > +	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
> 
> The above is suboptimal. The $(call if_changed,uimage) will execute
> $(cmd_uimage) if 1) prerequisites has changed or 2) the command to execute
> has changed.
> In the above case 1) is always true, otherwise we would not reach the
> statement. So change it to $(call cmd,uimage) is the correct way.
> 
> The 'bug' is also present in ppc/boot/images

thanks.  I'll send a follow up patch to fix both cases.

- kumar
