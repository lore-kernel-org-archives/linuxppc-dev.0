Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 608FE2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 08:45:14 +1100 (EST)
Date: Tue, 19 Nov 2013 22:45:05 +0100
From: Anatolij Gustschin <agust@denx.de>
To: neorf3k <neorf3k@gmail.com>
Subject: Re: Problem reading and programming memory location...
Message-ID: <20131119224505.7a31b69c@crub>
In-Reply-To: <F24AEED4-A8F7-4DE8-A1BB-D0BED489A223@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
 <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
 <20131114100917.31f674d7@crub>
 <51E043E6-19FB-4655-9B3C-3B81F868DC47@gmail.com>
 <20131116152933.276f9939@crub>
 <F24AEED4-A8F7-4DE8-A1BB-D0BED489A223@gmail.com>
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

Hi Lorenzo,

On Tue, 19 Nov 2013 11:20:24 +0100
neorf3k <neorf3k@gmail.com> wrote:

> Hello Anatolij, this is our code, used at University, but again it doesn=
=E2=80=99t work=E2=80=A6
>=20
> How i told, the only information we have about that reg are:
>=20
> Chip select 4 specification:
> Lp_cs4
> bus size: 8 bit
> bus control: 2 wait state R/W ACK disabled
> size allocated: 4 KByte
>=20
> Our Register 8 bit LP_cs4 (we want to write)
>=20
> cs4 offset: 0x001

is the byte in FPGA at offset 0x0 writable? In your code you
currently test read/write access to the byte at offset 0x0.

If the read/write access works under U-Boot, then maybe the
chip select parameters for CS4 are configured differently
in U-Boot. You can dump the Chip Select 4 configuration
registers under U-Boot and compare. Is address- and data-bus
to the FPGA multipexed? Another possible reason for non-working
access could be that the configured CS4 range 0x10020000 - 0x10030000
overlaps with configured range for CS0, CS1, CS2 or CS3. Can you
verify that no such overlapping exists.

Thanks,

Anatolij
