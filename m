Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2BAB1A0239
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:30:25 +1000 (EST)
Message-ID: <1401971411.3247.132.camel@pasglop>
Subject: Re: [PATCH 3/3] PPC: KVM: Add support for 64bit TCE windows
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 05 Jun 2014 22:30:11 +1000
In-Reply-To: <53905ADB.8000100@suse.de>
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
 <1401953144-19186-4-git-send-email-aik@ozlabs.ru>
 <1401953908.3247.121.camel@pasglop> <539037DB.5080706@ozlabs.ru>
 <1401964037.3247.129.camel@pasglop> <53905ADB.8000100@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Gleb Natapov <gleb@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-05 at 13:56 +0200, Alexander Graf wrote:
> What if we ask user space to give us a pointer to user space allocated 
> memory along with the TCE registration? We would still ask user space to 
> only use the returned fd for TCE modifications, but would have some 
> nicely swappable memory we can store the TCE entries in.

That isn't going to work terribly well for VFIO :-) But yes, for
emulated devices, we could improve things a bit, including for
the 32-bit TCE tables.

For emulated, the real mode path could walk the page tables and fallback
to virtual mode & get_user if the page isn't present, thus operating
directly on qemu memory TCE tables instead of the current pinned stuff.

However that has a cost in performance, but since that's really only
used for emulated devices and PAPR VIOs, it might not be a huge issue.

But for VFIO we don't have much choice, we need to create something the
HW can access.

> In fact, the code as is today can allocate an arbitrary amount of pinned 
> kernel memory from within user space without any checks.

Right. We should at least account it in the locked limit.

Cheers,
Ben.
