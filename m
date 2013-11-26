Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x229.google.com (mail-ea0-x229.google.com
 [IPv6:2a00:1450:4013:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A0B62C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 05:29:56 +1100 (EST)
Received: by mail-ea0-f169.google.com with SMTP id l9so3988157eaj.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 10:29:50 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131119224505.7a31b69c@crub>
Date: Tue, 26 Nov 2013 19:29:46 +0100
Message-Id: <4123A441-F04D-4F4B-9DA7-B73C808D9B79@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
 <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
 <20131114100917.31f674d7@crub>
 <51E043E6-19FB-4655-9B3C-3B81F868DC47@gmail.com>
 <20131116152933.276f9939@crub>
 <F24AEED4-A8F7-4DE8-A1BB-D0BED489A223@gmail.com>
 <20131119224505.7a31b69c@crub>
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

Hi Anatolij,
we have tried again=85 but the problem is still there=85 we are not able =
to read/write, not only CS4, but also CS1, CS2, CS3, etc=85

According to you, could we fix the problem if we include our Virtex FPGA =
in Device Tree?

U-Boot has been patched (not by us), for CS4, with:

+#define CONFIG_SYS_CS0_START		CONFIG_SYS_FLASH_BASE
+#define CONFIG_SYS_CS0_SIZE		CONFIG_SYS_FLASH_SIZE
+#define CONFIG_SYS_CS0_CFG       0x000ADD00


+#define CONFIG_SYS_CS3_START     0x10000000    //
+#define CONFIG_SYS_CS3_SIZE      0x00020000    //
+#define CONFIG_SYS_CS3_CFG       0x0002DF00    //=20
+
+#define CONFIG_SYS_CS4_START     0x10020000    //
+#define CONFIG_SYS_CS4_SIZE      0x00020000    //
+#define CONFIG_SYS_CS4_CFG       0x0002DC00    //=20
+
+#define CONFIG_SYS_CS5_START     0x11000000    //
+#define CONFIG_SYS_CS5_SIZE      0x01000000    //
+#define CONFIG_SYS_CS5_CFG       0x0002DD00    //=20
+
+#define CONFIG_SYS_CS_BURST		0x00000000
+#define CONFIG_SYS_CS_DEADCYCLE	0x33333333
+
+#define CONFIG_SYS_RESET_ADDRESS	0xff000000

but CONFIG_SYS_CS4_SIZE should be: 0x00010000 ...

Thank you

Lorenzo

On 19/nov/2013, at 10:45 PM, Anatolij Gustschin <agust@denx.de> wrote:

> Hi Lorenzo,
>=20
> On Tue, 19 Nov 2013 11:20:24 +0100
> neorf3k <neorf3k@gmail.com> wrote:
>=20
>> Hello Anatolij, this is our code, used at University, but again it =
doesn=92t work=85
>>=20
>> How i told, the only information we have about that reg are:
>>=20
>> Chip select 4 specification:
>> Lp_cs4
>> bus size: 8 bit
>> bus control: 2 wait state R/W ACK disabled
>> size allocated: 4 KByte
>>=20
>> Our Register 8 bit LP_cs4 (we want to write)
>>=20
>> cs4 offset: 0x001
>=20
> is the byte in FPGA at offset 0x0 writable? In your code you
> currently test read/write access to the byte at offset 0x0.
>=20
> If the read/write access works under U-Boot, then maybe the
> chip select parameters for CS4 are configured differently
> in U-Boot. You can dump the Chip Select 4 configuration
> registers under U-Boot and compare. Is address- and data-bus
> to the FPGA multipexed? Another possible reason for non-working
> access could be that the configured CS4 range 0x10020000 - 0x10030000
> overlaps with configured range for CS0, CS1, CS2 or CS3. Can you
> verify that no such overlapping exists.
>=20
> Thanks,
>=20
> Anatolij
