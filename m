Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id 429EEDDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 23:57:19 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2865463nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 06:57:18 -0700 (PDT)
Message-ID: <fa686aa40710020657j1c97a23ejdd3322f5cba3bbb5@mail.gmail.com>
Date: Tue, 2 Oct 2007 07:57:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2 5/6] Sysace: Move IRQ handler registration to occur
	after FSM is initialized
In-Reply-To: <1191304521.6310.94.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225726.2476.44211.stgit@trillian.cg.shawcable.net>
	<1191304521.6310.94.camel@pasglop>
Cc: axboe@kernel.dk, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/1/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2007-09-30 at 16:57 -0600, Grant Likely wrote:
> >         val |= ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
> >         ace_out(ace, ACE_CTRL, val);
> >
> > +       /* Now we can hook up the irq handler */
> > +       if (ace->irq != NO_IRQ) {
> > +               rc = request_irq(ace->irq, ace_interrupt, 0,
> > "systemace", ace);
> > +               if (rc) {
> > +                       /* Failure - fall back to polled mode */
> > +                       dev_err(ace->dev, "request_irq failed\n");
> > +                       ace->irq = NO_IRQ;
> > +               }
> > +       }
> > +
>
> I don't know the HW but from the above, it looks like you enable
> interrupt emission on the HW before you register the handler, which is
> wrong. You should make sure on the contrary that IRQs on the HW are
> disabled until after you have registered a handler.
>
> Only really a problem if you have shared interrupts but still...

Yeah, you're right.  Fortunately all current in-tree platforms which
use this do not have shared interrupts, but I'd like to be correct on
this.

I'll tidy this up and send a fixup patch.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
