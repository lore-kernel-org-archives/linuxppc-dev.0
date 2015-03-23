Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6B131A2B0B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 16:09:28 +1100 (AEDT)
Date: Mon, 23 Mar 2015 16:10:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150323051020.GS25043@voom.fritz.box>
References: <1426881525-11044-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426881525-11044-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150323013945.GE25043@voom.fritz.box>
 <20150323015636.GA9430@shangw>
 <20150323034303.GL25043@voom.fritz.box>
 <20150323050359.GA4975@shangw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9wW3yB/H9ZmnRBtb"
In-Reply-To: <20150323050359.GA4975@shangw>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9wW3yB/H9ZmnRBtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 04:03:59PM +1100, Gavin Shan wrote:
> On Mon, Mar 23, 2015 at 02:43:03PM +1100, David Gibson wrote:
> >On Mon, Mar 23, 2015 at 12:56:36PM +1100, Gavin Shan wrote:
> >> On Mon, Mar 23, 2015 at 12:39:45PM +1100, David Gibson wrote:
> >> >On Sat, Mar 21, 2015 at 06:58:45AM +1100, Gavin Shan wrote:
> >> >> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> >> >> to inject the specified EEH error, which is represented by
> >> >> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> >> >>=20
> >> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> >
> >> >Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >> >
> >> >> ---
> >> >>  Documentation/vfio.txt        | 12 ++++++++++++
> >> >>  drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
> >> >>  include/uapi/linux/vfio.h     | 36 +++++++++++++++++++++++++++++++=
++++-
> >> >>  3 files changed, 57 insertions(+), 1 deletion(-)
> >> >>=20
> >> >> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >> >> index 96978ec..c6e11a3 100644
> >> >> --- a/Documentation/vfio.txt
> >> >> +++ b/Documentation/vfio.txt
> >> >> @@ -385,6 +385,18 @@ The code flow from the example above should be=
 slightly changed:
> >> >> =20
> >> >>  	....
> >> >> =20
> >> >> +	/* Inject EEH error, which is expected to be caused by 32-bits
> >> >> +	 * config load.
> >> >> +	 */
> >> >> +	pe_op.op =3D VFIO_EEH_PE_INJECT_ERR;
> >> >> +	pe_op.err.type =3D VFIO_EEH_ERR_TYPE_32;
> >> >> +	pe_op.err.func =3D VFIO_EEH_ERR_FUNC_LD_CFG_ADDR;
> >> >> +	pe_op.err.addr =3D 0ul;
> >> >> +	pe_op.err.mask =3D 0ul;
> >> >> +	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
> >> >> +
> >> >> +	....
> >> >> +
> >> >>  	/* When 0xFF's returned from reading PCI config space or IO BARs
> >> >>  	 * of the PCI device. Check the PE's state to see if that has been
> >> >>  	 * frozen.
> >> >> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spap=
r_eeh.c
> >> >> index 5fa42db..38edeb4 100644
> >> >> --- a/drivers/vfio/vfio_spapr_eeh.c
> >> >> +++ b/drivers/vfio/vfio_spapr_eeh.c
> >> >> @@ -85,6 +85,16 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_gro=
up *group,
> >> >>  		case VFIO_EEH_PE_CONFIGURE:
> >> >>  			ret =3D eeh_pe_configure(pe);
> >> >>  			break;
> >> >> +		case VFIO_EEH_PE_INJECT_ERR:
> >> >> +			minsz =3D offsetofend(struct vfio_eeh_pe_op, err.mask);
> >> >> +			if (op.argsz < minsz)
> >> >> +				return -EINVAL;
> >> >> +			if (copy_from_user(&op, (void __user *)arg, minsz))
> >> >> +				return -EFAULT;
> >> >> +
> >> >> +			ret =3D eeh_pe_inject_err(pe, op.err.type, op.err.func,
> >> >> +						op.err.addr, op.err.mask);
> >> >> +			break;
> >> >>  		default:
> >> >>  			ret =3D -EINVAL;
> >> >>  		}
> >> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> >> index 82889c3..f68e962 100644
> >> >> --- a/include/uapi/linux/vfio.h
> >> >> +++ b/include/uapi/linux/vfio.h
> >> >> @@ -468,12 +468,23 @@ struct vfio_iommu_spapr_tce_info {
> >> >>   * - unfreeze IO/DMA for frozen PE;
> >> >>   * - read PE state;
> >> >>   * - reset PE;
> >> >> - * - configure PE.
> >> >> + * - configure PE;
> >> >> + * - inject EEH error.
> >> >>   */
> >> >> +struct vfio_eeh_pe_err {
> >> >> +	__u32 type;
> >> >> +	__u32 func;
> >> >> +	__u64 addr;
> >> >> +	__u64 mask;
> >> >> +};
> >> >> +
> >> >>  struct vfio_eeh_pe_op {
> >> >>  	__u32 argsz;
> >> >>  	__u32 flags;
> >> >>  	__u32 op;
> >> >> +	union {
> >> >> +		struct vfio_eeh_pe_err err;
> >> >> +	};
> >> >>  };
> >> >> =20
> >> >>  #define VFIO_EEH_PE_DISABLE		0	/* Disable EEH functionality */
> >> >> @@ -490,6 +501,29 @@ struct vfio_eeh_pe_op {
> >> >>  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
> >> >>  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental rese=
t  */
> >> >>  #define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
> >> >> +#define VFIO_EEH_PE_INJECT_ERR		9	/* Inject EEH error          */
> >> >> +#define  VFIO_EEH_ERR_TYPE_32		0	/* 32-bits EEH error type    */
> >> >> +#define  VFIO_EEH_ERR_TYPE_64		1	/* 64-bits EEH error type    */
> >> >> +#define  VFIO_EEH_ERR_FUNC_LD_MEM_ADDR		0	/* Memory load  */
> >> >> +#define  VFIO_EEH_ERR_FUNC_LD_MEM_DATA		1
> >> >> +#define  VFIO_EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load      */
> >> >> +#define  VFIO_EEH_ERR_FUNC_LD_IO_DATA		3
> >> >> +#define  VFIO_EEH_ERR_FUNC_LD_CFG_ADDR		4	/* Config load  */
> >> >> +#define  VFIO_EEH_ERR_FUNC_LD_CFG_DATA		5
> >> >> +#define  VFIO_EEH_ERR_FUNC_ST_MEM_ADDR		6	/* Memory store */
> >> >> +#define  VFIO_EEH_ERR_FUNC_ST_MEM_DATA		7
> >> >> +#define  VFIO_EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store     */
> >> >> +#define  VFIO_EEH_ERR_FUNC_ST_IO_DATA		9
> >> >> +#define  VFIO_EEH_ERR_FUNC_ST_CFG_ADDR		10	/* Config store */
> >> >> +#define  VFIO_EEH_ERR_FUNC_ST_CFG_DATA		11
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_ADDR		12	/* DMA read     */
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_DATA		13
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_MASTER	14
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_TARGET	15
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_ADDR		16	/* DMA write    */
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_DATA		17
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_MASTER	18
> >> >> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_TARGET	19
> >> >
> >> >These all seem to duplicate (under slightly different names) the
> >> >defines you just added in arch/powerpc/include/asm/eeh.h.  It would
> >> >make more sense to only have the uapi copy, surely.
> >> >
> >>=20
> >> David, Thanks for your time. The defines in eeh.h is used not only
> >> for mapping those constants defined in vfio.h, but also for validating
> >> arguments from debugfs entry "err_injct". So it'd better to keep
> >> them separate: one set is used by userspace, another set is used
> >> by host kernel.
> >
> >I don't understand why this is an argument for duplicating them.  They
> >have the same meanings and values, why can't you use the uapi versions
> >everywhere?
> >
>=20
> We can drop the constants defined in eeh.h and just use those defines
> in vfio.h. But I prefer separate constants for some ovbious reasons
> except the one I mentioned above :)
>=20
> - We already had separate sets of constants for EEH and VFIO. For example,
>   VFIO_EEH_PE_STATE_* in include/uapi/vfio.h always have counter part in
>   arch/powerpc/asm/include/eeh.h

Oh.. I see your point.

Yes, the EEH internal code shouldn't need to use the VFIO defined
constants.

But it's still silly to duplicate, I think the correct think would be
to expose the EEH constants in uapi, and use those for VFIO as well.

> - The UAPI interface is expected to be stable, or back-compatible when
>   introducing changes to it. The defines (at least their names) in eeh.h
>   doesn't have to be stable.

But is there any reason not to make them stable.  The VFIO case shows
that we need to lock down an interface somewhere.  I don't see that
there's an advantage to having a not locked down interface in addition
to a locked down one.

> - I would like keep the code between EEH/VFIO independent to each other
>   enough.
>=20
> Thanks,
> Gavin
>=20
> >> By the way, Alex Williamson, could you please ACK this if you don't
> >> find obvious errors in the patch. I really want this to be merged
> >> to 4.1.
> >>=20
> >> Thanks,
> >> Gavin=20
> >>=20
> >>=20
> >>=20
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9wW3yB/H9ZmnRBtb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVD6A8AAoJEGw4ysog2bOSLxsP/jnmArvhQwvuObyPVrO9lKPA
PUs2uJvQPQgHU/t8Hi2Zs/FKfnmOKMHQyWAVtgy7tSKRIwCdOV7KfNOkwBIMWZ9d
Do+/DQZlnayn+xP7JwcW+tZbAWwIGE6LwANKkIotyR1EfnRQ0IC38WyzX+x3DfZx
WASq03ePHppeDTtxGR6k+6S50cD1ugWaDaeVoJujmN94AB7dUbzAMkUCq2kAbekd
iWwWKF2ULT0mCO4gdpoMDrm+2Y8hC7R71rekUxafozFnE6TIqDx/jRigBMKWqPFO
uEldFGbETkivuoRK6zWtpy55xBCBuFbp3lGlvTecxe9lGiLTUQgNlvtvjhbhpHSm
XsCDwIUlR6d7FopD5eRVpe6MisPKZQuo3me/xhXAMxr0UwPkGkw46aH1dcBRTk0l
I3KEa7fLCI0novfmIUqr9/UBRkbBSYxeMMP25JbhKXdLR3vY8rMm7epBy+Q4/A/j
oTs/B7gz/ifoOLfvZa58Tuoq/CiySPclY3Y2wR84L3tFUtJopwDaq4eTmlORUCDF
4EAEKQHLOeYbuyzwq8j44B7ASRfeeruQJpLe3Ms3WCzzxBPbR87tx5Fl/OndIJhr
m1e/L4OXtv2DtifQ/nfhh8XhuP7n+a2U8cy/AgFhaopwtewh53CY9t9etWEj8Xmn
ryu+qQMDRkdQ/o/6cemj
=oRmT
-----END PGP SIGNATURE-----

--9wW3yB/H9ZmnRBtb--
