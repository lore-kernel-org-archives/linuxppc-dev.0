Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.201])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4DAEA2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 13:06:19 +1100 (EST)
In-Reply-To: <20140219204134.E4A2DC4088D@trevor.secretlab.ca>
References: <1392205084-2351-1-git-send-email-haokexin@gmail.com> <
 CAL_JsqKMi2H=vwoxrOt8QRA2xJeiLqBKKfLtt4QRCRoFk6JUHg@mail.gmail.com> <
 CAP=VYLr7hqnzW2HLS4GCMFeghCgPmrQZHYst+AUfZc_WNT-Wog@mail.gmail.com>
 <20140219204134.E4A2DC4088D@trevor.secretlab.ca>
To: Grant Likely <grant.likely@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH] of: give priority to the compatible match in
 __of_match_node()
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF16A9A8E2.CFE1BE7E-ONCA257C85.000B2719-CA257C85.000B87E1@csc.com>
Date: Thu, 20 Feb 2014 12:05:56 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, Kevin Hao <haokexin@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Rob Herring <robh+dt@kernel.org>, Rob Herring <robherring2@gmail.com>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely <glikely@secretlab.ca> wrote on 02/20/2014 07:41:34 AM:

> From: Grant Likely <grant.likely@linaro.org>
> To: Paul Gortmaker <paul.gortmaker@windriver.com>, Rob Herring 
> <robherring2@gmail.com>
> Cc: Kevin Hao <haokexin@gmail.com>, "devicetree@vger.kernel.org" 
> <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Chris 
> Proctor <cproctor@csc.com.au>, Stephen N Chivers 
> <schivers@csc.com.au>, Rob Herring <robh+dt@kernel.org>, Scott Wood 
> <scottwood@freescale.com>, linuxppc-dev <linuxppc-
> dev@lists.ozlabs.org>, Sebastian Hesselbarth 
<sebastian.hesselbarth@gmail.com>
> Date: 02/20/2014 07:41 AM
> Subject: Re: [PATCH] of: give priority to the compatible match in 
> __of_match_node()
> Sent by: Grant Likely <glikely@secretlab.ca>
> 
> On Wed, 19 Feb 2014 13:25:54 -0500, Paul Gortmaker 
> <paul.gortmaker@windriver.com> wrote:
> > On Thu, Feb 13, 2014 at 2:01 PM, Rob Herring <robherring2@gmail.com> 
wrote:
> > > On Wed, Feb 12, 2014 at 5:38 AM, Kevin Hao <haokexin@gmail.com> 
wrote:
> > >> When the device node do have a compatible property, we definitely
> > >> prefer the compatible match besides the type and name. Only if
> > >> there is no such a match, we then consider the candidate which
> > >> doesn't have compatible entry but do match the type or name with
> > >> the device node.
> > >>
> > >> This is based on a patch from Sebastian Hesselbarth.
> > >>   http://patchwork.ozlabs.org/patch/319434/
> > >>
> > >> I did some code refactoring and also fixed a bug in the original 
patch.
> > >
> > > I'm inclined to just revert this once again and avoid possibly
> > > breaking yet another platform.
> > 
> > Well, for what it is worth, today's (Feb19th) linux-next tree fails to 
boot
> > on my sbc8548.   It fails with:
> 
> I think I've got it fixed now with the latest series. Please try the
> devicetree/merge branch on git://git.secretlab.ca/git/linux
I have tested this with the following platforms: MVME5100, MVME4100,
SAM440EP and MPC8349MITXGP. All boot and reach the login state on the
serial console.

The MVME4100 is a MPC8548 platform like the SBC8548 and
suffered from the same PHY address is too large problem
when used with todays linux-next.

Tested-by: Stephen Chivers <schivers@csc.com>
> 
> g.
> 
> > -----------------------------------------------
> > libphy: Freescale PowerQUICC MII Bus: probed
> > mdio_bus ethernet@e002400: /soc8548@e0000000/ethernet@24000/mdio@520
> > PHY address 1312 is too large
> > libphy: Freescale PowerQUICC MII Bus: probed
> > libphy: Freescale PowerQUICC MII Bus: probed
> > mdio_bus ethernet@e002500: /soc8548@e0000000/ethernet@25000/mdio@520
> > PHY address 1312 is too large
> > libphy: Freescale PowerQUICC MII Bus: probed
> > TCP: cubic registered
> > Initializing XFRM netlink socket
> > NET: Registered protocol family 17
> > <fail nfs mount>
> > -----------------------------------------------
> > 
> > On a normal boot, we should see this:
> > -----------------------------------------------
> > libphy: Freescale PowerQUICC MII Bus: probed
> > libphy: Freescale PowerQUICC MII Bus: probed
> > fsl-gianfar e0024000.ethernet: enabled errata workarounds, flags: 0x4
> > fsl-gianfar e0024000.ethernet eth0: mac: 02:e0:0c:00:05:fd
> > fsl-gianfar e0024000.ethernet eth0: Running with NAPI enabled
> > fsl-gianfar e0024000.ethernet eth0: RX BD ring size for Q[0]: 256
> > fsl-gianfar e0024000.ethernet eth0: TX BD ring size for Q[0]: 256
> > fsl-gianfar e0025000.ethernet: enabled errata workarounds, flags: 0x4
> > fsl-gianfar e0025000.ethernet eth1: mac: 02:e0:0c:00:06:fd
> > fsl-gianfar e0025000.ethernet eth1: Running with NAPI enabled
> > fsl-gianfar e0025000.ethernet eth1: RX BD ring size for Q[0]: 256
> > fsl-gianfar e0025000.ethernet eth1: TX BD ring size for Q[0]: 256
> > TCP: cubic registered
> > Initializing XFRM netlink socket
> > NET: Registered protocol family 17
> > -----------------------------------------------
> > 
> > 
> > Git bisect says:
> > 
> > ee8b26ad943aa34acc03ae6cde2b81d8d3d483d4 is the first bad commit
> > commit ee8b26ad943aa34acc03ae6cde2b81d8d3d483d4
> > Author: Kevin Hao <haokexin@gmail.com>
> > Date:   Tue Feb 18 15:57:30 2014 +0800
> > 
> >     of: reimplement the matching method for __of_match_node()
> > 
> >     In the current implementation of __of_match_node(), it will 
compare
> >     each given match entry against all the node's compatible strings
> >     with of_device_is_compatible().
> > 
> >     To achieve multiple compatible strings per node with ordering from
> >     specific to generic, this requires given matches to be ordered 
from
> >     specific to generic. For most of the drivers this is not true and
> >     also an alphabetical ordering is more sane there.
> > 
> >     Therefore, we define a following priority order for the match, and
> >     then scan all the entries to find the best match.
> >       1. specific compatible && type && name
> >       2. specific compatible && type
> >       3. specific compatible && name
> >       4. specific compatible
> >       5. general compatible && type && name
> >       6. general compatible && type
> >       7. general compatible && name
> >       8. general compatible
> >       9. type && name
> >       10. type
> >       11. name
> > 
> >     This is based on some pseudo-codes provided by Grant Likely.
> > 
> >     Signed-off-by: Kevin Hao <haokexin@gmail.com>
> >     [grant.likely: Changed multiplier to 4 which makes more sense]
> >     Signed-off-by: Grant Likely <grant.likely@linaro.org>
> > 
> > :040000 040000 8f5dd19174417aece63b308ff299a5dbe2efa5a0
> > 8401b0e3903e23e973845ee75b26b04345d803d2 M      drivers
> > 
> > As a double check, I checked out the head of linux-next, and did a
> > revert of the above commit, and my sbc8548 can then boot properly.
> > 
> > Not doing anything fancy ; using the defconfig exactly as-is, and
> > ensuring the dtb is fresh from linux-next HEAD of today.
> > 
> > Thanks,
> > Paul.
> > --
> > 
> > >
> > > However, I think I would like to see this structured differently. We
> > > basically have 2 ways of matching: the existing pre-3.14 way and the
> > > desired match on best compatible only. All new bindings should match
> > > with the new way and the old way needs to be kept for compatibility.
> > > So lets structure the code that way. Search the match table first 
for
> > > best compatible with name and type NULL, then search the table the 
old
> > > way. I realize it appears you are doing this, but it is not clear 
this
> > > is the intent of the code. I would like to see this written as a 
patch
> > > with commit 105353145eafb3ea919 reverted first and you add a new 
match
> > > function to call first and then fallback to the existing function.
> > >
> > > Rob
> > >
> > >>
> > >> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > >> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > >> ---
> > >>  drivers/of/base.c | 55 ++++++++++++++++++++++++++++++++++++
> +------------------
> > >>  1 file changed, 37 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/drivers/of/base.c b/drivers/of/base.c
> > >> index ff85450d5683..9d655df458bd 100644
> > >> --- a/drivers/of/base.c
> > >> +++ b/drivers/of/base.c
> > >> @@ -730,32 +730,45 @@ out:
> > >>  }
> > >>  EXPORT_SYMBOL(of_find_node_with_property);
> > >>
> > >> +static int of_match_type_or_name(const struct device_node *node,
> > >> +                               const struct of_device_id *m)
> > >> +{
> > >> +       int match = 1;
> > >> +
> > >> +       if (m->name[0])
> > >> +               match &= node->name && !strcmp(m->name, 
node->name);
> > >> +
> > >> +       if (m->type[0])
> > >> +               match &= node->type && !strcmp(m->type, 
node->type);
> > >> +
> > >> +       return match;
> > >> +}
> > >> +
> > >>  static
> > >>  const struct of_device_id *__of_match_node(const struct 
> of_device_id *matches,
> > >>                                            const struct 
> device_node *node)
> > >>  {
> > >>         const char *cp;
> > >>         int cplen, l;
> > >> +       const struct of_device_id *m;
> > >> +       int match;
> > >>
> > >>         if (!matches)
> > >>                 return NULL;
> > >>
> > >>         cp = __of_get_property(node, "compatible", &cplen);
> > >> -       do {
> > >> -               const struct of_device_id *m = matches;
> > >> +       while (cp && (cplen > 0)) {
> > >> +               m = matches;
> > >>
> > >>                 /* Check against matches with current 
> compatible string */
> > >>                 while (m->name[0] || m->type[0] || 
m->compatible[0]) {
> > >> -                       int match = 1;
> > >> -                       if (m->name[0])
> > >> -                               match &= node->name
> > >> -                                       && !strcmp(m->name, 
node->name);
> > >> -                       if (m->type[0])
> > >> -                               match &= node->type
> > >> -                                       && !strcmp(m->type, 
node->type);
> > >> -                       if (m->compatible[0])
> > >> -                               match &= cp
> > >> -                                       && !of_compat_cmp
> (m->compatible, cp,
> > >> +                       if (!m->compatible[0]) {
> > >> +                               m++;
> > >> +                               continue;
> > >> +                       }
> > >> +
> > >> +                       match = of_match_type_or_name(node, m);
> > >> +                       match &= cp && 
!of_compat_cmp(m->compatible, cp,
> > >>                                                         strlen
> (m->compatible));
> > >>                         if (match)
> > >>                                 return m;
> > >> @@ -763,12 +776,18 @@ const struct of_device_id 
> *__of_match_node(const struct of_device_id *matches,
> > >>                 }
> > >>
> > >>                 /* Get node's next compatible string */
> > >> -               if (cp) {
> > >> -                       l = strlen(cp) + 1;
> > >> -                       cp += l;
> > >> -                       cplen -= l;
> > >> -               }
> > >> -       } while (cp && (cplen > 0));
> > >> +               l = strlen(cp) + 1;
> > >> +               cp += l;
> > >> +               cplen -= l;
> > >> +       }
> > >> +
> > >> +       m = matches;
> > >> +       /* Check against matches without compatible string */
> > >> +       while (m->name[0] || m->type[0] || m->compatible[0]) {
> > >> +               if (!m->compatible[0] && 
of_match_type_or_name(node, m))
> > >> +                       return m;
> > >> +               m++;
> > >> +       }
> > >>
> > >>         return NULL;
> > >>  }
> > >> --
> > >> 1.8.5.3
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe 
devicetree" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
