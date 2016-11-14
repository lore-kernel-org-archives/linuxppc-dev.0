Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHbXR2zjqzDvdb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 03:27:35 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEGNsDt033637
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:27:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qfda4u1v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:27:32 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 11:27:31 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C8AF66E803C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:27:03 -0500 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [RESEND PATCH] cxl: Fix coredump generation when cxl_get_fd() is
 used
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <20161114085854.19667-1-fbarrat@linux.vnet.ibm.com>
Date: Mon, 14 Nov 2016 10:27:25 -0600
Cc: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20161114085854.19667-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-Id: <987F854F-1F6F-4879-ACC1-04975A11589D@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Nov 14, 2016, at 2:58 AM, Frederic Barrat =
<fbarrat@linux.vnet.ibm.com> wrote:
>=20
> If a process dumps core while owning a cxl file descriptor obtained
> from an AFU driver (e.g. cxlflash) through the cxl_get_fd() API, the
> following error occurs:
>=20
> [  868.027591] Unable to handle kernel paging request for data at =
address ...
> [  868.027778] Faulting instruction address: 0xc00000000035edb0
> cpu 0x8c: Vector: 300 (Data Access) at [c000003c688275e0]
>    pc: c00000000035edb0: elf_core_dump+0xd60/0x1300
>    lr: c00000000035ed80: elf_core_dump+0xd30/0x1300
>    sp: c000003c68827860
>   msr: 9000000100009033
>   dar: c
> dsisr: 40000000
> current =3D 0xc000003c68780000
> paca    =3D 0xc000000001b73200   softe: 0        irq_happened: 0x01
>    pid   =3D 46725, comm =3D hxesurelock
> enter ? for help
> [c000003c68827a60] c00000000036948c do_coredump+0xcec/0x11e0
> [c000003c68827c20] c0000000000ce9e0 get_signal+0x540/0x7b0
> [c000003c68827d10] c000000000017354 do_signal+0x54/0x2b0
> [c000003c68827e00] c00000000001777c do_notify_resume+0xbc/0xd0
> [c000003c68827e30] c000000000009838 ret_from_except_lite+0x64/0x68
> --- Exception: 300 (Data Access) at 00003fff98ad2918
>=20
> The root cause is that the address_space structure for the file
> doesn't define a 'host' member.
>=20
> When cxl allocates a file descriptor, it's using the anonymous inode
> to back the file, but allocates a private address_space for each
> context. The private address_space allows to track memory allocation
> for each context. cxl doesn't define the 'host' member of the address
> space, i.e. the inode. We don't want to define it as the anonymous
> inode, since there's no longer a 1-to-1 relation between address_space
> and inode.
>=20
> To fix it, instead of using the anonymous inode, we introduce a simple
> pseudo filesystem so that cxl can allocate its own inodes. So we now
> have one inode for each file and address_space. The pseudo filesystem
> is only mounted on the first allocation of a file descriptor by
> cxl_get_fd().
>=20
> Tested with cxlflash.
>=20
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
