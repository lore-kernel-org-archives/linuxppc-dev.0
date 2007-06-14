Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B34ADDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 11:42:51 +1000 (EST)
Message-ID: <46709D15.8080606@am.sony.com>
Date: Wed, 13 Jun 2007 18:42:45 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 05/30] PS3: Use ioremap_flags
References: <20070612181825.730300780@am.sony.com>
	<20070612181825.730300780@am.sony.com>>
	<466EE965.404@am.sony.com> <200706131110.48809.arnd@arndb.de>
In-Reply-To: <200706131110.48809.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 12 June 2007, Geoff Levand wrote:
>> -       spu->problem = ioremap(spu->problem_phys,
>> -               sizeof(struct spu_problem));
>> +       spu->problem = (__force void *)ioremap_flags(spu->problem_phys,
>> +               sizeof(struct spu_problem), _PAGE_NO_CACHE);
>> +
> 
> Unlike the local_store member, of struct spu, ->problem and ->priv2
> members are __iomem, so you should not do a __force cast here.


OK, thanks for checking it, I just did a quick edit without thinking.

-Geoff
