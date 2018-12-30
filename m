Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D699C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 17:55:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080A220861
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 17:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080A220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SSl832QfzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 04:55:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SShy6rrSzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:53:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43SShp5FhDz9tyyP;
 Sun, 30 Dec 2018 18:52:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1CxxfnNyyxZB; Sun, 30 Dec 2018 18:52:58 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43SShp4WnZz9tyyH;
 Sun, 30 Dec 2018 18:52:58 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 39EDA1CB; Sun, 30 Dec 2018 18:53:00 +0100 (CET)
Received: from 37-165-14-176.coucou-networks.fr
 (37-165-14-176.coucou-networks.fr [37.165.14.176]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sun, 30 Dec 2018 18:53:00 +0100
Date: Sun, 30 Dec 2018 18:53:00 +0100
Message-ID: <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
 <alpine.LNX.2.21.1812301750320.424@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301750320.424@nippy.intranet>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Finn Thain <fthain@telegraphics.com.au> a =C3=A9crit=C2=A0:

> On Sat, 29 Dec 2018, Arnd Bergmann wrote:
>
>> On Wed, Dec 26, 2018 at 1:43 AM Finn Thain=20=20
>>=20<fthain@telegraphics.com.au> wrote:
>>
>> > +
>> > +static ssize_t m68k_nvram_get_size(void)
>> > +{
>> > +       if (MACH_IS_ATARI)
>> > +               return atari_nvram_get_size();
>> > +       else if (MACH_IS_MAC)
>> > +               return mac_pram_get_size();
>> > +       return -ENODEV;
>> > +}
>> > +
>> > +/* Atari device drivers call .read (to get checksum validation) where=
as
>> > + * Mac and PowerMac device drivers just use .read_byte.
>> > + */
>> > +const struct nvram_ops arch_nvram_ops =3D {
>> > +#ifdef CONFIG_MAC
>> > +       .read_byte      =3D m68k_nvram_read_byte,
>> > +       .write_byte     =3D m68k_nvram_write_byte,
>> > +#endif
>> > +#ifdef CONFIG_ATARI
>> > +       .read           =3D m68k_nvram_read,
>> > +       .write          =3D m68k_nvram_write,
>> > +       .set_checksum   =3D m68k_nvram_set_checksum,
>> > +       .initialize     =3D m68k_nvram_initialize,
>> > +#endif
>> > +       .get_size       =3D m68k_nvram_get_size,
>> > +};
>> > +EXPORT_SYMBOL(arch_nvram_ops);
>>
>> Since the operations are almost entirely distinct, why not have two
>> separate 'nvram_ops' instances here that each refer to just
>> the set they actually need?
>>
>
> The reason for that is that I am alergic to code duplication. But I'll
> change it if you think it matters. BTW, this patch has already been acked
> by Geert.

I agree it would be cleaner, as it would also avoid this=20=20
m68k_nvram_get_size()=20wouldn't it ?

I don't see potential code duplication here, do you ?

Christophe

>
>> I was actually expecting one more patch here that would make the
>> arch_nvram_ops a pointer to one of multiple structures, which would
>> be easier to do with multiple copies, but I suppose there is no need
>> for that here (there might be on ppc, I have to look again).
>>
>
> Yes, I considered that too. I picked the variation that makes everything
> const.
>
> --
>
>>        Arnd
>>


