Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D38EC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 04:33:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BD52081D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 04:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9oy6RxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BD52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pKYc2XjQzDrbn
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:33:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U9oy6RxB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U9oy6RxB"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pKVq6zsxzDrPv;
 Mon,  5 Nov 2018 15:30:59 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id n11-v6so5541658iob.6;
 Sun, 04 Nov 2018 20:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6f4HzEcQHkXLdpE+UQYYVVeJh0oGUjZz6dQyOYyyyJo=;
 b=U9oy6RxBa7Pz2W6/bFUJ3wRTeKcv0RVCSR31L2rZoFasj1dCXs797uG1/tTLxE2qCr
 KULznv91PNUB5RQ9inrKH91LYFOCyeLRQC6uFq8ERgAkEwM/0wvo/Tw4nAxgKDUe2cJS
 VB51v97MQ1rjqGnU57o57O+JJ25UC2CVetdN6BB0gF3imDNDimFftyUXMpEE3DEEuR1m
 EqQWmXapqU75sfdw8hOM7JRlxB9+QqrWs1u8fxMbe56DE5ECn6NTIaHrLY7WJj+JTRSP
 skLjqRwOVVfQQOflfoj1yCTHDyfQMQ7aOUb2cYTZ+eWhew1BsFAAGhYrOzXuSuH4TCyO
 iTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6f4HzEcQHkXLdpE+UQYYVVeJh0oGUjZz6dQyOYyyyJo=;
 b=cWCwk12Ba1bXkvRPF88Sx25/pFAfKXIIDA9PDolnwbL4mToMrSu0maM7INWCHzLgQ9
 Jvo0zqUpByM2kLHGS+7nfqzyVdZgZrVUnwQZKBvvjc9iIOFvDKX4E3uob3P5oz8+Nyxq
 t56dBDCBDHryePSBWaVOXDvkKyMve4eGDMnl5ZxUeet+qaeAlzHSUQVfElxOtp/sxdAv
 J/TV7KeyibQ/BPdZWHCZC8zf8fwf1dYswEi0trD4+UXuVw2WmSzqhg78vXNN5AgyXv48
 2AClFW+rRm0L3jK2wtyN97twk6yE7B3lx/suYdhkzh5rfap/SqkMVzLdwa1nXulCmtKX
 SC3A==
X-Gm-Message-State: AGRZ1gI1/K6AjapShfVM199XRl+hjF/krzZOYL3ivJLsxNu7RzfdWSDA
 G7LftJU/PypmojcnjNH5p5smyGLdAW+1npb+vU0Yq0+t
X-Google-Smtp-Source: AJdET5fcWwaNhniBecvy4XiJuN7AP1SgWFdIKZ3WspccYANiEO3ja94/SihYWjCLjCvJ2njDA1ifSdGD+c8or5lktZ8=
X-Received: by 2002:a6b:f115:: with SMTP id
 e21-v6mr15422273iog.271.1541392255416; 
 Sun, 04 Nov 2018 20:30:55 -0800 (PST)
MIME-Version: 1.0
References: <81e9a13c-3f8e-41bb-4aae-c7680817dbd3@yadro.com>
In-Reply-To: <81e9a13c-3f8e-41bb-4aae-c7680817dbd3@yadro.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 5 Nov 2018 15:30:43 +1100
Message-ID: <CAOSf1CEAqOgekkz3iq53n2mcn0MqFAUp1rbTAHdyDBFgajFpBw@mail.gmail.com>
Subject: Re: [Skiboot] Important details about race condition in
 EEH/NVMe-issue on ppc64le.
To: d.koltsov@yadro.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: a.senichev@yadro.com, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 s.kachkin@yadro.com, m.polyakov@yadro.com,
 skiboot list <skiboot@lists.ozlabs.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 1:28 AM Koltsov Dmitriy <d.koltsov@yadro.com> wrote:
>
> Hello.
>
> There is an EEH/NVMe-issue on SUT ppc64le POWER8-based server Yadro VESNIN (with minimum 2 NVMe disks) with
> Linux OS kernel 4.15.17/4.15.18/4.16.7 (OS - Ubuntu 16.04.5 LTS(hwe)/18.04.1 LTS or Fedora 27).
>
> The issue is described here -
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=db2173198b9513f7add8009f225afa1f1c79bcc6
>
> I've already had some discussion about it with IBM and now we know about suggested workaround (above).

Given this is a linux issue the discussion should go to linuxppc-dev
(+cc) directly rather than the skiboot list.

> But for know there are imho several important facts that remained "uncovered" in this discussion.
>
> The facts are that -
>
> 1) We found out that main reason of the issue is near evolution process of vanilla linux kernel taken as a base
> for Ubuntu releases, namely - the issue is not reproducible till Linux v.4.11 vanilla release (01.05.2017) and becomes
> reproducible from the closest release - Linux v.4.12-rc1 (13.05.2017). Further research showed that there is the commit
> responsible for appearance of the issue - its name is "Merge tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci",
> see https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?id=857f8640147c9fb43f20e43cbca6452710e1ca5d.
> More definitely - there are only two patches (of author Yongji Xie, in this commit) which enable the issue - they are:
>
> "PCI: Add pcibios_default_alignment() for arch-specific alignment control",
> see https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?id=0a701aa6378496ea54fb065c68b41d918e372e94
>
> and
> "powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned"
> see https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?id=382746376993cfa6d6c4e546c67384201c0f3a82.
>
> If we remove the code strings of these patches from 4.15.18 kernel in Ubuntu 18.04.1 LTS (or in OS Fedora 27) - the issue disappears and
> everything, regarding EEH/NVMe-issue, works fine.
>
> 2) Finally, we found out the exact point in kernel source which begins the abnormal behaviour during boot process and starts the sequence
> with EEH/NVMe-issue symptoms - stacktraces like show below
>
> [   16.922094] nvme 0000:07:00.0: Using 64-bit DMA iommu bypass
> [   16.922164] EEH: Frozen PHB#21-PE#fd detected
> [   16.922171] EEH: PE location: S002103, PHB location: N/A
> [   16.922177] CPU: 97 PID: 590 Comm: kworker/u770:0 Not tainted 4.15.18.ppc64le #1
> [   16.922182] nvme 0000:08:00.0: Using 64-bit DMA iommu bypass
> [   16.922194] Workqueue: nvme-wq nvme_reset_work [nvme]
> [   16.922198] Call Trace:
> [   16.922208] [c00001ffb07cba10] [c000000000ba5b3c] dump_stack+0xb0/0xf4 (unreliable)
> [   16.922219] [c00001ffb07cba50] [c00000000003f4e8] eeh_dev_check_failure+0x598/0x5b0
> [   16.922227] [c00001ffb07cbaf0] [c00000000003f58c] eeh_check_failure+0x8c/0xd0
> [   16.922236] [c00001ffb07cbb30] [d00000003c443970] nvme_reset_work+0x398/0x1890 [nvme]
> [   16.922240] nvme 0022:04:00.0: enabling device (0140 -> 0142)
> [   16.922247] [c00001ffb07cbc80] [c000000000136e08] process_one_work+0x248/0x540
> [   16.922253] [c00001ffb07cbd20] [c000000000137198] worker_thread+0x98/0x5f0
> [   16.922260] [c00001ffb07cbdc0] [c00000000014100c] kthread+0x1ac/0x1c0
> [   16.922268] [c00001ffb07cbe30] [c00000000000bca0] ret_from_kernel_thread+0x5c/0xbc.
>
>
>
> and part of nonseen NVMe-disks in /dev/-tree. This point is in nvme_pci_enable() function in readl()-execution string -
>
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/tree/drivers/nvme/host/pci.c?id=Ubuntu-4.15.0-29.31#n2088.
>
> When 64K alignment is not set by the Yongji Xie patch, this point is handled successfully. But when the 64K alignment is set from this patch,
> those readl() execution give us 0xffffffff inside the code execution of this function (inside eeh_readl()) - in_le32() returns 0xffffffff here -
>
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/tree/arch/powerpc/include/asm/eeh.h?id=Ubuntu-4.15.0-29.31#n379.
>
> 3) Btw, from linux kernel documentation we know that for pci error recovery technique -
>
> "STEP 0: Error Event
> -------------------
> A PCI bus error is detected by the PCI hardware.  On powerpc, the slot is isolated, in that all I/O is blocked: all reads return 0xffffffff,
> all writes are ignored."
>
> Also we know that 2)step-readl() gets virtual address of NVME_REG_CSTS register. I suppose that this readl() operation concerns to MMIO
> read mechanism. And in the same kernel documentation there are some explanation -
>
>                CPU                  CPU                  Bus
>              Virtual              Physical             Address
>              Address              Address               Space
>               Space                Space
>
>             +-------+             +------+             +------+
>             |       |             |MMIO  |   Offset    |      |
>             |       |  Virtual    |Space |   applied   |      |
>           C +-------+ --------> B +------+ ----------> +------+ A
>             |       |  mapping    |      |   by host   |      |
>   +-----+   |       |             |      |   bridge    |      |   +--------+
>   |     |   |       |             +------+             |      |   |        |
>   | CPU |   |       |             | RAM  |             |      |   | Device |
>   |     |   |       |             |      |             |      |   |        |
>   +-----+   +-------+             +------+             +------+   +--------+
>             |       |  Virtual    |Buffer|   Mapping   |      |
>           X +-------+ --------> Y +------+ <---------- +------+ Z
>             |       |  mapping    | RAM  |   by IOMMU
>             |       |             |      |
>             |       |             |      |
>             +-------+             +------+
>
>
> "During the enumeration process, the kernel learns about I/O devices and
> their MMIO space and the host bridges that connect them to the system.  For
> example, if a PCI device has a BAR, the kernel reads the bus address (A)
> from the BAR and converts it to a CPU physical address (B).  The address B
> is stored in a struct resource and usually exposed via /proc/iomem.  When a
> driver claims a device, it typically uses ioremap() to map physical address
> B at a virtual address (C).  It can then use, e.g., ioread32(C), to access
> the device registers at bus address A."
>
> So, we can conclude from this scheme and readl() execution string above that
> readl() execution must step through C->B->A path from virtual address to physical and then
> to bus address. I've added printk strings to some places in linux kernel, like nvme_dev_map()
> and so, to check the physical memory allocations, virtual memory allocations, and ioremap()
> results. Everything is ok in printk outputs even when EEH/NVMe-issue is reproduced.
>
> Hence, the hypothesis of EEH/NVMe-issue is in the B->A mapping which must be done,
> regarding the scheme above, - by PHB3 on POWER8 chip. When alignment=0, this process
> works fine, but with alignment=64K - this translation to bus addresses reproduce EEH/NVMe-issue,
> when more than one NVMe-disk are enabled in parallel with pcie bridge. Based on another commit
> but for phb4 - "phb4: Only clear some PHB config space registers on errors"
>
> https://github.com/open-power/skiboot/commit/5a8c57b6f2fcb46f1cac1840062a542c597996f9
>
> i suppose that the main reason may be in race in skiboot mechanism (or like firmware/hardware), which
> frequently doesn't have enough time for B->A translation when alignment is ON and =64K -
> i.e. in some entity which implement the pcie logic according to B->A translation with align=64K
> (may be bound with coherent cache layer).
>
> Question. Could you comment this hypothesis ? Is it far from to be true from your point of view ?
> May be this letter is enough to start the research in this direction to find the exact reason of
> mentioned EEH/NVMe-issue ?

Hi there,

So I spent a fair amount of time debugging that issue and I don't
really see anything here that suggests there is some kind of
underlying translation issue. To elaborate, the race being worked
around in db2173198b95 is due to this code inside
pci_enable_device_flags():

         if (atomic_inc_return(&dev->enable_cnt) > 1)
                 return 0;               /* already enabled */

If two threads are probing two different PCI devices with a common
upstream bridge they will both call pci_enable_device_flags() on their
common bridge (e.g. pcie switch upstream port). Since it uses an
atomic increment only one thread will attempt to enable the bridge and
the other thread will return from the function assuming the bridge is
already enabled. Keep in mind that a bridge will always forward PCI
configuration space accesses so the remainder of the PCI device enable
process will succeed and the 2nd thread well return to the driver
which assumes that MMIOs are now permitted since the device is
enabled. If the first thread has not updated the PCI_COMMAND register
of the upstream bridge to allow forwarding of memory cycles then any
MMIOs done by the 2nd thread will result in an Unsupported Request
error which invokes EEH.

To my eye, everything you have mentioned here is completely consistent
with the underlying cause being the bridge enable race. I don't know
why the BAR alignment patch would expose that race, but I don't see
any reason to believe there is some other address translation issue.

> (btw, i understand that another reason may be in the format of memory allocated for pcie resources
> and its concrete field values. But according to things said above - i precisely tend to the hypothesis above).
>
>
>
>
> ps: there are some other insteresting facts about experiments with this EEH/NVMe-issue - like for
> example - this issue is not reproducible with CONFIG_PCIEASPM='y' (in kernel config), which is always set
> to 'y' when CONFIG_PCIEPORTBUS='y' (D3hot, D3cold actions with some pauses in the appropriate
> ASPM code may give necessary time for B->A translation).

As brief look at pci_device_enable() and friends suggests that
additional work happens in the enable step when ASPM is enabled which
helps mask the bridge enable race.

>
> Regards,
> Dmitriy.
> _______________________________________________
> Skiboot mailing list
> Skiboot@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/skiboot
