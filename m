Return-Path: <mlord@pobox.com>
Received: from sasl.smtp.pobox.com (pb-sasl2.pobox.com [64.147.108.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmdtn31LHzDqqH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 00:41:35 +1100 (AEDT)
Subject: Re: [PATCH] bpf, powerpc: fix jit for seccomp_data access
From: Mark Lord <mlord@pobox.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, mpe@ellerman.id.au,
 Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org
References: <d79074fe-2ee1-c132-ef2d-f6bb618b53bb@pobox.com>
 <2a91fe0c-ea85-dd79-6682-66b1301d7e49@iogearbox.net>
 <53a6b85c-8cb7-d4d0-8234-7ecfb1a709b2@pobox.com>
 <1519154571.d9vaokens9.naveen@linux.ibm.com>
 <2f428cf9-23f3-d1f1-1524-46d6faa17386__30848.5239781023$1519169515$gmane$org@pobox.com>
 <1519201713.vxxqmwxkkx.naveen@linux.ibm.com>
 <32a60518-1de6-9f9c-b3e6-5e5292d6b289@pobox.com>
Message-ID: <2e79ef59-1731-f3a5-9868-c15beb939142@pobox.com>
Date: Wed, 21 Feb 2018 08:41:30 -0500
MIME-Version: 1.0
In-Reply-To: <32a60518-1de6-9f9c-b3e6-5e5292d6b289@pobox.com>
Content-Type: multipart/mixed; boundary="------------69D1A4F2893FF2C6772DFA9B"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------69D1A4F2893FF2C6772DFA9B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 18-02-21 07:52 AM, Mark Lord wrote:
> On 18-02-21 03:35 AM, Naveen N. Rao wrote:
..
>> Looks good to me, but I am not able to apply this patch. There seems to be whitespace damage.
> 
> Here (attached) is a clean copy.

Again, this time with the commit message included!

I am using SECCOMP to filter syscalls on a ppc32 platform,
and noticed that the JIT compiler was failing on the BPF
even though the interpreter was working fine.

The issue was that the compiler was missing one of the instructions
used by SECCOMP, so here is a patch to enable JIT for that instruction.

Signed-Off-By:  Mark Lord <mlord@pobox.com>

--- old/arch/powerpc/net/bpf_jit_comp.c 2018-02-16 14:07:01.000000000 -0500
+++ linux/arch/powerpc/net/bpf_jit_comp.c       2018-02-20 14:41:20.805227494 -0500
@@ -329,6 +329,9 @@ static int bpf_jit_build_body(struct bpf
                        BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
                        PPC_LWZ_OFFS(r_A, r_skb, offsetof(struct sk_buff, len));
                        break;
+               case BPF_LDX | BPF_W | BPF_ABS: /* A = *((u32 *)(seccomp_data + K)); */
+                       PPC_LWZ_OFFS(r_A, r_skb, K);
+                       break;
                case BPF_LDX | BPF_W | BPF_LEN: /* X = skb->len; */
                        PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff, len));
                        break;
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

--------------69D1A4F2893FF2C6772DFA9B
Content-Type: text/x-patch;
 name="ppc-jit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ppc-jit.patch"

I am using SECCOMP to filter syscalls on a ppc32 platform,
and noticed that the JIT compiler was failing on the BPF
even though the interpreter was working fine.

The issue was that the compiler was missing one of the instructions
used by SECCOMP, so here is a patch to enable JIT for that instruction.

Signed-Off-By:  Mark Lord <mlord@pobox.com>

--- old/arch/powerpc/net/bpf_jit_comp.c	2018-02-16 14:07:01.000000000 -0500
+++ linux/arch/powerpc/net/bpf_jit_comp.c	2018-02-20 14:41:20.805227494 -0500
@@ -329,6 +329,9 @@ static int bpf_jit_build_body(struct bpf
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
 			PPC_LWZ_OFFS(r_A, r_skb, offsetof(struct sk_buff, len));
 			break;
+		case BPF_LDX | BPF_W | BPF_ABS: /* A = *((u32 *)(seccomp_data + K)); */
+			PPC_LWZ_OFFS(r_A, r_skb, K);
+			break;
 		case BPF_LDX | BPF_W | BPF_LEN: /* X = skb->len; */
 			PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff, len));
 			break;

--------------69D1A4F2893FF2C6772DFA9B--
