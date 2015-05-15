Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 621801A042B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 01:58:52 +1000 (AEST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 15 May 2015 16:58:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C3D717D805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 16:59:35 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4FFwkIA10093002
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:58:46 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4FFweC5021317
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:58:45 -0600
Message-ID: <555617AE.9030508@de.ibm.com>
Date: Fri, 15 May 2015 17:58:38 +0200
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
 linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.vnet.ibm.com>,
 Nadav Amit <namit@cs.technion.ac.il>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
 jan.kiszka@siemens.com, Mihai Caraman <mihai.caraman@freescale.com>,
 bp@suse.de, Gleb Natapov <gleb@kernel.org>, r65777@freescale.com,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Farman <farman@linux.vnet.ibm.com>, linux-api@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>, dahi@linux.vnet.ibm.com,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 15.05.2015 um 16:27 schrieb Alex Bennée:
> index ef1a5fc..aca4f86 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -114,8 +114,6 @@ struct kvm_fpu {
>  	__u64 fprs[16];
>  };
> 
> -#define KVM_GUESTDBG_USE_HW_BP		0x00010000
> -


> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 70ac641..7c5dd11 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[...]
> +#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
> +#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)

This is a abi break for s390, no?

David do you remember why we did not use SW_BP?
