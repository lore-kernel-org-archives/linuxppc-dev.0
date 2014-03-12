Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x235.google.com (mail-pb0-x235.google.com
 [IPv6:2607:f8b0:400e:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DF1BB2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 16:58:12 +1100 (EST)
Received: by mail-pb0-f53.google.com with SMTP id rp16so612790pbb.26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 22:58:09 -0700 (PDT)
Date: Wed, 12 Mar 2014 13:57:55 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
Message-ID: <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <1394586624.13761.132.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Jason.Jin@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 08:10:24PM -0500, Scott Wood wrote:
> > +	FSL_DIS_ALL_IRQ
> > +
> > +	/*
> > +	 * Place DDR controller in self refresh mode.
> > +	 * From here on, DDR can't be access any more.
> > +	 */
> > +	lwz	r10, 0(r13)
> > +	oris	r10, r10, CCSR_DDR_SDRAM_CFG_2_FRC_SR@h
> > +	stw	r10, 0(r13)
> > +
> > +	/* can't call udelay() here, so use a macro to delay */
> > +	FSLDELAY(50)
>=20
> A timebase loop doesn't require accessing DDR.
>=20
> You also probably want to do a "sync, readback, data dependency, isync"
> sequence to make sure that the store has hit CCSR before you begin your
> delay (or is a delay required at all if you do that?).

Shouldn't we use "readback, sync" here? The following is quoted form t4240R=
M:
  To guarantee that the results of any sequence of writes to configuration
  registers are in effect, the final configuration register write should be
  immediately followed by a read of the same register, and that should be
  followed by a SYNC instruction. Then accesses can safely be made to memory
  regions affected by the configuration register write.

> > +
> > +	/* Enable SCU15 to trigger on RCPM Concentrator 0 */
> > +	lwz	r10, 0(r15)
> > +	oris	r10, r10, DCSR_EPU_EPECR15_IC0@h
> > +	stw	r10, 0(r15)
> > +
> > +	/* put Core0 in PH15 mode, trigger EPU FSM */
> > +	lwz	r10, 0(r12)
> > +	ori	r10, r10, CCSR_RCPM_PCPH15SETR_CORE0
> > +	stw	r10, 0(r12)
>=20
> Shouldn't there be a sync to ensure that the previous I/O happens before
> the final store to enter PH15?

Do we really need a sync here? According to the PowerISA, the above stores
should be performed in program order.
  If two Store instructions or two Load instructions
  specify storage locations that are both Caching
  Inhibited and Guarded, the corresponding storage
  accesses are performed in program order with
  respect to any processor or mechanism.

Thanks,
Kevin

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTH/djAAoJEJNY7TDerrFxTbUH/R6BbK6sbpZMI5Pabl4lGsJk
rKbTu5Bx+VtrEcEgMwlMmrFBnSKQIXZT+RCamNVUZgKOCCSYiALGGcq5hBijqk/V
xr+qk/oE2pvvmXVhzjxGs2e/A0VdEdBTzWU/M46pLsiN0ZM7XrpGwaDOpwimuDc2
4GxYYbJZBMKGkqMRFrekvWjeC6Q3OEXLSTigCxXR7b4Kgs2LWvVjZqpccwBzyJjT
IdDx5fiNbje73cnwAMs1qkrFnl45F0gdppCuhrmnrT+TCebfiXNMx8CmkD+feskh
2cOYzzD/6e3yJ9zXXav1BBFV8Y0s5x7p2hLBIUOhMzVz6BYUjVjguKCpcExBXUY=
=Dg5c
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
