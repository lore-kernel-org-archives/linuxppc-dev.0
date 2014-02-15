Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CAEF2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 16:19:22 +1100 (EST)
In-Reply-To: <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
References: <1392355366-1445-1-git-send-email-haokexin@gmail.com>	<1392355366-1445-3-git-send-email-haokexin@gmail.com>
 <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
To: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFE7538F6F.94B14E09-ONCA257C80.001BB296-CA257C80.001D350B@csc.com>
Date: Sat, 15 Feb 2014 15:19:01 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Kevin Hao <haokexin@gmail.com>, Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>, Kumar Gala <galak@codeaurora.org>,
 Grant Likely <grant.likely@linaro.org>,
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

Rob Herring <robherring2@gmail.com> wrote on 02/15/2014 02:53:40 AM:

> From: Rob Herring <robherring2@gmail.com>
> To: Kevin Hao <haokexin@gmail.com>
> Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
> linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Sebastian Hesselbarth 
> <sebastian.hesselbarth@gmail.com>, Stephen N Chivers 
> <schivers@csc.com.au>, Grant Likely <grant.likely@linaro.org>, Rob 
> Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
> Date: 02/15/2014 02:53 AM
> Subject: Re: [PATCH 2/2] of: search the best compatible match first 
> in __of_match_node()
> 
> On Thu, Feb 13, 2014 at 11:22 PM, Kevin Hao <haokexin@gmail.com> wrote:
> > Currently, of_match_node compares each given match against all node's
> > compatible strings with of_device_is_compatible.
> >
> > To achieve multiple compatible strings per node with ordering from
> > specific to generic, this requires given matches to be ordered from
> > specific to generic. For most of the drivers this is not true and also
> > an alphabetical ordering is more sane there.
> >
> > Therefore, this patch introduces a function to match each of the 
node's
> > compatible strings against all given compatible matches without type 
and
> > name first, before checking the next compatible string. This implies
> > that node's compatibles are ordered from specific to generic while
> > given matches can be in any order. If we fail to find such a match
> > entry, then fall-back to the old method in order to keep 
compatibility.
> >
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> 
> Looks good to me. I'll put this in next for a few days. I'd really
> like to see some acks and tested-by's before sending to Linus.
> 
Tested-by: Stephen Chivers <schivers@csc.com>

I have tested the patch for the four PowerPC platforms
available to me.

They are:

MPC8349_MITXGP - Works.
MVME5100        - Works.
MVME4100 - Works.
SAM440EP - Works.

The MPC8349_MITXGP platform is present in Linux-3.13 and previous 
releases.
The MVME5100 is a "revived" platform that is in Linux-3.14-rc2.
The MVME4100 is a work in progress and is the 85xx platform that the
original failure report was for.
The SAM440EP is present in Linux-3.13 and previous releases.

The MPC8349_MITXGP is one of the 49 DTS files with the serial compatible:

compatible = "fsl,ns16550", "ns16550";

For the SAM440EP, the patch improves things from Linux-3.13. In that
release the same sort of problem as reported in:

"Linux-3.14-rc2: Order of serial node compatibles in DTS files."

occurs with slightly different symptoms:

of_serial ef600300.serial: Port found
of_serial ef600300.serial: Port found
of_serial ef600300.serial: Unknown serial port found, ignored
of_serial ef600400.serial: Port found
of_serial ef600400.serial: Port found
of_serial ef600400.serial: Unknown serial port found, ignored
of_serial ef600500.serial: Port found
of_serial ef600500.serial: Port found
of_serial ef600500.serial: Unknown serial port found, ignored
of_serial ef600600.serial: Port found
of_serial ef600600.serial: Port found
of_serial ef600600.serial: Unknown serial port found, ignored

The SAM440EP has a IBM/AMCC 440EP PowerPC CPU and so simply has
"ns16550" as its serial compatible.


> We could be a bit more strict here and fallback to the old matching if
> the match table has any entries with name or type. I don't think that
> should be necessary though.
> 
> Rob
Stephen Chivers,
CSC Australia Pty. Ltd.
> 
> > ---
> >  drivers/of/base.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index ba195fbce4c6..10b51106c854 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -730,13 +730,49 @@ out:
> >  }
> >  EXPORT_SYMBOL(of_find_node_with_property);
> >
> > +static const struct of_device_id *
> > +of_match_compatible(const struct of_device_id *matches,
> > +                       const struct device_node *node)
> > +{
> > +       const char *cp;
> > +       int cplen, l;
> > +       const struct of_device_id *m;
> > +
> > +       cp = __of_get_property(node, "compatible", &cplen);
> > +       while (cp && (cplen > 0)) {
> > +               m = matches;
> > +               while (m->name[0] || m->type[0] || m->compatible[0]) {
> > +                       /* Only match for the entries without type
> and name */
> > +                       if (m->name[0] || m->type[0] ||
> > +                               of_compat_cmp(m->compatible, cp,
> > +                                        strlen(m->compatible)))
> > +                               m++;
> > +                       else
> > +                               return m;
> > +               }
> > +
> > +               /* Get node's next compatible string */
> > +               l = strlen(cp) + 1;
> > +               cp += l;
> > +               cplen -= l;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  static
> >  const struct of_device_id *__of_match_node(const struct 
> of_device_id *matches,
> >                                            const struct device_node 
*node)
> >  {
> > +       const struct of_device_id *m;
> > +
> >         if (!matches)
> >                 return NULL;
> >
> > +       m = of_match_compatible(matches, node);
> > +       if (m)
> > +               return m;
> > +
> >         while (matches->name[0] || matches->type[0] || 
> matches->compatible[0]) {
> >                 int match = 1;
> >                 if (matches->name[0])
> > @@ -760,7 +796,12 @@ const struct of_device_id *__of_match_node
> (const struct of_device_id *matches,
> >   *     @matches:       array of of device match structures to search 
in
> >   *     @node:          the of device structure to match against
> >   *
> > - *     Low level utility function used by device matching.
> > + *     Low level utility function used by device matching. We have 
two ways
> > + *     of matching:
> > + *     - Try to find the best compatible match by comparing each 
compatible
> > + *       string of device node with all the given matches 
respectively.
> > + *     - If the above method failed, then try to match the 
> compatible by using
> > + *       __of_device_is_compatible() besides the match in type and 
name.
> >   */
> >  const struct of_device_id *of_match_node(const struct 
> of_device_id *matches,
> >                                          const struct device_node 
*node)
> > --
> > 1.8.5.3
> >
