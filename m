Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061FC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 19:07:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBBD2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 19:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVkQSWrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBBD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RfQT6JBtzF3Jg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 05:07:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVkQSWrA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVkQSWrA"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RfM25VCBzF3dK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 05:04:30 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id t70-v6so5101019pgd.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IxNzpZfrzf04aYB260LV+RsW+idnvKy2G4n6HkUa5Hw=;
 b=DVkQSWrANzQVEbIxB0Nlcx7OLj3wGT7nho/daPWb/qgY8XmmDOCiZ2HhYLGObgLlXb
 nYHR4tdV3WiXB4V3mlPY+Sx5DXoFCwYTGMkSZfqql0ut03o9CXI2yvzgi4gb5jFv5wal
 ycFjyEpjMO0Fl1c+ajYfx4s+FldyTa2HmrBGi7utt66hccZ5oP9rVjRA1ZL9bmxc8uym
 qKGpKZVKaerFJCP2N6De3p4PGkGigAFP+0hkiW+ogoieb8/i6p+xY4ZiHX3faHdPoyYM
 FBYdXEx487K2J6VD9APzzm0tjdswYvpMi/kNJKrx5KB+LPtt+5wm+bctuWrlZ4NWj1OX
 ec0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IxNzpZfrzf04aYB260LV+RsW+idnvKy2G4n6HkUa5Hw=;
 b=WUVqJs7n4iweZfiZsQunf0877egBHNMyUClfT9pPJGHmJ9nmY7wTqyuqotMQiFGNI6
 N+ZamPum7ltXEXHr35neEvcts4kQfla77OwBwMAi4bQFL+/Uq5tOlx45KmejSN7JYErY
 UAegFa1UCO/6XnHDpqHpwbP7XuU1uuhqc9fhhgqQMIh1bIfpv5Vbr3YbIDKkir/xe3+r
 xD1AhO35AP5g9aOf7L47hmRyGNndLoTpmOUi4a4d+x55/OcDEmwysDHImIX0Q7MCT50L
 ktJSwC9hwCMkQ+YEC9eE0m3NYfi0zbkM1hSadQ0j6Q6EAexcBSK75h0Wbo/JgTsu1QZ6
 c5Bw==
X-Gm-Message-State: ABuFfogPQRf2NisvwkyUaYWUMIC75gL6Whbf7CMft54a4htnj8rIOrdg
 8L6OErM5qWz6WFQu6TWoH+Y=
X-Google-Smtp-Source: ACcGV62yVMH0Ns+v8EkrWDksh8GtzkzM9J+zqUJnswaNs+zHA4lj5w4Stj2v9nfb+nDIDPwk4Te+ig==
X-Received: by 2002:a62:d841:: with SMTP id
 e62-v6mr13285662pfg.60.1538766268846; 
 Fri, 05 Oct 2018 12:04:28 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id y128-v6sm11691843pfb.56.2018.10.05.12.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 12:04:28 -0700 (PDT)
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
To: Rob Herring <robh+dt@kernel.org>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
 <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <d251f99e-6618-f1d2-814f-7aaffb8f499f@gmail.com>
Date: Fri, 5 Oct 2018 12:04:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/05/18 07:53, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Callers of of_irq_parse_one() blindly use the pointer args.np
>> without checking whether of_irq_parse_one() had an error and
>> thus did not set the value of args.np.  Initialize args to
>> zero so that using the format "%pOF" to show the value of
>> args.np will show "(null)" when of_irq_parse_one() has an
>> error and does not set args.np instead of trying to
>> dereference a random value.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/unittest.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Does this need to be part of this series?

I do not know if it could be independently applied before the
rest of the series (I have not tested that).  I included it
in the series because the series has so many other changes to
unittest.c.

If you want me to break this out, I will remove it from this
series and resend it after the rest of the series has been
pulled to mainline (and rebase on the new mainline).

This patch is not fixing a known failure case - the current
test data does not trigger the problem.  The recent patch
from  Guenter that you already accepted fixes the known failure
case, so this patch is not urgent.  The same is true about the
other cases Guenter pointed out that this patch should fix.

-Frank
