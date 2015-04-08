Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 091E61A0BB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 15:39:58 +1000 (AEST)
Received: by iedfl3 with SMTP id fl3so74191733ied.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2015 22:39:56 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1428464944.4947.69.camel@kernel.crashing.org>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
 <1428464944.4947.69.camel@kernel.crashing.org>
Date: Tue, 7 Apr 2015 22:39:55 -0700
Message-ID: <CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in
 of parsing
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2015 at 8:49 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2015-04-07 at 17:24 -0700, Yinghai Lu wrote:
>> For device resource PREF bit setting under bridge 64-bit pref resource,
>> we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
>> for 64bit resource during of device resource flags parsing.
>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
>
> These patches (from the above BZ) aren't right for one thing: You
> shouldn't set the IORESOURCE_PREFETCH in the resource itself. This
> *will* break stuff.
>
> You can put the resource in a prefetchable region indeed, if you
> are on a PCIe-only path (though we should have some arch flag
> to check that the host bridge indeed doesn't do any prefetch,
> on powerpc we are good there).

The patch is at:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=1a3ec5e7b00dcd9cac24efe3d65bfccf82597ce5

and we limit to set pref bit for pcie end devices mmio 64bit resource.

>
> But you can't set the "prefetch" bit on the resource because that would
> be losing the indication that this resource has side effects. This bit
> is used in some cases to enable store gathering when mmap'ing via sysfs
> and can be used for similar uses by drivers.

Any pointer for that?

>
> It's one thing to say "you can put non-prefetch BARs in prefetch windows
> on that path", it's another one to completely make the BAR looks like
> it's prefetchable when it's not.

Too hard for me to tell the difference.

        Yinghai
