Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] powerpc/bootwrapper: Add documentation of boot wrapper
	targets
Date: Thu, 26 Jun 2008 09:48:40 -0700
In-Reply-To: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, "John Linn" <linnj@xilinx.com>,
	<linuxppc-dev@ozlabs.com>, <paulus@samba.org>
Message-ID: <20080626164842.1D3AB1358053@mail15-sin.bigfish.com>
Cc: petermendham@computing.dundee.ac.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


My unanswered questions:

1) Why are there 4 different types of targets that embed a device tree?
I assume they differ in how they are started loaded, but (unfortunately)
the names are meaningless (With the exception of cuImage, which is only
cryptic.. :)  If I'm adding support for a new board, which should I use?

2) The simpleImage target is capable of selecting a head.s file to link
based on the target name.  This needs to be documented.

> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]
> Sent: Wednesday, June 25, 2008 1:21 PM
> To: John Linn; Stephen Neuendorffer; linuxppc-dev@ozlabs.com;
paulus@samba.org
> Cc: petermendham@computing.dundee.ac.uk
> Subject: [PATCH] powerpc/bootwrapper: Add documentation of boot
wrapper targets
> =

> From: Grant Likely <grant.likely@secretlab.ca>
> =

> There have been many questions on and off the mailing list about how
> exactly the bootwrapper is used for embedded targets.  Add some
> documentation and help text to try and clarify the system.
> =

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> =

>  Documentation/powerpc/bootwrapper.txt |   78
+++++++++++++++++++++++++++++++++
>  arch/powerpc/Makefile                 |   15 ++++++
>  arch/powerpc/boot/wrapper             |    4 ++
>  3 files changed, 96 insertions(+), 1 deletions(-)
> =

> diff --git a/Documentation/powerpc/bootwrapper.txt
b/Documentation/powerpc/bootwrapper.txt
> new file mode 100644
> index 0000000..8dcb560
> --- /dev/null
> +++ b/Documentation/powerpc/bootwrapper.txt
> @@ -0,0 +1,78 @@
> +The PowerPC boot wrapper
> +------------------------
> +Copyright (C) Secret Lab Technologies Ltd.
> +
> +PowerPC image targets compresses and wraps the kernel image (vmlinux)
with
> +a boot wrapper to make it usable by the system firmware.  There is no
> +standard PowerPC firmware interface, so the boot wrapper is designed
to
> +be adaptable for each kind of image that needs to be built.
> +
> +The boot wrapper can be found in the arch/powerpc/boot/ directory.
The
> +Makefile in that directory has targets for all the available image
types.
> +Currently, the following image targets exist:
> +
> +   cuImage.%:		Backwards compatible uImage for older
version of
> +			U-Boot (for versions that don't understand the
device
> +			tree).  This image embeds a device tree blob
inside
> +			the image.
> +   dtbImage.%:		Similar to zImage, except device tree
blob is embedded
> +			inside the image.
> +   simpleImage.%:	Firmware independent compressed image that does
not
> +			depend on any particular firmware interface and
embeds
> +			a device tree blob.  This image can be loaded to
any
> +			location in RAM and jumped to.  Firmware cannot
pass
> +			any configuration data to the kernel with this
image
> +			type and the kernel depends on the device tree
to
> +			determine its console device.
> +   treeImage.%;		Image format for some versions of ppc4xx
firmware (non
> +			U-Boot firmware).  This image embeds a device
tree
> +			blob inside the image.
> +   uImage:		Native image format used by U-Boot.  The uImage
target
> +			does not add any boot code.  It just wraps a
compressed
> +			vmlinux in the uImage data structure.
> +   zImage.%:		Image usable by OpenFirmware.  Image expects
firmware
> +			to provide the device tree using OpenFirmware
> +			interfaces.  Typically general purpose hardware
uses
> +			this image format.
> +
> +Image types which embed a device tree blob (simpleImage, dtbImage,
treeImage,
> +and cuImage) all generate the device tree blob from a file in the
> +arch/powerpc/boot/dts/ directory.  The Makefile selects the correct
device
> +tree source based on the name of the target.  Therefore, if the
kernel is
> +built with 'make treeImage.walnut simpleImage.virtex405-ml403', then
the
> +build system will use arch/powerpc/boot/dts/walnut.dts to build
> +treeImage.walnut and arch/powerpc/boot/dts/virtex405-ml403.dts to
build
> +the simpleImage.virtex405-ml403.
> +
> +Two special targets called 'zImage' and 'zImage.initrd' also exist.
These
> +targets build all the default images as selected by the kernel
configuration.
> +Default images are selected by the boot wrapper Makefile
> +(arch/powerpc/boot/Makefile) by adding targets to the $image-y
variable.  Look
> +at the Makefile to see which default image targets are available.
> +
> +How it is built
> +---------------
> +arch/powerpc is designed to support multiplatform kernels, which
means
> +that a single vmlinux image can be booted on many different target
boards.
> +It also means that the boot wrapper must be able to wrap for many
kinds of
> +images on a single build.  The design decision was made to not use
any
> +conditional compilation code (#ifdef, etc) in the boot wrapper source
code.
> +All of the boot wrapper pieces are buildable at any time regardless
of the
> +kernel configuration.  Building all the wrapper bits on every kernel
build
> +also ensures that obscure parts of the wrapper are at the very least
compile
> +tested in a large variety of environments.
> +
> +The wrapper is adapted for different image types at link time by
linking in
> +just the wrapper bits that are appropriate for the image type.  The
'wrapper'
> +script (found in arch/powerpc/boot/wrapper) is called by the Makefile
and
> +is responsible for selecting the correct wrapper bits for the image
type.
> +The arguments are well documented in the script's comment block, so
they
> +are not repeated here.  However, it is worth mentioning that the
script
> +uses the -p (platform) argument as the main method of deciding which
wrapper
> +bits to compile in.  Look for the large 'case "$platform" in' block
in the
> +middle of the script.  This is also the place where platform specific
fixups
> +can be selected by changing the link order.
> +
> +In particular, care should be taken when working with cuImages.
cuImage
> +wrapper bits are very board specific and care should be taken to make
sure
> +the target you are trying to build is supported by the wrapper bits.
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index b7d4c4c..754c7eb 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -169,12 +169,25 @@ bootwrapper_install %.dtb:
>  	$(Q)$(MAKE) ARCH=3Dppc64 $(build)=3D$(boot) $(patsubst
%,$(boot)/%,$@)
> =

>  define archhelp
> -  @echo '* zImage          - Compressed kernel image
(arch/$(ARCH)/boot/zImage.*)'
> +  @echo '* zImage          - Build default images selected by kernel
config'
> +  @echo '  zImage.*        - Compressed kernel image
(arch/$(ARCH)/boot/zImage.*)'
> +  @echo '  uImage          - U-Book native image format'
> +  @echo '  cuImage.<dt>    - Backwards compatible U-Boot image for
older'
> +  @echo '                    versions which do not support device
trees'
> +  @echo '  dtbImage.<dt>   - zImage with an embedded device tree
blob'
> +  @echo '  simpleImage.<dt> - Firmware independant image.'
> +  @echo '  treeImage.<dt>  - Support for older IBM 4xx firmware (not
U-Boot)'
>    @echo '  install         - Install kernel using'
>    @echo '                    (your) ~/bin/installkernel or'
>    @echo '                    (distribution) /sbin/installkernel or'
>    @echo '                    install to $$(INSTALL_PATH) and run
lilo'
>    @echo '  *_defconfig     - Select default config from
arch/$(ARCH)/configs'
> +  @echo ''
> +  @echo '  Targets with <dt> embed a device tree blob inside the
image'
> +  @echo '  These targets support board with firmware that does not'
> +  @echo '  support passing a device tree directly.  Replace <dt> with
the'
> +  @echo '  name of a dts file from the arch/$(ARCH)/boot/dts/
directory'
> +  @echo '  (minus the .dts extension).'
>  endef
> =

>  install:
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index d6c96d9..7cd4182 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -203,6 +203,10 @@ simpleboot-virtex405-*)
>      platformo=3D"$object/virtex405-head.o $object/simpleboot.o"
>      binary=3Dy
>      ;;
> +simpleboot-*)
> +    platformo=3D"$object/simpleboot.o"
> +    binary=3Dy
> +    ;;
>  esac
> =

>  vmz=3D"$tmpdir/`basename \"$kernel\"`.$ext"
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
