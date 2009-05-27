Return-Path: <pku.leo@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id E16E8DDFE5
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 20:36:16 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2065670ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 03:36:15 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208934920A@zch01exm21.fsl.freescale.net>
References: <D7CCA83BB0796C49BC0BB53B6AB1208934920A@zch01exm21.fsl.freescale.net>
Date: Wed, 27 May 2009 18:36:14 +0800
Message-ID: <2a27d3730905270336n120f7652yad269858ff456c64@mail.gmail.com>
Subject: Re: Net: ucc_geth ethernet driver optimization space
From: Li Yang <leoli@freescale.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 27, 2009 at 1:08 PM, Liu Dave-R63238 <DaveLiu@freescale.com> wr=
ote:
> Guys,
>
> The ucc_geth ethernet driver have dozens of strong sync read/write
> operation, such as in_be32/16/8, out_be32/16/8.
>
> all of them is sync read/write, it is very expensive for performance.
>

Totally agree.  That's one of my concerns right from the beginning.

> For the critical patch, we can remove some unnecessary in_be(x),
> out_be(x) with normal memory operation, and keep some necessary
> memory barrier.
>
> eg: BD access in the interrupt handler and start_xmit.
>
> The BD operation only need the memory barrier between length/buffer
> and status.
>
> struct buffer descriptor {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 status;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 length;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 buffer;
> } __attribute__ ((packed));
>
> struct buffer descriptor *BD;
>
> BD->length =3D xxxx;
> BD->buffer =3D yyyy;
> wmb();
> BD->status =3D zzzz;

The BD can reside either in memory or memory mapped region, which
makes the case more complex.

MMIO accesses need to use IO accessors for the sparse checking.  We
might make use of the __raw_*() accessors, but I'm not sure if it's
suitable for non-PCI buses on powerpc.  And also we need to pay
special attention to the problem described here:
http://lwn.net/Articles/198988/

- Leo
