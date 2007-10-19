Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by ozlabs.org (Postfix) with ESMTP id 3869DDDF62
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:41:49 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so82730nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:41:48 -0700 (PDT)
Message-ID: <fa686aa40710190841q4f0c5ceao29ee55cc7fa2ff04@mail.gmail.com>
Date: Fri, 19 Oct 2007 09:41:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Li Yang" <leoli@freescale.com>
Subject: Re: [PATCH v7 5/9] add documentation for SATA nodes
In-Reply-To: <1192793930-26039-6-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/19/07, Li Yang <leoli@freescale.com> wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   32 ++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index a96e853..8d49942 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2242,6 +2242,38 @@ platforms are moved over to use the flattened-device-tree model.
>                            available.
>                            For Axon: 0x0000012a
>
> +    o) SATA nodes
> +
> +    SATA nodes are defined to describe on-chip Serial ATA controllers.
> +
> +    Required properties:
> +
> +    - compatible : Should specify what this SATA controller is compatible
> +      with.
> +    - reg : Offset and length of the register set for the device.
> +    - interrupts : <a b> where a is the interrupt number and b is a
> +      field that represents an encoding of the sense and level
> +      information for the interrupt.  This should be encoded based on
> +      the information in section 2) depending on the type of interrupt
> +      controller you have.
> +    - interrupt-parent : the phandle for the interrupt controller that
> +      services interrupts for this device.
> +
> +    Recommended properties :
> +
> +    - phy-handle : Some SATA controller uses a shared SerDes PHY. This
> +      property should specify the phandle of the SerDes node.

I'm not sure about this property.  Does the driver need to know about
this?  Will this setup ever change at runtime?  It seems to me that
like GPIOs and chip selects, setting you which shared PHY goes with
which device is something that should be done at board setup time.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
