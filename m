Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EFCD6DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 03:22:33 +1100 (EST)
Date: Tue, 6 Feb 2007 19:23:07 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Subject: Re: Conditions for mydriver_probe to be called
Message-ID: <20070206192307.71d41f03@vitb.ru.mvista.com>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E6237D0@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E6237D0@aquib01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 6 Feb 2007 16:42:30 +0100
"DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it> wrote:

> I'm realizing a controller driver for the mpc8xx spi master device. My
> driver has a mpc8xx_spi_probe method that I expected to be called. I'm
> sure that platform_device_register is called for my spi platform_device
> but nothing happens,  mpc8xx_spi_probe is not called.
I'd dump ppc_sys.c in the place where it puts devices into the bus, and peek into driver_register.
Note that for 8xx, spi normally resides on scc, so you'll have to use ...set_func and ...device_enable() stuff (see in ppc_sys.c for exact prototypes) to have foo-bar-scc:spi or alike registered on bus.

-- 
Sincerely, 
Vitaly
