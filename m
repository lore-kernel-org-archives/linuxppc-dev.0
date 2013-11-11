Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x235.google.com (mail-qc0-x235.google.com
 [IPv6:2607:f8b0:400d:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16D3A2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 12:02:11 +1100 (EST)
Received: by mail-qc0-f181.google.com with SMTP id w4so3664023qcr.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Nov 2013 17:02:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131108105837.GC16470@iris.ozlabs.ibm.com>
References: <1383895794-16164-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131108105837.GC16470@iris.ozlabs.ibm.com>
Date: Mon, 11 Nov 2013 09:02:07 +0800
Message-ID: <CAFgQCTvsf45r74vZmhX5v2XQ0c3UwnQ6hwDvzN6H1tSETOOugQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] powerpc kvm: fix deadlock scene
From: Liu ping fan <kernelfans@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 8, 2013 at 6:58 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Fri, Nov 08, 2013 at 03:29:52PM +0800, Liu Ping Fan wrote:
>> v2->v3:
>>   introduce kvmppc_hv_unlock_hpte() to pair with kvmppc_hv_find_lock_hpte()
>>   and hide the preemption detail inside this pair from the callers
>
> Actually, I preferred v2.  This version seems a bit over-engineered.
>
> Making a kvmppc_hv_unlock_hpte() is not such a bad idea, though I
> would make it identical to the existing unlock_hpte() from

Do you think it is helpful to distingusish HPTE_V_LOCK from
HPTE_V_HVLOCK at an API level?
If it is, I will keep patch 1/2 and just fix patch 2/2 .

> book3s_hv_rm_mmu.c, just in a header.  I'm really not convinced about
> putting the preempt_disable/enable inside the lock/unlock functions,
> with the consequent need to pass in a 'vmode' parameter, given that
> there is just one caller that needs to do the preempt_disable/enable.
>
Ok, will fix patch 2/2

Thanks and regards,
Pingfan
