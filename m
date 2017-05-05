Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK1WL3rhGzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 16:02:06 +1000 (AEST)
Received: by mail-wr0-x244.google.com with SMTP id g12so3317705wrg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 23:02:06 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: RE: [PATCH v2] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
Date: Fri,  5 May 2017 08:01:54 +0200
Message-Id: <1493964114-11296-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
References: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>On 5/4/2017 5:07 PM, Scott Wood wrote:
>> On Thu, 2017-05-04 at 06:58 +0200, Karim Eshapa wrote:
>>> +    stop = jiffies + 10000;
>>> +    /*
>>> +     * if MR was full and h/w had other FQRNI entries to produce, we
>>> +     * need to allow it time to produce those entries once the
>>> +     * existing entries are consumed. A worst-case situation
>>> +     * (fully-loaded system) means h/w sequencers may have to do 3-4
>>> +     * other things before servicing the portal's MR pump, each of
>>> +     * which (if slow) may take ~50 qman cycles (which is ~200
>>> +     * processor cycles). So rounding up and then multiplying this
>>> +     * worst-case estimate by a factor of 10, just to be
>>> +     * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
>>> +     * one entry at a time, so h/w has an opportunity to produce new
>>> +     * entries well before the ring has been fully consumed, so
>>> +     * we're being *really* paranoid here.
>>> +     */
>> OK, upon reading this more closely it seems the intent was to delay for 10,000
>> *processor cycles* and somehow that got turned into 10,000 jiffies (which is
>> 40 seconds at the default Hz!).  We could just replace this whole thing with
>> msleep(1) and still be far more paranoid than was originally intended.
>>
>> Claudiu and Roy, any comments?
>Yes the timing here is certainly off, the code changed a few times since
>the comment was originally written.
>An msleep(1) seems reasonable here to me.

If the previous patch with msleep(1) is OK.
can I send a patch to slightly change the comments.

Thanks,
Karim
