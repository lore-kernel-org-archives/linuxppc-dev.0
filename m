Return-Path: <linuxppc-dev+bounces-17933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B76FCA193
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:30:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV9CB6x76z2xNg;
	Tue, 10 Mar 2026 08:29:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773091798;
	cv=none; b=SYj79oBa7ZMAklkP4DAj7pL/wI74C8jqRVQkV52rCEexdr/l9BOD59vfZ1OVbGhW0jn4W1/nE3GT2wcF4vJ1gnqDZ/bkW8GKOUYivh6EJzjZsq8aPG0Ghz7a18Cdz+L5QuJiOblcCoRqd065qvovKYl3gfSiw3LKLHh+m4O0dODCLI9WqtGkUO2kh+SOTORQv7FeDdFlSFEinV6cF1FwGeZNB+M3rasskYjjjeIsDICyUcLaFVqL/CowLaWiSDXc6+sYqfYfjFWgbTmwzHpciy95pRyVDYxdhYW0re3KVVmeLYuPhux+fCDfeXbnkLO5noo+0ADElPxyi1AmDwEsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773091798; c=relaxed/relaxed;
	bh=Unk5TXwNJ12dMyo6ATnk7erekYuL2aFoAUQmE/QsUto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRQztH+vl8RTRDl34NBUXZ0eI8o493N6ObLFP0dqWvhqGEw1Vg9pC/JOJYOGD9GaxwASJYyXDKzy1py1A+XgyOS1slJWy0pi7zqsEY0NqOX3xT8hFtBVna0GUQU3THl3PEa+nN5MkISsgO/fLbFV6QUdFdKe4rOIc+lzfNtBvCAkm3mUYAxrBb5WYHTlCB9pLBOuljvVMYQIk/nB8xg93VbFKKvS8miuQBPMvq2/7+uMReU7tfpgKetPiS6l8DUDSqE76iAqkn8E4bDxrIz5EDeM9natll/FSYjYIFRT94EGJQcw4vGP8uCIsN4f72KflV1VL7uluyMvLmWB7b6uXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f3/uicOT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f3/uicOT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV9CB0CB4z2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 08:29:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DCE4F416D3;
	Mon,  9 Mar 2026 21:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6059C4CEF7;
	Mon,  9 Mar 2026 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091795;
	bh=dlZ+cYzjAVo9R0VWTOYYhJLvWL2hlTOrad+GmSBnVSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3/uicOTsDKsMaKy7R9/QUtYshUxWJBEDQwtzxfFYZSOYp7emjBBTyp8sACuA41ZA
	 uFsGingtwi4ZiWmLejlxSqNUNkNjw0whzlDh+lCbwMs55wI53/YT1Ff55j5rftp6o8
	 oOrwNy0ee74jJWtZQbwM9TrIfiZrkgU3VAO6WCMPwrogviRRnIDsz2jXaiwdXTArip
	 BUHMPgdDsJNuVgfrO91jO0Ue3qKjSl2/hysZ/hpLXypw3NvAf6W0ThbXJWgjEE6KbB
	 fi8jmiRwgeznkfplbkcSANyKgAHU4JnbCic2pM968DnfoezBirmtWFcFwsvpUbx59O
	 XpdOdy9PYrhUw==
Date: Mon, 9 Mar 2026 14:29:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Coiby Xu <coxu@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] integrity: avoid using __weak functions
Message-ID: <20260309212947.GA4150408@ax162>
References: <20260306150421.270124-1-arnd@kernel.org>
 <20260306225648.GC2746259@ax162>
 <abb4d186d1ca76c080d5e15bcd9e0019cce3af39.camel@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb4d186d1ca76c080d5e15bcd9e0019cce3af39.camel@linux.ibm.com>

On Sun, Mar 08, 2026 at 09:01:58PM -0400, Mimi Zohar wrote:
> Thanks Arnd, Nathan. LGTM.  Nathan, could you send a patch with a proper patch
> description.

Done, thanks for the input!

  https://lore.kernel.org/20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org/

Cheers,
Nathan

