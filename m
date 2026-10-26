Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B64606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aHkfVa8e
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD5150LpNz2yKn;
	Tue, 27 Oct 2026 07:33:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793046792;
	cv=none; b=P9BaUHX152E1+RY0vqb0oHs/2YEFYxvSGmn/S0Ln48v2f1Jo3JaUIa+/kwYV/j9g3qyZERp/2zZWNSxfaucJD8vZE82hZPJF1rsVmLGGV9pH76J+VZv2Noy2BMwdb7ilDYPyF+N8rega2Lwrb9wb2aWpXBPzaynbyGlcXlZu2zzUWRYHQ/JO+cdy1tObBAAwvPSabgYgL2VREDntuXKGk9mAt6p8OvZ/H/3Ji6LKk4Zsj+pkhD0WiDg5249Pt5E9n7Ha/zqeN9YZRNK4o0oh+a/WO5c+8zRwgRMcfoXpZTaNF4J+fkPTTOYW7T+7t8i2jEd+3lMpXLXG/3nI5xdhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793046792; c=relaxed/relaxed;
	bh=0rFainJhqdviEgXERCkuAXMBJIMk47qPeO7jf0mjJHI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=j2+8zowVNFK4B2dZkGhEult1nYsU1gcOYXsGjL47rOTaWbjRZ4zBlsFrSRDcKHGdndaVs7/1cJmJaA59q3yPLL4es5O3SIwT0AchBeYEuY8B7LyC2+d8PhFQxIp0BLE7GmSCIIGTxiSMw2PH/AJJGOsqGJXcBco1a424wYZ+H1tnVBPgZzJDSkZ26Sy6SnkQm56pEoQRv0jCVp0g2nbAyhN4q+J0Z3s7+VS0tS+Vo3lpY2Wp6aC0XTlwzl9POKy2u47L7C9/sdSLS/z4jTqCw5epegGQj8FDln+Fl9j5Zn/R9YbHdZKe9dv3LIvf7HpAeMfpIFSjQdu/ENvx6gGnsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aHkfVa8e; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aHkfVa8e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 326 seconds by postgrey-1.37 at boromir; Tue, 27 Oct 2026 07:33:08 AEDT
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD5105sB2z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 07:33:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793046784; x=1793651584; i=markus.elfring@web.de;
	bh=0rFainJhqdviEgXERCkuAXMBJIMk47qPeO7jf0mjJHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aHkfVa8eLATW71l4uEEng2J2Ve8itkp/VeH8xgU5Kb8RpOkm6sNkLVWXC4lG0koz
	 J8C421hDEZh1DQKifqaPbqfKxuMyKr8SB9IrqEkQNS6uy5sl0rQA97jaAW5CNFziZ
	 /9KPXxi+Sc+5wtJjy8vz2TEUgYPZ3tnhwHtJ++BYMjwNlckolw0xNSZqR9hQG9Mm3
	 guXOWceHXQ51Mk+SCqhCjQfo/HNSKGDXl4e5X+6D9QH78NJDjQpkNihpl+kklHOpZ
	 0x6tuxa7m8rh4YTtW1oL+OK64ahu3PAhn0FDy8yq7re5+rOUNGEBM2f9JCVYFxtA/
	 MuM8Ngco1HmqIDsTKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1wl00I3yRY-00pJfE; Mon, 26
 Oct 2026 21:27:11 +0100
Message-ID: <ed315ff8-36fa-40ef-90f9-01ad197a9f94@web.de>
Date: Mon, 26 Oct 2026 21:27:09 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <chleroy@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <56f0c45723ee53149a21ceb599010e957457afd8.1793044370.git.bvanassche@acm.org>
Subject: Re: [PATCH] powerpc/iommu: Fix an RCU read lock leak in
 mm_iommu_is_devmem()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <56f0c45723ee53149a21ceb599010e957457afd8.1793044370.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qTKgH57TOzyJ5nr5xKKTUtBr2l4rXHfZPZF2pcEZTRYDGjUdxlE
 BXKBRZAupAc5mNFpzrNkQk4aPUteBJORH/mhRrE1xIfiCAtTd/t05frACCZSAvljB6j5gAX
 zzYVZL75Ky5DJ5rH/xANUr2d0XackBiXZ6JjyibDi9pwI4JFSlZE4E04IRjGlWYqYIdCmXh
 DdnCCfrCF5/8vFgeBWIjw==
UI-OutboundReport: notjunk:1;M01:P0:X8FsTsFzyjE=;9xcWg+cyMcA989t7P86avkT3HMx
 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
 YxPEnGhIMSa/VI5hRb9dEmJrExeg==
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E2=80=A6
> +++ b/arch/powerpc/mm/book3s64/iommu_api.c
> @@ -371,6 +371,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsign=
ed long hpa,
>  			 * and the caller needs to distinguish this situation.
>  			 */
>  			*size =3D min(1UL << pageshift, end - hpa);
> +			rcu_read_unlock();
>  			return true;
>  		}
>  	}

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(rcu)();=E2=80=9D?
https://elixir.bootlin.com/linux/v7.3/source/include/linux/rcupdate.h#L121=
6

Regards,
Markus

