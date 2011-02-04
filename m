Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH v2 1/3] powerpc: Removing support for 'protected-sources'
Date: Fri, 4 Feb 2011 13:17:32 +0100
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
	<201102031656.38222.arnd@arndb.de> <4D4B3A4E.2070106@mentor.com>
In-Reply-To: <4D4B3A4E.2070106@mentor.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201102041317.32739.arnd@arndb.de>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 04 February 2011, Meador Inge wrote:
> On 02/03/2011 09:56 AM, Arnd Bergmann wrote:

> So in 'mpic_init' we don't initialize anything and then in 
> 'mpic_host_map' we lazily do the VECPRI and CPU binding initialization with:
> 
> 	if (!(mpic->flags & MPIC_WANTS_RESET))
> 		if (!(mpic_is_ipi(mpic, hw)
> 			|| mpic_is_timer_interrupt(mpic, hw)))
> 			mpic_init_vector(mpic, hw);
> 
> Thus when 'no-reset' is thrown it ensures that only the sources which 
> are mentioned in the device tree are actually initialized.  The net 
> effect should be the same as what 'protected-sources' was accomplishing, 
> but without having to maintain the list of sources in the property cell.

That sounds like a good idea, but unfortunately, it's not what SLOF
implements on QS21/QS22. It's a legacy product and there won't be
any firmware updates. Moreover, it relies on the open firmware
implementation and cannot boot with a flattened device tree image,
so I don't see how your patch can work on the old systems.

Maybe you can treat the presence of a 'protected-sources' property
the same way that you treat the no-reset property?

	Arnd
