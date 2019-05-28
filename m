Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB9C04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 05:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630202070D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 05:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630202070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Cj0y6p8NzDqMx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 15:23:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Chyj0NpTzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 15:21:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45Chyh0C8Tz9s9T;
 Tue, 28 May 2019 15:21:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kmemleak: 1157 new suspected memory leaks (see
 /sys/kernel/debug/kmemleak)
In-Reply-To: <CA+7wUsw_jkgWfknXbpK7_yfy=S5Y0jvQe1KP3kM-LT8fFnUF5g@mail.gmail.com>
References: <CA+7wUsw_jkgWfknXbpK7_yfy=S5Y0jvQe1KP3kM-LT8fFnUF5g@mail.gmail.com>
Date: Tue, 28 May 2019 15:21:14 +1000
Message-ID: <87tvdfp31x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> writes:
> Hi there,
>
> Is there a way to dump more context (somewhere in of tree
> flattening?). I cannot make sense of the following:

Hmm. Not that I know of.

Those don't look related to OF flattening/unflattening. That's just
sysfs setup based on the unflattened device tree.

The allocations are happening in safe_name() AFAICS.

int __of_add_property_sysfs(struct device_node *np, struct property *pp)
{
	...
	pp->attr.attr.name = safe_name(&np->kobj, pp->name);

And the free is in __of_sysfs_remove_bin_file():

void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop)
{
	if (!IS_ENABLED(CONFIG_SYSFS))
		return;

	sysfs_remove_bin_file(&np->kobj, &prop->attr);
	kfree(prop->attr.attr.name);


There is this check which could be failing leading to us not calling the
free at all:

void __of_remove_property_sysfs(struct device_node *np, struct property *prop)
{
	/* at early boot, bail here and defer setup to of_init() */
	if (of_kset && of_node_is_attached(np))
		__of_sysfs_remove_bin_file(np, prop);
}


So maybe stick a printk() in there to see if you're hitting that
condition, eg something like:

	if (of_kset && of_node_is_attached(np))
		__of_sysfs_remove_bin_file(np, prop);
	else
		printk("%s: leaking prop %s on node %pOF\n", __func__, prop->attr.attr.name, np);


cheers

> kmemleak: 1157 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>
> Where:
>
> # head -40 /sys/kernel/debug/kmemleak
> unreferenced object 0xdf44d180 (size 8):
>   comm "swapper", pid 1, jiffies 4294892297 (age 4766.460s)
>   hex dump (first 8 bytes):
>     62 61 73 65 00 00 00 00                          base....
>   backtrace:
>     [<0ca59825>] kstrdup+0x4c/0xb8
>     [<c8a79377>] kobject_set_name_vargs+0x34/0xc8
>     [<661b4c86>] kobject_add+0x78/0x120
>     [<c1416f27>] __of_attach_node_sysfs+0xa0/0x14c
>     [<2a143d10>] of_core_init+0x90/0x114
>     [<a353d0e1>] driver_init+0x30/0x48
>     [<84ed01b1>] kernel_init_freeable+0xfc/0x3fc
>     [<dc60f815>] kernel_init+0x20/0x110
>     [<faa1c5b0>] ret_from_kernel_thread+0x14/0x1c
> unreferenced object 0xdf44d178 (size 8):
>   comm "swapper", pid 1, jiffies 4294892297 (age 4766.460s)
>   hex dump (first 8 bytes):
>     6d 6f 64 65 6c 00 97 c8                          model...
>   backtrace:
>     [<0ca59825>] kstrdup+0x4c/0xb8
>     [<0eeb0a3b>] __of_add_property_sysfs+0x88/0x12c
>     [<f6c64af0>] __of_attach_node_sysfs+0xcc/0x14c
>     [<2a143d10>] of_core_init+0x90/0x114
>     [<a353d0e1>] driver_init+0x30/0x48
>     [<84ed01b1>] kernel_init_freeable+0xfc/0x3fc
>     [<dc60f815>] kernel_init+0x20/0x110
>     [<faa1c5b0>] ret_from_kernel_thread+0x14/0x1c
> unreferenced object 0xdf4021e0 (size 16):
>   comm "swapper", pid 1, jiffies 4294892297 (age 4766.460s)
>   hex dump (first 16 bytes):
>     63 6f 6d 70 61 74 69 62 6c 65 00 01 00 00 00 00  compatible......
>   backtrace:
>     [<0ca59825>] kstrdup+0x4c/0xb8
>     [<0eeb0a3b>] __of_add_property_sysfs+0x88/0x12c
>     [<f6c64af0>] __of_attach_node_sysfs+0xcc/0x14c
>     [<2a143d10>] of_core_init+0x90/0x114
>     [<a353d0e1>] driver_init+0x30/0x48
>     [<84ed01b1>] kernel_init_freeable+0xfc/0x3fc
>     [<dc60f815>] kernel_init+0x20/0x110
>     [<faa1c5b0>] ret_from_kernel_thread+0x14/0x1c
