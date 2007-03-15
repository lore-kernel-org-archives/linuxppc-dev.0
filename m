Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92101DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 16:36:14 +1100 (EST)
Date: Thu, 15 Mar 2007 05:36:07 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 10/13] BLK_DEV_IDE_CELLEB dependency fix
Message-ID: <20070315053607.GQ4095@ftp.linux.org.uk>
References: <E1HRPb0-0003Eh-OG@ZenIV.linux.org.uk>
	<200703150523.l2F5NelE001987@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703150523.l2F5NelE001987@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 02:25:40PM +0900, Akira Iguchi wrote:
> Al wrote:
> >
> >It's bool and it depends on IDE => should depend on IDE=y
> >
> >Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Move to "if BLK_DEV_IDEDMA_PCI" block because it depends on 
> BLK_DEV_IDEDMA_PCI.

> +config BLK_DEV_IDE_CELLEB
> +	bool "Toshiba's Cell Reference Set IDE support"
> +	depends on PPC_CELLEB
> +	help
> +	  This driver provides support for the built-in IDE controller on
> +	  Toshiba Cell Reference Board.
> +	  If unsure, say Y.
> +

Eh...  You still need dependency on IDE=y; otherwise you'll get configs
with IDE=m, BLK_DEV_IDE_CELLEB=y and those won't link.  BLK_DEV_IDEDMA_PCI
is selectable just fine with IDE=m.

It's the same problem as with ps3 fb.
