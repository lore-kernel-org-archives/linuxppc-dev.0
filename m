Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 856CD2C009C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 09:24:54 +1000 (EST)
Message-ID: <1375917882.18333.81.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for C293
From: Scott Wood <scottwood@freescale.com>
To: Liu Po-B43644 <B43644@freescale.com>
Date: Wed, 7 Aug 2013 18:24:42 -0500
In-Reply-To: <D473A0D087F4EA47A30C37E4637E25E609DB5B7F@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-1-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-2-git-send-email-Po.Liu@freescale.com>
 <1375208891.30721.74@snotra>
 <D473A0D087F4EA47A30C37E4637E25E609DB5966@039-SN2MPN1-023.039d.mgd.msft.net>
 <1375285614.30721.90@snotra>
 <D473A0D087F4EA47A30C37E4637E25E609DB5B7F@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-31 at 21:32 -0500, Liu Po-B43644 wrote:
> >  -----Original Message-----
> >  From: Wood Scott-B07421
> >  Sent: Wednesday, July 31, 2013 11:47 PM
> >  To: Liu Po-B43644
> >  Cc: Wood Scott-B07421; linuxppc-dev@ozlabs.org; galak@kernel.crashing.org;
> >  Fleming Andy-AFLEMING; Hu Mingkai-B21284
> >  Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for
> >  C293
> >  
> >  On 07/30/2013 09:13:28 PM, Liu Po-B43644 wrote:
> >  >
> >  > >  -----Original Message-----
> >  > >  From: Wood Scott-B07421
> >  > >  Sent: Wednesday, July 31, 2013 2:28 AM
> >  > >  To: Liu Po-B43644
> >  > >  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming
> >  > Andy-
> >  > >  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
> >  > >  Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree
> >  > for
> >  > >  C293
> >  > >
> >  > >  On 07/30/2013 03:49:22 AM, Po Liu wrote:
> >  > >  > +	crypto@80000 {
> >  > >  > +/include/ "qoriq-sec6.0-0.dtsi"
> >  > >  > +	};
> >  > >  > +
> >  > >  > +	crypto@80000 {
> >  > >  > +		reg = <0x80000 0x20000>;
> >  > >  > +		ranges = <0x0 0x80000 0x20000>;
> >  > >  > +
> >  > >  > +		jr@1000{
> >  > >  > +			interrupts = <45 2 0 0>;
> >  > >  > +		};
> >  > >  > +		jr@2000{
> >  > >  > +			interrupts = <57 2 0 0>;
> >  > >  > +		};
> >  > >  > +	};
> >  > >
> >  > >  Do these inline the way the example shows.
> >  > Sorry, Scott, I just remember in this way, the node can't be
> >  > recognized by system when run Uboot. The include can't be in the
> >  > crypto@80000. See the discussion in
> >  > http://git.am.freescale.net:8181/#/c/736/  .
> >  > Maybe I should re-modify the example file.
> >  
> >  git.am.freescale.net is not accessible outside of Freescale; don't
> >  reference it on external lists.  In any case, I don't know what
> >  specifically you want me to look at there.  Just put the explanation here.
> Sorry, I've realize that.
> The fact is that: when put the include into the crypto@xxxx, it can't compile success(make c293pcie.dtb as example). Error will show as:
> 
> ERROR (duplicate_node_names): Duplicate node name /soc@fffe00000/crypto@80000/jr@1000

OK... It seems dtc will only merge duplicates when it's not the first
time it's seen the parent node.  We're probably relying on a side-effect
of the intended behavior of accepting duplicates between the multiple
instances of the parent node.

-Scott
