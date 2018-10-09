Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76AC00449
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 02:29:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AF7213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 02:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AF7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Th520tG0zF3Hv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:29:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.33; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0033.hostedemail.com
 [216.40.44.33])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Th2t6Bt9zF3F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 13:27:33 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 682E8181D3368;
 Tue,  9 Oct 2018 02:27:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: north71_72f1545fc415
X-Filterd-Recvd-Size: 2794
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Tue,  9 Oct 2018 02:27:29 +0000 (UTC)
Message-ID: <8e2f906a85c3cfe0715982370a6d96f08a37987c.camel@perches.com>
Subject: Re: [PATCH] powerpc/xmon/ppc-opc: Use ARRAY_SIZE macro
From: Joe Perches <joe@perches.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Mon, 08 Oct 2018 19:27:28 -0700
In-Reply-To: <20181004171036.GA1907@embeddedor.com>
References: <20181004171036.GA1907@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-10-04 at 19:10 +0200, Gustavo A. R. Silva wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
[]
> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
[]
> @@ -966,8 +966,7 @@ const struct powerpc_operand powerpc_operands[] =
>    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>  };
>  
> -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
> -					   / sizeof (powerpc_operands[0]));
> +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);

It seems this is unused and could be deleted.

>  /* The functions used to insert and extract complicated operands.  */
>  
> @@ -6980,8 +6979,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
>  {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
>  };
>  
> -const int powerpc_num_opcodes =
> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
> +const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);

This is used once and should probably be replaced where
it is used with ARRAY_SIZE

>  /* The VLE opcode table.
>  
> @@ -7219,8 +7217,7 @@ const struct powerpc_opcode vle_opcodes[] = {
>  {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
>  };
>  
> -const int vle_num_opcodes =
> -  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
> +const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);

Also apparently unused and could be deleted.

>  
>  /* The macro table.  This is only used by the assembler.  */
>  
> @@ -7288,5 +7285,4 @@ const struct powerpc_macro powerpc_macros[] = {
>  {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
>  };
>  ld
> -const int powerpc_num_macros =
> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
> +const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);

Also apparently unused and could be deleted.


