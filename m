Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <348d48851a244bbd60bbfc4d60bee330e5c91eae.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
	<348d48851a244bbd60bbfc4d60bee330e5c91eae.1289943240.git.dirk.brandewie@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Nov 2010 17:16:14 -0700
Message-ID: <AANLkTik2TP_DUWstn_qmq1oz4HaPHqkoGkN5f1oUiHQa@mail.gmail.com>
Subject: Re: [PATCH 2/5] of/fdt: add kernel command line option for dtb_compat
	string
To: dirk.brandewie@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	arjan@linux.intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 3:41 PM,  <dirk.brandewie@gmail.com> wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>
> Adds a kernel command line option "dtb_compat=3D<string>" and functions
> for architecture/platform specific code to retrieve the command line
> string and locate the compatible DTB linked into the kernel
>
> of_flat_dt_get_dtb_compatible_string() returns a pointer string passed
> from the command line or a pointer to an empty string.
>
> of_flat_dt_find_compatible_dtb() returns a pointer to a DTB that is
> compatible with the "compatible" string or a NULL pointer if no
> matching DTB is present.
>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
[...]
> +void __init *of_flat_dt_find_compatible_dtb(char *name)
> +{
> + =A0 =A0 =A0 void *rc =3D NULL;
> + =A0 =A0 =A0 unsigned long root, size;
> + =A0 =A0 =A0 struct boot_param_header =A0*orig_initial_boot_params;
> + =A0 =A0 =A0 uint8_t *blob;
> +
> + =A0 =A0 =A0 orig_initial_boot_params =3D initial_boot_params;
> + =A0 =A0 =A0 blob =3D __dtb_start;
> + =A0 =A0 =A0 initial_boot_params =3D (struct boot_param_header *)blob;
> +
> + =A0 =A0 =A0 while (blob < __dtb_end &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (be32_to_cpu(initial_boot_params->magic) =
=3D=3D OF_DT_HEADER)) {

The kernel needs to complain *loudly* if this occurs because it
represents a bug.  I'm tempted to say use BUG, but that would halt the
kernel and prevent any possibility of kernel log output.  WARN_ON() is
probably best.

g.
