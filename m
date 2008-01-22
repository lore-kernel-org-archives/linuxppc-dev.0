Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id DACA1DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:49:18 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so2820013hsb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:49:16 -0800 (PST)
Message-ID: <fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
Date: Tue, 22 Jan 2008 15:49:16 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: [PATCH 1/3 v3] Add StorCenter DTS first draft.
In-Reply-To: <E1JHRkS-0005du-O1@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JHRkS-0005du-O1@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/22/08, Jon Loeliger <jdl@jdl.com> wrote:
> Based on the Kurobox DTS files.
>
> Signed-off-by: Andy Wilcox <andy@protium.com>
> Signed-off-by: Jon Loeliger <jdl@jdl.com>

Comments below

> +
> +/ {
> +       model = "StorCenter";
> +       compatible = "storcenter";

Be specific!  "iomega,storcenter".  Even better if you put in the model number.

> +
> +       soc@fc000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               device_type = "soc";

device_type should be dropped (but I know that requires changes to the
existing mpc82xx support code).

> +               compatible = "fsl,mpc8241", "mpc10x";

fsl,mpc8241-immr would be better; this node describes the internally
memory mapped registers; not the entire soc.

> +
> +               mpic: interrupt-controller@40000 {
> +                       #interrupt-cells = <2>;
> +                       #address-cells = <0>;

Is #address-cells needed?  There are no child nodes.

> +       chosen {
> +               linux,stdout-path = "/soc/serial@4500";

/soc@fc000000/ perhaps?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
