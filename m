Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE25F21917
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE25F21917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44177j39MyzDqYS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 20:22:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44175c17dzzDqdS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 20:20:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44175c00NYz9sDL; Fri, 15 Feb 2019 20:20:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 44175Y4lb9z9s7h;
 Fri, 15 Feb 2019 20:20:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
In-Reply-To: <CA+7wUszvErrmyo9jAuPk0dtvwKd3cw4jSb04z5Q4DkGEjGiY7w@mail.gmail.com>
References: <20190215061400.20302-1-mpe@ellerman.id.au>
 <CA+7wUszvErrmyo9jAuPk0dtvwKd3cw4jSb04z5Q4DkGEjGiY7w@mail.gmail.com>
Date: Fri, 15 Feb 2019 20:20:16 +1100
Message-ID: <87pnrtcsrz.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, Meelis Roos <mroos@linux.ee>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> writes:
> On Fri, Feb 15, 2019 at 7:14 AM Michael Ellerman <mpe@ellerman.id.au> wro=
te:
>>
>> GCC 8 warns about the logic in vr_get/set(), which with -Werror breaks
>> the build:
>>
>>   In function =E2=80=98user_regset_copyin=E2=80=99,
>>       inlined from =E2=80=98vr_set=E2=80=99 at arch/powerpc/kernel/ptrac=
e.c:628:9:
>>   include/linux/regset.h:295:4: error: =E2=80=98memcpy=E2=80=99 offset [=
-527, -529] is
>>   out of the bounds [0, 16] of object =E2=80=98vrsave=E2=80=99 with type=
 =E2=80=98union
>>   <anonymous>=E2=80=99 [-Werror=3Darray-bounds]
>>   arch/powerpc/kernel/ptrace.c: In function =E2=80=98vr_set=E2=80=99:
>>   arch/powerpc/kernel/ptrace.c:623:5: note: =E2=80=98vrsave=E2=80=99 dec=
lared here
>>      } vrsave;
>>
>> This has been identified as a regression in GCC, see GCC bug 88273.
>
> Good point, this does not seems this will be backported.
>
>> However we can avoid the warning and also simplify the logic and make
>> it more robust.
>>
>> Currently we pass -1 as end_pos to user_regset_copyout(). This says
>> "copy up to the end of the regset".
>>
>> The definition of the regset is:
>>         [REGSET_VMX] =3D {
>>                 .core_note_type =3D NT_PPC_VMX, .n =3D 34,
>>                 .size =3D sizeof(vector128), .align =3D sizeof(vector128=
),
>>                 .active =3D vr_active, .get =3D vr_get, .set =3D vr_set
>>         },
>>
>> The end is calculated as (n * size), ie. 34 * sizeof(vector128).
>>
>> In vr_get/set() we pass start_pos as 33 * sizeof(vector128), meaning
>> we can copy up to sizeof(vector128) into/out-of vrsave.
>>
>> The on-stack vrsave is defined as:
>>   union {
>>           elf_vrreg_t reg;
>>           u32 word;
>>   } vrsave;
>>
>> And elf_vrreg_t is:
>>   typedef __vector128 elf_vrreg_t;
>>
>> So there is no bug, but we rely on all those sizes lining up,
>> otherwise we would have a kernel stack exposure/overwrite on our
>> hands.
>>
>> Rather than relying on that we can pass an explict end_pos based on
>> the sizeof(vrsave). The result should be exactly the same but it's
>> more obviously not over-reading/writing the stack and it avoids the
>> compiler warning.
>>
>
> maybe:
>
> Link: https://lkml.org/lkml/2018/8/16/117

Hmm, I prefer not to include links because they're unlikely to last
forever like the git history.

If we do include them the preferred form is a link to lkml.kernel.org
using the message id. That way the message is recorded and also the link
is "guaranteed" to work in future, eg:

http://lkml.kernel.org/r/alpine.LRH.2.21.1808161041350.16413@math.ut.ee

In this case I don't think the link adds much over what I have in the
change log, in particular I did credit Meelis as the reporter.

> In any case the warning is now gone:
>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Thanks.

cheers

>> Reported-by: Meelis Roos <mroos@linux.ee>
>> Reported-by: Mathieu Malaterre <malat@debian.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
