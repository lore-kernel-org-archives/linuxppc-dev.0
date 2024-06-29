Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C20FC27C4F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jun 2024 07:31:01 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=UM9dRey6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WB3rM0mmSz3cdD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jun 2024 17:30:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=UM9dRey6;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WB3qX0c5Jz3c1L
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2024 17:30:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719646213;
	bh=QL/ulRF3WQDUZh0765KisZheh8Z7kRGyVfR1QZjKE0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UM9dRey6OYS6I3j0jXoaVgyR3dKW8lp+23A2Qys7IHzs8rnBzw8pe5v9kofWowwyN
	 sXYtVBTn9XUe4WUNNwdnK0jJw5y3JceECvcCT9Hg3NR+7T6V1tdEidNZUbk2p68i80
	 w9G67/N3wkquXFKoJNlOQdJLTpKnguw9fexo8LNYoTxlZG2qeina5jRGev7VitRAxt
	 GdItJ2E5xwsjsxCk08Z5LuGMoa66fyQ8QzJ/ZmMJNMaBhciqUrEuSit2i9l3CJVKzy
	 BCsCOHSOIYyzAxMHmQnP+/iTX4+lQzjgfm/dtPIdgccequb6lcRYgTAHhmTieUCXWS
	 1e2HoFl80vQpQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WB3qS5J2Zz4w2P;
	Sat, 29 Jun 2024 17:30:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shawn Anastasio <sanastasio@raptorengineering.com>, Krishna Kumar
 <krishnak@linux.ibm.com>, npiggin@gmail.com
Subject: Re: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
In-Reply-To: <76a154af-bd69-44f4-a6d8-e569b0890878@raptorengineering.com>
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
 <20240624121052.233232-2-krishnak@linux.ibm.com>
 <888d3984-d00e-4148-a1ca-f7887c0af413@raptorengineering.com>
 <87msn5llkv.fsf@mail.lhotse>
 <76a154af-bd69-44f4-a6d8-e569b0890878@raptorengineering.com>
Date: Sat, 29 Jun 2024 17:30:10 +1000
Message-ID: <875xtskxz1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: nathanl@linux.ibm.com, gbatra@linux.ibm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, brking@linux.vnet.ibm.com, tpearson@raptorengineering.com, oohall@gmail.com, bhelgaas@google.com, mahesh.salgaonkar@in.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shawn Anastasio <sanastasio@raptorengineering.com> writes:
> Hi Michael,
>
> On 6/27/24 11:48 PM, Michael Ellerman wrote:
>> Was the panic reported anywhere? So we can link to the report in the
>> commit.
>
> It was indeed -- here is the link to the thread from last December:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2023-December/267034.html

Thanks.

cheers
