Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 927301A078C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 02:48:59 +1100 (AEDT)
Message-ID: <550063D1.2070105@freescale.com>
Date: Wed, 11 Mar 2015 17:48:33 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com>	<54F475A8.6030105@gmail.com>
 <20150302220923.GC30523@darwin.bork.org>	<54F5D6D5.8070407@freescale.com>
 <CAJUS3Xnw66Eu6tvGPpdcet6KLjhKM=ptj8NRaztAVr0h_r+LqQ@mail.gmail.com>
 <54FD72E4.1060701@freescale.com>
 <CAJUS3XkY0tbYqBbU5HR7NT63UPFi5DO6XWuymbZnQaJEA5kkBw@mail.gmail.com>
In-Reply-To: <CAJUS3XkY0tbYqBbU5HR7NT63UPFi5DO6XWuymbZnQaJEA5kkBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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

On 3/9/2015 5:08 PM, Martin Hicks wrote:
> On Mon, Mar 9, 2015 at 6:16 AM, Horia Geantă <horia.geanta@freescale.com> wrote:
>> On 3/3/2015 7:44 PM, Martin Hicks wrote:
>>> On Tue, Mar 3, 2015 at 10:44 AM, Horia Geantă
>>> <horia.geanta@freescale.com> wrote:
>>>>
>>>> For talitos, there are two cases:
>>>>
>>>> 1. request data size is <= data unit / sector size
>>>> talitos can handle any IV / tweak scheme
>>>>
>>>> 2. request data size > sector size
>>>> since talitos internally generates the IV for the next sector by
>>>> incrementing the previous IV, only IV schemes that allocate consecutive
>>>> IV to consecutive sectors will function correctly.
>>>>
>>>
>>> it's not clear to me that #1 is right.  I guess it could be, but the
>>> IV length would be limited to 8 bytes.
>>
>> Yes, there's a limitation in talitos wrt. XTS IV / tweak size - it's up
>> to 8 bytes.
>> So I guess ESSIV won't work with talitos-xts, since the encrypted IV
>> output is 16 bytes.
>> But as previously said, ESSIV breaks the XTS standard requirement for
>> having a consecutive IV for consecutive blocks. ESSIV should really be
>> used only with disk-level encryption schemes that require an
>> unpredictable IV.
> 
> Ok.  I'll verify that the second half of the IV is zeroed.
> 
> One last thing that I'm not sure of is what string to place in
> cra_ablkcipher.geniv field.   "eseqiv" seems wrong if plain/plain64
> are the IVs that XTS is designed for.

Right. But since currently dm-crypt does not use .givencrypt and deals
with IV generation by itself, we're safe.
When dm-crypt IV generation will be moved to crypto, we'll have to
revisit this.

While here: note that xts-talitos supports only two key lengths - 256
and 512 bits. There are tcrypt speed tests that check also for 384-bit
keys (which is out-of-spec, but still...), leading to a "Key Size Error"
- see below (KSE bit in AESU Interrupt Status Register is set)

testing speed of async xts(aes) (xts-aes-talitos) encryption
[...]
test 5 (384 bit key, 16 byte blocks):
talitos ffe30000.crypto: CDPR is NULL, giving up search for offending
descriptor
talitos ffe30000.crypto: AESUISR 0x00000000_00000200
talitos ffe30000.crypto: DESCBUF 0x64300011_00000000
talitos ffe30000.crypto: DESCBUF 0x00000000_00000000
talitos ffe30000.crypto: DESCBUF 0x00100000_00000000
talitos ffe30000.crypto: DESCBUF 0x00300000_00000000
talitos ffe30000.crypto: DESCBUF 0x00100000_00000000
talitos ffe30000.crypto: DESCBUF 0x00100000_00000000
talitos ffe30000.crypto: DESCBUF 0x00100000_00000000
talitos ffe30000.crypto: DESCBUF 0x00000000_00000000
encryption() failed flags=0

So for xts, driver must enforce 256/512 bit key lengths and return
CRYPTO_TFM_RES_BAD_KEY_LEN in all other cases.
Or a SW fallback could be used for the other cases, but I don't think
it's worth the effort since these are non-standard.

Horia
