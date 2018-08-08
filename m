Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lgdd2yLrzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 15:57:25 +1000 (AEST)
Message-ID: <7526e100693e4db9bb3adf576254b2161086dfe8.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>,  "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>, "joe@perches.com"
 <joe@perches.com>
Date: Wed, 08 Aug 2018 00:50:38 -0500
In-Reply-To: <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
 <20180807180938.GA13623@rob-hp-laptop>
 <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
 <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-08 at 03:37 +0000, Bharat Bhushan wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Wednesday, August 8, 2018 2:34 AM
> > To: Rob Herring <robh@kernel.org>; Bharat Bhushan
> > <bharat.bhushan@nxp.com>
> > Cc: benh@kernel.crashing.org; paulus@samba.org; mpe@ellerman.id.au;
> > galak@kernel.crashing.org; mark.rutland@arm.com;
> > kstewart@linuxfoundation.org; gregkh@linuxfoundation.org;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org; keescook@chromium.org;
> > tyreld@linux.vnet.ibm.com; joe@perches.com
> > Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq
> > ranges
> > 
> > On Tue, 2018-08-07 at 12:09 -0600, Rob Herring wrote:
> > > On Fri, Jul 27, 2018 at 03:17:59PM +0530, Bharat Bhushan wrote:
> > > > Freescale MPIC h/w may not support all interrupt sources reported by
> > > > hardware, "last-interrupt-source" or platform. On these platforms a
> > > > misconfigured device tree that assigns one of the reserved
> > > > interrupts leaves a non-functioning system without warning.
> > > 
> > > There are lots of ways to misconfigure DTs. I don't think this is
> > > special and needs a property.
> > 
> > Yeah, the system will be just as non-functioning if you specify a valid-
> > but-
> > wrong-for-the-device interrupt number.
> 
> Some is one additional benefits of this changes, MPIC have reserved regions
> for un-supported interrupts and read/writes to these reserved regions seams
> have no effect.
> MPIC driver reads/writes to the reserved regions during init/uninit and
> save/restore state.
> 
> Let me know if it make sense to have these changes for mentioned reasons.

The driver has been doing this forever with no ill effect.  What is the
motivation for this change?

-Scott
