Return-Path: <bharata.rao@gmail.com>
Received: from mail-vn0-x229.google.com (mail-vn0-x229.google.com
 [IPv6:2607:f8b0:400c:c0f::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 329921A0CA4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:48:46 +1000 (AEST)
Received: by vnbf7 with SMTP id f7so1846211vnb.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2015 21:48:43 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 22 Jun 2015 10:18:43 +0530
Message-ID: <CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com>
Subject: powerpc,numa: Memory hotplug to memory-less nodes ?
From: Bharata B Rao <bharata.rao@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

While developing memory hotplug support in QEMU for PoweKVM, I
realized that guest kernel has specific checks to prevent hot addition
of memory to a memory-less node.

I am referring to arch/powerpc/mm/numa.c:hot_add_scn_to_nid() which
has explicit checks to ensure that it returns a nid that has some some
memory (NODE_DATA(nid)->node_spanned_pages) even when user wants to
hotplug to a node that currently has zero memory.

Is this limitation by design ?

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/
