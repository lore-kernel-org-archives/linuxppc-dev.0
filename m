Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 107901A05EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 06:40:04 +1100 (AEDT)
Received: by igl9 with SMTP id 9so81381127igl.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2015 11:40:01 -0800 (PST)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <87bna36v91.fsf@gamma.ozlabs.ibm.com>
References: <1449388004.2096.12.camel@hbabu-laptop>
 <87bna36v91.fsf@gamma.ozlabs.ibm.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Mon, 7 Dec 2015 14:39:22 -0500
Message-ID: <CALZtONDkyZ--PZ4VBH3yTiGPhmneo=vUuYLwbTHQ2q-2XRnyNg@mail.gmail.com>
Subject: Re: crypto/nx842: Ignore queue overflow informative error
To: Daniel Axtens <dja@axtens.net>
Cc: Haren Myneni <haren@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Michael Ellerman <mpe@ellerman.id.au>,
 pair@us.ibm.com, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 6, 2015 at 5:57 PM, Daniel Axtens <dja@axtens.net> wrote:
> Haren Myneni <haren@linux.vnet.ibm.com> writes:
>
>> NX842 coprocessor sets bit 3 if queue is overflow. It is just for
>> information to the user. So the driver prints this informative message
>> and ignores it.
>
> What queue, and what happens when the queue overflows? It seems like
> *something* would need to be done, somewhere, by someone?
>
> I realise that as a piece of IBM hardware this is probably an incredibly
> optimistic question, but is this behaviour documented publically anywhere?
> (As a distant second best, is it documented internally anywhere that I
> can read?)

When I worked there, it unfortunately wasn't public and there was no
future plan to make it public, but things might have changed since I
left.  Maybe it will be included in future openpower documentation...?

>
>> --- a/drivers/crypto/nx/nx-842-powernv.c
>> +++ b/drivers/crypto/nx/nx-842-powernv.c
>> @@ -442,6 +442,15 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
>>                            (unsigned int)ccw,
>>                            (unsigned int)be32_to_cpu(crb->ccw));
>>
>> +     /*
>> +      * NX842 coprocessor uses 3rd bit to report queue overflow which is
>> +      * not an error, just for information to user. So, ignore this bit.
>> +      */
>> +     if (ret & ICSWX_BIT3) {
>> +             pr_info_ratelimited("842 coprocessor queue overflow\n");
> It doesn't look like this is done anywhere else in the file, but should
> this be prefixed with something? Something like "nx-842: Coprocessor
> queue overflow"?

it defines pr_fmt at the top of the file so it will be prefixed with
the module name.

>
> Regards,
> Daniel
>
>> +             ret &= ~ICSWX_BIT3;
>> +     }
>> +
>>       switch (ret) {
>>       case ICSWX_INITIATED:
>>               ret = wait_for_csb(wmem, csb);
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
