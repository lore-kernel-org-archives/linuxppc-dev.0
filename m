Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s78MV1d9yzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 17:35:18 +1000 (AEST)
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s78MT2Rmlz9t0F
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 17:35:17 +1000 (AEST)
Date: Mon, 8 Aug 2016 17:35:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 19/21] powerpc: Add option to use jump label for
 mmu_has_feature()
Message-ID: <20160808173503.58ce7571@kryten>
In-Reply-To: <20160808105953.718262f8@kryten>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-19-git-send-email-mpe@ellerman.id.au>
 <20160808105953.718262f8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> This patch causes an oops when building with the gold linker:

Found the problem. On binutils .meminit.text is within _stext/_etext:

  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 3] .meminit.text     PROGBITS        c000000000989d14 999d14 00225c 00  AX  0   0  4

c000000000990000 R _etext

But on gold it is not:

c000000000970000 A _etext

  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 3] .meminit.text     PROGBITS        c000000000970bcc 980bcc 002220 00  AX  0   0  4

As a result kernel_text_address() returns false, and
__jump_label_update() fails to update:

    if (entry->code && kernel_text_address(entry->code))
            arch_jump_label_transform(entry, jump_label_type(entry));

Seems like we get the correct layout on binutils by luck and we
need to explicitly handle .meminit.text.

Anton
