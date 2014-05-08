Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 906DB1400B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 09:18:34 +1000 (EST)
Message-ID: <1399591088.15726.402.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 8 May 2014 18:18:08 -0500
In-Reply-To: <6CE62BBF-BFF4-4F2C-8EFF-B6F87EE6EEE9@kernel.crashing.org>
References: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
 <6CE62BBF-BFF4-4F2C-8EFF-B6F87EE6EEE9@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Diana Craciun <diana.craciun@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-08 at 07:00 -0700, Kumar Gala wrote:
> On Apr 18, 2014, at 8:11 AM, Diana Craciun <diana.craciun@freescale.com> wrote:
> 
> > From: Diana Craciun <Diana.Craciun@freescale.com>
> > 
> > The CoreNet coherency fabric is a fabric-oriented, conectivity
> > infrastructure that enables the implementation of coherent, multicore
> > systems. The CCF acts as a central interconnect for cores,
> > platform-level caches, memory subsystem, peripheral devices and I/O host
> > bridges in the system.
> > 
> > Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> > ---
> > .../devicetree/bindings/powerpc/fsl/ccf.txt        | 36 ++++++++++++++++++++++
> > 1 file changed, 36 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> > new file mode 100644
> > index 0000000..f0b7143
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> > @@ -0,0 +1,36 @@
> > +Freescale CoreNet Coherency Fabric(CCF) Device Tree Binding
> > +
> > +DESCRIPTION
> > +
> > +The CoreNet coherency fabric is a fabric-oriented, connectivity infrastructure
> > +that enables the implementation of coherent, multicore systems.
> > +
> > +Required properties:
> > +
> > +- compatible : <string>
> > +		Must include "fsl,corenetX-cf", "fsl,corenet-cf" - CoreNet coherency 
> > +		fabric version X
> 
> Can we make this ‘fsl,corenet-vX-cf’.
> 
> corenet-v1-cf/corenet-v2-cf looks nicer than corenet1-cf/corenet2-cf

How important is this?  We've already got corenet2-cf in SDK device
trees -- and while I know that's not binding on upstream in any way,
it's purely a cosmetic change.  Even if you disregard the SDK, is this
really worth going back and amending several pending patches over
(including a driver that I was waiting for this binding to settle before
sending)?  

FWIW, we have other instances of "deviceN", such as "fsl,etsec2",
"fsl,cpm2-<foo>","fsl,usb2-<foo>", and "fsl,elo3-dma".  We also call it
"corenet2" in U-Boot a lot.

If we must change it, I'd prefer "fsl,corenet-cf-vX.0".

-Scott
