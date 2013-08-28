Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD1D02C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 22:08:44 +1000 (EST)
Date: Wed, 28 Aug 2013 14:08:27 +0200
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 09/31] powerpc/fsl-pci: improve clock API use
Message-ID: <20130828120827.GB26379@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-10-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375821851-31609-10-git-send-email-gsi@denx.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ re-created the Cc: list, this is about the PCI clock exclusively ]

Of all the "preparation" patches in the series (parts 01-14/31,
forming the "peripheral driver cleanup" phase before the
introduction of CCF support), this patch remains the last to get
picked up.

But I'd suggest to leave this patch for now (for v3.12, it's
rather late).  Either ignore this message and the patch, or see
below for why application isn't required now, and an update of
this patch is needed and will be appropriate for v3.13.

I'm sorry for the confusion, the potentially perceived
instability is a result of both widening the series' scope after
initial submission as well as a recent extension of test coverage
after the scope has been widened.  Thank you for your patience!


On Tue, Aug 06, 2013 at 22:43 +0200, Gerhard Sittig wrote:
> 
> make the Freescale PCI driver get, prepare and enable the PCI clock
> during probe(); the clock gets put upon device close by the devm approach
> 
> clock lookup is non-fatal as not all platforms may provide clock specs
> in their device tree, but failure to enable specified clocks are fatal
> 
> the driver appears to not have a remove() routine, so no reference to
> the clock is kept during use, and the clock isn't released (the devm
> approach will put the clock, but it won't get disabled or unprepared)
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/sysdev/fsl_pci.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 46ac1dd..549ff08 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -17,6 +17,8 @@
> ...

What this patch 09/31 does is add a non-fatal device tree based
clock lookup in the fsl_pci_probe() routine, to acquire the PCI
clock item appropriately if there is a provider and a DT spec.

The patch in v4 has a bug, which has an obvious fix while an
update wasn't sent yet, for neither the patch nor the series.
There is one more known issue in the series (not with
functionality but with policy, specifically in a multi platform
configuration), while I don't want to resend the series while
known issues are pending.  But this is not the problem here.


First of all the patch is a NOP in the forseeable future.  It
won't harm yet its content isn't urgently needed either, to
unbreak stuff or to support upcoming features that were
communicated before.

Further analysis has shown that the patch is incomplete.

The 85xx and 86xx platforms will pass through the fsl_pci_probe()
routine.  That these platforms don't have OF clock providers is
not a problem, the patch will remain a NOP then.  Its function
will kick in when these platforms may grow clock providers
(things will transparently keep working, this was the actual
intent of the patch).  Since the series is about 512x CCF
support, the patch will remain a NOP throughout the whole series,
but won't harm either.

The 83xx and 512x platforms in contrast _don't_ pass through the
fsl_pci_probe() routine, instead they call mpc83xx_add_bridge()
from within the .setup_arch() callback in platform initialization
code, which iterates over the compatible OF nodes, and runs at a
point in time where the platform's clock provider has not yet
been setup and thus is not available.  In this situation any
clock lookup will fail, which is not fatal during PCI setup yet
won't acquire the clock item and thus will have the common
infrastructure disable the "unused" clock much later.

There is a workaround for this lack of proper clock acquisition
in the peripheral driver.  The clock provider needs to pre-enable
the PCI clock item upon its initialization, because the
peripheral driver can't when it initializes.  Checking the same
condition in the provider's pre-enable workaround which the
.setup_arch() routine is checking before the add_bridge() calls
(the presence of compatible nodes) results in correct operation
as well as most appropriate resource use (clock enabled when PCI
hardware was attached to, and clock disabled in the absence of
PCI hardware or driver attachment).


So the update of this patch 09/31 will contain
- the fix for the copy'n'paste bug in the probe() routine
- an appropriate comment in the add_bridge() routine
- no change in its nature, the idea remains unaffected

The backend (clock provider) will contain the pre-enable
workaround for the PCI clock item.

As a result, the 83xx, 85xx, and 86xx platforms won't see any
change (there is a NOP in probe() and a comment in add_bridge(),
neither of which break any operation).  The 512x platform will
have proper PCI operation in the presence of common clock
support.  Should 8xxx platforms grow CCF support later, they will
transparently keep working (85xx, 86xx), or may add the same
simple yet appropriate workaround (83xx).


So the outline is there, the approach is straight forward and
easily can get implemented, and the resulting code will work for
all platforms while there is no potential for breakage.  The PCI
driver will improve, and all is well. :)  There is no need for
action for v3.12, and v3.13 can include the improvement.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
