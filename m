Return-Path: <neorf3k@gmail.com>
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com
 [IPv6:2a00:1450:400c:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 792AB2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 19:38:47 +1100 (EST)
Received: by mail-wi0-f170.google.com with SMTP id f4so401610wiw.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 00:38:43 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131113190606.2a5d08fb@crub>
Date: Thu, 14 Nov 2013 09:38:35 +0100
Message-Id: <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
To: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you again=85
we have checked, and the settings in Chip Select 4 Configuration, seems =
to be ok=85

The strange thing is the return value from ioremap(). In U-Boot return =
value from address 0x1002000 is 0x45f80360=85 if we try to map it in our =
module, then we use ioremap(), return value is 0x10101010. So maybe the =
register address is mapped wrong=85 what could i fix it?
Then, after we have setted up the reg at 0x1002000 and we boot linux=85 =
the 0x1002000 doesn=92t change its value=85=20

Thanks again=85

Lorenzo

On 13/nov/2013, at 07:06 PM, Anatolij Gustschin <agust@denx.de> wrote:

> On Wed, 13 Nov 2013 14:48:24 +0100
> neorf3k <neorf3k@gmail.com> wrote:
>=20
>> Yes, that is a device on the lpb via an fpga. We  have tried to =
configure
>> the chip select 4 configuration register at address MBAR + 0x0310, =
and it
>> seems to be ok. what do you mean with =93chip select parameters=94?
>=20
> I meant the settings you can set up in the Chip Select 1=967 =
Configuration
> Registers, like address and data bus size, wait-states, etc.
>=20
>> We have been able to edit it in U-BOOT, and the board (that chip) now =
works=85
>> The strange thing, is that when we read in linux, at that address, we =
see
>> other content value=85
>> Suggestions?
>=20
> if you can access the register under U-Boot and read out the
> expected values, then the access should work under Linux too,
> assuming the chip select config is not overwritten somewhere
> while booting and the register address range is mapped correctly.
> I don't know your code, so I would first check if the register
> mapping is done correctly, i.e. check the return value of ioremap()
> for errors, then check if the chip select configuration is still
> valid when the kernel is up. Also verify that your fpga is not
> in the reset state when Linux is running.
>=20
> thanks,
>=20
> Anatolij
