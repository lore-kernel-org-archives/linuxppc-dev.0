Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5L7Y133YzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 18:48:41 +1000 (AEST)
Received: by mail-pa0-x231.google.com with SMTP id pp5so91111472pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 01:48:40 -0700 (PDT)
Subject: Re: [v5.1] ucc_fast: Fix to avoid IS_ERR_VALUE abuses and dead code
 on 64bit systems.
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
References: <1470329563-5464-1-git-send-email-arvind.yadav.cs@gmail.com>
 <2376517.GXv6XVOdDd@wuerfel>
Cc: zajec5@gmail.com, leoli@freescale.com, qiang.zhao@freescale.com,
 viresh.kumar@linaro.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, scottwood@freescale.com, akpm@linux-foundation.org,
 linux@roeck-us.net
From: arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <57A452E0.10904@gmail.com>
Date: Fri, 5 Aug 2016 14:18:32 +0530
MIME-Version: 1.0
In-Reply-To: <2376517.GXv6XVOdDd@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 05 August 2016 02:01 AM, Arnd Bergmann wrote:
> On Thursday, August 4, 2016 10:22:43 PM CEST Arvind Yadav wrote:
>> index df8ea79..ada9070 100644
>> --- a/include/soc/fsl/qe/ucc_fast.h
>> +++ b/include/soc/fsl/qe/ucc_fast.h
>> @@ -165,10 +165,12 @@ struct ucc_fast_private {
>>          int stopped_tx;         /* Whether channel has been stopped for Tx
>>                                     (STOP_TX, etc.) */
>>          int stopped_rx;         /* Whether channel has been stopped for Rx */
>> -       u32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx
>> -                                                   virtual fifo */
>> -       u32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx
>> -                                                   virtual fifo */
>> +       unsigned long ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of
>> +                                                           * Tx virtual fifo
>> +                                                           */
>> +       unsigned long ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of
>> +                                                           * Rx virtual fifo
>> +                                                           */
>>   #ifdef STATISTICS
>>          u32 tx_frames;          /* Transmitted frames counter. */
>>          u32 rx_frames;          /* Received frames counter (only frames
>>
> This change seems ok, but what about the other u32 variables in ucc_geth.c
> that get checked for IS_ERR_VALUE?
>
> 	Arnd
> I have send separate patch for ucc_geth ans ucc_slow.
> -Arvind
