Return-Path: <thayumker@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.198])
	by ozlabs.org (Postfix) with ESMTP id 45B976816F
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 19:36:56 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id h30so584742wxd
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 02:36:54 -0700 (PDT)
Message-ID: <3865cb8505082902305bdf368d@mail.gmail.com>
Date: Mon, 29 Aug 2005 15:00:06 +0530
From: Thayumanavar Sachithanantham <thayumker@gmail.com>
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B4D@exnet.3il.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B4D@exnet.3il.fr>
Cc: kernelnewbies@nl.linux.org, linuxppc-dev@ozlabs.org
Subject: Re: Allocating a cache-safe buffer for DMA devices and drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A an equivalent function that does this is pci_alloc_consistent or
dma_alloc_coherent which ensures cache coherency.
Please refer Documentation/DMA-API.txt of the linux source repository.

Thayumanavar S.

On 8/29/05, Garcia J=E9r=E9mie <GARCIAJ@3il.fr> wrote:
> Hi everybody, I have to port a vxWorks appz to Linux Montavista running o=
n a powerPC 405EP based architecture.
> In this one, we use the following vxWorks system call: cacheDmaMalloc( ) =
whose man page is :
>=20
> NAME
>    cacheDmaMalloc( ) - allocate a cache-safe buffer for DMA devices and d=
rivers
>=20
> SYNOPSIS
> void * cacheDmaMalloc
>    (
>    size_t bytes              /* number of bytes to allocate */
>    )
>=20
> DESCRIPTION
>    This routine returns a pointer to a section of memory that will not ex=
perience any cache coherency problems. Function pointers in the CACHE_FUNCS=
 structure provide access to DMA support routines.
>=20
> RETURNS
>    A pointer to the cache-safe buffer, or NULL.
>=20
>=20
> I need to handle the given amount of memory from the user space.
> So could anyone told how to achieve the same goal on Linux with these con=
straints?
>=20
> Tks a lot for your precious help!
>=20
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
>=20
>
