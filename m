Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B242BB71C2
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 01:37:24 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][v2] uio: Support 36-bit physical addresses on 32-bit
 systems
Date: Thu, 13 Oct 2011 14:37:17 +0000
Message-ID: <CAOZdJXWd_u_EWXNhh3-t258+Y8mx=JuJhU93CeZfaocPZvhOFA@mail.gmail.com>
References: <1318453063-17349-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1318453063-17349-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "hjk@hansjkoch.de" <hjk@hansjkoch.de>, "gregkh@suse.de" <gregkh@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 3:57 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> From: Kai Jiang <Kai.Jiang@freescale.com>
>
> To support >32-bit physical addresses for UIO_MEM_PHYS type we need to
> extend the width of 'addr' in struct uio_mem. =A0Numerous platforms like
> embedded PPC, ARM, and X86 have support for systems with larger physical
> address than logical.
>
> Since 'addr' may contain a physical, logical, or virtual address the
> easiest solution is to just change the type to 'unsigned long long'
> regardless of which type is utilized.

You forgot to update this description.

> =A0struct uio_mem {
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 addr;
> + =A0 =A0 =A0 phys_addr_t =A0 =A0 =A0 =A0 =A0 =A0 addr;

Please add a comment here saying:

1) That 'addr' can be a virtual or physical address
2) That the kernel guarantees that sizeof(phys_addr_t) >=3D sizeof(void
*), so it's safe to use phys_addr_t for a virtual pointer.

--=20
Timur Tabi
Linux kernel developer at Freescale=
