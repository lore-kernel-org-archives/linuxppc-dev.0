Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5CF2ADDEEB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 01:44:34 +1000 (EST)
Message-ID: <480E07BC.3050107@ru.mvista.com>
Date: Tue, 22 Apr 2008 19:43:56 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] atyfb: Fix 64 bits resources on 32 bits archs
References: <20080422012726.42775DE2A3@ozlabs.org>
In-Reply-To: <20080422012726.42775DE2A3@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, adaplas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> This fixes atyfb to not truncate 64 bits resources on 32 bits
> platforms. Unfortunately, there are still issues with addresses
> returned to userspace via struct fb_fix_screeninfo. This will
> have to be dealt with separately.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[...]
> --- linux-work.orig/drivers/video/aty/atyfb_base.c	2008-04-22 11:21:46.000000000 +1000
> +++ linux-work/drivers/video/aty/atyfb_base.c	2008-04-22 11:23:58.000000000 +1000
> @@ -2842,7 +2842,7 @@ static int atyfb_setcolreg(u_int regno, 
>  #ifdef __sparc__
>  
>  static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
> -			struct fb_info *info, unsigned long addr)
> +			struct fb_info *info, resource_size_t addr)

    Not sure what that change gives us -- this function mostly treats 'addr' 
as unsigned long (casting it to char/void *), ot compares it to 'unsigned 
long' 'base' variable -- which should be made 'resource_size_t' in its turn 
being assigned resource's start value.  So, this part of patch looks incomplete
(and yet I'm not sure if SPARC really needs all that)...

WBR, Sergei
