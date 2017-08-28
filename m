Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgq6N2mbyzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 21:19:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x: mask and shift to zero bug
In-Reply-To: <20170828075705.dxyoqyxgmd3ila3g@mwanda>
References: <20170825103340.op3uphrv3eyeutiz@mwanda>
 <1503809791.3814.43.camel@kernel.crashing.org>
 <20170828075705.dxyoqyxgmd3ila3g@mwanda>
Date: Mon, 28 Aug 2017 21:19:23 +1000
Message-ID: <87lgm4ueh0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Sun, Aug 27, 2017 at 02:56:31PM +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2017-08-25 at 13:33 +0300, Dan Carpenter wrote:
>> > My static checker complains that 0x00001800 >> 13 is zero.  Looking at
>> > the context, it seems like a copy and paste bug from the line below and
>> > probably 0x3 << 13 or 0x00006000 was intended.
>> > 
>> > Fixes: 2af59f7d5c3e ("[POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> > ---
>> > Not tested!
>> > 
>> > diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
>> > index 9d3bd4c45a24..f7da65169124 100644
>> > --- a/arch/powerpc/boot/4xx.c
>> > +++ b/arch/powerpc/boot/4xx.c
>> > @@ -564,7 +564,7 @@ void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
>> >  		fbdv = 16;
>> >  	cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
>> >  	opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
>> > -	ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
>> > +	ppdv = ((pllmr & 0x00006000) >> 13) + 1; /* PLB:PCI */
>> >  	epdv = ((pllmr & 0x00001800) >> 11) + 2; /* PLB:EBC */
>> >  	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1; 
>> 
>> That rings a bell... Is this something we tried to fix before and had
>> problems ? The thing is when I opened the 405GP and EP manual PDF,
>> evince had memorized that this register was the last page I looked at
>> :-) And I don't remember how many years ago that is.
>> 
>> According to the 405gp spec ppdv is IBM bits 17,18 so your patch is
>> correct.
>> 
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Hm...  I did a search through my mailbox and you're right we discussed
> this before.
>
> [bug report] [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper
>
> I sent this email during kernel summit and neither of us could send a
> patch at the time and we both problem forgot.  I definitely forgot.

If you send a patch with the report, like you did this time, then it
will be remembered in patchwork. That doesn't mean we won't forget it,
but it makes is *less likely* we'll forget it :)

http://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=9327&state=%2A&archive=both

cheers
