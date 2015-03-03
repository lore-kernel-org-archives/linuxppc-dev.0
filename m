Return-Path: <mohicks@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D4F11A026F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 04:45:02 +1100 (AEDT)
Received: by igal13 with SMTP id l13so29916989iga.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 09:44:59 -0800 (PST)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <54F5D6D5.8070407@freescale.com>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com> <54F475A8.6030105@gmail.com>
 <20150302220923.GC30523@darwin.bork.org>
 <54F5D6D5.8070407@freescale.com>
Date: Tue, 3 Mar 2015 12:44:58 -0500
Message-ID: <CAJUS3Xnw66Eu6tvGPpdcet6KLjhKM=ptj8NRaztAVr0h_r+LqQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
From: Martin Hicks <mort@bork.org>
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-crypto@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Milan Broz <gmazyland@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 3, 2015 at 10:44 AM, Horia Geant=C4=83
<horia.geanta@freescale.com> wrote:
> On 3/3/2015 12:09 AM, Martin Hicks wrote:
>>
>> On Mon, Mar 02, 2015 at 03:37:28PM +0100, Milan Broz wrote:
>>>
>>> If crypto API allows to encrypt more sectors in one run
>>> (handling IV internally) dmcrypt can be modified of course.
>>>
>>> But do not forget we can use another IV (not only sequential number)
>>> e.g. ESSIV with XTS as well (even if it doesn't make much sense, some p=
eople
>>> are using it).
>>
>> Interesting, I'd not considered using XTS with an IV other than plain/64=
.
>> The talitos hardware would not support aes/xts in any mode other than
>> plain/plain64 I don't think...Although perhaps you could push in an 8-by=
te
>> IV and the hardware would interpret it as the sector #.
>>
>
> For talitos, there are two cases:
>
> 1. request data size is <=3D data unit / sector size
> talitos can handle any IV / tweak scheme
>
> 2. request data size > sector size
> since talitos internally generates the IV for the next sector by
> incrementing the previous IV, only IV schemes that allocate consecutive
> IV to consecutive sectors will function correctly.
>

it's not clear to me that #1 is right.  I guess it could be, but the
IV length would be limited to 8 bytes.

This also points out that claiming that the XTS IV size is 16 bytes,
as my current patch does, could be problematic.  It's handy because
the first 8 bytes should contain a plain64 sector #, and the second
u64 can be used to encode the sector size but it would be a mistake
for someone to use the second 8 bytes for the rest of a 16byte IV.

mh

--=20
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
