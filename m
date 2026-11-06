Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955B606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L33pwgZS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLgZ15WcKz2xJR;
	Sat, 07 Nov 2026 00:51:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793973065;
	cv=none; b=eNma/IjoCywN8A6Wtb+PQ6SMTNaoFIaVFCAUb7gBLB+BFQZwRgxbXDubaI0XN0YutqMrRe1LvNw1XyQhGWjAHmjJlREOkCUY1ihJ7dGxNg4+fDHZSa67qhePsYm+ooK1roHQfi+XDz0kAdZv+eyf3CgKauVJZo4wYdunyArj0ZmDi12jLIxZ/C3YjJpRfpkgfDLmumro3h4FOnh/ZkenswZvpUrtVmmYHMuRTO6heVpe1aHbwBUAXFCKMA696pndVPPj3MQaHKTOqX1XqcsgcKDMU4JCYLWbEHGnOFQM7PtfFRXVoJl1WBBsyvuorxgt8JwkOcS04B7spfX+YjfI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793973065; c=relaxed/relaxed;
	bh=SvbdRNqL/8qCTDSGCTb8M0taIrstvBniNfZYFufgM5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8jIBYCPw8KLCMDLRcqeyh6/533BTqVpFQIY0sZ1Zli4SCaMC94RcOpp+Vf+PQxhQn+HrQatTDlufLUWudSWHHN++nohqh6fbK+OXBQ74qxn6hV060K2aG2nZdqpn0Howwxml0TzfHuVUsF7SQH1Rf3JJPPilJRCCndpb4/pmtMHiK+PCxP79peRvJdv5Rcps5qW18As2wDO2iuIYj5xclKHs8l1F8AeRN8N86VFCNQzuhMsnkel6qEFGLM3w+Huv20J6b0DCHYEz2Nh+fX90AX0RG7XDLIRWoaE3oOkG4FZXwZaw+YKUBKxzbwdnGoYujMwqgrCYBa1ZgqPUlvPaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L33pwgZS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L33pwgZS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jLgZ05XC4z2xDD;
	Sat, 07 Nov 2026 00:51:04 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 0C2E5601BF;
	Fri,  6 Nov 2026 13:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 257841F0089F;
	Fri,  6 Nov 2026 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973061;
	bh=SvbdRNqL/8qCTDSGCTb8M0taIrstvBniNfZYFufgM5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L33pwgZSVggirArZ13tgig1B1UCQKbjbxP46ClHAA2P14xrsBYu6ITrSuDWxD75nm
	 951iQE/lYInSkLK7zdv01x692IZ8EISZoenRxG8xR7Tk2E4p6mjAl59/Ld/fabYaci
	 0O0y4X0ZqJB89xAkdhFcg47FJX/vGN9YxDmynA2wfSj58zxVe28UDKojH8xPKB9pkm
	 JrmLw6sGmd3K1zoXLZ0badUqpxNhCbLlgu742muYZwUmimGIDQRTbhteYmZgvMqpeS
	 Vw7E7CJ3LK4waVWLimdiYEbfq546n85vZyX7ijnIUWr58UPgYMuJVskiiDeWqRCa4Y
	 8e/9k+FsTIHQw==
Date: Fri, 6 Nov 2026 15:50:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Cochran <richardcochran@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to
 mmap_prepare
Message-ID: <au3bQYYHRxR9VRfh@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
 <au2odtvEhpLJY4eD@gremlin>
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
In-Reply-To: <au2odtvEhpLJY4eD@gremlin>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:18:06AM +0000, Lorenzo Stoakes (ARM) wrote:
> > Granted I've only properly looked at the SELinux patch (7/14), the
> > rest I've just skimmed through, but these are all independent patches,
> > right?  Is there any reason why individual subsystem maintainers
> > shouldn't just pick up their associated patch?  Yes, perhaps chasing
> > down individual maintainers is a bit more work, but isn't that the way
> > this should work?
> 
> I've no objection to people taking patches independently, the concern is people
> lagging on that and holding up a key conversion which is entirely mechanical, +
> generally tree-wide stuff like this has been via the mm tree.

This is probably the best way forward, as for a subsystem this is just a
different API for doing the exact same thing (and that way "idempotent").

And looking at the intersection points overall, the changes are neither
likely to cause any major merge conflicts...

Br, Jarkko

