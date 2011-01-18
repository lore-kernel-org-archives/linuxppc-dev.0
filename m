Return-Path: <scottwood@freescale.com>
Date: Tue, 18 Jan 2011 14:31:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH 1/2] powerpc: document the MPIC device tree binding
Message-ID: <20110118143131.37811236@udp111988uds.am.freescale.net>
In-Reply-To: <4D34E448.8000902@mentor.com>
References: <4D34E448.8000902@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 17 Jan 2011 18:52:24 -0600
Meador Inge <meador_inge@mentor.com> wrote:

> +** Required properties:
> +
> +   NOTE: Many of these descriptions were paraphrased from [1] to aid
> +         readability.
> +
> +   - name : Specifies the name of the MPIC.

"name" isn't really a property with flat trees.  The appropriate
node name, according to the Generic Names recommendation and ePAPR, is
interrupt-controller.

> +   - device_type : Specifies the device type of this MPIC.  The value 
> of this
> +                   property shall be "open-pic".

Can we drop device_type, and fix the kernel to look for compatible
instead?

> +   - compatible : Specifies the compatibility list for the MPIC.  The 
> property
> +                  value shall include "chrp,open-pic".

ePAPR wants just "open-pic".  And while chrp,open-pic is common in
existing trees, only one platform currently checks for it.

I'd make in "open-pic" in the binding, and have the kernel accept
either one.

> +** Optional properties:
> +
> +   - no-reset : The presence of this property indicates that the MPIC
> +                should not be reset during runtime initialization.
> +   - protected-sources : Specifies a list of interrupt sources that are 
> not
> +                         available for use and whose corresponding vectors
> +                         should not be initialized.  A typical use case for
> +                         this property is in AMP systems where multiple
> +                         independent operating systems need to share 
> the MPIC
> +                         without clobbering each other.
> +

Can we define no-reset as meaning that all vectors are in a sane state
(either directed at other cores, or masked)?

If we do that, maybe we can get rid of protected-sources.

-Scott
