Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1637FC65BAF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 22:03:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7248320849
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH4eolPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7248320849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FW5t1wX1zDqN2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:03:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VH4eolPt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VH4eolPt"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FW2l62HSzDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 09:00:31 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w6so8955694pgl.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kH2NrjB5vcSca6qFFYtJujxGB4LhmIsrnFoTdHgon5M=;
 b=VH4eolPt04dVsVDV6BpqC0rdpE2bfn3G7MMdUYUIp0T7ZsyySM9SPJnkmF0sq86gvm
 MqqoErFrsrg8BH4+4EuCA8vOR8woekBaVzMPtDVQkcsLY2V0Wkg8396uD8qE9vLY688N
 Ty/9W5cbFHwyyio5O/HuxPwWYgNOeHpYJUNHS0l2f0pQydZqtIKx3b2Cj/Vnke8x/9Ry
 08Oc4Tn38xrsM2z9EFQq7+rIpg3E2VoEJwl2Ti6500JpZ28gKAzc2obSvnVGVI02xpPn
 S0WRJYPVeaOSx1hTH382AYO806ScowFifCoiicZy3eujQHH7GOoSW4Tgv4J7kfLF7Ugl
 j3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kH2NrjB5vcSca6qFFYtJujxGB4LhmIsrnFoTdHgon5M=;
 b=A2iVUR66p8EVyaLW18rNhhHr7HpxPtSW1UKl8i3Gu0NXPQ2WRVpk+RJTYcQ4YgEqdO
 e77a/wtyxmRLP1K7cK1GffdKVHADWGSbH6K2ETi7bhWOjg/VRlFPlGdHI8W3AyOnq0yp
 eM0lM7J689oGbTMBHh8Tev8OP9JsahoqlO9uUSboxGDNlhxs61gUmWbFasbr/bieE1yk
 OwJ5uhwy1xy2/tPzugxXHw+GQhXZbnKlNs2tzglUUNbHfLjWbbiEH0LVpFTlxCsL+8uH
 3yZo4jvoY9+n4xttznzCZSYBh5S1xZXjhM92hg4PaV+HQ0ytdCzbRMW5kxQQL+Ix5x28
 2rPQ==
X-Gm-Message-State: AA+aEWaHVZ+gkOB5r1efaSqzjdztqcXY961fJbYOlKClJMUbS0nr8yLZ
 v/noEjPhQyiECewOzvk/sqI=
X-Google-Smtp-Source: AFSGD/WlPIwm9wZ9L+sKgMNLwRVXtb9+cXuTsJgVWqvzrQf83De+U9OMf67GDCSGbjaI1vviCLkaRA==
X-Received: by 2002:a65:4ccb:: with SMTP id n11mr20179898pgt.257.1544652029523; 
 Wed, 12 Dec 2018 14:00:29 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id i184sm26778885pfc.41.2018.12.12.14.00.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 14:00:28 -0800 (PST)
Subject: Re: [PATCH v03] powerpc/mobility: Fix node detach/rename problem
To: Rob Herring <robh+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <a2d46622-a957-dffe-04d1-8087bbf0f8b5@linux.vnet.ibm.com>
 <871s6oxkdf.fsf@concordia.ellerman.id.au>
 <CAL_Jsq+t--486MiSsHnKcVy=q2wVvJgUmtAV6Vy2WwSNKymELA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <48aa028d-b786-7704-70ff-75a6d2321474@gmail.com>
Date: Wed, 12 Dec 2018 14:00:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+t--486MiSsHnKcVy=q2wVvJgUmtAV6Vy2WwSNKymELA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael Bringmann,

On 12/11/18 8:07 AM, Rob Herring wrote:
> On Tue, Dec 11, 2018 at 7:29 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Hi Michael,
>>
>> Please Cc the device tree folks on device tree patches, and also the
>> original author of the patch that added the code you're modifying.
>>
>> So I've added:
>>   robh+dt@kernel.org
>>   frowand.list@gmail.com
>>   devicetree@vger.kernel.org
>>   linux-kernel@vger.kernel.org
>>
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>> The PPC mobility code receives RTAS requests to delete nodes with
>>> platform-/hardware-specific attributes when restarting the kernel
>>> after a migration.  My example is for migration between a P8 Alpine
>>> and a P8 Brazos.   Nodes to be deleted include 'ibm,random-v1',
>>> 'ibm,platform-facilities', 'ibm,sym-encryption-v1', and,
>>> 'ibm,compression-v1'.
>>>
>>> The mobility.c code calls 'of_detach_node' for the nodes and their
>>> children.  This makes calls to detach the properties and to remove
>>> the associated sysfs/kernfs files.
>>>
>>> Then new copies of the same nodes are next provided by the PHYP,
>>> local copies are built, and a pointer to the 'struct device_node'
>>> is passed to of_attach_node.  Before the call to of_attach_node,
>>> the phandle is initialized to 0 when the data structure is alloced.
>>> During the call to of_attach_node, it calls __of_attach_node which
>>> pulls the actual name and phandle from just created sub-properties
>>> named something like 'name' and 'ibm,phandle'.
>>>
>>> This is all fine for the first migration.  The problem occurs with
>>> the second and subsequent migrations when the PHYP on the new system
>>> wants to replace the same set of nodes again, referenced with the
>>> same names and phandle values.
>>>
>>> On the second and subsequent migrations, the PHYP tells the system
>>> to again delete the nodes 'ibm,platform-facilities', 'ibm,random-v1',
>>> 'ibm,compression-v1', 'ibm,sym-encryption-v1'.  It specifies these
>>> nodes by its known set of phandle values -- the same handles used
>>> by the PHYP on the source system are known on the target system.
>>> The mobility.c code calls of_find_node_by_phandle() with these values
>>> and ends up locating the first instance of each node that was added
>>> during the original boot, instead of the second instance of each node
>>> created after the first migration.  The detach during the second
>>> migration fails with errors like,
>>>
>>> [ 4565.030704] WARNING: CPU: 3 PID: 4787 at drivers/of/dynamic.c:252 __of_detach_node+0x8/0xa0
>>> [ 4565.030708] Modules linked in: nfsv3 nfs_acl nfs tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag lockd grace fscache sunrpc xts vmx_crypto sg pseries_rng binfmt_misc ip_tables xfs libcrc32c sd_mod ibmveth ibmvscsi scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
>>> [ 4565.030733] CPU: 3 PID: 4787 Comm: drmgr Tainted: G        W         4.18.0-rc1-wi107836-v05-120+ #201
>>> [ 4565.030737] NIP:  c0000000007c1ea8 LR: c0000000007c1fb4 CTR: 0000000000655170
>>> [ 4565.030741] REGS: c0000003f302b690 TRAP: 0700   Tainted: G        W          (4.18.0-rc1-wi107836-v05-120+)
>>> [ 4565.030745] MSR:  800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22288822  XER: 0000000a
>>> [ 4565.030757] CFAR: c0000000007c1fb0 IRQMASK: 1
>>> [ 4565.030757] GPR00: c0000000007c1fa4 c0000003f302b910 c00000000114bf00 c0000003ffff8e68
>>> [ 4565.030757] GPR04: 0000000000000001 ffffffffffffffff 800000c008e0b4b8 ffffffffffffffff
>>> [ 4565.030757] GPR08: 0000000000000000 0000000000000001 0000000080000003 0000000000002843
>>> [ 4565.030757] GPR12: 0000000000008800 c00000001ec9ae00 0000000040000000 0000000000000000
>>> [ 4565.030757] GPR16: 0000000000000000 0000000000000008 0000000000000000 00000000f6ffffff
>>> [ 4565.030757] GPR20: 0000000000000007 0000000000000000 c0000003e9f1f034 0000000000000001
>>> [ 4565.030757] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> [ 4565.030757] GPR28: c000000001549d28 c000000001134828 c0000003ffff8e68 c0000003f302b930
>>> [ 4565.030804] NIP [c0000000007c1ea8] __of_detach_node+0x8/0xa0
>>> [ 4565.030808] LR [c0000000007c1fb4] of_detach_node+0x74/0xd0
>>> [ 4565.030811] Call Trace:
>>> [ 4565.030815] [c0000003f302b910] [c0000000007c1fa4] of_detach_node+0x64/0xd0 (unreliable)
>>> [ 4565.030821] [c0000003f302b980] [c0000000000c33c4] dlpar_detach_node+0xb4/0x150
>>> [ 4565.030826] [c0000003f302ba10] [c0000000000c3ffc] delete_dt_node+0x3c/0x80
>>> [ 4565.030831] [c0000003f302ba40] [c0000000000c4380] pseries_devicetree_update+0x150/0x4f0
>>> [ 4565.030836] [c0000003f302bb70] [c0000000000c479c] post_mobility_fixup+0x7c/0xf0
>>> [ 4565.030841] [c0000003f302bbe0] [c0000000000c4908] migration_store+0xf8/0x130
>>> [ 4565.030847] [c0000003f302bc70] [c000000000998160] kobj_attr_store+0x30/0x60
>>> [ 4565.030852] [c0000003f302bc90] [c000000000412f14] sysfs_kf_write+0x64/0xa0
>>> [ 4565.030857] [c0000003f302bcb0] [c000000000411cac] kernfs_fop_write+0x16c/0x240
>>> [ 4565.030862] [c0000003f302bd00] [c000000000355f20] __vfs_write+0x40/0x220
>>> [ 4565.030867] [c0000003f302bd90] [c000000000356358] vfs_write+0xc8/0x240
>>> [ 4565.030872] [c0000003f302bde0] [c0000000003566cc] ksys_write+0x5c/0x100
>>> [ 4565.030880] [c0000003f302be30] [c00000000000b288] system_call+0x5c/0x70
>>> [ 4565.030884] Instruction dump:
>>> [ 4565.030887] 38210070 38600000 e8010010 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
>>> [ 4565.030895] 7c0803a6 4e800020 e9230098 7929f7e2 <0b090000> 2f890000 4cde0020 e9030040
>>> [ 4565.030903] ---[ end trace 5bd54cb1df9d2976 ]---
>>>
>>> The mobility.c code continues on during the second migration, accepts
>>> the definitions of the new nodes from the PHYP and ends up renaming
>>> the new properties e.g.
>>>
>>> [ 4565.827296] Duplicate name in base, renamed to "ibm,platform-facilities#1"
>>>
>>> There is no check like 'of_node_check_flag(np, OF_DETACHED)' within
>>> of_find_node_by_phandle to skip nodes that are detached, but still
>>> present due to caching or use count considerations.  Also, note that
>>> of_find_node_by_phandle also uses a 'phandle_cache' which does not
>>> appear to be updated when of_detach_node() is invoked.
>>
>> This seems like the real bug. Since the phandle cache was added we can
>> now find detached nodes when we shouldn't be able to.
>>
>> Does the patch below work?
>>
>> cheers
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 09692c9b32a7..d8e4534c0686 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1190,6 +1190,10 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>                 if (phandle_cache[masked_handle] &&
>>                     handle == phandle_cache[masked_handle]->phandle)
>>                         np = phandle_cache[masked_handle];
>> +
>> +               /* If we find a detached node, remove it */
>> +               if (of_node_check_flag(np, OF_DETACHED))
>> +                       np = phandle_cache[masked_handle] = NULL;

The bug you found exposes a couple of different issues, a little bit
deeper than the proposed fix.  I'll work on a fuller fix tonight or
tomorrow.


> I'm wondering if we should explicitly remove the node from the cache
> when we set OF_DETACHED. Otherwise, it could be possible that the node
> pointer has been freed already. Or maybe we need both?

Yes, it should be explicitly removed.  I may also add in a paranoia check in
of_find_node_by_phandle().

-Frank

> 
> Rob
> 

