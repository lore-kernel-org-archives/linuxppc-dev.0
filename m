Return-Path: <benh@kernel.crashing.org>
Message-ID: <1326186610.23910.52.camel@pasglop>
Subject: Re: [PATCH v2] of: Change logic to overwrite cmd_line with
 CONFIG_CMDLINE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Jan 2012 20:10:10 +1100
In-Reply-To: <CAD=FV=UVo-vCe-s9tdXq_Od3jJnJ58Nx=4f-S3XfWBfDhxoXMg@mail.gmail.com>
References: <1316494215.7975.29.camel@pasglop>
 <20110920045510.GA31886@ponder.secretlab.ca>
 <CAD=FV=UVo-vCe-s9tdXq_Od3jJnJ58Nx=4f-S3XfWBfDhxoXMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-01-06 at 16:48 -0800, Doug Anderson wrote:
> I know this is a long-dead thread, but I was a little curious about
> the motivation here.

Hi ! Sorry, I planned to reply earlier and then forgot about it...

> I'm looking at trying to support CONFIG_CMDLINE_EXTEND (an ARM
> Kconfig) in this function and don't know in which cases I should look
> at the CONFIG_CMDLINE and in which cases I should use whatever
> happened to be in data before the function was called.

I'll have a look later (gotta run soon) but basically, the reason I did
that logic change is that in some specific circumstances and firmware
version, I end up writing the user-specified command line in the global
prior to actually booting the kernel :-)

So in that case, I really don't want CONFIG_CMDLINE to take over because
there's nothing in the device-tree, the user -did- specify something but
not via the device-tree.

Now, that's a bit of an oddball scenario but I felt that the logic
change was harmless.

For those interested in gory details, it's when doing the OPAL takeover
on some machines with the version 1 of OPAL firmware. We basically boot
under pHyp normally (pSeries hypervisor) and do a magic hcall which
relocates the kernel to contiguous physical memory and re-starts it with
a flat device-tree.

The takeover mechanism didn't provide me with a way for passing a
command line in that fdt. So I had to do it from prom_init (still
running under pHyp context), change the kernel global before it gets
relocated.

Cheers,
Ben.


> Here's the definition in the KConfig:
> <http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=blob;f=arch/arm/Kconfig;h=24626b0419ee97e963e68329a8eb6769360b46ea;hb=HEAD#l1984>
> 
> Which case do you have CONFIG_CMDLINE defined but not CMDLINE_FORCE?
> In those cases, do you happen to have CONFIG_CMDLINE_EXTEND or
> CMDLINE_FROM_BOOTLOADER defined?
> 
> Thanks much!
> 
> -Doug
> 
> ---
> 
> On Mon, Sep 19, 2011 at 9:55 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > On Tue, Sep 20, 2011 at 02:50:15PM +1000, Benjamin Herrenschmidt wrote:
> > > We used to overwrite with CONFIG_CMDLINE if we found a chosen
> > > node but failed to get bootargs out of it or they were empty,
> > > unless CONFIG_CMDLINE_FORCE is set.
> > >
> > > Instead change that to overwrite if "data" is non empty after
> > > the bootargs check. It allows arch code to have other mechanisms
> > > to retrieve the command line prior to parsing the device-tree.
> > >
> > > Note: CONFIG_CMDLINE_FORCE case should ideally be handled elsewhere
> > > as it won't work as it-is if the device-tree has no /chosen node
> > >
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > CC: devicetree-discuss@lists-ozlabs.org
> > > CC: Grant Likely <grant.likely@secretlab.ca>
> >
> > Looks okay to me.
> >
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > > ---
> > >  drivers/of/fdt.c |    7 ++++++-
> > >  1 files changed, 6 insertions(+), 1 deletions(-)
> > >
> > > v2. Use "data" instead of "cmd_line" so it works on archs like
> > > mips who don't pass cmd_line to that function to start with, also
> > > add a comment explaining the mechanism.
> > >
> > > (resent with right list address as well while at it)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 65200af..323b722 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -681,9 +681,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> > >       if (p != NULL && l > 0)
> > >               strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
> > >
> > > +     /*
> > > +      * CONFIG_CMDLINE is meant to be a default in case nothing else
> > > +      * managed to set the command line, unless CONFIG_CMDLINE_FORCE
> > > +      * is set in which case we override whatever was found earlier.
> > > +      */
> > >  #ifdef CONFIG_CMDLINE
> > >  #ifndef CONFIG_CMDLINE_FORCE
> > > -     if (p == NULL || l == 0 || (l == 1 && (*p) == 0))
> > > +     if (!data[0])
> > >  #endif
> > >               strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > >  #endif /* CONFIG_CMDLINE */
> > > --
> > > 1.7.4.1
> > >
> > >
> > >
> > >
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
