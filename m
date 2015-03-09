Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2C2A1A3F0A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 02:08:45 +1100 (AEDT)
Received: by iecar1 with SMTP id ar1so8547402iec.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2015 08:08:42 -0700 (PDT)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <54FD72E4.1060701@freescale.com>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com> <54F475A8.6030105@gmail.com>
 <20150302220923.GC30523@darwin.bork.org>
 <54F5D6D5.8070407@freescale.com>
 <CAJUS3Xnw66Eu6tvGPpdcet6KLjhKM=ptj8NRaztAVr0h_r+LqQ@mail.gmail.com>
 <54FD72E4.1060701@freescale.com>
Date: Mon, 9 Mar 2015 11:08:42 -0400
Message-ID: <CAJUS3XkY0tbYqBbU5HR7NT63UPFi5DO6XWuymbZnQaJEA5kkBw@mail.gmail.com>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
From: Martin Hicks <mort@bork.org>
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 9, 2015 at 6:16 AM, Horia Geant=C4=83 <horia.geanta@freescale.c=
om> wrote:
> On 3/3/2015 7:44 PM, Martin Hicks wrote:
>> On Tue, Mar 3, 2015 at 10:44 AM, Horia Geant=C4=83
>> <horia.geanta@freescale.com> wrote:
>>>
>>> For talitos, there are two cases:
>>>
>>> 1. request data size is <=3D data unit / sector size
>>> talitos can handle any IV / tweak scheme
>>>
>>> 2. request data size > sector size
>>> since talitos internally generates the IV for the next sector by
>>> incrementing the previous IV, only IV schemes that allocate consecutive
>>> IV to consecutive sectors will function correctly.
>>>
>>
>> it's not clear to me that #1 is right.  I guess it could be, but the
>> IV length would be limited to 8 bytes.
>
> Yes, there's a limitation in talitos wrt. XTS IV / tweak size - it's up
> to 8 bytes.
> So I guess ESSIV won't work with talitos-xts, since the encrypted IV
> output is 16 bytes.
> But as previously said, ESSIV breaks the XTS standard requirement for
> having a consecutive IV for consecutive blocks. ESSIV should really be
> used only with disk-level encryption schemes that require an
> unpredictable IV.

Ok.  I'll verify that the second half of the IV is zeroed.

One last thing that I'm not sure of is what string to place in
cra_ablkcipher.geniv field.   "eseqiv" seems wrong if plain/plain64
are the IVs that XTS is designed for.

Thanks,
mh

--=20
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
