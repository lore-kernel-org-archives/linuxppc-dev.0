Message-ID: <411381C7.4010705@rossvideo.com>
Date: Fri, 06 Aug 2004 09:04:07 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] 44x ethernet MDIO access
References: <41128413.7030900@rossvideo.com> <41129315.600@rossvideo.com> <Pine.GSO.4.58.0408061411220.26252@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0408061411220.26252@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>>-	udelay(MDIO_DELAY);
>>+	count = 0;
>>+	while (((stacr = in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
>>+					&& (count++ < 5000))
>
>                                                       ^^^^
> 						      MDIO_DELAY?
>
> And perhaps you want to create a (possibly inlined) function just for this
> loop?

Good catch - yes, should be MDIO_DELAY not 5000.  I had found that 50
was not enough so I had upped it in my testing - forgot to change it back :(

I'd also suggest the default MDIO_DELAY be increased from its present
value of 50 to perhaps 100 or 150...  Does anyone know what the slowest
possible EPB clock speed is?

-R

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
