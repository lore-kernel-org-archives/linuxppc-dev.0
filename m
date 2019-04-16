Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA26C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:51:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155A0206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZEmLI8WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kBGp3XqMzDqFv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="ZEmLI8WM"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kBDx6VltzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 02:50:09 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id q66so4653725ljq.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sCNFQh0jTa6sj9k5WIdIdVFNK8z05B2xT/7RvFXhZP8=;
 b=ZEmLI8WMiuJuHU8T3/vTMBZWhWtQVtDoUZX+2U07tSATOdKLcOnw17fuBT3SMvtM6W
 2ICWxu5NxKagoiGd9ISMLrfsqYoHHn9sYbBxP3eQNHKBZ8NsNDKJeCb4HeWzxGgtJayW
 DpkP/A/FSVg8T3ieIk9gP0YymaHl1Ta7ZPwng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sCNFQh0jTa6sj9k5WIdIdVFNK8z05B2xT/7RvFXhZP8=;
 b=VmNBHvFz9DjmyGyShiioiUmxmjajaLubKfW/Padx+abITtV7KIalrSyyoxAudcEmw+
 cKRjCSZjwlkBFm/kXFK8dFyyqbClfnfkRXwDRl3SLZM5yRhmOH0bEzF7mzJUiw3qZyls
 NXphZkjlieTwYotV3Wp7OWkOK2Kdn1i6BTxP/F2rwodL8/MqUEQhwtYgiDR6MlLqtqQS
 Y1shk+xpuMS/ejU58nXMc81SZHJt1jcN3GrObFx2drxvQxXxpAj+W5tS7xQCX2Wu0XpE
 zl33XvJCMxtd0dGRYoSW4kHgrjRpJS6CctMm+iYJBH6iu1I1CSanWYCLu1fvw3FaA2fT
 mScQ==
X-Gm-Message-State: APjAAAVup9cDxi7yq9X9I4m8sEA4BdHBlfyD1QE1wNvNS856CQB1ALjR
 h9WGb1xbThcrQKlFM/J7KZsAFH3TeOo=
X-Google-Smtp-Source: APXvYqzAzA94R+4taAtFiZAMSB7ER7OIi5whs4W7u1lIuWgAR+zMfZcJQM31gnvPA5iWhAwTcCO9+A==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr24770102ljb.3.1555433404231; 
 Tue, 16 Apr 2019 09:50:04 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id e64sm10547799ljf.75.2019.04.16.09.50.02
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Apr 2019 09:50:03 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q66so4653592ljq.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:50:02 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr18248032ljg.57.1555433402573; 
 Tue, 16 Apr 2019 09:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
In-Reply-To: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2019 09:49:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
Message-ID: <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: multipart/mixed; boundary="0000000000006f45e80586a88f88"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--0000000000006f45e80586a88f88
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 16, 2019 at 9:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We actually already *have* this function.
>
> It's called "gup_fast_permitted()" and it's used by x86-64 to verify
> the proper address range. Exactly like s390 needs..
>
> Could you please use that instead?

IOW, something like the attached.

Obviously untested. And maybe 'current' isn't declared in
<asm/pgtable.h>, in which case you'd need to modify it to instead make
the inline function be "s390_gup_fast_permitted()" that takes a
pointer to the mm, and do something like

  #define gup_fast_permitted(start, pages) \
         s390_gup_fast_permitted(current->mm, start, pages)

instead.

But I think you get the idea..

                Linus

--0000000000006f45e80586a88f88
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_juk0utdu0>
X-Attachment-Id: f_juk0utdu0

IGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAxMiArKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2luY2x1
ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKaW5kZXgg
NzZkYzM0NGVkYjhjLi5hMDgyNDg5OTVmNTAgMTAwNjQ0Ci0tLSBhL2FyY2gvczM5MC9pbmNsdWRl
L2FzbS9wZ3RhYmxlLmgKKysrIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL3BndGFibGUuaApAQCAt
MTY1OSw0ICsxNjU5LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja19wZ3RfY2FjaGUodm9p
ZCkgeyB9CiAKICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9wZ3RhYmxlLmg+CiAKK3N0YXRpYyBpbmxp
bmUgYm9vbCBndXBfZmFzdF9wZXJtaXR0ZWQodW5zaWduZWQgbG9uZyBzdGFydCwgaW50IG5yX3Bh
Z2VzKQoreworCXVuc2lnbmVkIGxvbmcgbGVuLCBlbmQ7CisKKwlsZW4gPSAodW5zaWduZWQgbG9u
Zylucl9wYWdlcyA8PCBQQUdFX1NISUZUOworCWVuZCA9IHN0YXJ0ICsgbGVuOworCWlmIChlbmQg
PCBzdGFydCkKKwkJcmV0dXJuIGZhbHNlOworCXJldHVybiBlbmQgPD0gY3VycmVudC0+bW0tPmNv
bnRleHQuYXNjZV9saW1pdDsKK30KKyNkZWZpbmUgZ3VwX2Zhc3RfcGVybWl0dGVkIGd1cF9mYXN0
X3Blcm1pdHRlZAorCiAjZW5kaWYgLyogX1MzOTBfUEFHRV9IICovCg==
--0000000000006f45e80586a88f88--
