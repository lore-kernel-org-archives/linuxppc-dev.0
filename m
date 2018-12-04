Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253A4C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:18:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB5F2082B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB5F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438bpg4YrPzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 09:18:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=namei.org
 (client-ip=65.99.196.166; helo=namei.org; envelope-from=jmorris@namei.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=namei.org
X-Greylist: delayed 898 seconds by postgrey-1.36 at bilbo;
 Wed, 05 Dec 2018 09:15:29 AEDT
Received: from namei.org (namei.org [65.99.196.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438blj4mzqzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 09:15:29 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by namei.org (8.14.4/8.14.4) with ESMTP id wB4Lxkjh022787;
 Tue, 4 Dec 2018 21:59:46 GMT
Date: Wed, 5 Dec 2018 08:59:45 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v8 00/14] Appended signatures support for IMA appraisal
In-Reply-To: <20181116200712.14154-1-bauerman@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812050855270.22148@namei.org>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-doc@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>,
 "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 16 Nov 2018, Thiago Jung Bauermann wrote:

> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.
> Since the kernel image on Power servers is an ELF binary, kernels are
> signed using the scripts/sign-file tool and thus use the same signature
> format as signed kernel modules.
> 
> This patch series adds support in IMA for verifying those signatures.

Are you saying you use IMA to verify kernels during boot?  From a Linux 
bootloader?

> It adds flexibility to OpenPOWER secure boot, because it allows it to boot
> kernels with the signature appended to them as well as kernels where the
> signature is stored in the IMA extended attribute.

Just to clarify, with these patches, IMA will be able to verify the 
native form of signed kernel modules?  i.e. without xattrs at all, and 
this will work with existing signed modules?



-- 
James Morris
<jmorris@namei.org>

