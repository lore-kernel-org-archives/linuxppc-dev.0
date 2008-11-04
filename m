Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by ozlabs.org (Postfix) with ESMTP id 64214DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 01:14:36 +1100 (EST)
Message-ID: <491058A3.9040807@unicontrol.de>
Date: Tue, 04 Nov 2008 15:13:55 +0100
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
	<20081104111545.GB17864@pengutronix.de>
In-Reply-To: <20081104111545.GB17864@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram Sang schrieb:
> Hello Rene,
>
> I haven't actually applied the patch, just a few comments from a
> glimpse:
>   
> Major nit: Please add to the comment that this bug is still present on
> the MPC5200B, although it is not in its errata sheet. Thils will avoid
> later confusion. (Out of interest, did you contact Freescale about this
> bug?)
>   
Comment added, contacting Freescale is still on my to-do-list :)
>   
>> + *
>> + * The workaround resets the baudrate to 4800, waits for a stable state and resets break state repeatedly if necessary.
>> + * Optionally it can release the lock while waiting.
>> + * 1 character at 4800 baud takes 2ms, 3ms should be enough for 1 character at higher speed and 1 char at lowest
>> + * works only with longer delays
>>     
>
> Did I get it right that there are cases where the workaround won't work?
>   
Yes, currently it doesn't work when receiving with less than 4800 baud. 
I'll try to fix this.
>   
>> +{
>> +	struct mpc52xx_psc __iomem *psc = PSC(port);
>> +#ifdef CONFIG_PPC_MPC52xx
>> +	out_8(&psc->ctur,0x01);
>> +	out_8(&psc->ctlr,0xae);
>>     
>
> Those are magic values. If you can't build them using defined
> constants, at least document them, please.
>   
The magic numbers will hopefully vanish after generalizing the patch to 
work with every baudrate.
> Thanks!
>
>    Wolfram Sang
>
>   
Thanks for your suggestions

-- 
René Bürgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
 
Unicontrol Systemtechnik GmbH
Geschäftsführer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475
