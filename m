Return-Path: <gorcunov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id A1643DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 21:59:17 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1952012wag
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 02:59:16 -0800 (PST)
Message-ID: <aa79d98a0711280259o6cc6fb12mf020c4a986d84ca6@mail.gmail.com>
Date: Wed, 28 Nov 2007 13:59:16 +0300
From: "Cyrill Gorcunov" <gorcunov@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] PPC: CELLEB - fix potential NULL pointer dereference
In-Reply-To: <aa79d98a0711280253x3d1d28d6qa0cee0b731e807fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <aa79d98a0711252346m583b652bocf72e11077da352e@mail.gmail.com>
	<1196243333.2109.2.camel@concordia>
	<aa79d98a0711280253x3d1d28d6qa0cee0b731e807fe@mail.gmail.com>
Cc: Olof Johansson <olof@lixom.net>, PPCML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/28/07, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> On 11/28/07, Michael Ellerman <michael@ellerman.id.au> wrote:
> > On Mon, 2007-11-26 at 10:46 +0300, Cyrill Gorcunov wrote:
> > > This patch adds checking for NULL value returned to prevent possible
> > > NULL pointer dereference.
> > > Also two unneeded 'return' are removed.
> > >
> > > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > > ---
> > > Any comments are welcome.
> >
> > I guess it's good to be paranoid, but this is a little verbose:
> >
> >        wi0 = of_get_property(node, "device-id", NULL);
> > +       if (unlikely((!wi0))) {
> > +               printk(KERN_ERR "PCI: device-id not found.\n");
> > +               goto error;
> > +       }
> >        wi1 = of_get_property(node, "vendor-id", NULL);
> > +       if (unlikely((!wi1))) {
> > +               printk(KERN_ERR "PCI: vendor-id not found.\n");
> > +               goto error;
> > +       }
> >        wi2 = of_get_property(node, "class-code", NULL);
> > +       if (unlikely((!wi2))) {
> > +               printk(KERN_ERR "PCI: class-code not found.\n");
> > +               goto error;
> > +       }
> >        wi3 = of_get_property(node, "revision-id", NULL);
> > +       if (unlikely((!wi3))) {
> > +               printk(KERN_ERR "PCI: revision-id not found.\n");
> > +               goto error;
> > +       }
> >
> > Perhaps instead:
> >
> >        wi0 = of_get_property(node, "device-id", NULL);
> >        wi1 = of_get_property(node, "vendor-id", NULL);
> >        wi2 = of_get_property(node, "class-code", NULL);
> >        wi3 = of_get_property(node, "revision-id", NULL);
> >
> >       if (!wi0 || !wi1 || !wi2 || !wi3) {
> >               printk(KERN_ERR "PCI: Missing device tree properties.\n");
> >               goto error;
> >       }
>
> Hi Michael, yes that is much better (actually I was doubt about what form of
> which the checking style to use - your form is much compact but mine does
> show where *exactly* the problem appeared). So 'case that is the fake driver
> your form is preferred ;) Ishizaki, could you use Michael's part then?
>
> >
> >
> > cheers
> >
> > --
> > Michael Ellerman
> > OzLabs, IBM Australia Development Lab
> >
> > wwweb: http://michael.ellerman.id.au
> > phone: +61 2 6212 1183 (tie line 70 21183)
> >
> > We do not inherit the earth from our ancestors,
> > we borrow it from our children. - S.M.A.R.T Person
> >
> >
>
> Cyrill
>
Ishizaki I can update the patch if you needed. Should I?

Cyrill
