Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmfVQ33WYzF0ks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 01:09:02 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LE51Zj096765
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:08:59 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g97enfx6t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:08:58 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 14:08:54 -0000
Date: Wed, 21 Feb 2018 19:38:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] bpf, powerpc: fix jit for seccomp_data access
To: Mark Lord <mlord@pobox.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,
 Kees Cook <keescook@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Andy Lutomirski <luto@amacapital.net>, mpe@ellerman.id.au,
 Will Drewry <wad@chromium.org>
References: <d79074fe-2ee1-c132-ef2d-f6bb618b53bb@pobox.com>
 <2a91fe0c-ea85-dd79-6682-66b1301d7e49@iogearbox.net>
 <53a6b85c-8cb7-d4d0-8234-7ecfb1a709b2@pobox.com>
 <1519154571.d9vaokens9.naveen@linux.ibm.com>
 <2f428cf9-23f3-d1f1-1524-46d6faa17386__30848.5239781023$1519169515$gmane$org@pobox.com>
 <1519201713.vxxqmwxkkx.naveen@linux.ibm.com>
 <32a60518-1de6-9f9c-b3e6-5e5292d6b289@pobox.com>
 <2e79ef59-1731-f3a5-9868-c15beb939142@pobox.com>
In-Reply-To: <2e79ef59-1731-f3a5-9868-c15beb939142@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1519221778.inx201t3s9.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Lord wrote:
> On 18-02-21 07:52 AM, Mark Lord wrote:
>> On 18-02-21 03:35 AM, Naveen N. Rao wrote:
> ..
>>> Looks good to me, but I am not able to apply this patch. There seems to=
 be whitespace damage.
>>=20
>> Here (attached) is a clean copy.
>=20
> Again, this time with the commit message included!

Thanks. However...
I am able to apply this using 'patch', but not with 'git am' since the=20
headers are missing. FWIW, the usual workflow is to make the changes and=20
commit it into your repository using 'git commit' and then use 'git=20
format-patch' to generate a patch file that you can then post.

I'll defer to Michael on whether he is ok to process this as it is.

>=20
> I am using SECCOMP to filter syscalls on a ppc32 platform,
> and noticed that the JIT compiler was failing on the BPF
> even though the interpreter was working fine.
>=20
> The issue was that the compiler was missing one of the instructions
> used by SECCOMP, so here is a patch to enable JIT for that instruction.
>=20
> Signed-Off-By:  Mark Lord <mlord@pobox.com>

Minot nit: The correct (TM) tag to use is:
Signed-off-by:
(note the case)

>=20
> --- old/arch/powerpc/net/bpf_jit_comp.c 2018-02-16 14:07:01.000000000 -05=
00
> +++ linux/arch/powerpc/net/bpf_jit_comp.c       2018-02-20 14:41:20.80522=
7494 -0500
> @@ -329,6 +329,9 @@ static int bpf_jit_build_body(struct bpf
>                         BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) !=
=3D 4);
>                         PPC_LWZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,=
 len));
>                         break;
> +               case BPF_LDX | BPF_W | BPF_ABS: /* A =3D *((u32 *)(seccom=
p_data + K)); */
> +                       PPC_LWZ_OFFS(r_A, r_skb, K);
> +                       break;
>                 case BPF_LDX | BPF_W | BPF_LEN: /* X =3D skb->len; */
>                         PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff,=
 len));
>                         break;

Apart from those aspects, for this patch:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen

=
