Return-Path: <fchen@apm.com>
Received: from exprod5og107.obsmtp.com (exprod5og107.obsmtp.com [64.18.0.184])
	by ozlabs.org (Postfix) with SMTP id 4621AB70B8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 05:28:21 +1000 (EST)
Received: by yxn35 with SMTP id 35so615383yxn.4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 12:28:19 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 12 Aug 2010 12:28:18 -0700
Message-ID: <AANLkTi=mOpSWnzfiMyPF+04NmEHZkF61nZJvkGU+gJau@mail.gmail.com>
Subject: Question about dma_direct_ops in PowerPC.
From: Fushen Chen <fchen@apm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0022152d614957ebb4048da55ec2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0022152d614957ebb4048da55ec2
Content-Type: text/plain; charset=ISO-8859-1

We have a board with PCI device driver that calls for
pci_dma_sync_single_for_device.
This driver used to work for Linux kernel 2.6.25.

We ported to the driver to Linux kernel 2.6.32. The PCI device driver
doesn't work anymore.
The following call trace shows why the PCI driver won't work in kernel
2.6.32.
1. In pci_include/asm-generic/pci-dma-compat.h
    pci_dma_sync_single_for_device calls for dma_sync_single_for_cpu
2. In include/asm-generic/dma-mapping-common.h
    dma_sync_single_for_cpu calls for ops->sync_single_for_cpu
3. In arch/powerpc/kernel/dma.c
struct dma_map_ops dma_direct_ops = {
        .alloc_coherent = dma_direct_alloc_coherent,
        .free_coherent  = dma_direct_free_coherent,
        .map_sg         = dma_direct_map_sg,
        .unmap_sg       = dma_direct_unmap_sg,
        .dma_supported  = dma_direct_dma_supported,
        .map_page       = dma_direct_map_page,
        .unmap_page     = dma_direct_unmap_page,
#ifdef CONFIG_NOT_COHERENT_CACHE
        .sync_single_range_for_cpu      = dma_direct_sync_single_range,
        .sync_single_range_for_device   = dma_direct_sync_single_range,
        .sync_sg_for_cpu                = dma_direct_sync_sg,
        .sync_sg_for_device             = dma_direct_sync_sg,
#endif
};
There is no ops defined for sync_single_for_cpu.
The pci_dma_sync_single_for_device is a no-op.

However Linux kernel 2.6.35.1 from kernel.org has the  .sync_single_for_cpu
for dma_direct_ops.
in arch/powerpc/kernel/dma.c
#ifdef CONFIG_NOT_COHERENT_CACHE
        .sync_single_for_cpu            = dma_direct_sync_single,
        .sync_single_for_device         = dma_direct_sync_single,
        .sync_sg_for_cpu                = dma_direct_sync_sg,
        .sync_sg_for_device             = dma_direct_sync_sg,
#endif


We won't move to Linux kernel 2.6.35 anytime soon.
My questions:
1. Is there any side effect for adding .sync_single_for_cpu to
dma_direct_ops in 2.6.32?
2. What will be the future development here?


Best regards & Thanks,
Fushen

--0022152d614957ebb4048da55ec2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

We have a board with PCI device driver that calls for pci_dma_sync_single_f=
or_device.<br>This driver used to work for Linux kernel 2.6.25.<br><br>We p=
orted to the driver to Linux kernel 2.6.32. The PCI device driver doesn&#39=
;t work anymore.<br>
The following call trace shows why the PCI driver won&#39;t work in kernel =
2.6.32. <br>1. In pci_include/asm-generic/pci-dma-compat.h<br>=A0=A0=A0 pci=
_dma_sync_single_for_device calls for dma_sync_single_for_cpu<br>2. In incl=
ude/asm-generic/dma-mapping-common.h<br>
=A0=A0=A0 dma_sync_single_for_cpu calls for ops-&gt;sync_single_for_cpu<br>=
3. In arch/powerpc/kernel/dma.c<br>struct dma_map_ops dma_direct_ops =3D {<=
br>=A0=A0=A0=A0=A0=A0=A0 .alloc_coherent =3D dma_direct_alloc_coherent,<br>=
=A0=A0=A0=A0=A0=A0=A0 .free_coherent=A0 =3D dma_direct_free_coherent,<br>
=A0=A0=A0=A0=A0=A0=A0 .map_sg=A0=A0=A0=A0=A0=A0=A0=A0 =3D dma_direct_map_sg=
,<br>=A0=A0=A0=A0=A0=A0=A0 .unmap_sg=A0=A0=A0=A0=A0=A0 =3D dma_direct_unmap=
_sg,<br>=A0=A0=A0=A0=A0=A0=A0 .dma_supported=A0 =3D dma_direct_dma_supporte=
d,<br>=A0=A0=A0=A0=A0=A0=A0 .map_page=A0=A0=A0=A0=A0=A0 =3D dma_direct_map_=
page,<br>=A0=A0=A0=A0=A0=A0=A0 .unmap_page=A0=A0=A0=A0 =3D dma_direct_unmap=
_page,<br>
#ifdef CONFIG_NOT_COHERENT_CACHE<br>=A0=A0=A0=A0=A0=A0=A0 .sync_single_rang=
e_for_cpu=A0=A0=A0=A0=A0 =3D dma_direct_sync_single_range,<br>=A0=A0=A0=A0=
=A0=A0=A0 .sync_single_range_for_device=A0=A0 =3D dma_direct_sync_single_ra=
nge,<br>=A0=A0=A0=A0=A0=A0=A0 .sync_sg_for_cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D dma_direct_sync_sg,<br>
=A0=A0=A0=A0=A0=A0=A0 .sync_sg_for_device=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D dma_direct_sync_sg,<br>#endif<br>};<br>There is no ops defined for =
sync_single_for_cpu.<br>The pci_dma_sync_single_for_device is a no-op.<br><=
br>However Linux kernel 2.6.35.1 from <a href=3D"http://kernel.org">kernel.=
org</a> has the=A0 .sync_single_for_cpu for dma_direct_ops.<br>
in arch/powerpc/kernel/dma.c<br>#ifdef CONFIG_NOT_COHERENT_CACHE<br>=A0=A0=
=A0=A0=A0=A0=A0 .sync_single_for_cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D d=
ma_direct_sync_single,<br>=A0=A0=A0=A0=A0=A0=A0 .sync_single_for_device=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D dma_direct_sync_single,<br>=A0=A0=A0=A0=A0=A0=A0 =
.sync_sg_for_cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D dma_direc=
t_sync_sg,<br>
=A0=A0=A0=A0=A0=A0=A0 .sync_sg_for_device=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D dma_direct_sync_sg,<br>#endif<br><br><br>We won&#39;t move to Linux=
 kernel 2.6.35 anytime soon.<br>My questions:<br>1. Is there any side effec=
t for adding .sync_single_for_cpu to dma_direct_ops in 2.6.32?<br>
2. What will be the future development here?<br><br><br>Best regards &amp; =
Thanks,<br>Fushen<br><br><br><br><br>

--0022152d614957ebb4048da55ec2--
