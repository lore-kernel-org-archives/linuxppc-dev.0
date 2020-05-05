Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24236C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 02:09:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28A4206D7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 02:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28A4206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GNSr37dgzDqZN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 12:09:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GNQx431lzDqTT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 12:07:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49GNQx0wvrz9sSx;
 Tue,  5 May 2020 12:07:37 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v7 18/28] powerpc/xmon: Use a function for reading
 instructions
Date: Tue, 05 May 2020 12:07:36 +1000
Message-ID: <2373446.VmBUS7fNXd@townsend>
In-Reply-To: <20200501034220.8982-19-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
 <20200501034220.8982-19-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shouldn't change anything and will be correct once prefix instructions are 
defined.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Friday, 1 May 2020 1:42:10 PM AEST Jordan Niethe wrote:
> Currently in xmon, mread() is used for reading instructions. In
> preparation for prefixed instructions, create and use a new function,
> mread_instr(), especially for reading instructions.
> 
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v5: New to series, seperated from "Add prefixed instructions to
>     instruction data type"
> v6: mread_instr(): correctly return error status
> ---
>  arch/powerpc/xmon/xmon.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index cde733a82366..1947821e425d 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -122,6 +122,7 @@ static unsigned bpinstr = 0x7fe00008;	/* trap */
>  static int cmds(struct pt_regs *);
>  static int mread(unsigned long, void *, int);
>  static int mwrite(unsigned long, void *, int);
> +static int mread_instr(unsigned long, struct ppc_inst *);
>  static int handle_fault(struct pt_regs *);
>  static void byterev(unsigned char *, int);
>  static void memex(void);
> @@ -896,7 +897,7 @@ static void insert_bpts(void)
>  	for (i = 0; i < NBPTS; ++i, ++bp) {
>  		if ((bp->enabled & (BP_TRAP|BP_CIABR)) == 0)
>  			continue;
> -		if (mread(bp->address, &instr, 4) != 4) {
> +		if (!mread_instr(bp->address, &instr)) {
>  			printf("Couldn't read instruction at %lx, "
>  			       "disabling breakpoint there\n", bp->address);
>  			bp->enabled = 0;
> @@ -946,7 +947,7 @@ static void remove_bpts(void)
>  	for (i = 0; i < NBPTS; ++i, ++bp) {
>  		if ((bp->enabled & (BP_TRAP|BP_CIABR)) != BP_TRAP)
>  			continue;
> -		if (mread(bp->address, &instr, 4) == 4
> +		if (mread_instr(bp->address, &instr)
>  		    && ppc_inst_equal(instr, ppc_inst(bpinstr))
>  		    && patch_instruction(
>  			(struct ppc_inst *)bp->address, ppc_inst_read(bp->instr)) != 0)
> @@ -1162,7 +1163,7 @@ static int do_step(struct pt_regs *regs)
>  	force_enable_xmon();
>  	/* check we are in 64-bit kernel mode, translation enabled */
>  	if ((regs->msr & (MSR_64BIT|MSR_PR|MSR_IR)) == (MSR_64BIT|MSR_IR)) {
> -		if (mread(regs->nip, &instr, 4) == 4) {
> +		if (mread_instr(regs->nip, &instr)) {
>  			stepped = emulate_step(regs, instr);
>  			if (stepped < 0) {
>  				printf("Couldn't single-step %s instruction\n",
> @@ -1329,7 +1330,7 @@ static long check_bp_loc(unsigned long addr)
>  		printf("Breakpoints may only be placed at kernel addresses\n");
>  		return 0;
>  	}
> -	if (!mread(addr, &instr, sizeof(instr))) {
> +	if (!mread_instr(addr, &instr)) {
>  		printf("Can't read instruction at address %lx\n", addr);
>  		return 0;
>  	}
> @@ -2122,6 +2123,25 @@ mwrite(unsigned long adrs, void *buf, int size)
>  	return n;
>  }
> 
> +static int
> +mread_instr(unsigned long adrs, struct ppc_inst *instr)
> +{
> +	volatile int n;
> +
> +	n = 0;
> +	if (setjmp(bus_error_jmp) == 0) {
> +		catch_memory_errors = 1;
> +		sync();
> +		*instr = ppc_inst_read((struct ppc_inst *)adrs);
> +		sync();
> +		/* wait a little while to see if we get a machine check */
> +		__delay(200);
> +		n = ppc_inst_len(*instr);
> +	}
> +	catch_memory_errors = 0;
> +	return n;
> +}
> +
>  static int fault_type;
>  static int fault_except;
>  static char *fault_chars[] = { "--", "**", "##" };




