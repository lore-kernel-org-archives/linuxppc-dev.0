Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F49F1A1D1F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 07:13:32 +1000 (AEST)
Message-ID: <55A81E75.5030200@redhat.com>
Date: Thu, 16 Jul 2015 23:13:25 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>
CC: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/1] KVM: PPC: Book3S: correct width in XER handling
References: <edf0cbb1d82070438f6b03f55e35347ef996503d.1432684609.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <edf0cbb1d82070438f6b03f55e35347ef996503d.1432684609.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/2015 01:56 AM, Sam Bobroff wrote:
> In 64 bit kernels, the Fixed Point Exception Register (XER) is a 64
> bit field (e.g. in kvm_regs and kvm_vcpu_arch) and in most places it is
> accessed as such.
> 
> This patch corrects places where it is accessed as a 32 bit field by a
> 64 bit kernel.  In some cases this is via a 32 bit load or store
> instruction which, depending on endianness, will cause either the
> lower or upper 32 bits to be missed.  In another case it is cast as a
> u32, causing the upper 32 bits to be cleared.
> 
> This patch corrects those places by extending the access methods to
> 64 bits.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>

Actually this patch also fixes a bug that SLOF sometimes crashes when a
vCPU gets kicked out of kernel mode (see the following URL for details:
https://bugzilla.redhat.com/show_bug.cgi?id=1178502 ), and I've just
tested that this bug does not occur with this patch anymore, so also:

Tested-by: Thomas Huth <thuth@redhat.com>
