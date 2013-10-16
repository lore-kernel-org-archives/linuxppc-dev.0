Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AFF982C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 03:48:03 +1100 (EST)
Message-ID: <1381942009.7979.727.camel@snotra.buserror.net>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Wed, 16 Oct 2013 11:46:49 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B150C312F@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <1381518433.7979.536.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381788786.7979.643.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C2B08@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381858855.7979.693.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C312F@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-15 at 21:57 -0500, Tang Yuantian-B29983 wrote:
> > > > > >
> > > > > The device tree makes that quite clear.
> > > >
> > > > You chose to model it that way in the device tree; that doesn't make
> > > > it clear that the hardware works that way or that it's a good way to
> > > > model it.
> > > >
> > > > > Each PLL has several output which MUX node can take from.
> > > >
> > > > Point out where in the hardware documentation it says this.  What I
> > > > see is a PLL that has one output, and a MUX register that can choose
> > > > from multiple PLL and divider options.
> > > >
> > > Take T4240 for example: see section 4.6.5.1 , (Page 141) in T4240RM Rev.
> > D, 09/2012.
> > 
> > That shows the dividers as being somewhere in between the PLL and the MUX.
> > The MUX is where the divider is selected.  There's nothing in the PLL's
> > programming interface that relates to the dividers.  As such it's simpler
> > to model it as being part of the MUX.
> > 
> > -Scott
> > 
> I don't know whether it is simpler, but "modeling divider as being part of the MUX"
> is your guess, right?
> If the "divider" is included in MUX, the MUX would not be called "MUX".

It's still selecting from multiple PLLs.

> I don't know whether "divider" module exists or not. If it exists, it should be part
> of PLL or between PLL and MUX. wherever it was, the device tree binding is appropriate.

The device tree binding is unnecessarily complicated.

> The P3041RM shows exactly each PLL has 2 outputs which definitely have no "divider" at all.

That diagram is a bit weird -- one of the outputs is used as is, and the
other is split into 1/2 and 1/4.  It doesn't really matter though; the
end result is the same.  We're describing the programming interface, not
artwork choices in the manual.

-Scott
