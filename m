Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 284FE2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 05:06:11 +1100 (EST)
Date: Wed, 13 Nov 2013 19:06:06 +0100
From: Anatolij Gustschin <agust@denx.de>
To: neorf3k <neorf3k@gmail.com>
Subject: Re: Problem reading and programming memory location...
Message-ID: <20131113190606.2a5d08fb@crub>
In-Reply-To: <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Nov 2013 14:48:24 +0100
neorf3k <neorf3k@gmail.com> wrote:

> Yes, that is a device on the lpb via an fpga. We  have tried to configure
> the chip select 4 configuration register at address MBAR + 0x0310, and it
> seems to be ok. what do you mean with =E2=80=9Cchip select parameters=E2=
=80=9D?

I meant the settings you can set up in the Chip Select 1=E2=80=937 Configur=
ation
Registers, like address and data bus size, wait-states, etc.

> We have been able to edit it in U-BOOT, and the board (that chip) now wor=
ks=E2=80=A6
> The strange thing, is that when we read in linux, at that address, we see
> other content value=E2=80=A6
> Suggestions?

if you can access the register under U-Boot and read out the
expected values, then the access should work under Linux too,
assuming the chip select config is not overwritten somewhere
while booting and the register address range is mapped correctly.
I don't know your code, so I would first check if the register
mapping is done correctly, i.e. check the return value of ioremap()
for errors, then check if the chip select configuration is still
valid when the kernel is up. Also verify that your fpga is not
in the reset state when Linux is running.

thanks,

Anatolij
