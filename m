Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Meador Inge <meadori@gmail.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: RE: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
Date: Fri, 11 Feb 2011 14:58:13 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15030C485D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>
	<4D54986A.60907@mentor.com>
	<AANLkTikPgqgnWDOz+H5OXK7Sc=J67xOF3NMNkfDErocu@mail.gmail.com>
In-Reply-To: <AANLkTikPgqgnWDOz+H5OXK7Sc=J67xOF3NMNkfDErocu@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Meador Inge [mailto:meadori@gmail.com]
> Sent: Thursday, February 10, 2011 9:26 PM
> To: Benjamin Herrenschmidt
> Cc: Yoder Stuart-B08248; devicetree-discuss@lists.ozlabs.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
>=20
> Apologies for the bad post. =A0Bad day for email ... =A0Please ignore the=
 top
> reply in my previous reply. =A0The full reply is the below the quote.
>=20
> On Thu, Feb 10, 2011 at 8:01 PM, Meador Inge <meador_inge@mentor.com>
> wrote:
> >
> > On 02/10/2011 02:42 PM, Meador Inge wrote:
> >>
> >> ---------- Forwarded message ----------
> >> From: Meador Inge<meador_inge@mentor.com>
> >> Date: Fri, Feb 4, 2011 at 5:25 PM
> >> Subject: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
> >> To: linuxppc-dev@lists.ozlabs.org
> >> Cc: devicetree-discuss@lists.ozlabs.org, Hollis Blanchard<
> >> hollis_blanchard@mentor.com>
> >>
> >>
> >> This patch set provides a binding for Open PIC and implements support
> >> for a new property, specified by that binding, called "pic-no-reset".
> >> With "pic-no-reset" in place the "protected-sources" property is no
> >> longer needed and its full implementation was removed.
> >> "protected-sources" is still checked for, however, for legacy
> >> purposes.
> >>
> >> For v3 of this patch the Open PIC binding was changed to be more
> >> consistent with existing bindings, several DTS files were cleaned up,
> >> "no-reset" was changed to "pic-no-reset", and a check to treat
> >> "protected-sources" as a synonym for "pic-no-reset" was added.
> >>
>=20
> From the feedback I have received so far, the fundamental ideas in this
> patch set are sane. =A0However, the following issues still need agreement=
:
>=20
>  =A0 =A01. What should be the name of the no reset property?
>  =A0 =A0 =A0 "pic-no-reset" or "no-reset"?
>  =A0 =A02. Should we just keep the existing protected sources implementat=
ion
>  =A0 =A0 =A0 in place?
>=20
> For (1), I prefer "no-reset".

I also prefer plain "no-reset".  The property is on a pic node so
"pic" on the property seems redundant.

> For (2), I still think that we can make "no-
> reset" a synonym for "protected-sources" and that things will work out.
>=20
> Ben, you said that you would really like to leave the protected sources
> implementation alone. =A0Is the mechanism implemented in "PATCH
> v3 3/4" [1] of having "protected-sources" as a synonym for "pic-no-reset"
> not suitable?

I thought what Ben was getting at was that there is existing
firmware that may provide a device tree with protected-sources,
and thus we should continue supporting it for backwards
compatibility.

So, I would say add "no-reset" as the preferred mechanism
going forward, but keep "protected-sources" for backwards
compatibility.

Stuart
