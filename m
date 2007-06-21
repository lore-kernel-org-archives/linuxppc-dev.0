Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] update g5_defconfig
From: Michael Ellerman <michael@ellerman.id.au>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1182461834.25426.38.camel@farscape.rchland.ibm.com>
References: <1182461834.25426.38.camel@farscape.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-e0WmN6IR9+9s5rL0pGmV"
Date: Fri, 22 Jun 2007 09:42:09 +1000
Message-Id: <1182469329.13799.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-e0WmN6IR9+9s5rL0pGmV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-06-21 at 16:37 -0500, Will Schmidt wrote:
> Update the g5_defconfig.    This is choosing all defaults via "make
> oldconfig", then going back and enabling CONFIG_MACINTOSH_DRIVERS and
> options underneath that.    Specifically this is to allow the windfarm
> driver to be automatically configured when building a defconfig kernel.=20
>=20
>=20
> Signed-off-by Will Schmidt <will_schmidt@vnet.ibm.com>
>=20
> ---
>  g5_defconfig |  354 ++++++++++++++++++++++++++++++----------------------=
-------
>  1 file changed, 185 insertions(+), 169 deletions(-)
>=20
> diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_=
defconfig
> index 3ccf19d..a47a41d 100644
> --- a/arch/powerpc/configs/g5_defconfig
> +++ b/arch/powerpc/configs/g5_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.20-rc5
> -# Mon Jan 22 22:15:04 2007
> +# Linux kernel version: 2.6.22-rc5
> +# Thu Jun 21 15:53:16 2007
>  #
>  CONFIG_PPC64=3Dy
>  CONFIG_64BIT=3Dy
> @@ -27,6 +27,7 @@ CONFIG_GENERIC_TBSYNC=3Dy
>  CONFIG_AUDIT_ARCH=3Dy
>  CONFIG_GENERIC_BUG=3Dy
>  # CONFIG_DEFAULT_UIMAGE is not set
> +CONFIG_PPC64_SWSUSP=3Dy
> =20
>  #
>  # Processor support
> @@ -39,6 +40,7 @@ CONFIG_PPC_FPU=3Dy
>  # CONFIG_PPC_OF_PLATFORM_PCI is not set
>  CONFIG_ALTIVEC=3Dy
>  CONFIG_PPC_STD_MMU=3Dy
> +CONFIG_PPC_MM_SLICES=3Dy
>  CONFIG_VIRT_CPU_ACCOUNTING=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_NR_CPUS=3D4
> @@ -59,6 +61,7 @@ CONFIG_LOCALVERSION_AUTO=3Dy
>  CONFIG_SWAP=3Dy
>  CONFIG_SYSVIPC=3Dy
>  # CONFIG_IPC_NS is not set
> +CONFIG_SYSVIPC_SYSCTL=3Dy
>  CONFIG_POSIX_MQUEUE=3Dy
>  # CONFIG_BSD_PROCESS_ACCT is not set
>  # CONFIG_TASKSTATS is not set
> @@ -66,9 +69,11 @@ CONFIG_POSIX_MQUEUE=3Dy
>  # CONFIG_AUDIT is not set
>  CONFIG_IKCONFIG=3Dy
>  CONFIG_IKCONFIG_PROC=3Dy
> +CONFIG_LOG_BUF_SHIFT=3D17
>  # CONFIG_CPUSETS is not set
>  CONFIG_SYSFS_DEPRECATED=3Dy
>  # CONFIG_RELAY is not set
> +CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_INITRAMFS_SOURCE=3D""
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>  CONFIG_SYSCTL=3Dy
> @@ -83,14 +88,19 @@ CONFIG_BUG=3Dy
>  CONFIG_ELF_CORE=3Dy
>  CONFIG_BASE_FULL=3Dy
>  CONFIG_FUTEX=3Dy
> +CONFIG_ANON_INODES=3Dy
>  CONFIG_EPOLL=3Dy
> +CONFIG_SIGNALFD=3Dy
> +CONFIG_TIMERFD=3Dy
> +CONFIG_EVENTFD=3Dy
>  CONFIG_SHMEM=3Dy
> -CONFIG_SLAB=3Dy
>  CONFIG_VM_EVENT_COUNTERS=3Dy
> +CONFIG_SLAB=3Dy
> +# CONFIG_SLUB is not set
> +# CONFIG_SLOB is not set
>  CONFIG_RT_MUTEXES=3Dy
>  # CONFIG_TINY_SHMEM is not set
>  CONFIG_BASE_SMALL=3D0
> -# CONFIG_SLOB is not set
> =20
>  #
>  # Loadable module support
> @@ -131,15 +141,21 @@ CONFIG_PPC_MULTIPLATFORM=3Dy
>  # CONFIG_PPC_PSERIES is not set
>  # CONFIG_PPC_ISERIES is not set
>  # CONFIG_PPC_MPC52xx is not set
> +# CONFIG_PPC_MPC5200 is not set
>  CONFIG_PPC_PMAC=3Dy
>  CONFIG_PPC_PMAC64=3Dy
>  # CONFIG_PPC_MAPLE is not set
>  # CONFIG_PPC_PASEMI is not set
> +# CONFIG_PPC_CELLEB is not set
> +# CONFIG_PPC_PS3 is not set
>  # CONFIG_PPC_CELL is not set
>  # CONFIG_PPC_CELL_NATIVE is not set
>  # CONFIG_PPC_IBM_CELL_BLADE is not set
> -# CONFIG_PPC_PS3 is not set
> +# CONFIG_PQ2ADS is not set
>  CONFIG_PPC_NATIVE=3Dy
> +CONFIG_MPIC=3Dy
> +# CONFIG_MPIC_WEIRD is not set
> +# CONFIG_PPC_I8259 is not set
>  CONFIG_U3_DART=3Dy
>  # CONFIG_PPC_RTAS is not set
>  # CONFIG_MMIO_NVRAM is not set
> @@ -160,9 +176,12 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
>  CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
>  # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
>  # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
> +
> +#
> +# CPU Frequency drivers
> +#
>  CONFIG_CPU_FREQ_PMAC64=3Dy
> -# CONFIG_WANT_EARLY_SERIAL is not set
> -CONFIG_MPIC=3Dy
> +# CONFIG_CPM2 is not set
> =20
>  #
>  # Kernel options
> @@ -199,34 +218,34 @@ CONFIG_FLAT_NODE_MEM_MAP=3Dy
>  # CONFIG_SPARSEMEM_STATIC is not set
>  CONFIG_SPLIT_PTLOCK_CPUS=3D4
>  CONFIG_RESOURCES_64BIT=3Dy
> +CONFIG_ZONE_DMA_FLAG=3D1
> +# CONFIG_PPC_HAS_HASH_64K is not set
>  # CONFIG_PPC_64K_PAGES is not set
>  # CONFIG_SCHED_SMT is not set
>  CONFIG_PROC_DEVICETREE=3Dy
>  # CONFIG_CMDLINE_BOOL is not set
>  # CONFIG_PM is not set
>  CONFIG_SECCOMP=3Dy
> +# CONFIG_WANT_DEVICE_TREE is not set
>  CONFIG_ISA_DMA_API=3Dy
> =20
>  #
>  # Bus options
>  #
> +CONFIG_ZONE_DMA=3Dy
>  CONFIG_GENERIC_ISA_DMA=3Dy
> -# CONFIG_MPIC_WEIRD is not set
> -# CONFIG_PPC_I8259 is not set
>  # CONFIG_PPC_INDIRECT_PCI is not set
>  CONFIG_PCI=3Dy
>  CONFIG_PCI_DOMAINS=3Dy
>  # CONFIG_PCIEPORTBUS is not set
> +CONFIG_ARCH_SUPPORTS_MSI=3Dy
> +# CONFIG_PCI_MSI is not set

I think we should turn MSI on, it works fine on the G5 here, and the
drivers are pretty good at falling back to LSI if it doesn't work for
some reason.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-e0WmN6IR9+9s5rL0pGmV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGewzQdSjSd0sB4dIRAg1fAJ9KvLqspaPEIWMxwjeczqZHwqyGpwCgku+y
T5TUs+iEo333soPNYkSWpWs=
=t6qh
-----END PGP SIGNATURE-----

--=-e0WmN6IR9+9s5rL0pGmV--
