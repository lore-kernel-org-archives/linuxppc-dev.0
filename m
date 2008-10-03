Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7F869DE02F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 19:08:06 +1000 (EST)
Date: Fri, 3 Oct 2008 13:08:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable
	Kconfig option
Message-ID: <20081003090804.GA29029@oksana.dev.rtsoft.ru>
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081003084849.GA18271@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 12:48:49PM +0400, Anton Vorontsov wrote:
> On Fri, Oct 03, 2008 at 02:58:57AM -0500, Kumar Gala wrote:
> >
> > On Oct 3, 2008, at 2:04 AM, Anton Vorontsov wrote:
> >
> >> On Thu, Oct 02, 2008 at 10:27:57AM -0500, Timur Tabi wrote:
> >>> Modify the Kconfig so that Freescale QUICC Engine (QE) support is a  
> >>> selectable
> >>> option, thereby allowing users to compile kernels without any QE  
> >>> support.
> >>>
> >>> The drawback is that QE support is now disabled by default on  
> >>> platforms that
> >>> have a QE, and so a defconfig is needed to enable QE and QE devices  
> >>> (like
> >>> UCC GETH).  Fortunately, all the current relevant defconfigs do that 
> >>> already.
> >>>
> >>> Signed-off-by: Timur Tabi <timur@freescale.com>
> >>> ---
> >>
> >> [...]
> >>> config MPC836x_RDK
> >>> 	bool "Freescale/Logic MPC836x RDK"
> >>> 	select DEFAULT_UIMAGE
> >>> -	select QUICC_ENGINE
> >>> 	select QE_GPIO
> >>
> >> IIRC selects do not honor any dependencies, i.e. you should delete
> >> the QE_GPIO too.
> >
> > Is QE_GPIO need by the board?  or you just enabled it to have it?

Btw, as for the need.. yes, it was needed to support the FHCI. But
now the FHCI would just depend on it, which is better approach anyway.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
