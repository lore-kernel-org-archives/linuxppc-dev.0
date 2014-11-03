Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 506531A0602
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 05:04:42 +1100 (AEDT)
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 95CB1140082
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2014 05:04:41 +1100 (AEDT)
Received: by mail-ob0-f169.google.com with SMTP id va2so9401218obc.14
 for <linuxppc-dev@ozlabs.org>; Mon, 03 Nov 2014 10:04:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5457A306.4040302@linux.vnet.ibm.com>
References: <1414351406-4122-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K0t3G-bHm_24GjrTp9mmKnYZS1_bdGgrwQBLjC_s5is6w@mail.gmail.com>
 <5457A306.4040302@linux.vnet.ibm.com>
Date: Mon, 3 Nov 2014 22:04:38 +0400
Message-ID: <CAOJe8K2hEfMe0T3xu9oF024nXvgyZ2ctAYR63mzdOX87HbYvPA@mail.gmail.com>
Subject: Re: [PATCH] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Matt Evans <matt@ozlabs.org>,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/3/14, Philippe Bergheaud <felix@linux.vnet.ibm.com> wrote:
> Denis Kirjanov wrote:
>> Any feedback from PPC folks?
>
> I have reviewed the patch and it looks fine to me.
> I have tested successfuly on ppc64le.
> I could not test it on ppc64.

Nice, I've tested it on PPC64be
>
> Philippe
>
>> On 10/26/14, Denis Kirjanov <kda@linux-powerpc.org> wrote:
>>
>>>Cc: Matt Evans <matt@ozlabs.org>
>>>Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>>>---
>>> arch/powerpc/include/asm/ppc-opcode.h | 1 +
>>> arch/powerpc/net/bpf_jit.h            | 7 +++++++
>>> arch/powerpc/net/bpf_jit_comp.c       | 5 +++++
>>> 3 files changed, 13 insertions(+)
>>>
>>>diff --git a/arch/powerpc/include/asm/ppc-opcode.h
>>>b/arch/powerpc/include/asm/ppc-opcode.h
>>>index 6f85362..1a52877 100644
>>>--- a/arch/powerpc/include/asm/ppc-opcode.h
>>>+++ b/arch/powerpc/include/asm/ppc-opcode.h
>>>@@ -204,6 +204,7 @@
>>> #define PPC_INST_ERATSX_DOT		0x7c000127
>>>
>>> /* Misc instructions for BPF compiler */
>>>+#define PPC_INST_LBZ			0x88000000
>>> #define PPC_INST_LD			0xe8000000
>>> #define PPC_INST_LHZ			0xa0000000
>>> #define PPC_INST_LHBRX			0x7c00062c
>>>diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>>>index 9aee27c..c406aa9 100644
>>>--- a/arch/powerpc/net/bpf_jit.h
>>>+++ b/arch/powerpc/net/bpf_jit.h
>>>@@ -87,6 +87,9 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
>>> #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
>>> 				     ___PPC_RA(base) | ((i) & 0xfffc))
>>>
>>>+
>>>+#define PPC_LBZ(r, base, i)	EMIT(PPC_INST_LBZ | ___PPC_RT(r) |	      \
>>>+				     ___PPC_RA(base) | IMM_L(i))
>>> #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
>>> 				     ___PPC_RA(base) | IMM_L(i))
>>> #define PPC_LWZ(r, base, i)	EMIT(PPC_INST_LWZ | ___PPC_RT(r) |	      \
>>>@@ -96,6 +99,10 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
>>> #define PPC_LHBRX(r, base, b)	EMIT(PPC_INST_LHBRX | ___PPC_RT(r) |	
>>> \
>>> 				     ___PPC_RA(base) | ___PPC_RB(b))
>>> /* Convenience helpers for the above with 'far' offsets: */
>>>+#define PPC_LBZ_OFFS(r, base, i) do { if ((i) < 32768) PPC_LBZ(r, base,
>>> i);
>>>  \
>>>+		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
>>>+			PPC_LBZ(r, r, IMM_L(i)); } } while(0)
>>>+
>>> #define PPC_LD_OFFS(r, base, i) do { if ((i) < 32768) PPC_LD(r, base,
>>> i);
>>>  \
>>> 		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
>>> 			PPC_LD(r, r, IMM_L(i)); } } while(0)
>>>diff --git a/arch/powerpc/net/bpf_jit_comp.c
>>>b/arch/powerpc/net/bpf_jit_comp.c
>>>index cbae2df..d110e28 100644
>>>--- a/arch/powerpc/net/bpf_jit_comp.c
>>>+++ b/arch/powerpc/net/bpf_jit_comp.c
>>>@@ -407,6 +407,11 @@ static int bpf_jit_build_body(struct bpf_prog *fp,
>>> u32
>>>*image,
>>> 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
>>> 							  queue_mapping));
>>> 			break;
>>>+		case BPF_ANC | SKF_AD_PKTTYPE:
>>>+			PPC_LBZ_OFFS(r_A, r_skb, PKT_TYPE_OFFSET());
>>>+			PPC_ANDI(r_A, r_A, PKT_TYPE_MAX);
>>>+			PPC_SRWI(r_A, r_A, 5);
>>>+			break;
>>> 		case BPF_ANC | SKF_AD_CPU:
>>> #ifdef CONFIG_SMP
>>> 			/*
>>>--
>>>2.1.0
>>>
>>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
