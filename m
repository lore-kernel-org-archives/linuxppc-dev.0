Return-Path: <linuxppc-dev+bounces-28946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ABCA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 06:15:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzQwt0sHRz30BJ;
	Tue, 06 Oct 2026 17:15:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791267342;
	cv=none; b=np3cSBNrYSfrltKnfrCEICEimwdzyb1SZ/YrVyczDQM8PVZhoYtzorw9lJWEf7LHf+keIhXdEe7xdRVeSmowIUY/lXFRV/crXy4HcpDVvCTIpMJCI9zKBwyo9pu7zZ0tegrFPZvY871cUJHmdZGBhcMwL27TF8H6ggKEQmUsNKZqlu36vlSLB4LiTm8nF+nSwt4T/QgSiUW9DVD2nYDY4OIG9DThfLB2+AzGqaRTfU4Y3k2RXHSBDta6Ep2tTJnH6kba5fGVkz9n0qZS200LFUKVuAoYyRkoM8itX0/RkoRNZIfekKhjLsZtYfCjrLOToGG3MhKj0VvFnzUeNnEoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791267342; c=relaxed/relaxed;
	bh=+rXo/9HsyVW3aJ8rwfYpaCgSZGYXBJigBbvc+8XFoRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVtPu2mFXzMuT3iBCVQKw8sFa7fhxaQ/7oUgoP6ttwen2+kFsNP07lThabsA5ayjx3yoGma+GoZBhWH1Vwht3Sl7vf7Gm87MihG7xZBfOufn76QtoaKxFHQWBzv7Gjin4PBk2fPv7X88eXitW6KqH9lNNPRN7OFpEvjljuFcCVNMU5a7nI/0d6DyuhkVwnY/Qmmw16T1RmC1eTX6pTI3qbg0eWNX3SG6yJSlrp7vRe5RlaugwGFeObBajenI9ewqQ9FAUzDsCo0VwVEr/KsGLwvy/A5Aqf7aR46WXOOW+EkcXeeNUJTLAP2xgUxefgt86hwBYRlVak2ouYoM8Ri+LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qkNQ8z/p; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qkNQ8z/p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzQwr33sSz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 17:15:39 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6963ZdQG695812;
	Tue, 6 Oct 2026 06:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+rXo/9
	HsyVW3aJ8rwfYpaCgSZGYXBJigBbvc+8XFoRg=; b=qkNQ8z/pgO8CESdAoHTYTS
	wTTpI5ZKwsYHoo0xrYLm+pQ+0Se50pZaLYDSQjXy4FE+6nJWanCIcGtWtmLDFEox
	WvajW8y32zRCNq0mErRo53TUNzCNum1SlsNOtLC+qLhJ4bEuJUMaDH8STeVbqZZQ
	OA0OQFzFsxjZNQushE7TsXxpfLVcyymrKh8dl8D9X4ogc4OzyX2LAXisy6B5aoXU
	fDRqkxfbHe/Wk0XOrZbeO9RuCzTUy6NV6PYk4TBB7RFY5pSsrhy5Dm1YFVx7O02B
	W4WKs+V0b5NpXsjysy/10ZfllFfi5/X1YKnOvwJrAi/Fb6w91BdEVYcQja5Rb+XQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2screajw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 06:14:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6963HdaR3925182;
	Tue, 6 Oct 2026 06:14:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgrmj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 06:14:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6966EZKP9240912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 06:14:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8649A2004E;
	Tue,  6 Oct 2026 06:14:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81DE42004B;
	Tue,  6 Oct 2026 06:14:26 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.25.101])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 06:14:26 +0000 (GMT)
Message-ID: <3297b07cf058b29251063e5e7dc61bf047c5148f.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/6] objtool/powerpc: Skip jump destination analysis
 and unnanotated intra-function call warnings for --ftr-fixup
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com,
        alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
        aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
        chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
        jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
        lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
        mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
        nsc@kernel.org, ojeda@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, tamird@kernel.org,
        thomas.weissschuh@linutronix.de, thuth@redhat.com,
        yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com
Date: Tue, 06 Oct 2026 11:44:25 +0530
In-Reply-To: <20260930094449.GJ88198@noisy.programming.kicks-ass.net>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
	 <20260929055138.43489-5-shivangu@linux.ibm.com>
	 <20260929142559.GC88198@noisy.programming.kicks-ass.net>
	 <05e06ab0d9fc8810fc50e888e9e0f55b2ec9b77f.camel@linux.ibm.com>
	 <20260930094449.GJ88198@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNCBTYWx0ZWRfXzRroh2hxk3ho
 /WMxD9GPhvrQGDKuB6JREuWbCxxFi7nBfjphufwdC0fDpAlZIoBCcscZOoVSVUj96K+uOXXqa67
 8rssQfEvhqQs1nbuE/qIBiZ934KkRY8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNCBTYWx0ZWRfX7kWSQavWXc7v
 mZS8AON7SxP7qJGQ5awJIPp1WWPFAnMslr69FD7TLG/fzs7rdUH2iaoVcIucgP7NBIMYWQrYnJk
 sQ0APpK+wS2dp1z3LOZERYwtCvqRgG0QeDWu9740wvu7NuxEFuGbgALGESjcHd+Pc3E5CC+DZnE
 dydYWdgEkJZiC4pj6V+CDy36HhDTCFeLQdlfLxrDJdO8DBMU07ZTPsWmjZ5RdhwCzlV+R0RV35S
 j1XZ0Pgu0bxhCianQyVKfENbWtWMeP2+QZcRlf3h/SUL5yL2i98SwVwzeDKucAy8/3DHJgpn00/
 ZeLH1QYy4DrqvSHJ3yNHvQJVk4ZIe+mlSW3BVA9eIZA1aDfU5bu73S2dLxo7LCUEXZPlbXh7Dm6
 JdPpsQZMlysHoZvitEFkI/nVesCzKeWWH4cgRO19Z/j/0MQ2UqSFa5lzglVd6DX0pmCi4mpG1E/
 U/HBhFpA8I4iRIXRPPw==
X-Proofpoint-GUID: N0UneCwz4OyrvdRWQDFs2ZF7DNe1FElD
X-Proofpoint-ORIG-GUID: a1oYyYKwK2rz2UngSXjTTmc1BQoEmsdp
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac491d3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=_kaDUDulWroBixN9eW0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_01,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060024

On Wed, 2026-09-30 at 11:44 +0200, Peter Zijlstra wrote:
> On Wed, Sep 30, 2026 at 11:43:10AM +0530, Shivang Upadhyay wrote:
> > On Tue, 2026-09-29 at 16:25 +0200, Peter Zijlstra wrote:
> > > > c00000000002a610 <system_reset_exception>:
> > > > c00000000002a610:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0e 01 4c 3c=
=C2=A0=C2=A0=C2=A0=C2=A0 addis=C2=A0=C2=A0 r2,r12,270
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 c00000000002a610: R_PPC64_REL16_HA=C2=A0=C2=A0=C2=A0
> > > > .TOC.
> > > > c00000000002a614:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f0 6c 42 38=
=C2=A0=C2=A0=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 r2,r2,27888
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 c00000000002a614: R_PPC64_REL16_LO=C2=A0=C2=A0=C2=A0
> > > > .TOC.+0x4
> > > > c00000000002a618:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a6 02 08 7c=
=C2=A0=C2=A0=C2=A0=C2=A0 mflr=C2=A0=C2=A0=C2=A0 r0
> > > >=20
> > > > This is happening because we should be looking for destination
> > > > symbols that are at absolute offsets instead of relative
> > > > offsets.
> > >=20
> > > Again, confused. We run objtool on objects, this is pre-linking,
> > > there
> > > are no absolute offsets.
> > Hi Peter,
> >=20
> > This is the special requirement of patching jump assembly
> > instructions
> > that we need to know where the jump is performed from/to. As per
> > 5/6
> > objtool is run post link on vmlinux. If handling post-link
> > information
> > is outside the scope of objtool, please let me know.
>=20
> I think we can make it work; but this wasn't immediately obvious.
> Also
> I'm still struggling to understand what exactly you're doing -- I'm
> not
> well versed in the PPC details and have no idea what this ftr thing
> really is and your patches don't really explain anything much at all.
>=20
> (Gemini is suggesting this is all somewhat similar to the x86 RIP
> relative fixup we do for alternatives, but your case is more 'fun').
>=20

Hi Peter,
Sorry for the delayed response.

I think I can explain the feature fixup mechanism and the problem we're
trying to solve more clearly in the cover letter.

Here is a basic example of what we're trying to achieve.

        GEN_COMMON data_access

            ld      r4,_DSISR(r1)
            addi    r3,r1,STACK_INT_FRAME_REGS
            andis.  r0,r4,DSISR_DABRMATCH@h
            bne-    1f

        #ifdef CONFIG_PPC_64S_HASH_MMU
        BEGIN_MMU_FTR_SECTION
            bl      CFUNC(do_hash_fault)
        MMU_FTR_SECTION_ELSE
            bl      CFUNC(do_page_fault)
        ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
        #else
            bl      CFUNC(do_page_fault)
        #endif

            b       interrupt_return_srr

This is the implementation of the data_access exception handler on
ppc64le. Depending on whether the machine is using the hash or radix
MMU, we need to execute a different fault handler. The choice is made
at runtime based on the CPU's feature bits.

The assembly macros therefore generate code for both possible cases at
build time, and the feature-fixup mechanism later patches the code so
that only the appropriate path is executed.

The problem is that the linker does not know about this later patching
when it resolves branch relocations.
For example, consider:

feat_loc:
    ...

BEGIN_MMU_FTR_SECTION

    ...
loc_a:
    bl      CFUNC(main_feature)
    ...

MMU_FTR_SECTION_ELSE

    ...
loc_b:
    bl      CFUNC(alt_feature)
    ...

When linking this code, the linker will encode=20
main_feature - loc_a at loc_a and alt_feature - loc_b at loc_b at two
bl instructions ablove.


However, alt_feature - loc_b is not the offset that we ultimately need
from the alt branch. When the feature fixup is applied, the instruction
at loc_a is replaced with the alternative instruction, so the branch
needs to encode (alt_feature - loc_a) jump.

This distinction matters because the branch displacement has to fit in
the range representable by the 32-bit PowerPC branch instruction.
Depending on where feat_loc, main_feature, and alt_feature end up after
linking, the linker-generated displacement can therefore be different
from the displacement that is actually needed after the feature fixup.
In some layouts this can result in either a build-time failure or, more
importantly, an invalid branch at runtime.

What we're trying to do with the build-time pass is detect these cases
and prepare the branch relocations for the code as it will actually
exist after feature patching. At minimum, it should allow us to detect
an impossible branch offset at build time rather than discovering it
only after the feature fixup is applied at runtime.


> Anyway, I would much rather objtool learns how to deal with absolute
> sections rather than making things depend on a 'random' ftr option.
> That
> is, if we need conditional code, have it be because the secion has
> non-zero address, not because ftr option or somesuch.
>=20
> But noting that, can't we simply change:
>=20
> =C2=A0 decode_instructions()
> =C2=A0=C2=A0=C2=A0 hash_add(file->insn_hash, &insn->hash, sec_offset_hash=
(sec, insn-
> >offset));
>=20
> to take sh_addr into account? I mean, when unlinked, it'll be 0 so
> nothing changes, but when already linked, it'll get you the absolute
> value and then you don't need that fixup later on, or am I missing
> some
> details?
>=20
> So from where I'm at, please:
>=20
> =C2=A0- teach objtool about absolute sections, not ftr specials
Sure I will try to rework these patches towards that.

>=20
> =C2=A0- expand changelog to actually explain what these ftr things are an=
d
> =C2=A0=C2=A0 how they work and what the actual problem is we're solving, =
so we
> =C2=A0=C2=A0 don't need to employ LLMs to understand patches and all that=
 :-)
>=20
> Does that sound reasonable?

Yes.

Thanks
~Shivang.

