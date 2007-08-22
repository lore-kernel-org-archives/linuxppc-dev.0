Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 047DDDDEBF
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 07:17:08 +1000 (EST)
Message-ID: <46CCA7CD.3060109@freescale.com>
Date: Wed, 22 Aug 2007 16:17:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 4/7] fs_enet: mac-fcc: Eliminate __fcc-* macros.
References: <20070817175320.GA8259@ld0162-tx32.am.freescale.net>	<20070817175402.GD9218@ld0162-tx32.am.freescale.net>
	<20070823010826.6ae3452d@localhost.localdomain>
In-Reply-To: <20070823010826.6ae3452d@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
>>-#define W8(_p, _m, _v)	__fcc_out8(&(_p)->_m, (_v))
>>-#define R8(_p, _m)	__fcc_in8(&(_p)->_m)
>>+#define W8(_p, _m, _v)	out_8(&(_p)->_m, (_v))
>>+#define R8(_p, _m)	in_8(&(_p)->_m)
>> #define S8(_p, _m, _v)	W8(_p, _m, R8(_p, _m) | (_v))
>> #define C8(_p, _m, _v)	W8(_p, _m, R8(_p, _m) & ~(_v))
>> 
>>@@ -290,7 +281,7 @@ static void restart(struct net_device *dev)
>> 
>> 	/* clear everything (slow & steady does it) */
>> 	for (i = 0; i < sizeof(*ep); i++)
>>-		__fcc_out8((char *)ep + i, 0);
>>+		out_8((char *)ep + i, 0);
>> 
> 
> Perhaps W8() here, to keep consistency?

W8 expects a struct pointer and member, which we don't have here.

-Scott
