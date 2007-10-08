Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id BA69DDDFF4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 07:06:29 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1891719wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 14:06:28 -0700 (PDT)
Message-ID: <fa686aa40710081406w4aa751ewddb6a164bc070871@mail.gmail.com>
Date: Mon, 8 Oct 2007 15:06:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Geoff Levand" <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
In-Reply-To: <fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<D6497F34-ECE1-481E-B969-E7DDC60BAAFD@kernel.crashing.org>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/8/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 10/8/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Oct 8, 2007, at 10:12 AM, Grant Likely wrote:
> >
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > I can't see a good reason for eval board platform code to mess with
> > > the
> > > ROOT_DEV value instead of using the default behaviour (so I'm writing
> > > this patch to see if anyone will clue me in).
> > >
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >
> > >  arch/powerpc/platforms/52xx/efika.c          |    9 ---------
> > >  arch/powerpc/platforms/52xx/lite5200.c       |   12 ------------
> > >  arch/powerpc/platforms/82xx/mpc82xx_ads.c    |    6 ------
> > >  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 --
> > >  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 --
> > >  arch/powerpc/platforms/chrp/setup.c          |   10 ----------
> > >  6 files changed, 0 insertions(+), 41 deletions(-)
> >
> > FYI, 82xx_ads and 885ads don't have this issue in my tree based on
> > fixes from Scott.
>
> So, if I respin this patch to exclude those two platforms, will you
> merge it?  (Efika and Lite5200 only have it because they were cloned
> from CHRP.
>
> Powermac and pseries also do this weirdness.  Should it be removed
> from there too?

Oh, and cell does too.  Geoff, does cell support really need to do this:
(in cell/setup.c and celleb/setup.c).
	if (ROOT_DEV == 0) {
		printk("No ramdisk, default root is /dev/hda2\n");
		ROOT_DEV = Root_HDA2;
	}

If not; I'll spin a patch to drop it.

Thanks,
g.



>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
