Return-Path: <qemulist@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com
 [IPv6:2a00:1450:4010:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D8732C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 12:07:19 +1100 (EST)
Received: by mail-lb0-f171.google.com with SMTP id q8so3120877lbi.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2013 17:07:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131116070056.GB18339@iris.ozlabs.ibm.com>
References: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1384504501-19348-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131116070056.GB18339@iris.ozlabs.ibm.com>
From: liu ping fan <qemulist@gmail.com>
Date: Mon, 18 Nov 2013 09:06:54 +0800
Message-ID: <CAJnKYQnr5J5kEkj4YVnUYXa=vcU2qcLP9MNVXqXqKO6Qx5bMVg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: kvm: optimize "sc 1" as fast return
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Sat, Nov 16, 2013 at 3:00 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Fri, Nov 15, 2013 at 04:35:01PM +0800, Liu Ping Fan wrote:
>>
>> +sc_1_fast_return:
>> +     mtspr   SPRN_SRR0,r10
>> +     mtspr   SPRN_SRR1,r11
>> +     li      r10, BOOK3S_INTERRUPT_SYSCALL
>> +     li      r11, (MSR_ME << 1) | 1  /* synthesize MSR_SF | MSR_ME */
>> +     rotldi  r11, r11, 63
>
> You need a "mr r4, r9" instruction here, because fast_guest_return
> needs the vcpu pointer in r4.  Apart from that this looks fine.
>
Will fix it.

Thanks and regards,
Pingfan
>> +     b       fast_guest_return
>
> Paul.
