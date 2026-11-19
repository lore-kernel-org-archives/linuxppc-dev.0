Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C160A5BCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYXclQdv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVjFt3c9Tz2xLF;
	Fri, 20 Nov 2026 02:34:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795102498;
	cv=none; b=N1OuzUBTobO1an6vGIXVXVfZYmdr7wzHZIZD31+4LkvavIR2QaotpRrHD6TOWZ9y4AIJI6x47n6i1+C++HNBgiQHpsGiEvUXo6dnNeIpKe1tmV1mQg5CXdmA7vExb+xOQvhsxpn1dNLMTcvOMX0NdmfMeeUzldVc9HiU4sG0dDuVjclRt1rXvlzGkTrzlZTH+Bx7sksCGsQKIDYKizLBXssLbwvh0AU7hAEqgsiVQLx9fPyKYTqpKtWLYVnXfRUy7cP0O5X5XoznMCELJbgmNiXycu7XhUF4SS/NRmJVmOM5nE3wcWBZa6t4X/f0gNvMb/sEbLbKhPhGan+KbpWA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795102498; c=relaxed/relaxed;
	bh=APdHxhVevbSPgpurjsZdo42O+VpO7Vh8nV06rY8boD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwDYDvHlvS7h5+zFk2bSZuhQTXt0Ywk8bA8btSBtsXkaxBS40vKZ/s15Zcqwg1dm/qLGJdcJNt81E9T4xf23q9tTW4mzMMSPz8WmM8/nhKCM5jWWibbWCGIxFBUypsxhZ3Vb8R83lxtWY9dA8JuU6GDrLphBqW2ek0eQFWpXIEfWAHP8EtvXvwNR5L1aqBpIv1BnrfGrQC4t9cKhe7kQz8MXn5yAAOt9r2lq9i+70aclGXEN5GqsKmnShaJpgpBs9pGmrNH5HrukmMRkz8wRui0XUrHlvS9zGSUuE+3vBgwc4JWRw9vN5819tkh2dGTL044hSDoiqH7VOzs/bnGidg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYXclQdv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYXclQdv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVjFr3M5gz2xGr;
	Fri, 20 Nov 2026 02:34:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C36B2444AA;
	Thu, 19 Nov 2026 15:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB681F000D2;
	Thu, 19 Nov 2026 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102492;
	bh=APdHxhVevbSPgpurjsZdo42O+VpO7Vh8nV06rY8boD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SYXclQdv+b2ige8985m5EUIy/JLoQxmabD6L38JETBlbyWyOxafAyDnLaHlFuiZzI
	 /kleeHI2fRI6NlzXJQ+01EHgKqPnrnWz2GxHUPBkmWq8xGnEhcqswjtufMMr/JVuVd
	 Oim6b/4sspvRWabq5lRrDi7ieeWfcppAjZwnNFriQGxgZJKPjQ+ITgzNBkJeLjptSm
	 CTkKZeFxoBR+bIZ90Rq28z+bZEO3fqgYVpxkcjnPYAi5DmrrR+9PwiAVnTogrtm68z
	 UT9kNPLjCKpIduy7cFAblizPGwX/paLojDgejUv3m13aRTjQL6aa4KuAJwRT+HywIe
	 ifbBCB27Cbtkw==
Date: Thu, 19 Nov 2026 15:34:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] vhost-vdpa: convert mmap hook to mmap_prepare
Message-ID: <av8VB40ncsb5yEtr@gremlin>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
 <20261119100450-mutt-send-email-mst@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119100450-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:05:05AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 05, 2026 at 09:05:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> > Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> > only validates the request and sets the VMA flags, operations and page
> > protection.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
>
> feel free to merge with rest of this.

Thanks, sorry I missed your previous mail re: merging, I think ideally best
merged together!

--
Cheers, Lorenzo

