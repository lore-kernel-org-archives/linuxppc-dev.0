Return-Path: <ivan.mercier@gmail.com>
Received: from mail-la0-x235.google.com (mail-la0-x235.google.com
 [IPv6:2a00:1450:4010:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AAD22C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 20:44:19 +1100 (EST)
Received: by mail-la0-f53.google.com with SMTP id eo20so3635478lab.26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 02:44:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381512940.7979.497.camel@snotra.buserror.net>
References: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
 <1381271655.7979.290.camel@snotra.buserror.net>
 <CAMc2ieqXg1C6twTaqL9irJoLceSw-fFyTseifW5dmCmnXHWLCw@mail.gmail.com>
 <1381418079.7979.396.camel@snotra.buserror.net>
 <CAMc2ieqO5eKiXdGh0qraJy3FKPMbzkpTGgWrSwwGHh7sn2iCFw@mail.gmail.com>
 <1381512940.7979.497.camel@snotra.buserror.net>
From: Mercier Ivan <ivan.mercier@gmail.com>
Date: Tue, 22 Oct 2013 11:43:31 +0200
Message-ID: <CAMc2ierLhKeLX2ijUBaVU=suF3OF4DPku2N+WBTE1HvMPc3yaQ@mail.gmail.com>
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

Ok Scott,
now it works!
We had severals hardware problem.
Thanks for your help

2013/10/11 Scott Wood <scottwood@freescale.com>:
> On Fri, 2013-10-11 at 17:03 +0200, Mercier Ivan wrote:
>> Hi,
>> this should be correct (I'm using chip select 3 for this device)
>>         lbc: localbus@ffe124000 {
>>                 reg = <0xf 0xfe124000 0 0x1000>;
>>                 ranges = <3 0 0xf 0xe0000000 0x08000000>;
>>
>>                 a3p400{
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>                         compatible = "my_a3p_driver";
>>                         reg = <0x0 0x0 0x800000>;
>>                 };
>>         };
>
> Compatible describes the device, not the driver.  It takes the format
> "vendor,device".  The node name, OTOH, is normally a generic description
> of the device's functionality ("flash", "ethernet", "board-control",
> etc).
>
> You don't need #address-cells/#size-cells on the a3p400 node unless it
> has child nodes with reg or ranges.
>
> -Scott
>
>
>
