Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57EF8B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Jul 2010 12:50:38 +1000 (EST)
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C2C8FA8.1030702@suse.de>
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
	<4C2C547E.7010404@redhat.com> <4C2C6745.8040001@suse.de>
	<4C2C78AC.3070605@redhat.com> <4C2C89D6.3090401@suse.de>
	<4C2C8D8A.7080103@redhat.com>  <4C2C8FA8.1030702@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Jul 2010 12:50:29 +1000
Message-ID: <1278039029.4200.372.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avi Kivity <avi@redhat.com>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-01 at 14:52 +0200, Alexander Graf wrote:
> Page ageing is difficult. The HTAB has a hardware set referenced bit,
> but we don't have a guarantee that the entry is still there when we look
> for it. Something else could have overwritten it by then, but the entry
> could still be lingering around in the TLB.
> 
> So I think the only reasonable way to implement page ageing is to unmap
> pages. And that's slow, because it means we have to map them again on
> access. Bleks. Or we could look for the HTAB entry and only unmap them
> if the entry is moot.

Well, not quite.

We -could- use the HW reference bit. However, that means that whenever
we flush the hash PTE we get a snapshot of the HW bit and copy it over
to the PTE.

That's not -that- bad for normal invalidations. However, it's a problem
potentially for eviction. IE. When a hash bucket is full, we
pseudo-randomly evict a slot. If we were to use the HW ref bit, we would
need a way to go back to the PTE from the hash bucket to perform that
update (or something really tricky like sticking it in a list somewhere,
and have the young test walk that list when non-empty, etc...)

Cheers,
Ben.
