Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BC5FB7094
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Jul 2010 12:54:36 +1000 (EST)
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C2C9B36.8000002@redhat.com>
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
	<4C2C547E.7010404@redhat.com> <4C2C6745.8040001@suse.de>
	<4C2C78AC.3070605@redhat.com> <4C2C89D6.3090401@suse.de>
	<4C2C8D8A.7080103@redhat.com> <4C2C8FA8.1030702@suse.de>
	<4C2C9B36.8000002@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Jul 2010 12:54:29 +1000
Message-ID: <1278039269.4200.376.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Alexander Graf <agraf@suse.de>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-01 at 16:42 +0300, Avi Kivity wrote:
> > So I think the only reasonable way to implement page ageing is to
> unmap
> > pages. And that's slow, because it means we have to map them again
> on
> > access. Bleks. Or we could look for the HTAB entry and only unmap
> them
> > if the entry is moot.
> >    
> 
> I think it works out if you update struct page when you clear out an
> HTAB.

Hrm... going to struct page without going through the PTE might work out
indeed. We can get to the struct page from the RPN.

However, that means -reading- the hash entry we want to evict, and
that's a fairly expensive H-Call, especially if we ask phyp to
back-translate the real address into a logical (partition) address so we
can get to the struct page.... While we might be able to reconstitute
the virtual address from the hash content + bucket address. However,
from the vsid back to the page table might be tricky as well.

IE. Either way, it's not a simple process.

Now, eviction is rare, our MMU hash is generally big, so maybe the read
back with back translate to hit struct page might be the way to go here.

As for other kind of invalidations, we do have the PTE around when they
happen so we can go fetch the HW ref bit and update the PTE I suppose.

Ben.
