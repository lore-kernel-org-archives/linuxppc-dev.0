Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52485C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:05:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D171C21907
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D171C21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wg5w0SxyzDqVR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg2n254PzDqVT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:02:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wg2m71Qzz9sBZ;
 Fri,  8 Feb 2019 14:02:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64s: Work around spurious warning on old gccs
 with -fsanitize-coverage
In-Reply-To: <e1e1fc85-6ab6-ba91-c91f-21c3f51ee6ee@au1.ibm.com>
References: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
 <20190207063736.GS14180@gate.crashing.org>
 <630e392b-e9a7-6b1e-e3d8-c5382f94e5d7@au1.ibm.com>
 <20190207074947.GT14180@gate.crashing.org>
 <e1e1fc85-6ab6-ba91-c91f-21c3f51ee6ee@au1.ibm.com>
Date: Fri, 08 Feb 2019 14:02:24 +1100
Message-ID: <87h8dfj83j.fsf@concordia.ellerman.id.au>
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
Cc: syzkaller@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> (+ Nick)
>
> On 7/2/19 6:49 pm, Segher Boessenkool wrote:
>> On Thu, Feb 07, 2019 at 05:59:48PM +1100, Andrew Donnellan wrote:
>>> On 7/2/19 5:37 pm, Segher Boessenkool wrote:
>>>> On Thu, Feb 07, 2019 at 04:33:23PM +1100, Andrew Donnellan wrote:
>>>>> Some older gccs (<GCC 7), when invoked with -fsanitize-coverage=3Dtra=
ce-pc,
>>>>> cause a spurious uninitialised variable warning in dt_cpu_ftrs.c:
>>>>>
>>>>>    arch/powerpc/kernel/dt_cpu_ftrs.c: In function
>>>>>    =E2=80=98cpufeatures_process_feature=E2=80=99:
>>>>>    arch/powerpc/kernel/dt_cpu_ftrs.c:686:7: warning: =E2=80=98m=E2=80=
=99 may be used
>>>>>    uninitialized in this function [-Wmaybe-uninitialized]
>>>>>      if (m->cpu_ftr_bit_mask)
>>>>
>>>> It seems to me the warning is correct?  If enable_unknown is false and=
 no
>>>> cpu_feature is found, it will in
>>>>
>>>> 	if (m->cpu_ftr_bit_mask)
>>>> 		cur_cpu_spec->cpu_features |=3D m->cpu_ftr_bit_mask;
>>>>
>>>> enable random features (whatever was last in the table), or indeed acc=
ess
>>>> via NULL if the table is length 0?  So maybe this should be
>>>>
>>>> 	if (known && m->cpu_ftr_bit_mask)
>>>> 		cur_cpu_spec->cpu_features |=3D m->cpu_ftr_bit_mask;
>>>>
>>>> instead?  (The code would be much clearer if all the known vs. !known
>>>> codepath was fully separated here).
>>>
>>> The table is never length 0, it's a statically defined array.
>>=20
>> Sure, and presumably that is why newer GCC doesn't warn.  But what about
>> the other point?  Is this code ever correct?  Enabling random features
>> (in cur_cpu_spec->cpu_features) when the name isn't found seems wrong.
>
> Now that I'm replying without being 2 minutes before a meeting :)
>
> The warning is still spurious, but the logic looks very suspicious.
>
> I think your solution looks correct, though the whole function could be=20
> cleaned up a bit.
>
> I also notice that if enable_unknown =3D=3D false, then I think an unknow=
n=20
> feature will still print "enabling" and return true, which seems wrong.
>
> How does something like the following look, which I could send instead=20
> and will probably solve the spurious warnings issues anyway?

I'd prefer a minimal fix that we can backport. How about:

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu=
_ftrs.c
index 8be3721d9302..a1acccd25839 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -675,12 +675,10 @@ static bool __init cpufeatures_process_feature(struct=
 dt_cpu_feature *f)
 		}
 	}
=20
-	if (!known && enable_unknown) {
-		if (!feat_try_enable_unknown(f)) {
-			pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
-				f->name);
-			return false;
-		}
+	if (!known && (!enable_unknown || !feat_try_enable_unknown(f))) {
+		pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
+			f->name);
+		return false;
 	}
=20
 	if (m->cpu_ftr_bit_mask)


cheers
