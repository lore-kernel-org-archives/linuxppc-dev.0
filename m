Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0C2F2C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 09:28:55 +1000 (EST)
Date: Fri, 26 Jul 2013 18:28:46 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/8] powerpc: enable the relocatable support for the
 fsl booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1372942454-25191-4-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Thu Jul  4 07:54:09 2013)
Message-ID: <1374881326.30721.37@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2013 07:54:09 AM, Kevin Hao wrote:
> This is based on the codes in the head_44x.S. Since we always align to
> 256M before mapping the PAGE_OFFSET for a relocatable kernel, we also
> change the init tlb map to 256M size.
>=20
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2: Move the code to set kernstart_addr and virt_phys_offset to a c =20
> function.
>     So we can expand it easily later.
>=20
> Hi Scott,
>=20
> I still use the 256M align for the init tlb as in v1 for the =20
> following reasons:
>   * This should be the most possible case in reality.

There is no "most possible case".  It's either possible (and supported) =20
or not.  And having less than 256M is definitely possible.  The 8540 =20
reference board has 64M.

AMP scenarios that start on a 64M-aligned but not 256M-aligned address =20
are also something I've done.

>   * This is just for very early booting code and should not be a big =20
> issue
>     if the first tlb entry shrink to a less size later.

"We can probably get away with it most of the time" is not a very good =20
justification.  What's wrong with the suggestion I made last time, of =20
basing the size on the alignment of the address?

> +	/*
> +	 * We have the runtime (virutal) address of our base.
> +	 * We calculate our shift of offset from a 256M page.
> +	 * We could map the 256M page we belong to at PAGE_OFFSET and
> +	 * get going from there.
> +	 */
> +	lis	r4,KERNELBASE@h
> +	ori	r4,r4,KERNELBASE@l
> +	rlwinm	r6,r25,0,0xfffffff		/* r6 =3D PHYS_START % =20
> 256M */
> +	rlwinm	r5,r4,0,0xfffffff		/* r5 =3D KERNELBASE % =20
> 256M */
> +	subf	r3,r5,r6			/* r3 =3D r6 - r5 */
> +	add	r3,r4,r3			/* Required Virutal =20
> Address */

s/Virutal/Virtual/

-Scott=
