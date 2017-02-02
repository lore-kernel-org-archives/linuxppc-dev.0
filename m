Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDxhR75CbzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 10:55:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>,
 Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linux-edac\@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa\@gmail.com" <morbidrsa@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
In-Reply-To: <20170202173005.gqesvy5owtsbrviu@pd.tnic>
References: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
 <20170201232735.byk7bnpeoqtcc7mh@pd.tnic>
 <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
 <20170202173005.gqesvy5owtsbrviu@pd.tnic>
Date: Fri, 03 Feb 2017 10:55:33 +1100
Message-ID: <87h94cb11m.fsf@concordia.ellerman.id.au>
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

Borislav Petkov <bp@alien8.de> writes:

> On Wed, Feb 01, 2017 at 11:46:23PM +0000, Chris Packham wrote:
>> >> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>> >> index 8f66cbed70b7..67f7bc3fe5b3 100644
>> >> --- a/drivers/edac/mpc85xx_edac.c
>> >> +++ b/drivers/edac/mpc85xx_edac.c
>> >> @@ -629,6 +629,7 @@ static const struct of_device_id mpc85xx_l2_err_of_match[] = {
>> >>  	{ .compatible = "fsl,p1020-l2-cache-controller", },
>> >>  	{ .compatible = "fsl,p1021-l2-cache-controller", },
>> >>  	{ .compatible = "fsl,p2020-l2-cache-controller", },
>> >> +	{ .compatible = "fsl,t2080-l2-cache-controller", },
>> >
>> > WARNING: DT compatible string "fsl,t2080-l2-cache-controller" appears un-documented -- check ./Documentation/devicetree/bindings/
>> > #58: FILE: drivers/edac/mpc85xx_edac.c:632:
>> > +       { .compatible = "fsl,t2080-l2-cache-controller", },
>> >
>> > What is checkpatch.pl trying to tell me here?
>> >
>> 
>> checpkatch.pl is confused by 
>> Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt which says
>> 
>> - compatible    : Should include "fsl,chip-l2-cache-controller" and "cache"
>>                    where chip is the processor (bsc9132, npc8572 etc.)
>> 
>> So none of the fsl cache controllers pass the checkpatch.pl test.
>
> Hmm, so others do list those names explicitly. For example:
>
> Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>
> And the patch that added that check to cp:
>
> bff5da433525 ("checkpatch: add DT compatible string documentation checks")
>
> is basically to enforce explicit compatible names.
>
> So I'd like to have an ACK from a PPC maintainer here first before I
> apply this.

It's fine with me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


Chris if you want to send a patch to add the compatible string to the
l2cache.txt I would merge that, but honestly it doesn't achieve much
other than possibly catching a typo in the compatible name.

cheers
