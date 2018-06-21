Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2cB0Qz8zF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:28:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Walker <danielwa@cisco.com>,
 "Guilherme G. Piccoli" <guilherme@gpiccoli.net>, benh@kernel.crashing.org
Cc: Andrew Morton <akpm@linux-foundation.org>, xe-kernel@external.cisco.com,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Mauro Rodrigues <maurosr@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
In-Reply-To: <6d321d8a-432d-d41d-cc08-144764d644b2@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com>
 <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
 <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
 <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
 <6d321d8a-432d-d41d-cc08-144764d644b2@cisco.com>
Date: Thu, 21 Jun 2018 10:28:22 +1000
Message-ID: <87in6dvv89.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

Sorry we broke things for you.

Daniel Walker <danielwa@cisco.com> writes:
> On 06/19/2018 09:26 AM, Guilherme G. Piccoli wrote:
>>> [...]
>>> What your doing is changing the phb_id to some transformation of "reg" for
>>> all platforms except which have "ibm,opal-phbid". This is what we observe.
>>> This is a radical altering of the prior phb_id selection before your patch.
...
>
> I didn't look into changing the behavior on our side because it didn't 
> look like the intent of the patch was to make a global change. I can 
> take a look at changing this behavior on our side , given that this was 
> intended by your changes.

You're right the change log and the patch are a bit out of sync, that
was probably my fault.

> However, they're may be other platforms or drivers which depend on these 
> numbers getting set a certain way, so there may be other userspace 
> dependencies on these values.

That's true, though I think yours is the first report we've had of
problems.

The old behaviour relied on device tree ordering in nearly all cases, so
you basically get whatever order your firmware happened to flatten the
device tree in.

That tends to be consistent on a single system or with a single firmware
version, but it's not stable in general. If your firmware changes, or
you kexec then the ordering can change.

So I'd definitely prefer we didn't go back to that behaviour, because
it's basically "random order".

If there's anything you can do on your end to cope with the new ordering
that would be great.

cheers
