Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 3E869DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:54:04 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so604990anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 13:54:03 -0800 (PST)
Message-ID: <fa686aa40801221354i53b5e8ebn8fc547b8eea75ebe@mail.gmail.com>
Date: Tue, 22 Jan 2008 14:54:03 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add docs for Freescale PowerQUICC SATA device
	tree nodes
In-Reply-To: <Pine.LNX.4.64.0801221536430.25559@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0801221536430.25559@blarg.am.freescale.net>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/22/08, Kumar Gala <galak@kernel.crashing.org> wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  Documentation/powerpc/booting-without-of.txt |   30 ++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 3584c33..387310a 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2743,6 +2743,36 @@ platforms are moved over to use the flattened-device-tree model.
>                 };
>         };
>
> +    * Freescale 8xxx/3.0 Gb/s SATA nodes
> +
> +    SATA nodes are defined to describe on-chip Serial ATA controllers.
> +    Each SATA port should have its own node.
> +
> +    Required properties:
> +    - compatible        : compatible list, contains 2 entries, first is
> +                        "fsl,CHIP-sata", where CHIP is the processor
> +                        (mpc8315, mpc8379, etc.) and the second is
> +                        "fsl,pq-sata"

As discussed on IRC, I don't like the approach of trying to define
generic names for these ip cores.  Too much can change in the future
to make the definition of the generic type drift over time.  Better to
always refer to exact chip variants.

ie.  Assuming mpc8315 was the first part to contain the sata core; the
dts should claim "fsl,CHIP-sata","fsl,mpc8315-sata" instead of
"fsl,CHIP-sata","fsl,pq-sata".

It ends up being the same amount of work to support, but it doesn't
fall into the trap of making stuff up.

Another example; when describing serial ports, we still use an
*ancient* device to claim compatibility with: "ns16550".  ns16550 is
specific, not generic, yet everyone still knows what it means.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
