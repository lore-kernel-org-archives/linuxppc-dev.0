Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7838F1007D2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 17:57:05 +1000 (EST)
Date: Wed, 28 Jul 2010 09:56:55 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 1/5] fsl-diu-fb: fix issue with re-enabling DIU area
	descriptor
Message-ID: <20100728095655.0e1c81eb@wker>
In-Reply-To: <AANLkTikkLVCxU4ZC_nmUhKTQogUNeQzxOX6KqgZcxiYr@mail.gmail.com>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-2-git-send-email-agust@denx.de>
	<AANLkTikkLVCxU4ZC_nmUhKTQogUNeQzxOX6KqgZcxiYr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Jul 2010 01:02:59 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:
...
> > =C2=A0drivers/video/fsl-diu-fb.c | =C2=A0 38 +++++++++++++++++++++++---=
------------
> > =C2=A01 files changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index 27455ce..9b8c991 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -317,6 +317,17 @@ static void fsl_diu_free(void *virt, size_t size)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_pages_exact=
(virt, size);
> > =C2=A0}
> >
> > +/*
> > + * Workaround for failed writing desc register of planes.
> > + * Needed with MPC5121 DIU rev 2.0 silicon.
> > + */
> > +void wr_reg_wa(u32 *reg, u32 val)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 do {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(reg, val);
> > + =C2=A0 =C2=A0 =C2=A0 } while (in_be32(reg) !=3D val);
> > +}
>=20
> I'll apply this one, but it looks like a potential problem.  What
> happens if the write never succeeds?  The kernel then gets stuck in a
> forever busy loop.  You should look at reworking it.

I'll submit an incremental patch that prevents looping forever in
the case if the write never succeeds. Thanks!

Anatolij
