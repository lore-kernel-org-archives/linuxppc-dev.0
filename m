Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9156CB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:18:55 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1277507817-626-2-git-send-email-agraf@suse.de>
Date: Sat, 26 Jun 2010 01:18:50 +0200
Message-Id: <9E1A7E61-031C-4B5E-B4E5-833F78CD8C20@suse.de>
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.06.2010, at 01:16, Alexander Graf wrote:

> Currently the shadow paging code keeps an array of entries it knows about.
> Whenever the guest invalidates an entry, we loop through that entry,
> trying to invalidate matching parts.
> 
> While this is a really simple implementation, it is probably the most
> ineffective one possible. So instead, let's keep an array of lists around
> that are indexed by a hash. This way each PTE can be added by 4 list_add,
> removed by 4 list_del invocations and the search only needs to loop through
> entries that share the same hash.
> 
> This patch implements said lookup and exports generic functions that both
> the 32-bit and 64-bit backend can use.

Yikes - I forgot -n.

This is patch 1/2.


Alex
