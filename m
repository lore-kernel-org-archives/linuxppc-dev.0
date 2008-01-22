Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 80ED8DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:16:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so611647anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 15:16:35 -0800 (PST)
Message-ID: <fa686aa40801221516o27154589w20fabe3e365230c0@mail.gmail.com>
Date: Tue, 22 Jan 2008 16:16:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@freescale.com>
Subject: Re: [PATCH 1/3 v3] Add StorCenter DTS first draft.
In-Reply-To: <47967436.9070704@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JHRkS-0005du-O1@jdl.com>
	<fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
	<47967436.9070704@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/22/08, Jon Loeliger <jdl@freescale.com> wrote:
> Grant Likely wrote:
> > On 1/22/08, Jon Loeliger <jdl@jdl.com> wrote:
> >> Based on the Kurobox DTS files.
> >>
> >> Signed-off-by: Andy Wilcox <andy@protium.com>
> >> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> >
> > Comments below
> >
> >> +
> >> +/ {
> >> +       model = "StorCenter";
> >> +       compatible = "storcenter";
> >
> > Be specific!  "iomega,storcenter".  Even better if you put in the model number.
>
> As I mentioned vefore, there is no further model number.
> That _is_ the model name.

/me has a short memory.

> >> +               compatible = "fsl,mpc8241", "mpc10x";
> >
> > fsl,mpc8241-immr would be better; this node describes the internally
> > memory mapped registers; not the entire soc.
>
> Uh, whatever? :-)  'Cuz how many other DTS files say that?

True, we haven't been doing this until recently; but we've also been
stumbling about over the last 2 years figuring out how best to use
this fancy device tree thing in embedded systems effectively.  Best
practices are starting to emerge (wadda you know, the open firmware
recommended practices actually have good thought behind them) and
being specific with the compatible property is one aspect.  I'm moving
the 5200 over to specifying -immr and some of the other soc ports are
doing so also.  Chat with Scott Wood.

> >> +               linux,stdout-path = "/soc/serial@4500";
> >
> > /soc@fc000000/ perhaps?
>
> Not really necessary to specify the unit number.

Okay, I wasn't sure if we could get away with that with the fdt.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
