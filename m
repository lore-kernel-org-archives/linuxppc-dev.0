Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1814C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 07:10:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08623213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 07:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0ksWcBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08623213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q6bb4x4FzF3Jh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 17:10:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0ksWcBn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0ksWcBn"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q6Xv5vqyzDrS4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 17:07:43 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id d4-v6so1235098pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K+cwvjhyKlRtLBu5We6UdPtBN6bnBLfv0MQtWcb1ikU=;
 b=Y0ksWcBn+GpKgYhAceI4aj4yZQUSO93TvgCVtMGBRo5m2GB1U0xS2v+dTvVn9vXQK6
 GHrxFiI4fFeJWq0DvN5CXJhbL9r9A3ESCN9V8EOCEgmbzoEsefzdTPG7JcnyuxAZ+8zw
 N9Zzb3TK+ztKJcLYbvHYNOKojvkqc4XLM2zMP2o3QeOfPOYqYIP35YR6MJxi2wyFfvqZ
 7sqdxiceLVl7sJVB/HjXemPzAOuzthM1xDDBBvsZkkZ1WPnh982JPosqqqsu+NMIeQHG
 CkbYkFLAcwDVomkCym2TlLaZp7RiVIuOjK1OJauxj4Yq3bEj9W6l53Fsmxo2mCogFYIa
 GHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+cwvjhyKlRtLBu5We6UdPtBN6bnBLfv0MQtWcb1ikU=;
 b=fJ1P/GdfqzPYJoOAd86wbwtd77HtLL9jiWWVQzxv683iSSRkPZfIvJgMHUpErH/38k
 hIAQiUlKg/P1pmC2Lcvt/T08dhhpWyXf5l76YdWmn8McMDtO0HHXdwYzVwqzHIRRjrsr
 gTQV2VeIccGzj8VUvdYJnCSLqbdAGRFj1bM1W1oTBehsIQi5Mxxqq3Z77EvkbLIrvvny
 xuws0/r8cWVTy7X9sbHG7t4aioLimzSACwiwQRYbNtTyDdvi8XnZ2da9VIAaI77Vl3h+
 QwhcfV7G6wEPCDmnsveMcmVn768QO3yLbmP5mqojCyDPCiXDWJh3kzCo8Y99oNXXDs3z
 MEeg==
X-Gm-Message-State: ABuFfogrKcoT0BirFfchQrpYd4bENAn6rj0vJY3nR+y16R53eoMfCe7x
 cYxb4PM/2R37NowICwVOp6Y=
X-Google-Smtp-Source: ACcGV61xco3QPlcjQdB34YuzoGRw9dE442MXBRdQMibRxnK0Da5MqwKMT2Ak2VhxH7eIOFxYU+CNIQ==
X-Received: by 2002:a63:415:: with SMTP id 21-v6mr100110pge.327.1538550461709; 
 Wed, 03 Oct 2018 00:07:41 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id r1-v6sm1215531pfb.41.2018.10.03.00.07.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Oct 2018 00:07:41 -0700 (PDT)
Date: Wed, 3 Oct 2018 17:07:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
Message-ID: <20181003170736.34082f4d@roar.ozlabs.ibm.com>
In-Reply-To: <38d58749-c058-a6d7-1ca2-23abe9dd34a3@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
 <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
 <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
 <20181003163024.281254bf@roar.ozlabs.ibm.com>
 <38d58749-c058-a6d7-1ca2-23abe9dd34a3@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Oct 2018 08:45:25 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 08:30, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Wed, 3 Oct 2018 07:52:59 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Le 03/10/2018 =C3=A0 07:34, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>> On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
> >>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>>     =20
> >>>> thread_info is not anymore in the stack, so the entire stack
> >>>> can now be used. =20
> >>>
> >>> Nice.
> >>>     =20
> >>>>
> >>>> In the meantime, all pointers to the stacks are not anymore
> >>>> pointers to thread_info so this patch changes them to void* =20
> >>>
> >>> Wasn't this previously effectively already the case with patch
> >>> 3/7? You had thread_info sized space left there, but it was not
> >>> used or initialized right? Does it make sense to move this part
> >>> of it to the previous patch? =20
> >>
> >> Not really.
> >>
> >> In 3/7 I changed the prototypes of two functions that really used the
> >> pointer as a task pointer only. =20
>=20
> I meant 2/7 here sorry.
>=20
> >>
> >> Here it change things that before 4/7 were really used as both stack
> >> pointers and thread_info pointers. =20
>=20
> And here I meant 3/7
>=20
> >=20
> > What uses it as a thread_info pointer? It seems more like a stack
> > with some amount of unused space in it but that's all. =20
>=20
> Before 3/7, we have
>=20
> void do_softirq_own_stack(void)
> {
> 	struct thread_info *curtp, *irqtp;
>=20
> 	curtp =3D current_thread_info();
> 	irqtp =3D softirq_ctx[smp_processor_id()];
> 	irqtp->task =3D curtp->task;
> 	irqtp->flags =3D 0;
> 	call_do_softirq(irqtp);
> 	irqtp->task =3D NULL;
>=20
> 	/* Set any flag that may have been set on the
> 	 * alternate stack
> 	 */
> 	if (irqtp->flags)
> 		set_bits(irqtp->flags, &curtp->flags);
> }
>=20
> After 3/7, we have
>=20
>   void do_softirq_own_stack(void)
>   {
> 	struct thread_info *irqtp;
>=20
>   	irqtp =3D softirq_ctx[smp_processor_id()];
>   	call_do_softirq(irqtp);
>   }
>=20
>=20
> So now only we can change irqtp to void* can't we ?

In patch 3 we can, right? That's what I mean by moving from
thread_info * to void * in patch 3 rather than 4.

But if you prefer not to, it's fine. Maybe it keeps patch 3
a little smaller.

Thanks,
Nick
