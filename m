Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0118.outbound.protection.outlook.com [157.56.111.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0ED01A09A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 05:46:19 +1100 (AEDT)
Message-ID: <550724ED.1050003@freescale.com>
Date: Mon, 16 Mar 2015 20:46:05 +0200
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
 <550063D1.2070105@freescale.com>
 <CAJUS3Xmv3atWu=-ydYrSVe+5PON7SM22hoXDQ1_5_ULM_zKvbQ@mail.gmail.com>
In-Reply-To: <CAJUS3Xmv3atWu=-ydYrSVe+5PON7SM22hoXDQ1_5_ULM_zKvbQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Milan Broz <gmazyland@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/13/2015 4:08 PM, Martin Hicks wrote:
> Hi Horia,
> 
> On Wed, Mar 11, 2015 at 11:48 AM, Horia Geantă
> <horia.geanta@freescale.com> wrote:
>>
>> While here: note that xts-talitos supports only two key lengths - 256
>> and 512 bits. There are tcrypt speed tests that check also for 384-bit
>> keys (which is out-of-spec, but still...), leading to a "Key Size Error"
>> - see below (KSE bit in AESU Interrupt Status Register is set)
> 
> Ok.  I've limited the keysize to 32 or 64 bytes for AES-XTS in the
> talitos driver.
> 
> This was my first experiments with the tcrypt module.  It also brought
> up another issue related to the IV limitations of this hardware.  The
> latest patch that I have returns an error when there is a non-zero
> value in the second 8 bytes of the IV:
> 
> +       /*
> +        * AES-XTS uses the first two AES Context registers for:
> +        *
> +        *     Register 1:   Sector Number (Little Endian)
> +        *     Register 2:   Sector Size   (Big Endian)
> +        *
> +        * Whereas AES-CBC uses registers 1/2 as a 16-byte IV.
> +        */
> +       if ((ctx->desc_hdr_template &
> +            (DESC_HDR_SEL0_MASK | DESC_HDR_MODE0_MASK)) ==
> +            (DESC_HDR_SEL0_AESU | DESC_HDR_MODE0_AESU_XTS)) {
> +               u64 *aesctx2 = (u64 *)areq->info + 1;
> +
> +               if (*aesctx2 != 0) {
> +                       dev_err(ctx->dev,
> +                               "IV length limited to the first 8 bytes.");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +
> +               /* Fixed sized sector */
> +               *aesctx2 = cpu_to_be64(1 << SECTOR_SHIFT);
> +       }
> 
> 
> This approach causes the tcrypt tests to fail because tcrypt sets all
> 16 bytes of the IV to 0xff.  I think returning an error is the right
> approach for the talitos module, but it would be nice if tcrypt still
> worked.  Should tcrypt just set the IV bytes to 0 instead of 0xff?
> Isn't one IV just as good as another?  I think adding exceptions to
> the tcrypt code would be ugly, but maybe one should be made for XTS
> since the standard dictates that the IV should be plain or plain64?

AFAICT xts-aes standard does not mandate for plain or plain64.
The requirements are the following (below IV = tweak value, sector =
data unit):
-IV size: 16 bytes
-IV format: little endian byte array
-IV values: non-negative; consecutive IV values for consecutive sectors

In practice, an 8-byte IV should be enough to represent the sector index
even for large capacity storage devices.
However, dm-crypt has support for a user-provided iv_offset that is
added to the sector index: IV = sector_index + iv_offset.
While in most of the cases user would choose iv_offset = 0, in theory
anything is possible.

IMHO the correct approach would be to use a fallback tfm that would
handle all the requests with IVs > 8 bytes.
We can take this off-list if you prefer.

Horia
