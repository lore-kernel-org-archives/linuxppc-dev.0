Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90936C7618B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 12:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1AC206E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 12:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1AC206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xzkg1DGRzDqBK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 22:38:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xzgs1mBvzDq9G
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 22:36:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45xzgq1LHkz9s7T;
 Mon, 29 Jul 2019 22:36:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, Qian Cai <cai@lca.pw>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/imc: Dont create debugfs files for cpu-less
 nodes
In-Reply-To: <b1d6a06f-5f3b-d887-27cf-ba8c0255c4b0@linux.vnet.ibm.com>
References: <20190702092112.4015-1-maddy@linux.vnet.ibm.com>
 <87d0ihgojp.fsf@concordia.ellerman.id.au> <1563216075.4610.3.camel@lca.pw>
 <b1d6a06f-5f3b-d887-27cf-ba8c0255c4b0@linux.vnet.ibm.com>
Date: Mon, 29 Jul 2019 22:36:06 +1000
Message-ID: <87o91dyq4p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> Hi Qian,
>
> On 7/16/19 12:11 AM, Qian Cai wrote:
>> On Thu, 2019-07-11 at 14:53 +1000, Michael Ellerman wrote:
>>> Hi Maddy,
>>>
>>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>>> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c
>>>> b/arch/powerpc/platforms/powernv/opal-imc.c
>>>> index 186109bdd41b..e04b20625cb9 100644
>>>> --- a/arch/powerpc/platforms/powernv/opal-imc.c
>>>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>>>> @@ -69,20 +69,20 @@ static void export_imc_mode_and_cmd(struct device_=
node
>>>> *node,
>>>>  =C2=A0	if (of_property_read_u32(node, "cb_offset", &cb_offset))
>>>>  =C2=A0		cb_offset =3D IMC_CNTL_BLK_OFFSET;
>>>>=20=20=20
>>>> -	for_each_node(nid) {
>>>> -		loc =3D (u64)(pmu_ptr->mem_info[chip].vbase) + cb_offset;
>>>> +	while (ptr->vbase !=3D NULL) {
>>> This means you'll bail out as soon as you find a node with no vbase, but
>>> it's possible we could have a CPU-less node intermingled with other
>>> nodes.
>>>
>>> So I think you want to keep the for loop, but continue if you see a NULL
>>> vbase?
>> Not sure if this will also takes care of some of those messages during t=
he boot
>> on today's linux-next even without this patch.
>>
>>
>> [=C2=A0=C2=A0=C2=A018.077780][=C2=A0=C2=A0=C2=A0=C2=A0T1] debugfs: Direc=
tory 'imc' with parent 'powerpc' already
>> present!
>>
>>
>
> This is introduced by a recent commit: c33d442328f55 (debugfs: make=20
> error message a bit more verbose).
>
> So basically, the debugfs imc_* file is created per node, and is created=
=20
> by the first nest unit which is
>
> being registered. For the subsequent nest units, debugfs_create_dir()=20
> will just return since the imc_* file already
>
> exist.
>
> The commit "c33d442328f55 (debugfs: make error message a bit more=20
> verbose)", prints
>
> a message if the debugfs file already exists in debugfs_create_dir().=20
> That is why we are encountering these
>
> messages now.
>
>
> This patch (i.e, powerpc/imc: Dont create debugfs files for cpu-less=20
> nodes) will address the initial issue, i.e
>
> "numa crash while reading imc_* debugfs files for cpu less nodes", and=20
> will not address these debugfs messages.
>
>
> But yeah this is a good catch. We can have some checks to avoid these=20
> debugfs messages.
>
>
> Hi Michael,
>
> Do we need to have a separate patch to address these debugfs messages,=20
> or can we address the same
>
> in the next version of this patch itself?

No, please do one logical change per patch.

cheers
