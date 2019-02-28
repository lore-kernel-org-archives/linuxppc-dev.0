Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EADC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:45:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD3F20C01
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD3F20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449NLt1lpKzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:45:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449NJl0805zDqMP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 06:43:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=intel.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 449NJk62Gyz8t2S
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 06:43:34 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 449NJk5gTNz9s9L; Fri,  1 Mar 2019 06:43:34 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 449NJj6K1Zz9s1b
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Mar 2019 06:43:32 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2019 11:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
 d="gz'50?scan'50,208,50";a="119902260"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 28 Feb 2019 11:43:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gzRaZ-000BTC-GA; Fri, 01 Mar 2019 03:43:27 +0800
Date: Fri, 1 Mar 2019 03:43:02 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 9/9] powerpc/64s: Implement KUAP for Radix MMU
Message-ID: <201903010307.9SrrJtXo%fengguang.wu@intel.com>
References: <20190228144917.16876-9-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20190228144917.16876-9-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com, kbuild-all@01.org,
 akshay.adiga@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[cannot apply to v5.0-rc8 next-20190228]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-Ellerman/powerpc-powernv-idle-Restore-IAMR-after-idle/20190228-235025
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-ppc64e_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/entry_64.S: Assembler messages:
>> arch/powerpc/kernel/entry_64.S:279: Error: unrecognized opcode: `kuap_check_amr'
>> arch/powerpc/kernel/entry_64.S:317: Error: unrecognized opcode: `kuap_restore_amr'
   arch/powerpc/kernel/entry_64.S:606: Error: unrecognized opcode: `kuap_check_amr'

vim +279 arch/powerpc/kernel/entry_64.S

   250	
   251		ld	r9,TI_FLAGS(r12)
   252		li	r11,-MAX_ERRNO
   253		andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
   254		bne-	.Lsyscall_exit_work
   255	
   256		andi.	r0,r8,MSR_FP
   257		beq 2f
   258	#ifdef CONFIG_ALTIVEC
   259		andis.	r0,r8,MSR_VEC@h
   260		bne	3f
   261	#endif
   262	2:	addi    r3,r1,STACK_FRAME_OVERHEAD
   263		bl	restore_math
   264		ld	r8,_MSR(r1)
   265		ld	r3,RESULT(r1)
   266		li	r11,-MAX_ERRNO
   267	
   268	3:	cmpld	r3,r11
   269		ld	r5,_CCR(r1)
   270		bge-	.Lsyscall_error
   271	.Lsyscall_error_cont:
   272		ld	r7,_NIP(r1)
   273	BEGIN_FTR_SECTION
   274		stdcx.	r0,0,r1			/* to clear the reservation */
   275	END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
   276		andi.	r6,r8,MSR_PR
   277		ld	r4,_LINK(r1)
   278	
 > 279		kuap_check_amr r11
   280	
   281	#ifdef CONFIG_PPC_BOOK3S
   282		/*
   283		 * Clear MSR_RI, MSR_EE is already and remains disabled. We could do
   284		 * this later, but testing shows that doing it here causes less slow
   285		 * down than doing it closer to the rfid.
   286		 */
   287		li	r11,0
   288		mtmsrd	r11,1
   289	#endif
   290	
   291		beq-	1f
   292		ACCOUNT_CPU_USER_EXIT(r13, r11, r12)
   293	
   294	BEGIN_FTR_SECTION
   295		HMT_MEDIUM_LOW
   296	END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
   297	
   298	#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
   299		std	r8, PACATMSCRATCH(r13)
   300	#endif
   301	
   302		/*
   303		 * We don't need to restore AMR on the way back to userspace for KUAP.
   304		 * The value of AMR only matters while we're in the kernel.
   305		 */
   306		ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
   307		ld	r2,GPR2(r1)
   308		ld	r1,GPR1(r1)
   309		mtlr	r4
   310		mtcr	r5
   311		mtspr	SPRN_SRR0,r7
   312		mtspr	SPRN_SRR1,r8
   313		RFI_TO_USER
   314		b	.	/* prevent speculative execution */
   315	
   316	1:	/* exit to kernel */
 > 317		kuap_restore_amr r2
   318	
   319		ld	r2,GPR2(r1)
   320		ld	r1,GPR1(r1)
   321		mtlr	r4
   322		mtcr	r5
   323		mtspr	SPRN_SRR0,r7
   324		mtspr	SPRN_SRR1,r8
   325		RFI_TO_KERNEL
   326		b	.	/* prevent speculative execution */
   327	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
dfj4AAA=

--VbJkn9YxBvnuCH5J--
