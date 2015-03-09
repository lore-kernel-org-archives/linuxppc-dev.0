Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C2BE1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 21:16:20 +1100 (AEDT)
Message-ID: <54FD72E4.1060701@freescale.com>
Date: Mon, 9 Mar 2015 12:16:04 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com>	<54F475A8.6030105@gmail.com>
 <20150302220923.GC30523@darwin.bork.org>	<54F5D6D5.8070407@freescale.com>
 <CAJUS3Xnw66Eu6tvGPpdcet6KLjhKM=ptj8NRaztAVr0h_r+LqQ@mail.gmail.com>
In-Reply-To: <CAJUS3Xnw66Eu6tvGPpdcet6KLjhKM=ptj8NRaztAVr0h_r+LqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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

On 3/3/2015 7:44 PM, Martin Hicks wrote:
> On Tue, Mar 3, 2015 at 10:44 AM, Horia Geantă
> <horia.geanta@freescale.com> wrote:
>> On 3/3/2015 12:09 AM, Martin Hicks wrote:
>>>
>>> On Mon, Mar 02, 2015 at 03:37:28PM +0100, Milan Broz wrote:
>>>>
>>>> If crypto API allows to encrypt more sectors in one run
>>>> (handling IV internally) dmcrypt can be modified of course.
>>>>
>>>> But do not forget we can use another IV (not only sequential number)
>>>> e.g. ESSIV with XTS as well (even if it doesn't make much sense, some people
>>>> are using it).
>>>
>>> Interesting, I'd not considered using XTS with an IV other than plain/64.
>>> The talitos hardware would not support aes/xts in any mode other than
>>> plain/plain64 I don't think...Although perhaps you could push in an 8-byte
>>> IV and the hardware would interpret it as the sector #.
>>>
>>
>> For talitos, there are two cases:
>>
>> 1. request data size is <= data unit / sector size
>> talitos can handle any IV / tweak scheme
>>
>> 2. request data size > sector size
>> since talitos internally generates the IV for the next sector by
>> incrementing the previous IV, only IV schemes that allocate consecutive
>> IV to consecutive sectors will function correctly.
>>
> 
> it's not clear to me that #1 is right.  I guess it could be, but the
> IV length would be limited to 8 bytes.

Yes, there's a limitation in talitos wrt. XTS IV / tweak size - it's up
to 8 bytes.
So I guess ESSIV won't work with talitos-xts, since the encrypted IV
output is 16 bytes.
But as previously said, ESSIV breaks the XTS standard requirement for
having a consecutive IV for consecutive blocks. ESSIV should really be
used only with disk-level encryption schemes that require an
unpredictable IV.

> 
> This also points out that claiming that the XTS IV size is 16 bytes,
> as my current patch does, could be problematic.  It's handy because
> the first 8 bytes should contain a plain64 sector #, and the second
> u64 can be used to encode the sector size but it would be a mistake
> for someone to use the second 8 bytes for the rest of a 16byte IV.

XTS IV *is* 16 bytes. The fact that xts-talitos can handle only 8 bytes
is a problem indeed, but for plain and plain64 should not matter.

Horia
