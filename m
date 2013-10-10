Return-Path: <ivan.mercier@gmail.com>
Received: from mail-lb0-x22a.google.com (mail-lb0-x22a.google.com
 [IPv6:2a00:1450:4010:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C24CB2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 01:55:45 +1100 (EST)
Received: by mail-lb0-f170.google.com with SMTP id w7so2264302lbi.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 07:55:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381271655.7979.290.camel@snotra.buserror.net>
References: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
 <1381271655.7979.290.camel@snotra.buserror.net>
From: Mercier Ivan <ivan.mercier@gmail.com>
Date: Thu, 10 Oct 2013 16:54:58 +0200
Message-ID: <CAMc2ieqXg1C6twTaqL9irJoLceSw-fFyTseifW5dmCmnXHWLCw@mail.gmail.com>
Subject: Re: Elbc device driver
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I've got a KERN_INFO msg: "fsl-lbc a3p400.11: failed to get memory
region" corresponding to my elbc device that I try to map.
                a3p400@3,0 {
                        compatible = "fsl,elbc";
                        reg = <0 0xe0000000 0x1000000>;
                };
The corresponding law on ELBC is 0xe0000000 ->0xf0000000.
I want to map my device on 0xe0000000 ->0xe8000000 as it has 16 adress bits.

Now the controler registers are properly set,but how do I map the device?

Thanks a lot





2013/10/9 Scott Wood <scottwood@freescale.com>:
> On Tue, 2013-10-08 at 16:06 +0200, Mercier Ivan wrote:
>> Hi,
>>
>> I'm working on a powerpc qoriq p3041 and trying to communicate with a
>> device by elbc bus in gpmc mode.
>>
>> I 've integrated CONFIG_FSL_LBC in Linux which provide the basic functions.
>>
>> Now I'm wondering how can I do read and write operations on the
>> bus.Where is mapped my device?
>
> You'll need to use ioremap() or of_iomap() to map it.
>
>> Should I code .read and .write driver functions?How can I start?
>>
>> How integrates my device in the device tree?
>
> See Documentation/devicetree/bindings/powerpc/fsl/lbc.txt and examples
> such as "board-control" in various device trees.
>
> -Scott
>
>
>
