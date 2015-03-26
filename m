Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FA221A0681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 12:09:58 +1100 (AEDT)
Date: Thu, 26 Mar 2015 12:01:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 4/4] drivers/vfio: Remove duplicated PE states
Message-ID: <20150326010157.GA28039@voom.redhat.com>
References: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427325637-14345-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427330788.3643.883.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
In-Reply-To: <1427330788.3643.883.camel@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 06:46:28PM -0600, Alex Williamson wrote:
> On Thu, 2015-03-26 at 10:20 +1100, Gavin Shan wrote:
> > The set of constants for PE states defined in uapi/linux/vfio.h is
> > duplicated to uapi/asm/eeh.h. The patch removes the set from the
> > former.
> >=20
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > ---
> >  include/uapi/linux/vfio.h | 5 -----
> >  1 file changed, 5 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index d81c17f..3fd1e86 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -492,11 +492,6 @@ struct vfio_eeh_pe_op {
> >  #define VFIO_EEH_PE_UNFREEZE_IO		2	/* Enable IO for frozen PE   */
> >  #define VFIO_EEH_PE_UNFREEZE_DMA	3	/* Enable DMA for frozen PE  */
> >  #define VFIO_EEH_PE_GET_STATE		4	/* PE state retrieval        */
> > -#define  VFIO_EEH_PE_STATE_NORMAL	0	/* PE in functional state    */
> > -#define  VFIO_EEH_PE_STATE_RESET	1	/* PE reset in progress      */
> > -#define  VFIO_EEH_PE_STATE_STOPPED	2	/* Stopped DMA and IO        */
> > -#define  VFIO_EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only          =
*/
> > -#define  VFIO_EEH_PE_STATE_UNAVAIL	5	/* State unavailable         */
> >  #define VFIO_EEH_PE_RESET_DEACTIVATE	5	/* Deassert PE reset         */
> >  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
> >  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
>=20
> How do you know that nobody depends on these defines?  I thought the
> suggestion was to use the EEH_* defines for error injection, not to
> remove existing VFIO_EEH_* defines.  You could certainly redefine these
> in terms of EEH_* defines instead.  Thanks,

Yeah, since they're already exported, these can't be just removed, but
should be redefined in terms of the new exported EEH defines.

I also think this should be folded into 1/1.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVE1qEAAoJEGw4ysog2bOSJ2EP/0g9S9J2w3+uO8cvYDM1mppm
dWnuw0/ARXaS77HvQhBXtM3trlR/Jj43R/32VSx9rytaMASh9LYiDz5jbcaCCltV
lYcXh7LbmEAYjUEb7xHoFRHQUgwONfmJi9ghrSs93DtvfyofetLYgXtUwIEvo/o+
XLRed/ewaeaJACx0eQfNIpLoGjOX2sfecWtDYrEXjVYVPoxcsKp+RxO7/dgEzZ2Z
uNip2jL6Dwd2PT+a8PWDhhzBeFsmqadcvBQMBkBzK8yP2Z12tTtfud8ZA1IRDCtJ
heZslF2S9ohBLJBN9xdT2ArhHMqOT0m++y1VzZNLh6UUOO5kF0dzPqU8aRPHocmp
IazPkRaUF3n+CGmwbroPaTI3DKtss+fQTwJjWE5invsmOU544yh0DvsAtxOa8MYR
sCIaTgAFQP28hotxPO+LZB7Jxn1rRpo+4IqnLwqmUVD8gZ6wJpO/B9YwZZrq8AEz
UChIPiRQgIbBbiscS7uMtyt2bNNUvKMTjUb6Szeuuxp9qm33Qm4MjW/V93G6AZyM
4H6zDs0EYhqQGLKYPvc5V2mBmY59DGayygbY/sDlBt+khjXy4ymoXRrq7M+HHZVu
G7GQtQ7nU8X2S1TnEEpPeynYjJEQzhTxh/ZupY/xQkLRz6PipgVaGv5vQEv4x16p
JC74jst+y6Q6/coyQ/iS
=oJzw
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
