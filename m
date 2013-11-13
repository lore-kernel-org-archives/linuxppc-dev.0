Return-Path: <neorf3k@gmail.com>
Received: from mail-ee0-x235.google.com (mail-ee0-x235.google.com
 [IPv6:2a00:1450:4013:c00::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 697202C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 00:48:36 +1100 (EST)
Received: by mail-ee0-f53.google.com with SMTP id b57so190837eek.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 05:48:31 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131113083259.1b69ed18@crub>
Date: Wed, 13 Nov 2013 14:48:24 +0100
Message-Id: <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
To: Anatolij Gustschin <agust@denx.de>
Cc: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, that is a device on the lpb via an fpga. We  have tried to =
configure the chip select 4 configuration register at address MBAR + =
0x0310, and it seems to be ok. what do you mean with =93chip select =
parameters=94?
We have been able to edit it in U-BOOT, and the board (that chip) now =
works=85
The strange thing, is that when we read in linux, at that address, we =
see other content value=85
Suggestions?

Thanks

Lorenzo

On 13/nov/2013, at 08:32 AM, Anatolij Gustschin <agust@denx.de> wrote:

> On Tue, 12 Nov 2013 20:23:20 +0100
> neorf3k <neorf3k@gmail.com> wrote:
>=20
>> we have tried to read and program an 8bit register with 32bit =
address.
>> we have mapped it with: ioremap, kmalloc etc=85 and then using: outb,
>> iowrite8 etc.. but when we write to it, the value doesn=92t change=85
>> with other memory location is ok.
>> That is an 8 bit register, located at 0x10020000 in a mpc5200b
>> architecture. we are using kernel 2.6.33.=20
>> what could be?
>=20
> 0x10020000 is not in the internal register memory map, so it
> is probably a device on the LocalPlus bus. Did you configure
> the chip select parameters for this device and did you enable
> the associated chip select?
>=20
> HTH,
>=20
> Anatolij
>=20
