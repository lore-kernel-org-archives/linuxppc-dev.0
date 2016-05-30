Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ8Kx4HvJzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:04:53 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Fix definition of SIAR and SDAR registers
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1463052404-18092-1-git-send-email-thuth@redhat.com>
 <20160513033546.GA22018@oak.ozlabs.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <574BF41F.4050305@redhat.com>
Date: Mon, 30 May 2016 10:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160513033546.GA22018@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.05.2016 05:35, Paul Mackerras wrote:
> On Thu, May 12, 2016 at 01:26:44PM +0200, Thomas Huth wrote:
>> The SIAR and SDAR registers are available twice, one time as SPRs
>> 780 / 781 (unprivileged, but read-only), and one time as the SPRs
>> 796 / 797 (privileged, but read and write). The Linux kernel code
>> currently uses the unprivileged  SPRs - while this is OK for reading,
>> writing to that register of course does not work.
>> Since the KVM code tries to write to this register, too (see the mtspr
>> in book3s_hv_rmhandlers.S), the contents of this register sometimes get
>> lost for the guests, e.g. during migration of a VM.
>> To fix this issue, simply switch to the privileged SPR numbers instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Acked-by: Paul Mackerras <paulus@ozlabs.org>

*ping*

Michael, could you please pick this patch up? I think it should rather
go through the generic powerpc tree instead of kvm-ppc, since it also
affects other parts than just KVM...

Thanks,
 Thomas
