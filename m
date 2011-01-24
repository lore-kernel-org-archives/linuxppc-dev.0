Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 036D4B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 17:47:26 +1100 (EST)
Message-ID: <4D3D20D4.5040902@windriver.com>
Date: Mon, 24 Jan 2011 14:48:52 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Mitsutaka Amano <mitsutaka.amano@gmail.com>
Subject: Re: About mpc85xx flash memory allocation
References: <AANLkTin0RHAF8ieFqv12dFfOr_N3g3w6VVUTGOvH47uq@mail.gmail.com>
In-Reply-To: <AANLkTin0RHAF8ieFqv12dFfOr_N3g3w6VVUTGOvH47uq@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mitsutaka Amano wrote:
> Hi all,
> 
> I'm testing the ppc platform is based on mpc85xx. 256MB Flash memory
> has been installed. Then I found this entries.
> 
> /proc/vmallocinfo
> ~~~
> 0xc9100000-0xd9101000 268439552 of_flash_probe+0x290/0x814 ioremap
> 
> physmap_of allocated 268MB over to the vmalloc. vmalloc space is tight.
> 
> Why does we need mpc platforms to flash memory allocation? I know

This should not be dedicated to so-called mpc platform. And we always use
ioremap() to map the device space. And on PPC ioremap also use the same space as
vmalloc(). While bootstrap you also can see this associated message like the
follows,
------
......
  * 0xd1000000..0xffbe9000  : vmalloc & ioremap

> other architectures don't allocate to the vmalloc.
> The design of the hardware? or Is there the way to use the flash

You can open /dev/mem then mmap() with a appropriate offset to access the device
space including flash.

Tiejun

> memory without vmalloc?
> 
> Thanks,
> Mitsutaka
