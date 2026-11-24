Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DE606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Ns0ocBa9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VyCHGOD7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYsRf6gSxz2y2L;
	Wed, 25 Nov 2026 05:54:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795546462;
	cv=none; b=D5kHxwS16UHzRwt5MR/v8/DrhndOzaxHKKktNrTA8aALqzGnjtNJG5kZexrO0Ykyu/N5ese4ARRHkMbQWMBGvWCqwTD3oR1galvpYjwdR9yIM+OHhWZaE8+ouXBF7Pc1Mh2h621Hr7+kxJEdD9Zm+/Yv6OF9AzT3BGLpQVXFfAZCnqd7xC5Cv5rY0OXRxeHT4V+rzJB+Oess2rSVyvNs/XsS36J08rn5ejMq1EqYvrc7Y7f23uoV0sxBFzdWE4Ooc/yS1jG+EsrB78R/OdxlM+KpzGJSONB3qnMuTLh3MOM38HtQ22ASKauLU4gu5syyE5fro6ltalF0s1SaVrNp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795546462; c=relaxed/relaxed;
	bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DF+oln2lpfgPmWJFFlczGrtvNO5PoO7m8oyxy1TWEZvYRoruck8sdgJHfIdQT+j9F1Q6tAphvFgfCq6V+mtNBi8yj4vGd49x+vGZO6eMFIbGj0NHZ4mgPuGgHvRPxZWjNJDh071BN3HYIQsCUkkN+NkyOa8TEe6LfLIHZ0skTER5rZMXh6Xo14qiwrBs0JLwIO4uDE0qCoHoZ38nNR6LXBzFhIsdKGs9VXwGW6wuISQZ00ZSz7lFezdsHsqL/FJJDu3TfM+E063UaYA8k4k5QY3aphwG0i1s4eSK3gAMH91Lfm4P0Y8K5JP91JsnXZPBfIe/iSHZeJGURRGj380jxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Ns0ocBa9; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VyCHGOD7; dkim-atps=neutral; spf=pass (client-ip=103.168.172.139; helo=flow-a4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Ns0ocBa9;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VyCHGOD7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.139; helo=flow-a4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYsRb5MM6z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 05:54:19 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id B271D13803C7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 13:54:16 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 13:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795546436;
	 x=1795553636; bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=; b=
	Ns0ocBa9uuJQNTtG3QfiU8sUxKT2BVab79oK6XioPic07HNY7BbGUro4492vDSKa
	taWSB3j0rahIlRO5r8ZoxMAmIeofQrkEd2O7X1OMQEOOEmHkNvuaEYSDts/UAM8w
	fED4InNTr0trVvSv57ETj3yHni+DAOQy8IgrUckr5I1xjqbrfGUxOwoJi0smwrAp
	nxVmvZkiOxgeZLtuxZuUgSTF8HOJ38Mrh+Szpuf5yDk9lzFD74nKhq2IZnhfVZN/
	vyB/Gl1S/ltyMKRNSc+WiurJ6LH/MJ4UcyvYBvhtsIXVP/k06hqmaXkoDI11XeA7
	wlXBDaQ5dfB4kxGI+OVvoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795546436; x=
	1795553636; bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=; b=V
	yCHGOD7HZXf+kTkcfTRyN6yTdKP309423KicUoIMqFh/OtFm+5uIv1vysvBFedjV
	XJFPWePPRM0CnxRFksiKelXDd4qxik7aQ3mMcyBCJjLxhyAF1/B4D21N2RNJubIz
	u5cBy+nZv7B/NkDxHFeW1hHCDPsd2Yncp7NFyXICp+R3pT0Y5ellhwQTcSjOD4Is
	qcejxkzW8ihZzqAnjwKGNkFDJQStwnjJ8vVNe8gpcx5sVF8NLwPxyCUUnJOe3iXr
	77Djsuz/1kfq3wwkXcMCZm5S41gIGVWAkWq3DEPG3YLiO4EDE4ry1FhRdzsZiw+Q
	+pL5WKOI4leoxTvwkIf/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795546436; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:mmTqL9ciIPJL/qozR4rIxAifhnJe3auTf2L582GLKJUdmUl
	O6JpBiI83gK2AUgKk1JnS0pO4VnMBYvZQSgvlYwI+0Cu1ksRTWr4gLdGMLBtmnr3
	Q/nVLj2x3BgIb3XN1EWxKrPTJxEkzt7TtBuaZCs6jDvIh++xBv7fOT78APzFQ1jy
	Tvwpeu9rx3JllAZeZByU8DfTlG8G6pJOPbMJ9VdaGc5z1ZecA9VBOF4aNaYpV/SR
	u5gSLoT2QYrILK14qidD14KMLP9vWh1ikybqETTUsKk6XRwepYwzO2SCUJdZyj5f
	lVvY8bGlTUOoaFwsvz8rHGVWhdd/dOkyLt4Gqzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JE9Pf+dIuvBMDyw467eQ/Tr4tyY4SBvJ9vbnWlDmBbU=:iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=;
X-ME-Sender: <xms:NN0Fa_Dh16pBjRQMtmAQtpYpz28UEZAAlNWef9QDlR230iNPWwpgaA>
    <xme:NN0FawWnt_cU2zPqxwlF3kn6lXR865LwUWDq-4TBjsqjqIqfahALCgQWW-0jyO7G3
    I2uTFidD6Jk0Jt_ZRZrrybQhsZmf0PkwLrG07cX5Ey9rp4FNHu-UqM>
X-ME-Proxy-Cause: dmFkZTFsQKpYLoHX3KE6zope7Xly27EYv6AQYyIF3Qau4aRC0vSHzWA0jMBeGZ/9+uCniy
    PTkF5Fmn4ClSCnUsMdxXtnQhtPNPNvOPsMvdctlUYyw6p+0jhYlfcnMwYC+ka8/fLSpuKw
    3YLhivPgri0MvBEeHeehNeV5wiFAsJv2bcNaHD7UboTSW+RjgcB42VuUlh1hahI0iQExPr
    +XuV8lAvetVw7YfrG+rkJKl9bl6k1+Pc6YG1mdIQsn8HBaASQD8dGrUNem4yjy4NNXFr2o
    l0vAJfxG5EW/9uTEMy9av1oYJYPAqHBvhuaThuRz9ZxrEhJBnZZaNefPyOfbd5a857jzji
    xS3AH0yNi27nlGbP2enOJqlf9wVeoOUs7OcWrHRUnaD4wGX3BucglKw1DWVVHUPxhfMt+c
    yYMsv9QYzlu0IncPWVnqsNMz+WiqY0HZprQifxi/zsPZ8ChkJiSCAB7jX698jdmSQw7t0Q
    wldIOTkPNxc4rzT0CMfulFrj4Rm5L/cie4t1IvZQrqsjE2CBRn8iUu7yiZ0dS2UrGJdlIv
    HMXP1d1uGpGRgLQ/rxCRTkol4EEsKGIX1Iz0tWkHIV/hA4OOaUelQC0/ml5S6Hx7O/VRRR
    HHsnZozZEW2a8iAqfQuYUL98uV7rqteWCN+bZ4WQQO+0dMzPuH8W8HlVGiTA
X-ME-Proxy: <xmx:PN0Fa_OfkSf0I2gz53d1q87MSYiyija7o2MtMOioAI-ZeTkir1jV5A>
    <xmx:PN0Fa6p4AcKgvKj7Nxl2i9GHjEd2VbenjcJEjgY_FbTxdjTIKHGJeg>
    <xmx:PN0Fa5WDuMRF3QKr7uInN4TtUt9GYOr8jpLSEeuwpRljz5xEyg6WqA>
    <xmx:PN0Fazu29G7Wm_IQCdCnlJY6WRkfF9-85rVjBcVYL-WZQOkOQNyjOA>
    <xmx:RN0Fa7HuB9LonHDmNq2kLPdcfAnhX1Syf3plWTxAvus5eCvT9QG1bsct>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4968232A0099; Tue, 24 Nov 2026 13:53:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: Ai76fMdDSoMo
Date: Tue, 24 Nov 2026 19:53:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <ljs@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Juergen Gross" <jgross@suse.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Shrikanth Hegde" <sshegde@linux.ibm.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Ryan Chen" <ryan_chen@aspeedtech.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Abel Vesa" <abelvesa@kernel.org>,
 "Jens Wiklander" <jenswi@kernel.org>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Scott Branden" <scott.branden@broadcom.com>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org
Message-Id: <3208cde3-c5cf-4888-88f7-c77d7b0e5940@app.fastmail.com>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
Subject: Re: [PATCH v2 08/13] soc: aspeed: convert LPC and P2A control mmap hooks to
 mmap_prepare
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026, at 15:02, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook for both
> the LPC control and P2A control drivers.
>
> Both remap a range of their reserved memory region, so use the PFN remap
> mmap action to do so, retaining the -EAGAIN error on failure via the action
> error override.
>
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

