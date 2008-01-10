Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 6F82EDDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 02:01:13 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so156237anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 07:01:10 -0800 (PST)
Message-ID: <fa686aa40801100701q7454d8d0o8542ce9cc10f3bfb@mail.gmail.com>
Date: Thu, 10 Jan 2008 08:01:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH V3] [POWERPC] Add common clock setting routine
	mpc52xx_psc_set_clkdiv()
In-Reply-To: <20080110181316.1213f273.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080110052629.8853.52821.stgit@trillian.secretlab.ca>
	<20080110181316.1213f273.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, dragos.carp@toptica.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/10/08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Grant,
>
> On Wed, 09 Jan 2008 22:26:30 -0700 Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > +mpc52xx_map_common_devices(void)
> >  {
>
> > +     /* Clock Distribution Module, used by PSC clock setting function */
> > +     np = of_find_matching_node(NULL, mpc52xx_cdm_ids);
>
> What happens if we find no node?

Both of_iomap and of_put fail gracefully if np is NULL.  IIRC that was
done on purpose so this exact thing could be done.

Users of mpc52xx_cdm (and the others done in this style) all check for
mpc52xx_cdm being NULL before dereferencing.

>
> > +     mpc52xx_cdm = of_iomap(np, 0);
> > +     of_node_put(np);
> >  }
>
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
