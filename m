Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id EE03DB6EE9
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 09:25:50 +1100 (EST)
Received: by gxk28 with SMTP id 28so5903497gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 14:25:48 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1261446643-21714-2-git-send-email-ptyser@xes-inc.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-2-git-send-email-ptyser@xes-inc.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 30 Dec 2009 15:25:28 -0700
Message-ID: <fa686aa40912301425s47b0363cq723e8bff1ab995c6@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc: Use scripts/mkuboot.sh instead of
	'mkimage'
To: Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 6:50 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> mkuboot.sh provides a basic wrapper for the 'mkimage' utility. =A0Using
> mkuboot.sh provides clearer error reporting and allows a toolchain to
> use its own 'mkimage' executable specified by ${CROSS_COMPILE}mkimage.
> Additionally, this brings PowerPC in line with other architectures
> which already call mkimage via mkuboot.sh.
>
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>

Okay by me.  I've picked this one up.

g.

> ---
> =A0arch/powerpc/boot/wrapper | =A0 =A07 +++++--
> =A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 390512a..f4594ed 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -43,6 +43,9 @@ gzip=3D.gz
> =A0# cross-compilation prefix
> =A0CROSS=3D
>
> +# mkimage wrapper script
> +MKIMAGE=3D$srctree/scripts/mkuboot.sh
> +
> =A0# directory for object and other files used by this script
> =A0object=3Darch/powerpc/boot
> =A0objbin=3D$object
> @@ -267,7 +270,7 @@ membase=3D`${CROSS}objdump -p "$kernel" | grep -m 1 L=
OAD | awk '{print $7}'`
> =A0case "$platform" in
> =A0uboot)
> =A0 =A0 rm -f "$ofile"
> - =A0 =A0mkimage -A ppc -O linux -T kernel -C gzip -a $membase -e $membas=
e \
> + =A0 =A0${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $mem=
base \
> =A0 =A0 =A0 =A0$uboot_version -d "$vmz" "$ofile"
> =A0 =A0 if [ -z "$cacheit" ]; then
> =A0 =A0 =A0 =A0rm -f "$vmz"
> @@ -327,7 +330,7 @@ coff)
> =A0 =A0 ;;
> =A0cuboot*)
> =A0 =A0 gzip -f -9 "$ofile"
> - =A0 =A0mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry"=
 \
> + =A0 =A0${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$ent=
ry" \
> =A0 =A0 =A0 =A0 =A0 =A0 $uboot_version -d "$ofile".gz "$ofile"
> =A0 =A0 ;;
> =A0treeboot*)
> --
> 1.6.2.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
