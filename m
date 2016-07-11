Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpBP46mTzzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 03:07:52 +1000 (AEST)
Subject: Re: [PATCH V2 3/5] kvm/ppc/book3s_hv: Implement halt polling in the
 kvm_hv kernel module
To: David Matlack <dmatlack@google.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-3-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=cUiiQ=OW=qKZ=J1jOC2KUoA8HeD2P_y_4odfkjCMJ-fw@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org,
 kvm list <kvm@vger.kernel.org>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78e920ba-b596-5475-ff30-0dd2c23d97b6@redhat.com>
Date: Mon, 11 Jul 2016 19:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <CALzav=cUiiQ=OW=qKZ=J1jOC2KUoA8HeD2P_y_4odfkjCMJ-fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/07/2016 18:57, David Matlack wrote:
> On Mon, Jul 11, 2016 at 12:08 AM, Suraj Jitindar Singh
> <sjitindarsingh@gmail.com> wrote:
> > This patch introduces new halt polling functionality into the kvm_hv kernel
> > module. When a vcore is idle it will poll for some period of time before
> > scheduling itself out.
> 
> Is there any way to reuse the existing halt-polling code? Having two
> copies risks them diverging over time.

s/risks/guarantees/ :(

Unfortunately, handling of the hardware threads in KVM PPC is a mess,
and I don't think it's possible to remove the duplication.

Paolo
