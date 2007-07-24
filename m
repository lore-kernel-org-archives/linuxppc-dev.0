Return-Path: <gerrit.vandevelde@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id CF32ADDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 17:33:34 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2445541wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 00:33:33 -0700 (PDT)
Message-ID: <d07a51700707240033t7ca17dc1ic6c24c708405b78a@mail.gmail.com>
Date: Tue, 24 Jul 2007 09:33:33 +0200
From: "Gerrit Van de Velde" <gerrit.vandevelde@gmail.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Subject: Re: [U-Boot-Users] MPC8540, UPM Writeburst generating also read bursts
In-Reply-To: <46A51C3F.2070408@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <d07a51700707200345g48ae4585wdfe55b02569a6a07@mail.gmail.com>
	<46A09CF1.1050705@anagramm.de>
	<d07a51700707230805u347feb73sf97c45676882f89e@mail.gmail.com>
	<46A51C3F.2070408@anagramm.de>
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

Hello again,

> Please don't top-post and please don't remove the list. (use reply-to-all)
> (and please move this thread over to linuxppc-embedded, as we are OT here)

Ok, I'll never do that again. And the topic has been moved.

> You don't have single read and write instructions in your UPM?
> Please post your UPM table.

I do have single reads and writes. The UPM is as follows (taken from
the upmtool output)

/* MxMR Configuration Code */
unsigned long MAMR = 0x40000;
unsigned long MBMR = 0x40000;
unsigned long MCMR = 0x40000;

/* UPM Table Configuration Code */
static unsigned long UPMATable[] =
{
	0x0faffc00,  0x0faffc00,  0x0fafdc04,  0x3fbffc01, //Words 0 to 3
	0xfffffc00,  0xfffffc00,  0xfffffc00,  0xfffffc00, //Words 4 to 7
	0x0ffffc00,  0x0ffffc00,  0x0ffffc0c,  0x0ffffc0c, //Words 8 to 11
	0x0ffffc0c,  0x0ffffc0c,  0x0ffffc0c,  0x0ffffc0c, //Words 12 to 15
	0x0ffffc0c,  0x0ffffc04,  0x3ffffc01,  0xfffffc00, //Words 16 to 19
	0xfffffc00,  0xfffffc00,  0xfffffc00,  0xfffffc00, //Words 20 to 23
	0x0fa3fc00,  0x0fa3fc00,  0x0fa3fc04,  0x3fb7fc01, //Words 24 to 27
	0xfffffc00,  0xfffffc00,  0xfffffc00,  0xfffffc00, //Words 28 to 31
	0x0ff3fc00,  0x0ff3fc00,  0x0ff3fc0c,  0x0ff3fc0c, //Words 32 to 35
	0x0ff3fc0c,  0x0ff3fc0c,  0x0ff3fc0c,  0x0ff3fc0c, //Words 36 to 39
	0x0ff3fc0c,  0x0ff3fc04,  0x3ff7fc00,  0xfffffc01, //Words 40 to 43
	0xfffffc00,  0xfffffc00,  0xfffffc00,  0xfffffc01, //Words 44 to 47
	0xfffffc00,  0xfffffc01,  0xfffffc00,  0xfffffc00, //Words 48 to 51
	0xfffffc00,  0xfffffc00,  0xfffffc00,  0xfffffc00, //Words 52 to 55
	0xfffffc00,  0xfffffc00,  0xfffffc00,  0xfffffc01, //Words 56 to 59
	0xfffffc00,  0xfffffc01,  0xfffffc00,  0xfffffc01  //Words 60 to 63
};

> Do you access the DDR memory aligned in 32byte cacheline sizes?
> The UPM propably cannot burst unaligned chunks properly.
> (I'm not sure about that, comments are welcome).
> 500MBit/s should be easy to handle with the UPM, if done right.

Yes target addresses are aligned to 32 byte words. I 'm not sure what
you mean with cachelines.

> 1) It makes sense to use the DMA to offload the CPU for copying bulk
> data if the CPU can be used for other stuff.

Ok, but currently our MPC8540 is a bit overkill, maybe later in the
life of our board it will be come necessary but at least not now.

> 2) Can you first make sure that your Gbit link is working fine by copying
> data from/to the CPU's memory without using the UPM?

That's something I should try first indeed, I'll update you/the list
if I know about the results

> I guess you will need to post more information about your
> system (schematics, code, UPM)...

I'll do that when UPM-less writes are much faster and you don't see
anything strange in the UPM table.

Regards,
Gerrit Van de Velde
