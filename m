Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B3C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 07:02:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF01D21848
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 07:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exD3mkrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF01D21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443WsD5MV4zDqLL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 18:02:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="exD3mkrQ"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443WqG0ZsLzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 18:01:13 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w7so9649070pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 23:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=X16hCAq2fEPXNIGVXcCcH3umZsrh2FSl2ZbjpApM4P8=;
 b=exD3mkrQLAIhH2LMiLD+GRPj7GYVzRNI9dE2JCT16jJ69y9Xtx2Knq3eS2FIulanX6
 SGJ8LaJF1iMLwuTHJ+heKXzUZWDLWEIkkbalAYIxQtpPf/RTNcO2RYsEU6gIMamjOtcq
 VwVWJ9c69yum9Skt0Bex4XGLU1YulPayQtQwfw4BBl0Y6XlU0thGA7qRMQqLIDV7pBUs
 9neNVmh3ZImPS9h6YgcAtwTduxK9S0gOVNeIsQ6t0jU2hW7WQj3tLinlQGM2zmI8cY6G
 W7Sd6sMAIjH8320vYrYSnSXWzSLum4K5rTLm56x0ZfKd8J0tqWHl+k2aMmElcl5sbepc
 lB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=X16hCAq2fEPXNIGVXcCcH3umZsrh2FSl2ZbjpApM4P8=;
 b=uVcaXwSRQSk7OxZ2aUut2Bj2YfRYk7zHPa8pe+XCTP/k7so3ieq+EK3dvEPlw1jmDi
 6TbAmFzYmLraK/jlNYiAeuVXF4Yr0pqZ+a0f2RhG9/XG4kgefOW1RAZ+qDIK0NXvkOZZ
 ueG2Kc3GMQydbqf4Uhbxnw8EXvx+fkGYCTbfuxxxg8qdig5POeelYpM314TsVXk2Tn+0
 930kvS4RfXmoxfWEOFU5I8VMv06QU3Oln+rRFRkCP+sy4dVOwcqoL7WP4lW4JPZWS8xR
 MPGO/c46T2tCir02y9jgcEPeJo5xydA10Zzco9irsaEB5oIkTuNjwEV+jZTzYsRDyDUF
 M01w==
X-Gm-Message-State: AHQUAuZFp6dQE6CL139HQG98GUXnzDHOMy061tHLHSATLuA5wNhe69kN
 rTeFn92hnQjPtkPbj1feOnc=
X-Google-Smtp-Source: AHgI3IbPSeIfH+YldDFCeJMO3ebXwQgkRiuPjnDPkFSQ1Dzxr3udvV8gTJeD/KweXNlHJiFIsRY4ZQ==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr22691740pgb.58.1550559672029; 
 Mon, 18 Feb 2019 23:01:12 -0800 (PST)
Received: from localhost ([61.69.157.156])
 by smtp.gmail.com with ESMTPSA id y20sm27732217pfd.161.2019.02.18.23.01.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 23:01:11 -0800 (PST)
Date: Tue, 19 Feb 2019 17:01:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 2/2] powerpc/mm/hash64: Map all the kernel mapping in
 the same 0xc range
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org, Daniel Axtens
 <dja@axtens.net>, mpe@ellerman.id.au, paulus@samba.org
References: <20190217051609.24140-1-aneesh.kumar@linux.ibm.com>
 <20190217051609.24140-2-aneesh.kumar@linux.ibm.com>
 <1550555813.fmra4d124d.astroid@bobo.none>
 <61b935a8-6fb2-e1ec-15cb-fbe4f293fe80@linux.ibm.com>
In-Reply-To: <61b935a8-6fb2-e1ec-15cb-fbe4f293fe80@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550559594.nl4vxs2jg6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Aneesh Kumar K.V's on February 19, 2019 4:00 pm:
> On 2/19/19 11:28 AM, Nicholas Piggin wrote:
>> Aneesh Kumar K.V's on February 17, 2019 3:16 pm:
>>> This patch maps vmap, IO and vmemap regions in the 0xc address range
>>> instead of the current 0xd and 0xf range. This brings the mapping close=
r
>>> to radix translation mode.
>>=20
>> What was the reason for that address layout in the first place?
>>=20
>=20
> To bring in closer to radix translation mode and it should also help=20
> with KASAN implementation.

No I mean the old implementation. Your change seems fine, it would just
be good to know what the downside (if any) is from changing. Maybe it=20
was just to make debugging slightly simpler?

Thanks,
Nick
=
