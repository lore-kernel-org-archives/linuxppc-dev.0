Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.241])
	by ozlabs.org (Postfix) with ESMTP id AC35ADE09B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 04:17:36 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so3089403hsb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 09:17:35 -0800 (PST)
Message-ID: <fa686aa40802060917x3a1a9f58l21a4461f9213fcf1@mail.gmail.com>
Date: Wed, 6 Feb 2008 10:17:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH v3] [POWERPC] bootwrapper: build multiple cuImages
In-Reply-To: <47A9E8AB.1050804@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
	<47A9E8AB.1050804@freescale.com>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/6/08, Scott Wood <scottwood@freescale.com> wrote:
> > -ifneq ($(CONFIG_REDBOOT),"")
> > -image-$(CONFIG_PPC_8xx)                      += zImage.redboot-8xx
> > -endif
> > +# Board ports in arch/powerpc/platform/8xx/Kconfig
> > +image-$(CONFIG_PPC_MPC86XADS)                += cuImage.mpc866ads
> > +image-$(CONFIG_PPC_MPC885ADS)                += zImage-dtb.mpc885ads
>
> mpc885ads is cuImage.

Fixed

>
> > +# Board ports in arch/powerpc/platform/83xx/Kconfig
> > +image-$(CONFIG_MPC8313_RDB)          += cuImage.mpc8313erdb
>
> I don't think we need cuImage for this board (no pre-device-tree u-boot).

removed

>
> > +image-$(CONFIG_MPC837x_MDS)          += cuImage.mpc8377_mds \
> > +                                        cuImage.mpc8378_mds \
> > +                                        cuImage.mpc8379_mds
>
> I really hope we don't need cuImage for these. :-)

removed

>
> I wish CONFIG_BOARD_FOO could be annotated with properties such as image
>    name and bootwrapper platform, rather than having to maintain
> separate lists...  Oh well.

Me too.  Fortunately this is probably only an issue for images which
require an embedded dtb.  Images that get their device trees from
elsewhere can follow the lead of CONFIG_DEFAULT_UIMAGE.  Over time
this issue will diminish.

Thanks for the feedback

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
