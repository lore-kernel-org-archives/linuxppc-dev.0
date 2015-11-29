Return-Path: <geyslan@gmail.com>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com
 [IPv6:2607:f8b0:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C16901A07BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 07:14:05 +1100 (AEDT)
Received: by vkca188 with SMTP id a188so35614588vkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2015 12:14:03 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 29 Nov 2015 17:14:03 -0300
Message-ID: <CAGG-pUS04iVsi3s4hkB8goWkCM3sq+QiLw7L74bbef93Z=+qwg@mail.gmail.com>
Subject: [RFC] kvm - possible out of bounds
From: =?UTF-8?Q?Geyslan_Greg=C3=B3rio_Bem?= <geyslan@gmail.com>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I have found a possible out of bounds reading in
arch/powerpc/kvm/book3s_64_mmu.c (kvmppc_mmu_book3s_64_xlate
function). pteg[] array could be accessed twice using the i variable
after the for iteration. What happens is that in the last iteration
the i index is incremented to 16, checked (i<16) then confirmed
exiting the loop.

277    for (i=0; i<16; i+=2) { ...

Later there are reading attempts to the pteg last elements, but using
again the already incremented i (16).

303    v = be64_to_cpu(pteg[i]);  /* pteg[16] */
304    r = be64_to_cpu(pteg[i+1]); /* pteg[17] */

I really don't know if the for lace will somehow iterate until i is
16, anyway I think that the last readings must be using a defined max
len/index or another more clear method.

Eg.

    v = be64_to_cpu(pteg[PTEG_LEN - 2]);
    r = be64_to_cpu(pteg[PTEG_LEN - 1]);

Or just.

    v = be64_to_cpu(pteg[14]);
    r = be64_to_cpu(pteg[15]);

----------------------------

I found in the same file a variable that is not used.

380    struct kvmppc_vcpu_book3s *vcpu_book3s;
...
387    vcpu_book3s = to_book3s(vcpu);

-----------------------------

A question, the kvmppc_mmu_book3s_64_init function is accessed by
unconventional way? Because I have not found any calling to it.

If something that I wrote is correct please tell me if I could send the patch.

-- 
Regards,

Geyslan G. Bem
hackingbits.com
