Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93734DDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 09:33:49 +1100 (EST)
Date: Thu, 20 Mar 2008 15:33:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 2/2 v2] Add DIU platform code for MPC8610HPCD
Message-Id: <20080320153304.cdc1817d.akpm@linux-foundation.org>
In-Reply-To: <12059526271964-git-send-email-yorksun@freescale.com>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<12059526271964-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Mar 2008 13:50:27 -0500
York Sun <yorksun@freescale.com> wrote:

> Add platform code to support Freescale DIU. The platform code includes
> framebuffer memory allocation, pixel format, monitor port, etc.
>
> ...
>
> +unsigned int mpc8610hpcd_get_pixel_format
> +	(unsigned int bits_per_pixel, int monitor_port)

Again, please do

unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
					int monitor_port)

(and anywhere else where this was done)

> +int __init preallocate_diu_videomemory(void);

Nope, please don't put extern declarations in .c files.  Find a suitable
header for it - one which is included by the defining file and by all users
of the symbol.

Andy, checkpatch missed this.

>  }
>  #endif
> +
