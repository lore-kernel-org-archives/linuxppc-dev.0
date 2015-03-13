Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BC9D1A078D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 01:08:51 +1100 (AEDT)
Received: by ieclw3 with SMTP id lw3so107412197iec.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 07:08:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <550063D1.2070105@freescale.com>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com> <54F475A8.6030105@gmail.com>
 <20150302220923.GC30523@darwin.bork.org>
 <54F5D6D5.8070407@freescale.com>
 <CAJUS3Xnw66Eu6tvGPpdcet6KLjhKM=ptj8NRaztAVr0h_r+LqQ@mail.gmail.com>
 <54FD72E4.1060701@freescale.com>
 <CAJUS3XkY0tbYqBbU5HR7NT63UPFi5DO6XWuymbZnQaJEA5kkBw@mail.gmail.com>
 <550063D1.2070105@freescale.com>
Date: Fri, 13 Mar 2015 10:08:29 -0400
Message-ID: <CAJUS3Xmv3atWu=-ydYrSVe+5PON7SM22hoXDQ1_5_ULM_zKvbQ@mail.gmail.com>
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

Hi Horia,

On Wed, Mar 11, 2015 at 11:48 AM, Horia Geant=C4=83
<horia.geanta@freescale.com> wrote:
>
> While here: note that xts-talitos supports only two key lengths - 256
> and 512 bits. There are tcrypt speed tests that check also for 384-bit
> keys (which is out-of-spec, but still...), leading to a "Key Size Error"
> - see below (KSE bit in AESU Interrupt Status Register is set)

Ok.  I've limited the keysize to 32 or 64 bytes for AES-XTS in the
talitos driver.

This was my first experiments with the tcrypt module.  It also brought
up another issue related to the IV limitations of this hardware.  The
latest patch that I have returns an error when there is a non-zero
value in the second 8 bytes of the IV:

+       /*
+        * AES-XTS uses the first two AES Context registers for:
+        *
+        *     Register 1:   Sector Number (Little Endian)
+        *     Register 2:   Sector Size   (Big Endian)
+        *
+        * Whereas AES-CBC uses registers 1/2 as a 16-byte IV.
+        */
+       if ((ctx->desc_hdr_template &
+            (DESC_HDR_SEL0_MASK | DESC_HDR_MODE0_MASK)) =3D=3D
+            (DESC_HDR_SEL0_AESU | DESC_HDR_MODE0_AESU_XTS)) {
+               u64 *aesctx2 =3D (u64 *)areq->info + 1;
+
+               if (*aesctx2 !=3D 0) {
+                       dev_err(ctx->dev,
+                               "IV length limited to the first 8 bytes.");
+                       return ERR_PTR(-EINVAL);
+               }
+
+               /* Fixed sized sector */
+               *aesctx2 =3D cpu_to_be64(1 << SECTOR_SHIFT);
+       }


This approach causes the tcrypt tests to fail because tcrypt sets all
16 bytes of the IV to 0xff.  I think returning an error is the right
approach for the talitos module, but it would be nice if tcrypt still
worked.  Should tcrypt just set the IV bytes to 0 instead of 0xff?
Isn't one IV just as good as another?  I think adding exceptions to
the tcrypt code would be ugly, but maybe one should be made for XTS
since the standard dictates that the IV should be plain or plain64?

Thanks,
mh

--=20
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
