Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 196791A0245
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 21:28:23 +1000 (AEST)
Received: by obcbp4 with SMTP id bp4so44713394obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2015 04:28:20 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <55E5803F.3090704@canonical.com>
References: <1441102876-26978-1-git-send-email-colin.king@canonical.com>
 <CAMuHMdUm-eRpPmoNARdPVsi9=4Fqxp8crfgOXZkVTdAFhNzngQ@mail.gmail.com>
 <55E5803F.3090704@canonical.com>
Date: Tue, 1 Sep 2015 13:28:20 +0200
Message-ID: <CAMuHMdW=zGAPGP8+tys3pkjN3hUuUeb8Q5SSi+U1qyUeUmWiew@mail.gmail.com>
Subject: Re: [PATCH] ps3-vuart: BUG_ON on null drv before dereferencing it on
 dev_dbg
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Geoff Levand <geoff@infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Colin,

On Tue, Sep 1, 2015 at 12:38 PM, Colin Ian King
<colin.king@canonical.com> wrote:
> On 01/09/15 11:35, Geert Uytterhoeven wrote:
>> On Tue, Sep 1, 2015 at 12:21 PM, Colin King <colin.king@canonical.com> wrote:
>>> On the unlikely event that drv is null, the current code will
>>> perform a null pointer dereference with it when printing a dev_dbg
>>> message.  Instead, the BUG_ON check on drv should be performed
>>> before we emit the dev_dbg message.
>>
>> What about just removing the BUG_ON()?
>>
>> The system will crash anyway, providing a backtrace.
>
> I personally think a BUG_ON() shows intention to try to catch an
> unexpected issue in a standard way as opposed to just removing it and
> then hitting an issue with a null ptr deference.

I think this BUG_ON() was purely used during development of the ps3_vuart
framework.

Note that the corresponding platform_drv_probe() also just dereferences its
driver pointer.

>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/ps3/ps3-vuart.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
>>> index d6db822..632701a 100644
>>> --- a/drivers/ps3/ps3-vuart.c
>>> +++ b/drivers/ps3/ps3-vuart.c
>>> @@ -1000,12 +1000,11 @@ static int ps3_vuart_probe(struct ps3_system_bus_device *dev)
>>>         dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
>>>
>>>         drv = ps3_system_bus_dev_to_vuart_drv(dev);
>>> +       BUG_ON(!drv);
>>>
>>>         dev_dbg(&dev->core, "%s:%d: (%s)\n", __func__, __LINE__,
>>>                 drv->core.core.name);
>>>
>>> -       BUG_ON(!drv);
>>> -
>>>         if (dev->port_number >= PORT_COUNT) {
>>>                 BUG();
>>>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
