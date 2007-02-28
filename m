Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU profiling updated patch
Date: Wed, 28 Feb 2007 02:44:12 +0100
References: <1172102523.5233.31.camel@dyn9047021078.beaverton.ibm.com>
	<200702270051.00393.arnd@arndb.de> <45E461D4.6050807@us.ibm.com>
In-Reply-To: <45E461D4.6050807@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200702280244.12844.arnd@arndb.de>
Cc: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Mike Perks <mperks@us.ibm.com>,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 27 February 2007, Maynard Johnson wrote:
> I have applied the "cleanup" patch that Arnd sent, but had to fix up a=20
> few things:
> =A0 =A0- =A0Bug fix: =A0Initialize retval in spu_task_sync.c, line 95, ot=
herwise=20
> OProfile this function returns non-zero and OProfile fails.
> =A0 =A0- =A0Remove unused codes in include/linux/oprofile.h
> =A0 =A0- =A0Compile warnings: =A0Initialize offset and spu_cookie at line=
s 283=20
> and 284 in spu_task_sync.c
>=20
> With these changes and some userspace changes that were necessary to=20
> correspond with Arnd's changes, our testing was successful.
>=20
> A fixup patch is attached.
>=20

The patch does not contain any of the metadata I need to apply it
(subject, description, signed-off-by).

> @@ -280,8 +280,8 @@ static int process_context_switch(struct
>  {
>         unsigned long flags;
>         int retval;
> -       unsigned int offset;
> -       unsigned long spu_cookie, app_dcookie;
> +       unsigned int offset =3D 0;
> +       unsigned long spu_cookie =3D 0, app_dcookie;
>         retval =3D prepare_cached_spu_info(spu, objectId);
>         if (retval)
>                 goto out;

No, this is wrong. Leaving the variables uninitialized at least warns
you about the bug you have in this function: when there is anything wrong,
you just continue writing the record with zero offset and dcookie values
in it. Instead, you should get handle the error condition somewhere
down the code.

It's harmless most of the time, but you really should not be painting
over your bugs by blindly initializing variables.

> diff -paur linux-orig/include/linux/oprofile.h linux-new/include/linux/op=
rofile.h
> --- linux-orig/include/linux/oprofile.h 2007-02-27 14:41:29.000000000 -06=
00
> +++ linux-new/include/linux/oprofile.h  2007-02-27 14:43:18.000000000 -06=
00
> @@ -36,9 +36,6 @@
>  #define XEN_ENTER_SWITCH_CODE          10
>  #define SPU_PROFILING_CODE             11
>  #define SPU_CTX_SWITCH_CODE            12
> -#define SPU_OFFSET_CODE                13
> -#define SPU_COOKIE_CODE                14
> -#define SPU_SHLIB_COOKIE_CODE          15
> =20
>  struct super_block;
>  struct dentry;
>=20
Right, I forgot about this.

	Arnd <><
