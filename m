Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 129FD1A04A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 01:42:52 +1000 (AEST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 15 May 2015 16:42:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5F99E17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 16:43:36 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4FFgkIv10748280
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:42:46 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4FFgiMX021877
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:42:46 -0600
Message-ID: <555613F2.9060204@de.ibm.com>
Date: Fri, 15 May 2015 17:42:42 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 christoffer.dall@linaro.org, marc.zyngier@arm.com,
 peter.maydell@linaro.org, agraf@suse.de, drjones@redhat.com,
 pbonzini@redhat.com, zhichao.huang@linaro.org
Subject: Re: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
In-Reply-To: <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 S390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>,
 Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
 jan.kiszka@siemens.com, Mihai Caraman <mihai.caraman@freescale.com>,
 bp@suse.de, Gleb Natapov <gleb@kernel.org>, r65777@freescale.com,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Farman <farman@linux.vnet.ibm.com>, ABI/API <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>, dahi@linux.vnet.ibm.com,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, S390 <linux390@de.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 15.05.2015 um 16:27 schrieb Alex Bennée:
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -114,8 +114,6 @@ struct kvm_fpu {
>  	__u64 fprs[16];
>  };
> 
> -#define KVM_GUESTDBG_USE_HW_BP		0x00010000
[...]
> +++ b/include/uapi/linux/kvm.h
[...]
> +#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
> +#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)

This is an ABI break for s390, no?

David, do you remember why we do not use KVM_GUESTDBG_USE_SW_BP?
