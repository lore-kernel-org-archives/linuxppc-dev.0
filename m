Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 4FD69DDE32
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:17:46 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5837427wag
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 11:17:45 -0700 (PDT)
Message-ID: <fa686aa40710031117x528e5afarb059d8f1c9eb3e7f@mail.gmail.com>
Date: Wed, 3 Oct 2007 12:17:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
In-Reply-To: <874ph8xjz1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
	<fa686aa40710030856u74054993q2d73cf18920665f2@mail.gmail.com>
	<874ph8xjz1.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/3/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  Grant> Why not just:
>
>  Grant>         np = of_find_node_by_type(NULL, "qe");
>  Grant> +       if (!np)
>  Grant> +               np = of_find_node_by_type(NULL, "soc");
>  Grant>         if (!np)
>  Grant>                 return -ENODEV;
>
> My first iteration did it like that, but then you don't get a -ENODEV
> if the node is missing (and you'll end up using the wrong clock) and
> it doesn't support processors with SPI on and off QE (if that
> exists/will ever exist).

Okay, but you should at least be able confine your determination of
which sysclk value to use to one part of the function.  Otherwise, it
looks good.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
