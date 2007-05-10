Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28E99DDEE6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:20:21 +1000 (EST)
Date: Thu, 10 May 2007 00:15:43 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v4] powerpc: change rheap functions to use ulongs instead
	of pointers
In-Reply-To: <11786535963742-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0705100015270.27791@localhost.localdomain>
References: <11786535963742-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007, Timur Tabi wrote:

> The rheap allocation functions return a pointer, but the actual value is based
> on how the heap was initialized, and so it can be anything, e.g. an offset
> into a buffer.  A ulong is a better representation of the value returned by
> the allocation functions.
>
> This patch changes all of the relevant rheap functions to use a unsigned long
> integers instead of a pointer.  In case of an error, the value returned is
> a negative error code that has been cast to an unsigned long.  The caller can
> use the IS_ERR_VALUE() macro to check for this.
>
> All code which calls the rheap functions is updated accordingly.  Macros
> IS_MURAM_ERR() and IS_DPERR(), have been deleted in favor of IS_ERR_VALUE().
>
> Also added error checking to rh_attach_region().
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

applied.

- k
