Return-Path: <SRS0=bRiG=3T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63AAC33C9E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 12:07:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00F9206D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 12:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gARRmL+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00F9206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 487fGj2pn9zDqXt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 23:06:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=fweimer@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=gARRmL+g; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 487fCX2dDkzDqXd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2020 23:04:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580385841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKuBJA8OPCdrwIVumv/E6YJ57Qgp9vb3v6pG7Dh/nj8=;
 b=gARRmL+gCWbKL6FqXTPxIURilQtE7W9fp+2UWYrvuTZ7mB+i4chZSN70qlkLwoAlz6qWM4
 Xh4ba/OktFBro60J9KyBEdnnVKyfHPiYAEMQaxRoXh5b06XKc17lzSlF/PNgkSuJDWQg3t
 mMuXnjrZxI5nnQFeSBR2LCmuJ696vQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-oSPlSeQRO3i_9_2sqYW4Mw-1; Thu, 30 Jan 2020 07:03:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D947107ACC7;
 Thu, 30 Jan 2020 12:03:56 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-29.ams2.redhat.com
 [10.36.116.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0AA55C1B2;
 Thu, 30 Jan 2020 12:03:54 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc Linux scv support and scv system call ABI proposal
References: <87tv4fd8wp.fsf@oldenburg2.str.redhat.com>
 <1580218232.2tezmthp1x.astroid@bobo.none>
 <20200128154026.GI22482@gate.crashing.org>
 <87o8unbm8u.fsf@oldenburg2.str.redhat.com>
 <20200128200133.GJ22482@gate.crashing.org>
 <87wo9a8cc8.fsf@oldenburg2.str.redhat.com>
 <20200129162947.GN22482@gate.crashing.org>
 <87imku8ac5.fsf@oldenburg2.str.redhat.com>
 <20200129175104.GO22482@gate.crashing.org>
 <87k1595iok.fsf@oldenburg2.str.redhat.com>
 <20200130112512.GS22482@gate.crashing.org>
Date: Thu, 30 Jan 2020 13:03:53 +0100
In-Reply-To: <20200130112512.GS22482@gate.crashing.org> (Segher Boessenkool's
 message of "Thu, 30 Jan 2020 05:25:12 -0600")
Message-ID: <87y2tp40d2.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: oSPlSeQRO3i_9_2sqYW4Mw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: libc-alpha@sourceware.org,
 Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Segher Boessenkool:

>> I *assumed* that I would still get
>> the value of r0 (the register) from the associated extended asm in this
>> expression, even if it may now be a different register.  Your comment
>> made me think that this is undefined.
>
> Please show full(er) examples, I think we are talking about something
> else?

No, I think we are in agreement here how things should behave under the
new model.  But I have doubts whether that is implemented in GCC 9.

>> The GCC documentation has this warning:
>>=20
>> |  _Warning:_ In the above example, be aware that a register (for
>> | example 'r0') can be call-clobbered by subsequent code, including
>> | function calls and library calls for arithmetic operators on other
>> | variables (for example the initialization of 'p2').
>
> Yes.  This does not matter for the only supported use.

I'm not so sure.  See below.

> This is why that *is* the only supported use.  The documentation could
> use a touch-up, I think.  Unless we still have problems here?

I really don't know.  GCC still has *some* support for the old behavior,
though.  For example, local register variables are treated as
initialized, and I think you can still use registers like global
variables.  GCC does not perform copy propagation here:

int f1 (int);

int
f (void)
{
  register int edi __asm__ ("edi");
  int edi_copy =3D edi;
  return f1 (1) + edi_copy;
}

And the case that we agreed should be defined in fact is not:

void f1 (int);

int
f (void)
{
  register int edi __asm__ ("edi");
  asm ("#" : "=3Dr" (edi));
  f1 (1);
  return edi;
}

On x86-64, %edi is used to pass the first function parameter, so the
call clobbers %edi.  It is simply ambiguous whether edi (the variable)
should retain the value prior to the call to f1 (which I think is what
should happen under the new model, where register variables are only
affect asm operands), or if edi (the variable) should have the value of
%edi (the register) after the call (the old model).

Should we move this to the gcc list?

Thanks,
Florian

