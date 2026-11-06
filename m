Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368C606A330
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2m6k6Gq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLZrc0ZnMz2xPb;
	Fri, 06 Nov 2026 21:18:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793960303;
	cv=none; b=h4axXLrsxI5E+maLeH7lw72l2fuZmptURWbwL5Wai3Igvvlxc672bRxpe+oXj00npzTRT/zInXT5r1HfI3PwcC+9CvIzO1jkARuW9KWVkEgS0wcnPEMzDqUJa69fbqC7fje0nOLqallA0W3nzD7k7c9tBf+qqfE/ArCymih2lhdAiW8FWCCiEZ/65MEN8leMN1fPptVIz999D0CYt9d5TKOe2e5shcJlUwm51iqBUPH3189MwHHuQrELQPUwQcw9K1vG+YUEUwbv6+eVPu4hIkKnpGuxDyKRKfLS6Kouu0y2BnWW2gEg0xVxKtRljZSVPLPME6b96z+HK2/U3tL/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793960303; c=relaxed/relaxed;
	bh=WRJXIR3G73/bAoeCrNJcFgak4mvp+3ngQ+qpnIKUqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLebWebaDKzQs4IQ8iCQBb4oE+nbaoyWE50SgKXL04bVeMUCKz7nQK2FnJdZD/AZGuvwroEJHTy6cFDXqIvniLk2KcF2Sp+jhftvxgd65Yw+K/+VbNcNxcamUU0meDBMr6x5B3kLHw0eeMB4PenX/BA6KRRrG/ur6NPrKOe6OvgzQjN1hE5vuzZpfIR2w5e4tcW62KW8B3PIUewhfUIrqbVrtu0XEKyYJsMbKCZ0GlngnkVGLHFboAmzC+efKuEhB0G8p+q8n7Zjly//Qg6UTXV/uIGx93kBj1vaxxUbJsBpCabKmmgr/oVkv1v/UQug6x/uJDOsvc3RYrRBgefoPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2m6k6Gq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2m6k6Gq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLZrZ64jyz2xJR;
	Fri, 06 Nov 2026 21:18:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C69A601BF;
	Fri,  6 Nov 2026 10:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFC01F0089F;
	Fri,  6 Nov 2026 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960300;
	bh=WRJXIR3G73/bAoeCrNJcFgak4mvp+3ngQ+qpnIKUqWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l2m6k6GqXZKAI6ai2Tun1aF46awXpI/z2hhpm9C9mWFFrwb28EgYdeM12++TFdXHC
	 tZPDcNtqorI1JgQeh4d/V0oUoA8wTmUuwUWJnczsn3SnNHjwPhjBcdo7A1YGDV2mTG
	 KcYpC48NxWmRQWs88tJMsCh3bVG0uv6meLjHSwr1ICrXX3Vw/iw6HMzgoNOlCZ+Cr/
	 4yqxl3LXfTuCElZyaokutxEyEknbHWSUP2DCjtT8OlSb46KYExKXDg1tVpuuXc3j/i
	 oBl8kAvxU+cGtuwjokkyklXwgQ5yXoGFuePAoE1OqzN7B+weZmt4UCKvb6LGDNbMBE
	 27H/f4pFzu1cw==
Date: Fri, 6 Nov 2026 10:18:06 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
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
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to
 mmap_prepare
Message-ID: <au2odtvEhpLJY4eD@gremlin>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:12:09PM -0500, Paul Moore wrote:
> On Thu, Nov 5, 2026 at 4:06 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > Continue the conversion of users of the deprecated f_op->mmap callback to
> > f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> > cases.
> >
> > No functional change intended.
> >
> > Build tested on x86-64 (allmodconfig, each patch individually), i386,
> > arm64 and ppc64le.
> >
> > <<>>
> >
> > David, Andrew - I wonder whether one of you guys could take this series
> > through your tree? Since it's kernel-wide it seems sensible to take it
> > through an mm tree.
>
> Granted I've only properly looked at the SELinux patch (7/14), the
> rest I've just skimmed through, but these are all independent patches,
> right?  Is there any reason why individual subsystem maintainers
> shouldn't just pick up their associated patch?  Yes, perhaps chasing
> down individual maintainers is a bit more work, but isn't that the way
> this should work?

I've no objection to people taking patches independently, the concern is people
lagging on that and holding up a key conversion which is entirely mechanical, +
generally tree-wide stuff like this has been via the mm tree.

The mmap_prepare stuff is actually important for security (pertinent given
current AI fix storm) as it's by design super locked down vs. mmap which has
caused several genuine issues including a nasty 0-day.

So am keen to keep that rolling!

In this case each patch is mechanical and simple, so little surface area for
issues.

--
Cheers, Lorenzo

