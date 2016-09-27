Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjqc522M2zDrSv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 15:47:33 +1000 (AEST)
Date: Tue, 27 Sep 2016 15:45:33 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Alexander Graf <agraf@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3s PR: Allow access to unprivileged MMCR2
 register
Message-ID: <20160927054533.3azixxy77bh6v3om@oak.ozlabs.ibm.com>
References: <1474463205-5965-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474463205-5965-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2016 at 03:06:45PM +0200, Thomas Huth wrote:
> The MMCR2 register is available twice, one time with number 785
> (privileged access), and one time with number 769 (unprivileged,
> but it can be disabled completely). In former times, the Linux
> kernel was using the unprivileged register 769 only, but since
> commit 8dd75ccb571f3c92c ("powerpc: Use privileged SPR number
> for MMCR2"), it uses the privileged register 785 instead.
> The KVM-PR code then of course also switched to use the SPR 785,
> but this is causing older guest kernels to crash, since these
> kernels still access 769 instead. So to support older kernels
> with KVM-PR again, we have to support register 769 in KVM-PR, too.
> 
> Fixes: 8dd75ccb571f3c92c48014b3dabd3d51a115ab41
> Cc: stable@vger.kernel.org # v3.10+
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to kvm-ppc-next.

Paul.
