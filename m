Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3585DDDF01
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 12:11:30 +1100 (EST)
Date: Tue, 20 Mar 2007 20:25:34 -0500
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 3/11] ppc64: EEH: Tolerate high mmio
Message-ID: <20070321012534.GA2485@lixom.net>
References: <20070319194349.GT5151@austin.ibm.com>
	<20070319195322.GC11532@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319195322.GC11532@austin.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 19, 2007 at 02:53:22PM -0500, Linas Vepstas wrote:
> 
> Some drivers will attempt to perform a lot of mmio even after
> an EEH event was detected. This is especially the case for fast cpu's
> and PCI-E slots. Be a bit more lenient in allowing this.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> ----
>  arch/powerpc/platforms/pseries/eeh.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
> ===================================================================
> --- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:19:26.000000000 -0500
> +++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:19:30.000000000 -0500
> @@ -74,7 +74,7 @@
>   * is broken and panic.  This sets the threshold for how many read
>   * attempts we allow before panicking.
>   */
> -#define EEH_MAX_FAILS	100000
> +#define EEH_MAX_FAILS	2100000

100000 I can understand, it's a nice and round number. but why 2100000
of all possible values?


-Olof
