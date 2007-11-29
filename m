Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 418C3DE1A0
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 14:23:01 +1100 (EST)
Date: Thu, 29 Nov 2007 12:22:45 +0900 (JST)
Message-Id: <20071129.122245.-1300543769.kouish@swc.toshiba.co.jp>
To: gorcunov@gmail.com
Subject: Re: [PATCH] PPC: CELLEB - fix potential NULL pointer dereference
In-Reply-To: <aa79d98a0711280259o6cc6fb12mf020c4a986d84ca6@mail.gmail.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: olof@lixom.net, paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> On 11/28/07, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > On 11/28/07, Michael Ellerman <michael@ellerman.id.au> wrote:
> > > On Mon, 2007-11-26 at 10:46 +0300, Cyrill Gorcunov wrote:
> > > > This patch adds checking for NULL value returned to prevent possible
> > > > NULL pointer dereference.
> > > > Also two unneeded 'return' are removed.
> > > >
> > > > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > > > ---
> > > > Any comments are welcome.
> > >
> > > I guess it's good to be paranoid, but this is a little verbose:
> > >
> > >        wi0 = of_get_property(node, "device-id", NULL);
> > > +       if (unlikely((!wi0))) {
> > > +               printk(KERN_ERR "PCI: device-id not found.\n");
> > > +               goto error;
> > > +       }
> > >        wi1 = of_get_property(node, "vendor-id", NULL);
> > > +       if (unlikely((!wi1))) {
> > > +               printk(KERN_ERR "PCI: vendor-id not found.\n");
> > > +               goto error;
> > > +       }
> > >        wi2 = of_get_property(node, "class-code", NULL);
> > > +       if (unlikely((!wi2))) {
> > > +               printk(KERN_ERR "PCI: class-code not found.\n");
> > > +               goto error;
> > > +       }
> > >        wi3 = of_get_property(node, "revision-id", NULL);
> > > +       if (unlikely((!wi3))) {
> > > +               printk(KERN_ERR "PCI: revision-id not found.\n");
> > > +               goto error;
> > > +       }
> > >
> > > Perhaps instead:
> > >
> > >        wi0 = of_get_property(node, "device-id", NULL);
> > >        wi1 = of_get_property(node, "vendor-id", NULL);
> > >        wi2 = of_get_property(node, "class-code", NULL);
> > >        wi3 = of_get_property(node, "revision-id", NULL);
> > >
> > >       if (!wi0 || !wi1 || !wi2 || !wi3) {
> > >               printk(KERN_ERR "PCI: Missing device tree properties.\n");
> > >               goto error;
> > >       }
> >
> > Hi Michael, yes that is much better (actually I was doubt about what form of
> > which the checking style to use - your form is much compact but mine does
> > show where *exactly* the problem appeared). So 'case that is the fake driver
> > your form is preferred ;) Ishizaki, could you use Michael's part then?
> >
> > >
> > >
> > > cheers
> > >
> > > --
> > > Michael Ellerman
> > > OzLabs, IBM Australia Development Lab
> > >
> > > wwweb: http://michael.ellerman.id.au
> > > phone: +61 2 6212 1183 (tie line 70 21183)
> > >
> > > We do not inherit the earth from our ancestors,
> > > we borrow it from our children. - S.M.A.R.T Person
> > >
> > >
> >
> > Cyrill
> >
> Ishizaki I can update the patch if you needed. Should I?
> 
> Cyrill

There is no problem to use Michael's part, and I also prefer simple
one like this.

Cyrill, would you please update your patch?

Best regards,
Kou Ishizaki
