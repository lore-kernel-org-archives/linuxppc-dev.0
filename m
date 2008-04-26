Return-Path: <ttyagi@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01-ext1.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AC099DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Apr 2008 12:59:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Enabling 64 bit data type for dma_addr_t on non PPC64 architecture
Date: Fri, 25 Apr 2008 19:48:56 -0700
Message-ID: <BA76C315ECE5B149AE7194FE094819E205E59012@SDCEXCHANGE01.ad.amcc.com>
From: "Tushar Tyagi" <ttyagi@amcc.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I'm working a new DMA hardware for PPC processors.
The processor is a 32 bit architecture having 40 bit physical address
space.=20
So we need the 32 bit processor code base but we want the type
dma_addr_t to represent 64 bit data, without enabling the CONFIG_PPC64
flag.
=20
We want to use the Linux generic DMA layer to offload DMA operations to
the hw and the Linux code path goes through function=20
dma_async_memcpy_buf_to_buf and then dma_map_single.
=20
Currently the dma_map_single function has 2 versions based upon
CONFIG_PPC64 defined or not.
=20
Is it possible to reuse the CONFIG_PPC64 based code only pertaining to
DMA by doing the following:
=20
Add a new flag called CONFIG_DMA64 along with CONFIG_PPC64 and
__powerpc64__ flags, enabling our code to use the generic DMA layer with
64 bit data type for dma_addr_t.
=20
With the above modification, the function dma_map_single starts
returning 64 bit data type instead of 32.
=20
Do you have any comments or suggestions ?
=20
-thanks
TT
