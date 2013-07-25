Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-x236.google.com (mail-bk0-x236.google.com
 [IPv6:2a00:1450:4008:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 261902C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 04:38:11 +1000 (EST)
Received: by mail-bk0-f54.google.com with SMTP id it19so824113bkc.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 11:38:04 -0700 (PDT)
Date: Thu, 25 Jul 2013 11:37:54 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv5 02/11] PCI: use weak functions for MSI arch-specific
 functions
Message-ID: <20130725183752.GA18584@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-3-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <1373889167-27878-3-git-send-email-thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-pci@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Jason Cooper <jason@lakedaemon.net>,
 Rob Herring <rob.herring@calxeda.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 Maen Suleiman <maen@marvell.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 01:52:38PM +0200, Thomas Petazzoni wrote:
> Until now, the MSI architecture-specific functions could be overloaded
> using a fairly complex set of #define and compile-time
> conditionals. In order to prepare for the introduction of the msi_chip
> infrastructure, it is desirable to switch all those functions to use
> the 'weak' mechanism. This commit converts all the architectures that
> were overidding those MSI functions to use the new strategy.
>=20
> Note that we keep a separate, non-weak, function
> default_teardown_msi_irqs() for the default behavior of the
> arch_teardown_msi_irqs(), as the default behavior is needed by the Xen
> x86 PCI code.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/mips/include/asm/pci.h    |  5 -----
>  arch/powerpc/include/asm/pci.h |  5 -----
>  arch/s390/include/asm/pci.h    |  4 ----
>  arch/x86/include/asm/pci.h     | 28 --------------------------
>  arch/x86/kernel/x86_init.c     | 21 ++++++++++++++++++++
>  drivers/pci/msi.c              | 45 +++++++++++++++++++-----------------=
------
>  include/linux/msi.h            |  7 ++++++-
>  7 files changed, 47 insertions(+), 68 deletions(-)

Bjorn,

any chance that we can get your Acked-by on this?

Thierry

>=20
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index fa8e0aa..f194c08 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -136,11 +136,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_=
dev *dev, int channel)
>  	return channel ? 15 : 14;
>  }
> =20
> -#ifdef CONFIG_CPU_CAVIUM_OCTEON
> -/* MSI arch hook for OCTEON */
> -#define arch_setup_msi_irqs arch_setup_msi_irqs
> -#endif
> -
>  extern char * (*pcibios_plat_setup)(char *str);
> =20
>  #ifdef CONFIG_OF
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pc=
i.h
> index 6653f27..95145a1 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -113,11 +113,6 @@ extern int pci_domain_nr(struct pci_bus *bus);
>  /* Decide whether to display the domain number in /proc */
>  extern int pci_proc_domain(struct pci_bus *bus);
> =20
> -/* MSI arch hooks */
> -#define arch_setup_msi_irqs arch_setup_msi_irqs
> -#define arch_teardown_msi_irqs arch_teardown_msi_irqs
> -#define arch_msi_check_device arch_msi_check_device
> -
>  struct vm_area_struct;
>  /* Map a range of PCI memory or I/O space for a device into user space */
>  int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 6e577ba..262b91b 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -21,10 +21,6 @@ void pci_iounmap(struct pci_dev *, void __iomem *);
>  int pci_domain_nr(struct pci_bus *);
>  int pci_proc_domain(struct pci_bus *);
> =20
> -/* MSI arch hooks */
> -#define arch_setup_msi_irqs	arch_setup_msi_irqs
> -#define arch_teardown_msi_irqs	arch_teardown_msi_irqs
> -
>  #define ZPCI_BUS_NR			0	/* default bus number */
>  #define ZPCI_DEVFN			0	/* default device number */
> =20
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index d9e9e6c..8c61de0 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -100,29 +100,6 @@ static inline void early_quirks(void) { }
>  extern void pci_iommu_alloc(void);
> =20
>  #ifdef CONFIG_PCI_MSI
> -/* MSI arch specific hooks */
> -static inline int x86_setup_msi_irqs(struct pci_dev *dev, int nvec, int =
type)
> -{
> -	return x86_msi.setup_msi_irqs(dev, nvec, type);
> -}
> -
> -static inline void x86_teardown_msi_irqs(struct pci_dev *dev)
> -{
> -	x86_msi.teardown_msi_irqs(dev);
> -}
> -
> -static inline void x86_teardown_msi_irq(unsigned int irq)
> -{
> -	x86_msi.teardown_msi_irq(irq);
> -}
> -static inline void x86_restore_msi_irqs(struct pci_dev *dev, int irq)
> -{
> -	x86_msi.restore_msi_irqs(dev, irq);
> -}
> -#define arch_setup_msi_irqs x86_setup_msi_irqs
> -#define arch_teardown_msi_irqs x86_teardown_msi_irqs
> -#define arch_teardown_msi_irq x86_teardown_msi_irq
> -#define arch_restore_msi_irqs x86_restore_msi_irqs
>  /* implemented in arch/x86/kernel/apic/io_apic. */
>  struct msi_desc;
>  int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> @@ -130,11 +107,6 @@ void native_teardown_msi_irq(unsigned int irq);
>  void native_restore_msi_irqs(struct pci_dev *dev, int irq);
>  int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  		  unsigned int irq_base, unsigned int irq_offset);
> -/* default to the implementation in drivers/lib/msi.c */
> -#define HAVE_DEFAULT_MSI_TEARDOWN_IRQS
> -#define HAVE_DEFAULT_MSI_RESTORE_IRQS
> -void default_teardown_msi_irqs(struct pci_dev *dev);
> -void default_restore_msi_irqs(struct pci_dev *dev, int irq);
>  #else
>  #define native_setup_msi_irqs		NULL
>  #define native_teardown_msi_irq		NULL
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 45a14db..a2b189c 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -116,6 +116,27 @@ struct x86_msi_ops x86_msi =3D {
>  	.setup_hpet_msi		=3D default_setup_hpet_msi,
>  };
> =20
> +/* MSI arch specific hooks */
> +int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	return x86_msi.setup_msi_irqs(dev, nvec, type);
> +}
> +
> +void arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	x86_msi.teardown_msi_irqs(dev);
> +}
> +
> +void arch_teardown_msi_irq(unsigned int irq)
> +{
> +	x86_msi.teardown_msi_irq(irq);
> +}
> +
> +void arch_restore_msi_irqs(struct pci_dev *dev, int irq)
> +{
> +	x86_msi.restore_msi_irqs(dev, irq);
> +}
> +
>  struct x86_io_apic_ops x86_io_apic_ops =3D {
>  	.init			=3D native_io_apic_init_mappings,
>  	.read			=3D native_io_apic_read,
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index aca7578..aa2f697 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -30,20 +30,21 @@ static int pci_msi_enable =3D 1;
> =20
>  /* Arch hooks */
> =20
> -#ifndef arch_msi_check_device
> -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	return 0;
> +	return -EINVAL;
>  }
> -#endif
> =20
> -#ifndef arch_setup_msi_irqs
> -# define arch_setup_msi_irqs default_setup_msi_irqs
> -# define HAVE_DEFAULT_MSI_SETUP_IRQS
> -#endif
> +void __weak arch_teardown_msi_irq(unsigned int irq)
> +{
> +}
> =20
> -#ifdef HAVE_DEFAULT_MSI_SETUP_IRQS
> -int default_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +{
> +	return 0;
> +}
> +
> +int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
>  	struct msi_desc *entry;
>  	int ret;
> @@ -65,14 +66,11 @@ int default_setup_msi_irqs(struct pci_dev *dev, int n=
vec, int type)
> =20
>  	return 0;
>  }
> -#endif
> =20
> -#ifndef arch_teardown_msi_irqs
> -# define arch_teardown_msi_irqs default_teardown_msi_irqs
> -# define HAVE_DEFAULT_MSI_TEARDOWN_IRQS
> -#endif
> -
> -#ifdef HAVE_DEFAULT_MSI_TEARDOWN_IRQS
> +/*
> + * We have a default implementation available as a separate non-weak
> + * function, as it is used by the Xen x86 PCI code
> + */
>  void default_teardown_msi_irqs(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> @@ -89,15 +87,13 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
>  			arch_teardown_msi_irq(entry->irq + i);
>  	}
>  }
> -#endif
> =20
> -#ifndef arch_restore_msi_irqs
> -# define arch_restore_msi_irqs default_restore_msi_irqs
> -# define HAVE_DEFAULT_MSI_RESTORE_IRQS
> -#endif
> +void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	return default_teardown_msi_irqs(dev);
> +}
> =20
> -#ifdef HAVE_DEFAULT_MSI_RESTORE_IRQS
> -void default_restore_msi_irqs(struct pci_dev *dev, int irq)
> +void __weak arch_restore_msi_irqs(struct pci_dev *dev, int irq)
>  {
>  	struct msi_desc *entry;
> =20
> @@ -114,7 +110,6 @@ void default_restore_msi_irqs(struct pci_dev *dev, in=
t irq)
>  	if (entry)
>  		write_msi_msg(irq, &entry->msg);
>  }
> -#endif
> =20
>  static void msi_set_enable(struct pci_dev *dev, int enable)
>  {
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index ee66f3a..18870b0 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -51,12 +51,17 @@ struct msi_desc {
>  };
> =20
>  /*
> - * The arch hook for setup up msi irqs
> + * The arch hooks to setup up msi irqs. Those functions are
> + * implemented as weak symbols so that they /can/ be overriden by
> + * architecture specific code if needed.
>   */
>  int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
>  void arch_teardown_msi_irq(unsigned int irq);
>  int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void arch_teardown_msi_irqs(struct pci_dev *dev);
>  int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
> +void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
> +
> +void default_teardown_msi_irqs(struct pci_dev *dev);
> =20
>  #endif /* LINUX_MSI_H */
> --=20
> 1.8.1.2
>=20

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR8XCAAAoJEN0jrNd/PrOhc4IP/ReCIiTdM/QpDygqfxxQ8A/V
1PX/w19tIcUH8ZUhu53XAbjGwK+fN7ANuQInKersQeWfu2rjvoaPi4nxuLBkoFwg
aTsdyawR1xlHKgwJFfXgnbCdDmoJ4m5vp7Fh+9drcsnWGBxCBq4dFxeTGcRJnooh
F7yAGnt3aPCGsG0hOPfEVBjvH0I0vj8XB8At7nX0LZXGSUQbIGRj8CtVqITkFAZB
bfUA0B1O2+PqwtYaO5oSkfmcYW04jBJ6Y9eX2etd5uyQzBl65nYZiwmVoeDfagJf
3Djg5+33jVA8k1UIx26A1y4MYOCZM5rZN7A89UzuN3vl9FEUc2HyRkTg0zmVtIfZ
LUoapqX8CzUsqW2uxmhUpQLwopXsFn6KYPWjFGHIfxHfAV+f1AAE3c7mBodRwJLr
WDvIFDUANldpylzr9ln97q22MCRZoPqSnNHQj3lkJhOQFu8AhrxdPWHC6NZx5jdx
+WDVU9clw5M1ZPidH8Yqn/rFt+UiDTW9jcRdZRZXbn4XCQQGAyFkOof63NU2N+w7
HAPV2Xs8qrsEzUAviPqRHFLY5SOLcYNfDLX4XLczIvvp/p+WsY0cX0K4VyWi8CWt
q0TyUOfBA9i6Aoz+uVDKRTFHbIndDPRWISRH5FGEr86BLBdGyw2xupKvDsQOrOQM
ObJh9T/Vi3CgYzhO0Hcc
=CAXR
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
