Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8E606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4tXb1x6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKpLC0Tqpz2xNC;
	Thu, 05 Nov 2026 14:52:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793850770;
	cv=none; b=Y2l2jLu9AA8crrxfC2pyMGheXsXRyQFSbX1Bu+ebVstNIyan1sbmVmy5chMaA0GLZA3pnasaLfrBp7/+RAqo5OyMAaGlTpA+JpB99KcGyhPUADnI4mvVET5YmqL/yhmnK6w+6Wo97NY93+PaGpn6IiqZpsPmuu4i6ovbKHekKx0dl1biYVfkVPfA6J+GyE6kYVbjT0L8zMtn1UtL/sl/Pj1jllE+1RpuMMXVBsYXa037B0O2FI9i76fXd5gmcED4A7KuXREauoWvEYYnsWCBpPR/Gw/jcymh8yXnDia30yiIoDlfPjyRe+CVI1e0QaPScsd3oIih1vEiCYMXikrzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793850770; c=relaxed/relaxed;
	bh=6bdNkQDjGlIQCQFekmGTbct/uYcQnh6+aY3rXTFb1Wo=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=RZ0d1AGy/Jj8V7QwLSfcn7IkUo71k4IsVgSxU+ErLoCy92glgfdgHoXUA6xfrqui7+va+dj5UXVjWI4QEMOyryv3c0OKzjEKcVYmRL6yIf1D2peVrZaT0s6UDxyUy65pZBZXD3aw5yGnewPXAI4PQP4dlG9/P8Ds34m8fwLXeHIBAaH8/hk0T67hgKEKp5++eSLzgZ5NHdwFVAYahfKbUUNyK8tuWjNUTlROFDFu91TFepuxLUZBydwVT4bfely+Z1nKEYRvUlQWoX08ksJWzN/035zgH9eeKDYTyOjzWvyubSDjSZksqdOm3DHPswqz5D2UQ3Ez70/9JpgRQB53rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4tXb1x6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4tXb1x6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKpLB14t3z2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 14:52:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 701BD43CD1;
	Thu,  5 Nov 2026 03:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1361F000C1;
	Thu,  5 Nov 2026 03:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793850767;
	bh=6bdNkQDjGlIQCQFekmGTbct/uYcQnh6+aY3rXTFb1Wo=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=Q4tXb1x61oMdBxzIXLfiJIaOsBuDwwcKPOBYp9IneQWrl13rT7tyiWIh3AT/e2vAr
	 oLkGg4OSMiX6eLdXBO6xBIjkcewQxuo+7nW1Sp6XSCY3oTxDkYRvelrMk1p0P09aj6
	 r16u4vRK38AW/ApZPb42Qdvcy5vFZTr8sygMkOF3hA8bcwRqtxz2tM5WCDaXVjTWfT
	 hUnE7RPJ5PScGNNabnriNdG8/EeYtEgT1Z3MViiOGwLkYv8u0vL9yoDuFi/vDqjkId
	 vkYhh1P9CWr8ihSozQqE6IJIKenwy9PJWW0a4OSknuQigltStuU3BLiER6UWa4i1hH
	 L1kQUQ8fbxe9Q==
To: davemarq@linux.ibm.com
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  "Martin K. Petersen"
 <mkp@kernel.org>,  Tyrel Datwyler <tyreld@linux.ibm.com>,
  linux-scsi@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 00/13] scsi: ibmvfc: make ibmvfc support FPIN messages
From: "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
Message-ID: <yq18q38ym3n.fsf@mail.kernel.org>
References: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
Date: Wed, 04 Nov 2026 22:52:46 -0500
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
Content-Type: text/plain
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Dave,

A malformed patch 12 in this series meant Sashiko failed to apply it and
therefore could not provide feedback.

We are getting close. However, a manually triggered analysis identifies
lingering issues in patches 6, 9, and 13.

-- 
Martin K. Petersen

