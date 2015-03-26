Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A1401A011B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 13:10:13 +1100 (AEDT)
Date: Thu, 26 Mar 2015 12:46:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 4/4] drivers/vfio: Remove duplicated PE states
Message-ID: <20150326014651.GL28039@voom.redhat.com>
References: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427325637-14345-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427330788.3643.883.camel@redhat.com>
 <20150326005903.GA16778@shangw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
In-Reply-To: <20150326005903.GA16778@shangw>
Cc: linuxppc-dev@ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 agraf@suse.de, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 11:59:03AM +1100, Gavin Shan wrote:
> On Wed, Mar 25, 2015 at 06:46:28PM -0600, Alex Williamson wrote:
> >On Thu, 2015-03-26 at 10:20 +1100, Gavin Shan wrote:
> >> The set of constants for PE states defined in uapi/linux/vfio.h is
> >> duplicated to uapi/asm/eeh.h. The patch removes the set from the
> >> former.
> >>=20
> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> ---
> >>  include/uapi/linux/vfio.h | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>=20
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index d81c17f..3fd1e86 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -492,11 +492,6 @@ struct vfio_eeh_pe_op {
> >>  #define VFIO_EEH_PE_UNFREEZE_IO		2	/* Enable IO for frozen PE   */
> >>  #define VFIO_EEH_PE_UNFREEZE_DMA	3	/* Enable DMA for frozen PE  */
> >>  #define VFIO_EEH_PE_GET_STATE		4	/* PE state retrieval        */
> >> -#define  VFIO_EEH_PE_STATE_NORMAL	0	/* PE in functional state    */
> >> -#define  VFIO_EEH_PE_STATE_RESET	1	/* PE reset in progress      */
> >> -#define  VFIO_EEH_PE_STATE_STOPPED	2	/* Stopped DMA and IO        */
> >> -#define  VFIO_EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only         =
 */
> >> -#define  VFIO_EEH_PE_STATE_UNAVAIL	5	/* State unavailable         */
> >>  #define VFIO_EEH_PE_RESET_DEACTIVATE	5	/* Deassert PE reset         */
> >>  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
> >>  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  =
*/
> >
> >How do you know that nobody depends on these defines?  I thought the
> >suggestion was to use the EEH_* defines for error injection, not to
> >remove existing VFIO_EEH_* defines.  You could certainly redefine these
> >in terms of EEH_* defines instead.  Thanks,
> >
>=20
> QEMU should be the first user to utilize the EEH capability exposed by
> the host kernel, and I believe QEMU doesn't use those constants yet.
> So it's right time to move those constants to uapi/asm/eeh.h. Once some
> one starts to use them, it's impossible to do so.

That's a good point, actually.  This seems like a reasonable risk
under the cirucmstances to me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVE2ULAAoJEGw4ysog2bOSIBYQANlDl5gMdYwC3zHoUus+eobU
ViVaEPPgbQuCt4G88a+byUTcc9oo/xWwTuUIz/8ojowrv4Dwm7aLXaQY0x46CLqd
Kvubla3JGF28GYwpSUROJvZUoBSkh2jym5tqZ0AtJoHBnkbiBnEXLWoy8bY8NgTy
/b44+u21jE56crrSn+YUeHCsScTrHRWNWhLEvERJ1Q2HsiqSYpkmkFVsTukLK/Y1
cbY9Bw9rMxqlRtg2TxoJeIoVogwO2OUstv8wZbEHpzVfUXnJMZo96HlF7R7QEi08
8PAktclutKGMRoGaoC4H+BMx/PUBfn1UmWsAooPg7BWhkblmepa8eVW+1bFW5maA
gGWgS9SQ24XPixp3ar03EOLkCZoS2OS5Awt8gyaOuz533OI4YMMeVnj08+b6WLFQ
gmUjdCq8E7oPWZII5F6sy7YvR3JxKQxager/exRrUYXer6or695Cj+WWmvQU+0Mv
SwP2VzgNPtjOghZjm1QV8rs06nk1XPHykzkV//4IYL7N+vqjbia2ph4Dkjp6VgRd
BxrePKg10rBy5K93qB2WlVmolcDj8YHBVHL5KEtSfw1WZB/pzr6tPb6My9OpxkH5
FvFxcJHTsar1DjVGUR8uxjyQnsG7QedcntFAnolcR82X8hIMFid22bvb73yEL98G
rXZUc1xaWsXz7SdEif5F
=skYH
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
