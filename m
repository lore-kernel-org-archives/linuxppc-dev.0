Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0073.outbound.protection.outlook.com [104.47.37.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnxJr53LMzDrSb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 20:19:40 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: UIO memmap of PCi devices not working?
Date: Thu, 7 Sep 2017 10:19:31 +0000
Message-ID: <1504779569.31322.16.camel@infinera.com>
References: <1504711235.27247.110.camel@infinera.com>
 <1504768612.12628.19.camel@kernel.crashing.org>
 <1504768943.27247.149.camel@infinera.com>
 <1504773212.12628.26.camel@kernel.crashing.org>
 <1504774792.31322.13.camel@infinera.com>
In-Reply-To: <1504774792.31322.13.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 10:59 +0200, Joakim Tjernlund wrote:
> On Thu, 2017-09-07 at 18:33 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2017-09-07 at 07:22 +0000, Joakim Tjernlund wrote:
> > > On Thu, 2017-09-07 at 17:16 +1000, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2017-09-06 at 15:20 +0000, Joakim Tjernlund wrote:
> > > > > Having problems to mmap PCI UIO devices and stumbeled over this p=
age:
> > > > >  http://billfarrow.blogspot.se/2010/09/userspace-access-to-pci-me=
mory.html
> > > > > it claims some adjustments are needed for UIO mmap over PCI to wo=
rk.
> > > > > These are #if 0 ATM and trying to enable them fails build.
> > > > >=20
> > > > > Can this be fixed to at least build again ?
> > > > > The reason for having #if 0 in the first place appears to be old =
X servers,
> > > > > is that still true? Can the special casing be removed now?
> > > >=20
> > > > This article seems out of date... I *think* things should work with=
out
> > > > change by just mmap'ing the appropriate sysfs files. I'm not sure w=
hy
> > > > the author thought that had to be ifdef'ed out...
> > >=20
> > > Isn't that what the article is doing(mmaping sysfs files)?
> > > And the article author is #ifdefing it back, not out.
> >=20
> > Yes sorry that's what I meant. It should work as-is.
> >=20
> > > >=20
> > > > Let me know if you have problems.
> > >=20
> > > Sure, we still are looking=20
> > >=20
> > > >=20
> > > > As far as I know, the generic code will call pci_resource_to_user()
> > > > which on powerpc will return a physical address that already includ=
es
> > > > the offset, which is why we don't later add it.
> > > >=20
> > > > Now we could probably tear all that out and use the new generic cod=
e
> > > > instead as I *think* X has (very) long been fixed but I'd have to s=
pend
> > > > some time triple checking and testing on old HW which I don't have =
the
> > > > bandwidth for right now.=20
> > >=20
> > > Could you fixup the code which is now #if 0 ? I wan't to test the
> > > difference and I not sure how to fix the build problem after changing
> > > those two #if 0 to #if 1
> > > Even better if they could be a CONFIG option instead.
> >=20
> > Hrm it's tricky, you shouldn't just turn that ifdef back on without
> > also changing pci_resource_to_user().
>=20
> There are two ifdef to change:
> __pci_mmap_make_offset():
> #if 0 /* See comment in pci_resource_to_user() for why this is disabled *=
/
> 		*offset +=3D hose->pci_mem_offset;
> #endif
>=20
> and
>=20
> pci_resource_to_user()
> 	/* We pass a fully fixed up address to userland for MMIO instead of
> 	 * a BAR value because X is lame and expects to be able to use that
> 	 * to pass to /dev/mem !
> 	 *
> 	 * That means that we'll have potentially 64 bits values where some
> 	 * userland apps only expect 32 (like X itself since it thinks only
> 	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
> 	 * 32 bits CHRPs :-(
> 	 *
> 	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
> 	 * has been fixed (and the fix spread enough), we can re-enable the
> 	 * 2 lines below and pass down a BAR value to userland. In that case
> 	 * we'll also have to re-enable the matching code in
> 	 * __pci_mmap_make_offset().
> 	 *
> 	 * BenH.
> 	 */
> #if 0
> 	else if (rsrc->flags & IORESOURCE_MEM)
> 		offset =3D hose->pci_mem_offset;
> #endif

This seems to work, just a hack though:
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -314,8 +314,8 @@ static struct resource *__pci_mmap_make_offset(struct p=
ci_dev *dev,
=20
        /* If memory, add on the PCI bridge address offset */
        if (mmap_state =3D=3D pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-               *offset +=3D hose->pci_mem_offset;
+#if 1  /* See comment in pci_resource_to_user() for why this is disabled *=
/
+               *offset +=3D hose->mem_offset[0];
 #endif
                res_bit =3D IORESOURCE_MEM;
        } else {
@@ -634,9 +634,9 @@ void pci_resource_to_user(const struct pci_dev *dev, in=
t bar,
         *
         * BenH.
         */
-#if 0
+#if 1
        else if (rsrc->flags & IORESOURCE_MEM)
-               offset =3D hose->pci_mem_offset;
+               offset =3D hose->mem_offset[0];
 #endif
=20
        *start =3D rsrc->start - offset;

>=20
> Problem is that pci_mem_offset is gone, the closed I can find is mem_offs=
et
> but that is an array,maybe just mem_offset[0] ?
>=20
> > I'm not sure exactly what's going
> > on in your case, if you have a problem can you add printk to instrument
> > ?
>=20
> Seems to be something else going on in out board. Anyhow, the mem_offset =
should
> be fixed to compile, nice to have it behind a CONFIG option. Then
> one can start the process to remove the special casing easier.

After sorting the bugs in our app, it works with and without above patch.

 Jocke=
