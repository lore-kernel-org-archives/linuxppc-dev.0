Return-Path: <linuxppc-dev+bounces-6400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAC8C021B3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1Xvh0n0vz2yl1;
	Mon, 24 Feb 2025 18:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740383408;
	cv=none; b=jtJnIBtUSOg8m77Fmxob30oS/xtB8bVBYtGkoQwdewcfqxGjcMZsQz6pokysAkHk9bgaQJegSkV3ZcFS0GvdbrIN4sk0D/3LBJqIcuA137z1joi4e7k0W8nboD1L1uK+xFTiK8LY8o+u1ek6oXswm37sIVJYNkYqpmdV5uDM5m4WTzVU5OJmBg28FO7z/2VfCoCQAhiG/2delu4i3d951iw/zFucWEwp29/gH9NOzciRJ2AkNi9NytmWhoBxFjJVfdPHrUPwB1Mh3kkpk2nHIneb0lhSmIcoZzXaozCA7cTXWQRDmwgSZR7uGtkhvjPfdMamOevNfzt4YfneCUamJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740383408; c=relaxed/relaxed;
	bh=xSwp7fOFiq9KwYSb1JpUYfpliZRF14r3mIYwVnNphV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMM0LNmyNwLcgBpl1eilOjj0RAVExBDN9D2Kathz0Jkv3jVJjwlZD1rD/9zikGasXRlCC3Cky2cqOc7DhyFsGQgIo7+UOI7QlK2yA/jmsfgOgNJEcXx5lS0a2GDwGROk3PZwsz17oIj21CzVX73TWEmOcH59gHRL1VUNW6kxpbH7AfyncT8fY/kbpQM+0pZnR7IRuDVFssSELQUvX50F5maxyyIFAzvQmRfy9DBLz5jaRNTKMbg3hmDtBKZNe+rvPgWnzurK8xCkU96/+sVs5Sp5Qr4Ao1DdfCvsbaERWxQGp+dk6VMzOcVNivAEU93cVH2wV1AWPW9vjTAWjDCr4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1Xvf5X7qz2xHp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2025 18:50:05 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z1X7D3xsVz9sSY;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlCaqB87YQCz; Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z1X7D2md3z9sSX;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A4978B765;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SnYPeEpOAy8h; Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 23FFD8B763;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Message-ID: <3223ec0e-c445-4bbf-ae72-276688e40908@csgroup.eu>
Date: Mon, 24 Feb 2025 08:15:04 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call warning
 for bl+mflr pattern
To: Sathvika Vasireddy <sv@linux.ibm.com>, jpoimboe@kernel.org,
 peterz@infradead.org, npiggin@gmail.com, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev
References: <20250219162014.10334-1-sv@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250219162014.10334-1-sv@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/02/2025 à 17:20, Sathvika Vasireddy a écrit :
> Architectures like PowerPC use a pattern where the compiler generates a
> branch-and-link (bl) instruction that targets the very next instruction,
> followed by loading the link register (mflr) later. This pattern appears
> in the code like:
> 
>   bl .+4
>   li r5,0
>   mflr r30

What compiler do you use ? Is it a very old version of GCC ?

That sequence is not correct and should never be used by modern 
compilers. It should be bcl 20,31,+4 instead.

All such hand writen sequences have been removed from kernel assembly, 
see commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption in 
__get_datapage()") for details


> 
> Objtool currently warns about this as an "unannotated intra-function
> call" because find_call_destination() fails to find any symbol at the
> target offset. Add a check to skip the warning when a branch targets
> the immediate next instruction in the same function.

I think this should be done in arch_decode_instruction(), just set 
insn->type to INSN_OTHER when you see bl .+4

Something like:

diff --git a/tools/objtool/arch/powerpc/decode.c 
b/tools/objtool/arch/powerpc/decode.c
index 53b55690f320..ca264c97ee8d 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -55,7 +55,9 @@ int arch_decode_instruction(struct objtool_file *file, 
const struct section *sec

  	switch (opcode) {
  	case 18: /* b[l][a] */
-		if ((ins & 3) == 1) /* bl */
+		if (ins == 0x48000005)	/* bl .+4 */
+			typ = INSN_OTHER;
+		else if ((ins & 3) == 1) /* bl */
  			typ = INSN_CALL;

  		imm = ins & 0x3fffffc;



> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502180818.XnFdv8I8-lkp@intel.com/
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>   tools/objtool/check.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 753dbc4f8198..3f7cf2c917b5 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1613,6 +1613,7 @@ static struct symbol *find_call_destination(struct section *sec, unsigned long o
>    */
>   static int add_call_destinations(struct objtool_file *file)
>   {
> +       struct instruction *next_insn;
>          struct instruction *insn;
>          unsigned long dest_off;
>          struct symbol *dest;
> @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
>                  reloc = insn_reloc(file, insn);
>                  if (!reloc) {
>                          dest_off = arch_jump_destination(insn);
> +
> +                       next_insn = next_insn_same_func(file, insn);
> +                       if (next_insn && dest_off == next_insn->offset)
> +                               continue;
> +
>                          dest = find_call_destination(insn->sec, dest_off);
> 
>                          add_call_dest(file, insn, dest, false);
> --
> 2.39.3
> 


