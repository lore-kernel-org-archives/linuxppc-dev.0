Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1D8312C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 21:48:53 +1000 (EST)
Message-ID: <51F261E1.7080701@asianux.com>
Date: Fri, 26 Jul 2013 19:47:45 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Suggestion] powerpc: xmon: about 'longjmp' related warning.
References: <51ECD91D.7090903@asianux.com> <20130723135809.GG31944@concordia>
 <51EF21FD.9020509@asianux.com> <51F1F6E3.7040502@asianux.com>
 <51F26164.1070801@asianux.com>
In-Reply-To: <51F26164.1070801@asianux.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, "paulus@samba.org" <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jovi.zhangwei@huawei.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26/2013 07:45 PM, Chen Gang wrote:
> Hello Maintainers:
> 
> This reply is the analyzing result for the warning:
> 
>   arch/powerpc/xmon/xmon.c:352:48: warning: argument ‘fromipi’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
> 
> I assume: for CONFIG_SMP, the thread within the function can not switch
> to another cpus (between local_irq_save and local_irq_restore). If my
> assumption is incorrect, please tell me, thanks.
> 
> If my assumption is correct, the source code for setjmp() and longjmp()
> looks OK to me: they are for checking recurse call, if it finds, it will
> jump to outside with the jump buffer which lay on the stack.
> 
> For the related warning about 'fromipi' and 'longjmp', it is issue:
> 'fromipi' is saved in stack '680(r1)'.
> 

OH, sorry typo mistake: need use "it is no issue" instead of "it is issue".

> The details may be a little complex by compiler's optimization, and
> 'fromipi' has 3 areas which each is optimized much, need read related
> reconstructed code to understand (at least for me, these optimization
> are correct).
> 
> And the disassembly code below is really a little longer, but they are
> still simple enough for understanding (I have given some comments for
> them, but not quite in details).
> 
> 
> Welcome any additional suggestions or completions.
> 
> Thanks.
> 
> 
> 
> The related source code (!CONFIG_BOOKE, CONFIG_SMP):
> 
>  352 static int xmon_core(struct pt_regs *regs, int fromipi)
>  353 {
>  354         int cmd = 0;
>  355         struct bpt *bp;
>  356         long recurse_jmp[JMP_BUF_LEN];
>  357         unsigned long offset;
>  358         unsigned long flags;
>  359 #ifdef CONFIG_SMP
>  360         int cpu;
>  361         int secondary;
>  362         unsigned long timeout;
>  363 #endif
>  364 
>  365         local_irq_save(flags);
>  366 
>  367         bp = in_breakpoint_table(regs->nip, &offset);
>  368         if (bp != NULL) {
>  369                 regs->nip = bp->address + offset;
>  370                 atomic_dec(&bp->ref_count);
>  371         }
>  372 
>  373         remove_cpu_bpts();
>  374 
>  375 #ifdef CONFIG_SMP
>  376         cpu = smp_processor_id();
>  377         if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
>  378                 get_output_lock();
>  379                 excprint(regs);
>  380                 printf("cpu 0x%x: Exception %lx %s in xmon, "
>  381                        "returning to main loop\n",
>  382                        cpu, regs->trap, getvecname(TRAP(regs)));
>  383                 release_output_lock();
>  384                 longjmp(xmon_fault_jmp[cpu], 1);
>  385         }
>  386 
>  387         if (setjmp(recurse_jmp) != 0) {
>  388                 if (!in_xmon || !xmon_gate) {
>  389                         get_output_lock();
>  390                         printf("xmon: WARNING: bad recursive fault "
>  391                                "on cpu 0x%x\n", cpu);
>  392                         release_output_lock();
>  393                         goto waiting;
>  394                 }
>  395                 secondary = !(xmon_taken && cpu == xmon_owner);
>  396                 goto cmdloop;
>  397         }
>  398 
>  399         xmon_fault_jmp[cpu] = recurse_jmp;
>  400         cpumask_set_cpu(cpu, &cpus_in_xmon);
>  401 
>  402         bp = NULL;
>  403         if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
>  404                 bp = at_breakpoint(regs->nip);
>  405         if (bp || unrecoverable_excp(regs))
>  406                 fromipi = 0;
>  407 
>  408         if (!fromipi) {
>  409                 get_output_lock();
>  410                 excprint(regs);
>  411                 if (bp) {
>  412                         printf("cpu 0x%x stopped at breakpoint 0x%x (",
>  413                                cpu, BP_NUM(bp));
>  414                         xmon_print_symbol(regs->nip, " ", ")\n");
>  415                 }
>  416                 if (unrecoverable_excp(regs))
>  417                         printf("WARNING: exception is not recoverable, "
>  418                                "can't continue\n");
>  419                 release_output_lock();
>  420         }
>  421 
>  422  waiting:
>  423         secondary = 1;
>  424         while (secondary && !xmon_gate) {
>  425                 if (in_xmon == 0) {
>  426                         if (fromipi)
>  427                                 goto leave;
>  428                         secondary = test_and_set_bit(0, &in_xmon);
>  429                 }
>  430                 barrier();
>  431         }
>  432 
>  433         if (!secondary && !xmon_gate) {
>  434                 /* we are the first cpu to come in */
>  435                 /* interrupt other cpu(s) */
>  436                 int ncpus = num_online_cpus();
>  437 
>  438                 xmon_owner = cpu;
>  439                 mb();
>  440                 if (ncpus > 1) {
>  441                         smp_send_debugger_break();
>  442                         /* wait for other cpus to come in */
>  443                         for (timeout = 100000000; timeout != 0; --timeout) {
>  444                                 if (cpumask_weight(&cpus_in_xmon) >= ncpus)
>  445                                         break;
>  446                                 barrier();
>  447                         }
>  448                 }
>  449                 remove_bpts();
>  450                 disable_surveillance();
>  451                 /* for breakpoint or single step, print the current instr. */
>  452                 if (bp || TRAP(regs) == 0xd00)
>  453                         ppc_inst_dump(regs->nip, 1, 0);
>  454                 printf("enter ? for help\n");
>  455                 mb();
>  456                 xmon_gate = 1;
>  457                 barrier();
>  458         }
>  459 
>  460  cmdloop:
>  461         while (in_xmon) {
>  462                 if (secondary) {
>  463                         if (cpu == xmon_owner) {
>  464                                 if (!test_and_set_bit(0, &xmon_taken)) {
>  465                                         secondary = 0;
>  466                                         continue;
>  467                                 }
>  468                                 /* missed it */
>  469                                 while (cpu == xmon_owner)
>  470                                         barrier();
>  471                         }
>  472                         barrier();
>  473                 } else {
>  474                         cmd = cmds(regs);
>  475                         if (cmd != 0) {
>  476                                 /* exiting xmon */
>  477                                 insert_bpts();
>  478                                 xmon_gate = 0;
>  479                                 wmb();
>  480                                 in_xmon = 0;
>  481                                 break;
>  482                         }
>  483                         /* have switched to some other cpu */
>  484                         secondary = 1;
>  485                 }
>  486         }
>  487  leave:
>  488         cpumask_clear_cpu(cpu, &cpus_in_xmon);
>  489         xmon_fault_jmp[cpu] = NULL;
>  490 #else
>  491         /* UP is simple... */
>  492         if (in_xmon) {
>  493                 printf("Exception %lx %s in xmon, returning to main loop\n",
>  494                        regs->trap, getvecname(TRAP(regs)));
>  495                 longjmp(xmon_fault_jmp[0], 1);
>  496         }
>  497         if (setjmp(recurse_jmp) == 0) {
>  498                 xmon_fault_jmp[0] = recurse_jmp;
>  499                 in_xmon = 1;
>  500 
>  501                 excprint(regs);
>  502                 bp = at_breakpoint(regs->nip);
>  503                 if (bp) {
>  504                         printf("Stopped at breakpoint %x (", BP_NUM(bp));
>  505                         xmon_print_symbol(regs->nip, " ", ")\n");
>  506                 }
>  507                 if (unrecoverable_excp(regs))
>  508                         printf("WARNING: exception is not recoverable, "
>  509                                "can't continue\n");
>  510                 remove_bpts();
>  511                 disable_surveillance();
>  512                 /* for breakpoint or single step, print the current instr. */
>  513                 if (bp || TRAP(regs) == 0xd00)
>  514                         ppc_inst_dump(regs->nip, 1, 0);
>  515                 printf("enter ? for help\n");
>  516         }
>  517 
>  518         cmd = cmds(regs);
>  519 
>  520         insert_bpts();
>  521         in_xmon = 0;
>  522 #endif
>  523 
>  524 #ifdef CONFIG_BOOKE
>  525         if (regs->msr & MSR_DE) {
>  526                 bp = at_breakpoint(regs->nip);
>  527                 if (bp != NULL) {
>  528                         regs->nip = (unsigned long) &bp->instr[0];
>  529                         atomic_inc(&bp->ref_count);
>  530                 }
>  531         }
>  532 #else
>  533         if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT)) {
>  534                 bp = at_breakpoint(regs->nip);
>  535                 if (bp != NULL) {
>  536                         int stepped = emulate_step(regs, bp->instr[0]);
>  537                         if (stepped == 0) {
>  538                                 regs->nip = (unsigned long) &bp->instr[0];
>  539                                 atomic_inc(&bp->ref_count);
>  540                         } else if (stepped < 0) {
>  541                                 printf("Couldn't single-step %s instruction\n",
>  542                                     (IS_RFID(bp->instr[0])? "rfid": "mtmsrd"));
>  543                         }
>  544                 }
>  545         }
>  546 #endif
>  547         insert_cpu_bpts();
>  548 
>  549         local_irq_restore(flags);
>  550 
>  551         return cmd != 'X' && cmd != EOF;
>  552 }
> 
> 
> The related disassembly code:
> 
>   "make ARCH=powerpc EXTRA_CFLAGS=-W"
>   "powerpc64-linux-gnu-objdump -d vmlinux.o > vmlinux.S"
>   "gcc version 4.7.1 20120606 (Red Hat 4.7.1-0.1.20120606) (GCC)"
>   "GNU objdump version 2.23.51.0.3-1.fc16 20120918"
> 
> 
> c0000000000804b0 <.xmon_core>:
> c0000000000804b0:	7c 08 02 a6 	mflr    r0
> c0000000000804b4:	f9 c1 ff 70 	std     r14,-144(r1)
> c0000000000804b8:	f9 e1 ff 78 	std     r15,-136(r1)
> c0000000000804bc:	fa 01 ff 80 	std     r16,-128(r1)
> c0000000000804c0:	fa 21 ff 88 	std     r17,-120(r1)
> c0000000000804c4:	fa 41 ff 90 	std     r18,-112(r1)
> c0000000000804c8:	fa 61 ff 98 	std     r19,-104(r1)
> c0000000000804cc:	fa 81 ff a0 	std     r20,-96(r1)
> c0000000000804d0:	fa a1 ff a8 	std     r21,-88(r1)
> c0000000000804d4:	fa c1 ff b0 	std     r22,-80(r1)
> c0000000000804d8:	f8 01 00 10 	std     r0,16(r1)
> c0000000000804dc:	fa e1 ff b8 	std     r23,-72(r1)
> c0000000000804e0:	fb 01 ff c0 	std     r24,-64(r1)
> c0000000000804e4:	fb 21 ff c8 	std     r25,-56(r1)
> c0000000000804e8:	fb 41 ff d0 	std     r26,-48(r1)
> c0000000000804ec:	fb 61 ff d8 	std     r27,-40(r1)
> c0000000000804f0:	fb 81 ff e0 	std     r28,-32(r1)
> c0000000000804f4:	fb a1 ff e8 	std     r29,-24(r1)
> c0000000000804f8:	fb c1 ff f0 	std     r30,-16(r1)
> c0000000000804fc:	fb e1 ff f8 	std     r31,-8(r1)
> c000000000080500:	f8 21 fd 91 	stdu    r1,-624(r1)
> c000000000080504:	f8 61 02 a0 	std     r3,672(r1)		; 672(r1) = parameter regs
> c000000000080508:	f8 81 02 a8 	std     r4,680(r1)		; 680(r1) = parameter fromipi
> 
> c00000000008050c:	39 20 00 00 	li      r9,0
> c000000000080510:	88 cd 02 72 	lbz     r6,626(r13)
> c000000000080514:	99 2d 02 72 	stb     r9,626(r13)
> c000000000080518:	3d 22 00 0f 	addis   r9,r2,15
> c00000000008051c:	39 00 00 00 	li      r8,0
> c000000000080520:	39 29 3e 10 	addi    r9,r9,15888
> c000000000080524:	f8 c1 01 a8 	std     r6,424(r1)
> c000000000080528:	39 29 00 08 	addi    r9,r9,8
> c00000000008052c:	f9 01 01 70 	std     r8,368(r1)
> c000000000080530:	e8 e1 02 a0 	ld      r7,672(r1)
> c000000000080534:	e9 47 01 00 	ld      r10,256(r7)
> c000000000080538:	7d 29 50 50 	subf    r9,r9,r10
> c00000000008053c:	2b a9 1f ff 	cmpldi  cr7,r9,8191
> c000000000080540:	41 9d 00 20 	bgt-    cr7,c000000000080560 <.xmon_core+0xb0>
> c000000000080544:	79 29 06 e0 	clrldi  r9,r9,59
> c000000000080548:	2f a9 00 08 	cmpdi   cr7,r9,8
> c00000000008054c:	41 9e 03 f4 	beq-    cr7,c000000000080940 <.xmon_core+0x490>
> c000000000080550:	2f a9 00 0c 	cmpdi   cr7,r9,12
> c000000000080554:	41 9e 03 ec 	beq-    cr7,c000000000080940 <.xmon_core+0x490>
> c000000000080558:	60 00 00 00 	nop
> c00000000008055c:	60 00 00 00 	nop
> 
> /* 	remove_cpu_bpts() */
> c000000000080560:	39 20 00 00 	li      r9,0
> c000000000080564:	38 61 00 70 	addi    r3,r1,112
> c000000000080568:	f9 21 00 70 	std     r9,112(r1)
> c00000000008056c:	b1 21 00 78 	sth     r9,120(r1)
> c000000000080570:	b1 21 00 7a 	sth     r9,122(r1)
> c000000000080574:	4b f9 3a 0d 	bl      c000000000013f80 <.set_breakpoint>
> c000000000080578:	60 00 00 00 	nop
> c00000000008057c:	3d 22 00 0b 	addis   r9,r2,11
> c000000000080580:	39 29 69 18 	addi    r9,r9,26904
> c000000000080584:	e9 29 00 00 	ld      r9,0(r9)
> c000000000080588:	e9 29 00 10 	ld      r9,16(r9)
> c00000000008058c:	79 28 e7 e1 	rldicl. r8,r9,28,63
> c000000000080590:	41 82 00 0c 	beq-    c00000000008059c <.xmon_core+0xec>
> c000000000080594:	39 20 00 00 	li      r9,0
> c000000000080598:	7d 32 fb a6 	mtspr   1010,r9
> 
> /* 	cpu = smp_processor_id(); */
> /*	if (cpumask_test_cpu(cpu, &cpus_in_xmon)) { */
> c00000000008059c:	a1 2d 00 0a 	lhz     r9,10(r13)
> c0000000000805a0:	3f e2 00 0f 	addis   r31,r2,15
> c0000000000805a4:	3b df 3e 10 	addi    r30,r31,15888
> c0000000000805a8:	7d 2a 07 b4 	extsw   r10,r9
> c0000000000805ac:	39 1e 24 e8 	addi    r8,r30,9448
> c0000000000805b0:	79 46 d1 82 	rldicl  r6,r10,58,6
> c0000000000805b4:	f9 41 01 78 	std     r10,376(r1)
> c0000000000805b8:	78 ca 1f 24 	rldicr  r10,r6,3,60
> c0000000000805bc:	55 27 06 be 	clrlwi  r7,r9,26
> c0000000000805c0:	7d 48 50 2a 	ldx     r10,r8,r10
> c0000000000805c4:	f8 c1 01 88 	std     r6,392(r1)
> c0000000000805c8:	90 e1 01 90 	stw     r7,400(r1)
> c0000000000805cc:	7d 49 3c 36 	srd     r9,r10,r7
> c0000000000805d0:	79 28 07 e1 	clrldi. r8,r9,63
> c0000000000805d4:	40 82 2a 6c 	bne-    c000000000083040 <.xmon_core+0x2b90>	; cpumask_test_cpu(cpu, &cpus_in_xmon) == true
> 
> /*
>  387         if (setjmp(recurse_jmp) != 0) {
>  388                 if (!in_xmon || !xmon_gate) {
>  389                         get_output_lock();
>  390                         printf("xmon: WARNING: bad recursive fault "
>  391                                "on cpu 0x%x\n", cpu);
>  392                         release_output_lock();
>  393                         goto waiting;
>  394                 }
>  395                 secondary = !(xmon_taken && cpu == xmon_owner);
>  396                 goto cmdloop;
>  397         }
> */
> c0000000000805d8:	38 61 00 70 	addi    r3,r1,112
> c0000000000805dc:	4b fa 10 15 	bl      c0000000000215f0 <.setjmp>
> c0000000000805e0:	60 00 00 00 	nop
> c0000000000805e4:	2f a3 00 00 	cmpdi   cr7,r3,0
> c0000000000805e8:	41 9e 02 b8 	beq-    cr7,c0000000000808a0 <.xmon_core+0x3f0>a
> c0000000000805ec:	3d 22 00 09 	addis   r9,r2,9
> c0000000000805f0:	e9 29 2f 00 	ld      r9,12032(r9)
> c0000000000805f4:	2f a9 00 00 	cmpdi   cr7,r9,0
> c0000000000805f8:	41 9e 00 18 	beq-    cr7,c000000000080610 <.xmon_core+0x160>
> c0000000000805fc:	3d 42 00 0f 	addis   r10,r2,15
> c000000000080600:	39 4a 3e 10 	addi    r10,r10,15888
> c000000000080604:	81 0a 66 50 	lwz     r8,26192(r10)
> c000000000080608:	2f 88 00 00 	cmpwi   cr7,r8,0
> c00000000008060c:	40 9e 22 b0 	bne-    cr7,c0000000000828bc <.xmon_core+0x240c>
> c000000000080610:	4b ff b2 51 	bl      c00000000007b860 <.get_output_lock>
> c000000000080614:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000080618:	e8 81 01 78 	ld      r4,376(r1)		; 376(r1) = cpu
> c00000000008061c:	38 63 8a e8 	addi    r3,r3,-29976
> c000000000080620:	48 00 32 21 	bl      c000000000083840 <.xmon_printf>
> c000000000080624:	60 00 00 00 	nop
> c000000000080628:	3d 22 00 0f 	addis   r9,r2,15
> c00000000008062c:	39 40 00 00 	li      r10,0
> c000000000080630:	80 c1 01 90 	lwz     r6,400(r1)
> c000000000080634:	91 49 3e 10 	stw     r10,15888(r9)
> c000000000080638:	39 20 00 01 	li      r9,1
> c00000000008063c:	7d 29 30 36 	sld     r9,r9,r6
> c000000000080640:	f9 21 01 80 	std     r9,384(r1)
> 
> /*
>  426                         if (fromipi)
>  427                                 goto leave;
> */
> c000000000080644:	e9 21 02 a8 	ld      r9,680(r1)
> c000000000080648:	3d 42 00 09 	addis   r10,r2,9
> c00000000008064c:	3c e2 00 0f 	addis   r7,r2,15
> c000000000080650:	39 4a 2f 00 	addi    r10,r10,12032
> c000000000080654:	39 00 00 01 	li      r8,1
> c000000000080658:	2f 29 00 00 	cmpdi   cr6,r9,0
> c00000000008065c:	48 00 00 2c 	b       c000000000080688 <.xmon_core+0x1d8>
> 
> 
> c000000000080660:	40 9a 00 ec 	bne-    cr6,c00000000008074c <.xmon_core+0x29c>
> c000000000080664:	7c 20 04 ac 	lwsync
> c000000000080668:	7f 80 50 a8 	ldarx   r28,0,r10
> c00000000008066c:	7f 89 43 78 	or      r9,r28,r8
> c000000000080670:	7d 20 51 ad 	stdcx.  r9,0,r10
> c000000000080674:	40 a2 ff f4 	bne-    c000000000080668 <.xmon_core+0x1b8>
> c000000000080678:	7c 00 04 ac 	sync    
> c00000000008067c:	7b 9c 07 e0 	clrldi  r28,r28,63
> c000000000080680:	2f bc 00 00 	cmpdi   cr7,r28,0
> c000000000080684:	41 9e 00 2c 	beq-    cr7,c0000000000806b0 <.xmon_core+0x200>
> c000000000080688:	39 27 3e 10 	addi    r9,r7,15888
> c00000000008068c:	81 29 66 50 	lwz     r9,26192(r9)
> c000000000080690:	2f 89 00 00 	cmpwi   cr7,r9,0
> c000000000080694:	40 9e 20 0c 	bne-    cr7,c0000000000826a0 <.xmon_core+0x21f0>
> c000000000080698:	e9 2a 00 00 	ld      r9,0(r10)
> c00000000008069c:	2f a9 00 00 	cmpdi   cr7,r9,0
> c0000000000806a0:	41 9e ff c0 	beq+    cr7,c000000000080660 <.xmon_core+0x1b0>
> c0000000000806a4:	7d 1c 43 78 	mr      r28,r8
> c0000000000806a8:	2f bc 00 00 	cmpdi   cr7,r28,0
> c0000000000806ac:	40 9e ff dc 	bne+    cr7,c000000000080688 <.xmon_core+0x1d8>
> c0000000000806b0:	3f a2 00 0f 	addis   r29,r2,15
> c0000000000806b4:	3b bd 3e 10 	addi    r29,r29,15888
> c0000000000806b8:	81 3d 66 50 	lwz     r9,26192(r29)
> c0000000000806bc:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000806c0:	41 9e 25 c8 	beq-    cr7,c000000000082c88 <.xmon_core+0x27d8>
> c0000000000806c4:	3d 22 00 09 	addis   r9,r2,9
> c0000000000806c8:	e9 29 2f 00 	ld      r9,12032(r9)
> 
> c0000000000806cc:	2f a9 00 00 	cmpdi   cr7,r9,0
> c0000000000806d0:	3c c2 ff d4 	addis   r6,r2,-44
> c0000000000806d4:	eb 61 01 78 	ld      r27,376(r1)
> c0000000000806d8:	3c e2 ff d4 	addis   r7,r2,-44
> c0000000000806dc:	3d 02 ff d4 	addis   r8,r2,-44
> c0000000000806e0:	3d 42 ff d4 	addis   r10,r2,-44
> c0000000000806e4:	39 e7 99 68 	addi    r15,r7,-26264
> c0000000000806e8:	3a 28 99 70 	addi    r17,r8,-26256
> c0000000000806ec:	3f a2 ff d4 	addis   r29,r2,-44
> c0000000000806f0:	3f c2 ff d4 	addis   r30,r2,-44
> c0000000000806f4:	38 c6 99 50 	addi    r6,r6,-26288
> c0000000000806f8:	39 4a 99 30 	addi    r10,r10,-26320
> c0000000000806fc:	fa 21 01 a0 	std     r17,416(r1)
> c000000000080700:	3f e2 00 0f 	addis   r31,r2,15
> c000000000080704:	7d f1 7b 78 	mr      r17,r15
> c000000000080708:	e9 e1 02 a0 	ld      r15,672(r1)
> c00000000008070c:	3b bd 8b b8 	addi    r29,r29,-29768
> c000000000080710:	3b de 8b c0 	addi    r30,r30,-29760
> c000000000080714:	f8 c1 01 98 	std     r6,408(r1)
> c000000000080718:	f9 41 01 b0 	std     r10,432(r1)
> c00000000008071c:	41 9e 00 30 	beq-    cr7,c00000000008074c <.xmon_core+0x29c>
> c000000000080720:	2f bc 00 00 	cmpdi   cr7,r28,0
> c000000000080724:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000080728:	41 9e 02 c8 	beq-    cr7,c0000000000809f0 <.xmon_core+0x540>
> c00000000008072c:	81 49 66 54 	lwz     r10,26196(r9)
> c000000000080730:	7f 8a d8 00 	cmpw    cr7,r10,r27
> c000000000080734:	41 9e 02 5c 	beq-    cr7,c000000000080990 <.xmon_core+0x4e0>
> c000000000080738:	3b 80 00 01 	li      r28,1
> c00000000008073c:	3d 22 00 09 	addis   r9,r2,9
> c000000000080740:	e9 29 2f 00 	ld      r9,12032(r9)
> c000000000080744:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000080748:	40 9e ff d8 	bne+    cr7,c000000000080720 <.xmon_core+0x270>
> 
> /*
>  487  leave:
>  488         cpumask_clear_cpu(cpu, &cpus_in_xmon);
>  489         xmon_fault_jmp[cpu] = NULL;
> */
> c00000000008074c:	3b 80 00 00 	li      r28,0
> c000000000080750:	e8 c1 01 88 	ld      r6,392(r1)
> c000000000080754:	3d 42 00 0f 	addis   r10,r2,15
> c000000000080758:	e8 e1 01 80 	ld      r7,384(r1)
> c00000000008075c:	39 4a 3e 10 	addi    r10,r10,15888
> c000000000080760:	39 0a 24 e8 	addi    r8,r10,9448
> c000000000080764:	78 c9 1f 24 	rldicr  r9,r6,3,60
> c000000000080768:	7d 28 4a 14 	add     r9,r8,r9
> c00000000008076c:	7d 00 48 a8 	ldarx   r8,0,r9
> c000000000080770:	7d 08 38 78 	andc    r8,r8,r7
> c000000000080774:	7d 00 49 ad 	stdcx.  r8,0,r9
> c000000000080778:	40 a2 ff f4 	bne-    c00000000008076c <.xmon_core+0x2bc>
> c00000000008077c:	e9 21 02 a0 	ld      r9,672(r1)
> c000000000080780:	3d 00 80 00 	lis     r8,-32768
> c000000000080784:	e8 c1 01 78 	ld      r6,376(r1)
> c000000000080788:	79 08 07 c6 	rldicr  r8,r8,32,31
> c00000000008078c:	e8 e9 01 08 	ld      r7,264(r9)
> c000000000080790:	3d 20 80 00 	lis     r9,-32768
> c000000000080794:	61 08 40 20 	ori     r8,r8,16416
> c000000000080798:	79 29 07 c6 	rldicr  r9,r9,32,31
> c00000000008079c:	7c e8 40 38 	and     r8,r7,r8
> c0000000000807a0:	61 29 00 20 	ori     r9,r9,32
> c0000000000807a4:	7f a8 48 00 	cmpd    cr7,r8,r9
> c0000000000807a8:	78 c7 1f 24 	rldicr  r7,r6,3,60
> c0000000000807ac:	7c ea 3a 14 	add     r7,r10,r7
> c0000000000807b0:	38 c0 00 00 	li      r6,0
> c0000000000807b4:	f8 c7 26 50 	std     r6,9808(r7)		; xmon_fault_jmp[cpu] = NULL;
> 
> /*
>  533         if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT)) {
> */
> c0000000000807b8:	41 9e 1f 34 	beq-    cr7,c0000000000826ec <.xmon_core+0x223c>
> /*
>  547         insert_cpu_bpts();
> */
> c0000000000807bc:	3d 42 00 0f 	addis   r10,r2,15
> c0000000000807c0:	39 4a 3e 10 	addi    r10,r10,15888
> c0000000000807c4:	81 2a 66 fc 	lwz     r9,26364(r10)
> c0000000000807c8:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000807cc:	40 9e 1e f4 	bne-    cr7,c0000000000826c0 <.xmon_core+0x2210>
> c0000000000807d0:	3d 22 00 0f 	addis   r9,r2,15
> c0000000000807d4:	39 29 3e 10 	addi    r9,r9,15888
> c0000000000807d8:	e9 29 67 08 	ld      r9,26376(r9)
> c0000000000807dc:	2f a9 00 00 	cmpdi   cr7,r9,0
> c0000000000807e0:	41 9e 00 30 	beq-    cr7,c000000000080810 <.xmon_core+0x360>
> c0000000000807e4:	3d 42 00 0b 	addis   r10,r2,11
> c0000000000807e8:	39 4a 69 18 	addi    r10,r10,26904
> c0000000000807ec:	e9 4a 00 00 	ld      r10,0(r10)
> c0000000000807f0:	e9 4a 00 10 	ld      r10,16(r10)
> c0000000000807f4:	79 46 e7 e1 	rldicl. r6,r10,28,63
> c0000000000807f8:	41 82 00 18 	beq-    c000000000080810 <.xmon_core+0x360>
> c0000000000807fc:	81 49 00 14 	lwz     r10,20(r9)
> c000000000080800:	e9 29 00 00 	ld      r9,0(r9)
> c000000000080804:	79 4a 07 a0 	clrldi  r10,r10,62
> c000000000080808:	7d 49 4b 78 	or      r9,r10,r9
> c00000000008080c:	7d 32 fb a6 	mtspr   1010,r9
> 
> /*
>  549         local_irq_restore(flags);
> */
> c000000000080810:	e8 e1 01 a8 	ld      r7,424(r1)
> c000000000080814:	2f a7 00 00 	cmpdi   cr7,r7,0
> c000000000080818:	40 9e 01 60 	bne-    cr7,c000000000080978 <.xmon_core+0x4c8>
> c00000000008081c:	38 60 00 00 	li      r3,0
> c000000000080820:	4b f8 f3 81 	bl      c00000000000fba0 <.arch_local_irq_restore>
> c000000000080824:	60 00 00 00 	nop
> c000000000080828:	2f 9c 00 58 	cmpwi   cr7,r28,88
> c00000000008082c:	38 60 00 00 	li      r3,0
> c000000000080830:	41 9e 00 18 	beq-    cr7,c000000000080848 <.xmon_core+0x398>
> c000000000080834:	3b 9c 00 01 	addi    r28,r28,1
> c000000000080838:	7f 9c 00 34 	cntlzw  r28,r28
> c00000000008083c:	57 9c d9 7e 	rlwinm  r28,r28,27,5,31
> c000000000080840:	6b 83 00 01 	xori    r3,r28,1
> c000000000080844:	7c 63 07 b4 	extsw   r3,r3
> c000000000080848:	38 21 02 70 	addi    r1,r1,624
> c00000000008084c:	e8 01 00 10 	ld      r0,16(r1)
> c000000000080850:	e9 c1 ff 70 	ld      r14,-144(r1)
> c000000000080854:	e9 e1 ff 78 	ld      r15,-136(r1)
> c000000000080858:	ea 01 ff 80 	ld      r16,-128(r1)
> c00000000008085c:	7c 08 03 a6 	mtlr    r0
> c000000000080860:	ea 21 ff 88 	ld      r17,-120(r1)
> c000000000080864:	ea 41 ff 90 	ld      r18,-112(r1)
> c000000000080868:	ea 61 ff 98 	ld      r19,-104(r1)
> c00000000008086c:	ea 81 ff a0 	ld      r20,-96(r1)
> c000000000080870:	ea a1 ff a8 	ld      r21,-88(r1)
> c000000000080874:	ea c1 ff b0 	ld      r22,-80(r1)
> c000000000080878:	ea e1 ff b8 	ld      r23,-72(r1)
> c00000000008087c:	eb 01 ff c0 	ld      r24,-64(r1)
> c000000000080880:	eb 21 ff c8 	ld      r25,-56(r1)
> c000000000080884:	eb 41 ff d0 	ld      r26,-48(r1)
> c000000000080888:	eb 61 ff d8 	ld      r27,-40(r1)
> c00000000008088c:	eb 81 ff e0 	ld      r28,-32(r1)
> c000000000080890:	eb a1 ff e8 	ld      r29,-24(r1)
> c000000000080894:	eb c1 ff f0 	ld      r30,-16(r1)
> c000000000080898:	eb e1 ff f8 	ld      r31,-8(r1)
> c00000000008089c:	4e 80 00 20 	blr
> /* } // Function end */
> 
> 
> 
> 
> 
> 
> 
> 
> 
> /*
>  399         xmon_fault_jmp[cpu] = recurse_jmp;
>  400         cpumask_set_cpu(cpu, &cpus_in_xmon);
>  401 
>  402         bp = NULL;
>  403         if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
>  404                 bp = at_breakpoint(regs->nip);
>  405         if (bp || unrecoverable_excp(regs))
>  406                 fromipi = 0;
> */
> c0000000000808a0:	e9 01 01 78 	ld      r8,376(r1)		; 376(r1) = cpu
> c0000000000808a4:	e8 c1 01 88 	ld      r6,392(r1)
> c0000000000808a8:	3d 42 00 0f 	addis   r10,r2,15
> c0000000000808ac:	39 4a 3e 10 	addi    r10,r10,15888
> c0000000000808b0:	79 07 1f 24 	rldicr  r7,r8,3,60
> c0000000000808b4:	78 c9 1f 24 	rldicr  r9,r6,3,60
> c0000000000808b8:	7c ea 3a 14 	add     r7,r10,r7
> c0000000000808bc:	38 c1 00 70 	addi    r6,r1,112
> c0000000000808c0:	f8 c7 26 50 	std     r6,9808(r7)		; xmon_fault_jmp[cpu] = recurse_jmp;
> c0000000000808c4:	80 c1 01 90 	lwz     r6,400(r1)
> c0000000000808c8:	38 e0 00 01 	li      r7,1
> c0000000000808cc:	39 0a 24 e8 	addi    r8,r10,9448
> c0000000000808d0:	7c e7 30 36 	sld     r7,r7,r6
> c0000000000808d4:	7d 28 4a 14 	add     r9,r8,r9
> c0000000000808d8:	f8 e1 01 80 	std     r7,384(r1)
> c0000000000808dc:	7d 00 48 a8 	ldarx   r8,0,r9
> c0000000000808e0:	7d 08 3b 78 	or      r8,r8,r7
> c0000000000808e4:	7d 00 49 ad 	stdcx.  r8,0,r9
> c0000000000808e8:	40 a2 ff f4 	bne-    c0000000000808dc <.xmon_core+0x42c>
> c0000000000808ec:	e9 21 02 a0 	ld      r9,672(r1)
> c0000000000808f0:	3d 00 80 00 	lis     r8,-32768
> c0000000000808f4:	38 c0 00 00 	li      r6,0
> c0000000000808f8:	79 08 07 c6 	rldicr  r8,r8,32,31
> c0000000000808fc:	f8 c1 01 70 	std     r6,368(r1)
> c000000000080900:	e8 e9 01 08 	ld      r7,264(r9)
> c000000000080904:	3d 20 80 00 	lis     r9,-32768
> c000000000080908:	61 08 40 20 	ori     r8,r8,16416
> c00000000008090c:	79 29 07 c6 	rldicr  r9,r9,32,31
> c000000000080910:	7c e8 40 38 	and     r8,r7,r8
> c000000000080914:	61 29 00 20 	ori     r9,r9,32
> c000000000080918:	7f a8 48 00 	cmpd    cr7,r8,r9
> c00000000008091c:	41 9e 1f cc 	beq-    cr7,c0000000000828e8 <.xmon_core+0x2438>	; call bp = at_breakpoint(regs->nip);
> c000000000080920:	78 e9 ff e3 	rldicl. r9,r7,63,63
> c000000000080924:	41 82 20 1c 	beq-    c000000000082940 <.xmon_core+0x2490>
> /*
>  408         if (!fromipi) {
> */
> c000000000080928:	e9 41 02 a8 	ld      r10,680(r1)
> c00000000008092c:	2f aa 00 00 	cmpdi   cr7,r10,0
> c000000000080930:	40 9e fd 14 	bne+    cr7,c000000000080644 <.xmon_core+0x194>
> c000000000080934:	48 00 20 0c 	b       c000000000082940 <.xmon_core+0x2490>
> c000000000080938:	60 00 00 00 	nop
> c00000000008093c:	60 00 00 00 	nop
> 
> /*
>  671 static struct bpt *in_breakpoint_table(unsigned long nip, unsigned long *offp)
> */
> c000000000080940:	7c c9 50 51 	subf.   r6,r9,r10
> c000000000080944:	f8 c1 01 70 	std     r6,368(r1)
> c000000000080948:	41 a2 fc 18 	beq-    c000000000080560 <.xmon_core+0xb0>
> c00000000008094c:	e9 06 00 00 	ld      r8,0(r6)
> c000000000080950:	e8 e1 02 a0 	ld      r7,672(r1)
> c000000000080954:	39 46 00 10 	addi    r10,r6,16
> c000000000080958:	39 08 ff f8 	addi    r8,r8,-8
> c00000000008095c:	7d 28 4a 14 	add     r9,r8,r9
> c000000000080960:	f9 27 01 00 	std     r9,256(r7)
> c000000000080964:	7d 20 50 28 	lwarx   r9,0,r10
> c000000000080968:	31 29 ff ff 	addic   r9,r9,-1
> c00000000008096c:	7d 20 51 2d 	stwcx.  r9,0,r10
> c000000000080970:	40 a2 ff f4 	bne-    c000000000080964 <.xmon_core+0x4b4>
> c000000000080974:	4b ff fb ec 	b       c000000000080560 <.xmon_core+0xb0>
> 
> 
> /*
>  549         local_irq_restore(flags);
> */
> c000000000080978:	e8 61 01 a8 	ld      r3,424(r1)
> c00000000008097c:	4b f8 f2 25 	bl      c00000000000fba0 <.arch_local_irq_restore>
> c000000000080980:	60 00 00 00 	nop
> c000000000080984:	4b ff fe a4 	b       c000000000080828 <.xmon_core+0x378>
> c000000000080988:	60 00 00 00 	nop
> c00000000008098c:	60 00 00 00 	nop
> 
> 
> c000000000080990:	3d 02 ff ed 	addis   r8,r2,-19
> c000000000080994:	39 40 00 01 	li      r10,1
> c000000000080998:	39 08 44 e8 	addi    r8,r8,17640
> c00000000008099c:	39 08 00 28 	addi    r8,r8,40
> c0000000000809a0:	7c 20 04 ac 	lwsync
> c0000000000809a4:	7c e0 40 a8 	ldarx   r7,0,r8
> c0000000000809a8:	7c e6 53 78 	or      r6,r7,r10
> c0000000000809ac:	7c c0 41 ad 	stdcx.  r6,0,r8
> c0000000000809b0:	40 a2 ff f4 	bne-    c0000000000809a4 <.xmon_core+0x4f4>
> c0000000000809b4:	7c 00 04 ac 	sync    
> c0000000000809b8:	78 ea 07 e1 	clrldi. r10,r7,63
> c0000000000809bc:	3b 80 00 00 	li      r28,0
> c0000000000809c0:	41 82 fd 7c 	beq+    c00000000008073c <.xmon_core+0x28c>
> c0000000000809c4:	48 00 00 10 	b       c0000000000809d4 <.xmon_core+0x524>
> c0000000000809c8:	60 00 00 00 	nop
> c0000000000809cc:	60 00 00 00 	nop
> 
> 
> c0000000000809d0:	39 3f 3e 10 	addi    r9,r31,15888
> c0000000000809d4:	81 29 66 54 	lwz     r9,26196(r9)
> c0000000000809d8:	7f 89 d8 00 	cmpw    cr7,r9,r27
> c0000000000809dc:	41 9e ff f4 	beq+    cr7,c0000000000809d0 <.xmon_core+0x520>
> c0000000000809e0:	4b ff fd 58 	b       c000000000080738 <.xmon_core+0x288>
> c0000000000809e4:	60 00 00 00 	nop
> c0000000000809e8:	60 00 00 00 	nop
> c0000000000809ec:	60 00 00 00 	nop
> 
> /*
>  787 static int
>  788 cmds(struct pt_regs *excp)
>  789 {
> */
> c0000000000809f0:	81 49 24 e0 	lwz     r10,9440(r9)
> c0000000000809f4:	fb 89 26 38 	std     r28,9784(r9)
> c0000000000809f8:	f9 e9 25 e8 	std     r15,9704(r9)
> c0000000000809fc:	2f 8a 00 00 	cmpwi   cr7,r10,0
> c000000000080a00:	41 9e 0f b0 	beq-    cr7,c0000000000819b0 <.xmon_core+0x1500>
> c000000000080a04:	3d 22 ff d4 	addis   r9,r2,-44
> c000000000080a08:	3a 49 99 18 	addi    r18,r9,-26344
> c000000000080a0c:	60 00 00 00 	nop
> 
> /* 
>  800         for(;;) {
> */
> /*
>  801 #ifdef CONFIG_SMP
>  802                 printf("%x:", smp_processor_id());
>  803 #endif \* CONFIG_SMP *\
>  804                 printf("mon> ");
>  805                 flush_input();
>  806                 termch = 0;
>  807                 cmd = skipbl();
> */
> c000000000080a10:	a0 8d 00 0a 	lhz     r4,10(r13)
> c000000000080a14:	7f a3 eb 78 	mr      r3,r29
> c000000000080a18:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000080a1c:	3b 20 00 00 	li      r25,0
> c000000000080a20:	48 00 2e 21 	bl      c000000000083840 <.xmon_printf>
> c000000000080a24:	60 00 00 00 	nop
> c000000000080a28:	7f c3 f3 78 	mr      r3,r30
> c000000000080a2c:	48 00 2e 15 	bl      c000000000083840 <.xmon_printf>
> c000000000080a30:	60 00 00 00 	nop
> c000000000080a34:	fb 3a 24 d0 	std     r25,9424(r26)
> c000000000080a38:	93 3a 24 d8 	stw     r25,9432(r26)
> c000000000080a3c:	4b ff e9 25 	bl      c00000000007f360 <.skipbl>
> /*
>  808                 if( cmd == '\n' ) {
> */
> c000000000080a40:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000080a44:	7c 7c 1b 78 	mr      r28,r3
> c000000000080a48:	41 9e 00 b8 	beq-    cr7,c000000000080b00 <.xmon_core+0x650>
> c000000000080a4c:	39 3c 00 01 	addi    r9,r28,1
> c000000000080a50:	2b 89 00 7b 	cmplwi  cr7,r9,123
> c000000000080a54:	40 9d 00 d4 	ble-    cr7,c000000000080b28 <.xmon_core+0x678>
> 
> /*
>  904                 default:
>  905                         printf("Unrecognized command: ");
>  906                         do {
>  907                                 if (' ' < cmd && cmd <= '~')
>  908                                         putchar(cmd);
>  909                                 else
>  910                                         printf("\\x%x", cmd);
>  911                                 cmd = inchar();
>  912                         } while (cmd != '\n');
>  913                         printf(" (type ? for help)\n");
>  914                         break;
>  915                 }
> */
> c000000000080a58:	e8 61 01 98 	ld      r3,408(r1)
> c000000000080a5c:	48 00 2d e5 	bl      c000000000083840 <.xmon_printf>
> c000000000080a60:	60 00 00 00 	nop
> c000000000080a64:	7f 84 e3 78 	mr      r4,r28
> c000000000080a68:	48 00 00 24 	b       c000000000080a8c <.xmon_core+0x5dc>
> c000000000080a6c:	60 00 00 00 	nop
> c000000000080a70:	7c 83 23 78 	mr      r3,r4
> c000000000080a74:	48 00 2a dd 	bl      c000000000083550 <.xmon_putchar>
> c000000000080a78:	60 00 00 00 	nop
> c000000000080a7c:	4b ff e2 75 	bl      c00000000007ecf0 <.inchar>
> c000000000080a80:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000080a84:	7c 64 1b 78 	mr      r4,r3
> c000000000080a88:	41 9e 00 2c 	beq-    cr7,c000000000080ab4 <.xmon_core+0x604>
> c000000000080a8c:	39 24 ff df 	addi    r9,r4,-33
> c000000000080a90:	2b 89 00 5d 	cmplwi  cr7,r9,93
> c000000000080a94:	40 9d ff dc 	ble+    cr7,c000000000080a70 <.xmon_core+0x5c0>
> c000000000080a98:	7e 23 8b 78 	mr      r3,r17
> c000000000080a9c:	48 00 2d a5 	bl      c000000000083840 <.xmon_printf>
> c000000000080aa0:	60 00 00 00 	nop
> c000000000080aa4:	4b ff e2 4d 	bl      c00000000007ecf0 <.inchar>
> c000000000080aa8:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000080aac:	7c 64 1b 78 	mr      r4,r3
> c000000000080ab0:	40 9e ff dc 	bne+    cr7,c000000000080a8c <.xmon_core+0x5dc>
> c000000000080ab4:	e8 61 01 a0 	ld      r3,416(r1)
> c000000000080ab8:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000080abc:	3b 20 00 00 	li      r25,0
> c000000000080ac0:	48 00 2d 81 	bl      c000000000083840 <.xmon_printf>
> c000000000080ac4:	60 00 00 00 	nop
> 
> /*
>  801 #ifdef CONFIG_SMP
>  802                 printf("%x:", smp_processor_id());
>  803 #endif \* CONFIG_SMP *\
>  804                 printf("mon> ");
>  805                 flush_input();
>  806                 termch = 0;
>  807                 cmd = skipbl();
>  808                 if( cmd == '\n' ) {
> */
> c000000000080ac8:	7f a3 eb 78 	mr      r3,r29
> c000000000080acc:	a0 8d 00 0a 	lhz     r4,10(r13)
> c000000000080ad0:	48 00 2d 71 	bl      c000000000083840 <.xmon_printf>
> c000000000080ad4:	60 00 00 00 	nop
> c000000000080ad8:	7f c3 f3 78 	mr      r3,r30
> c000000000080adc:	48 00 2d 65 	bl      c000000000083840 <.xmon_printf>
> c000000000080ae0:	60 00 00 00 	nop
> c000000000080ae4:	fb 3a 24 d0 	std     r25,9424(r26)
> c000000000080ae8:	93 3a 24 d8 	stw     r25,9432(r26)
> c000000000080aec:	4b ff e8 75 	bl      c00000000007f360 <.skipbl>
> c000000000080af0:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000080af4:	7c 7c 1b 78 	mr      r28,r3
> c000000000080af8:	40 9e ff 54 	bne+    cr7,c000000000080a4c <.xmon_core+0x59c>
> c000000000080afc:	60 00 00 00 	nop
> 
> /*
>  809                         if (last_cmd == NULL)
>  810                                 continue;
>  811                         take_input(last_cmd);
>  812                         last_cmd = NULL;
>  813                         cmd = inchar();
>  814                 }
> */
> c000000000080b00:	e9 3a 26 38 	ld      r9,9784(r26)
> c000000000080b04:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000080b08:	41 9e ff 08 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000080b0c:	f9 3a 24 d0 	std     r9,9424(r26)
> c000000000080b10:	fb 3a 26 38 	std     r25,9784(r26)
> c000000000080b14:	4b ff e1 dd 	bl      c00000000007ecf0 <.inchar>
> /*
>  815                 switch (cmd) {
> */
> c000000000080b18:	7c 7c 1b 78 	mr      r28,r3
> c000000000080b1c:	39 3c 00 01 	addi    r9,r28,1
> c000000000080b20:	2b 89 00 7b 	cmplwi  cr7,r9,123
> c000000000080b24:	41 9d ff 34 	bgt+    cr7,c000000000080a58 <.xmon_core+0x5a8>
> 
> c000000000080b28:	3d 42 ff 33 	addis   r10,r2,-205
> c000000000080b2c:	79 29 17 88 	rldic   r9,r9,2,30
> c000000000080b30:	39 4a f2 5c 	addi    r10,r10,-3492
> c000000000080b34:	7d 2a 4a aa 	lwax    r9,r10,r9
> c000000000080b38:	7d 49 52 14 	add     r10,r9,r10
> c000000000080b3c:	7d 49 03 a6 	mtctr   r10
> c000000000080b40:	4e 80 04 20 	bctr
> c000000000080b44:	00 00 03 8c 	.long 0x38c
> c000000000080b48:	ff ff ff 14 	.long 0xffffff14
> c000000000080b4c:	ff ff ff 14 	.long 0xffffff14
> c000000000080b50:	ff ff ff 14 	.long 0xffffff14
> c000000000080b54:	ff ff ff 14 	.long 0xffffff14
> c000000000080b58:	ff ff ff 14 	.long 0xffffff14
> c000000000080b5c:	ff ff ff 14 	.long 0xffffff14
> c000000000080b60:	ff ff ff 14 	.long 0xffffff14
> c000000000080b64:	ff ff ff 14 	.long 0xffffff14
> c000000000080b68:	ff ff ff 14 	.long 0xffffff14
> c000000000080b6c:	ff ff ff 14 	.long 0xffffff14
> c000000000080b70:	ff ff ff 14 	.long 0xffffff14
> c000000000080b74:	ff ff ff 14 	.long 0xffffff14
> c000000000080b78:	ff ff ff 14 	.long 0xffffff14
> c000000000080b7c:	ff ff ff 14 	.long 0xffffff14
> c000000000080b80:	ff ff ff 14 	.long 0xffffff14
> c000000000080b84:	ff ff ff 14 	.long 0xffffff14
> c000000000080b88:	ff ff ff 14 	.long 0xffffff14
> c000000000080b8c:	ff ff ff 14 	.long 0xffffff14
> c000000000080b90:	ff ff ff 14 	.long 0xffffff14
> c000000000080b94:	ff ff ff 14 	.long 0xffffff14
> c000000000080b98:	ff ff ff 14 	.long 0xffffff14
> c000000000080b9c:	ff ff ff 14 	.long 0xffffff14
> c000000000080ba0:	ff ff ff 14 	.long 0xffffff14
> c000000000080ba4:	ff ff ff 14 	.long 0xffffff14
> c000000000080ba8:	ff ff ff 14 	.long 0xffffff14
> c000000000080bac:	ff ff ff 14 	.long 0xffffff14
> c000000000080bb0:	ff ff ff 14 	.long 0xffffff14
> c000000000080bb4:	ff ff ff 14 	.long 0xffffff14
> c000000000080bb8:	ff ff ff 14 	.long 0xffffff14
> c000000000080bbc:	ff ff ff 14 	.long 0xffffff14
> c000000000080bc0:	ff ff ff 14 	.long 0xffffff14
> c000000000080bc4:	ff ff ff 14 	.long 0xffffff14
> c000000000080bc8:	ff ff ff 14 	.long 0xffffff14
> c000000000080bcc:	ff ff ff 14 	.long 0xffffff14
> c000000000080bd0:	ff ff ff 14 	.long 0xffffff14
> c000000000080bd4:	ff ff ff 14 	.long 0xffffff14
> c000000000080bd8:	ff ff ff 14 	.long 0xffffff14
> c000000000080bdc:	ff ff ff 14 	.long 0xffffff14
> c000000000080be0:	ff ff ff 14 	.long 0xffffff14
> c000000000080be4:	ff ff ff 14 	.long 0xffffff14
> c000000000080be8:	ff ff ff 14 	.long 0xffffff14
> c000000000080bec:	ff ff ff 14 	.long 0xffffff14
> c000000000080bf0:	ff ff ff 14 	.long 0xffffff14
> c000000000080bf4:	ff ff ff 14 	.long 0xffffff14
> c000000000080bf8:	ff ff ff 14 	.long 0xffffff14
> c000000000080bfc:	ff ff ff 14 	.long 0xffffff14
> c000000000080c00:	ff ff ff 14 	.long 0xffffff14
> c000000000080c04:	ff ff ff 14 	.long 0xffffff14
> c000000000080c08:	ff ff ff 14 	.long 0xffffff14
> c000000000080c0c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c10:	ff ff ff 14 	.long 0xffffff14
> c000000000080c14:	ff ff ff 14 	.long 0xffffff14
> c000000000080c18:	ff ff ff 14 	.long 0xffffff14
> c000000000080c1c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c20:	ff ff ff 14 	.long 0xffffff14
> c000000000080c24:	ff ff ff 14 	.long 0xffffff14
> c000000000080c28:	ff ff ff 14 	.long 0xffffff14
> c000000000080c2c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c30:	ff ff ff 14 	.long 0xffffff14
> c000000000080c34:	ff ff ff 14 	.long 0xffffff14
> c000000000080c38:	ff ff ff 14 	.long 0xffffff14
> c000000000080c3c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c40:	ff ff ff 14 	.long 0xffffff14
> c000000000080c44:	00 00 03 6c 	.long 0x36c
> c000000000080c48:	ff ff ff 14 	.long 0xffffff14
> c000000000080c4c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c50:	ff ff ff 14 	.long 0xffffff14
> c000000000080c54:	00 00 03 bc 	.long 0x3bc
> c000000000080c58:	ff ff ff 14 	.long 0xffffff14
> c000000000080c5c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c60:	ff ff ff 14 	.long 0xffffff14
> c000000000080c64:	ff ff ff 14 	.long 0xffffff14
> c000000000080c68:	ff ff ff 14 	.long 0xffffff14
> c000000000080c6c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c70:	ff ff ff 14 	.long 0xffffff14
> c000000000080c74:	ff ff ff 14 	.long 0xffffff14
> c000000000080c78:	ff ff ff 14 	.long 0xffffff14
> c000000000080c7c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c80:	ff ff ff 14 	.long 0xffffff14
> c000000000080c84:	ff ff ff 14 	.long 0xffffff14
> c000000000080c88:	ff ff ff 14 	.long 0xffffff14
> c000000000080c8c:	ff ff ff 14 	.long 0xffffff14
> c000000000080c90:	ff ff ff 14 	.long 0xffffff14
> c000000000080c94:	00 00 03 2c 	.long 0x32c
> c000000000080c98:	ff ff ff 14 	.long 0xffffff14
> c000000000080c9c:	ff ff ff 14 	.long 0xffffff14
> c000000000080ca0:	ff ff ff 14 	.long 0xffffff14
> c000000000080ca4:	ff ff ff 14 	.long 0xffffff14
> c000000000080ca8:	00 00 02 4c 	.long 0x24c
> c000000000080cac:	ff ff ff 14 	.long 0xffffff14
> c000000000080cb0:	ff ff ff 14 	.long 0xffffff14
> c000000000080cb4:	ff ff ff 14 	.long 0xffffff14
> c000000000080cb8:	ff ff ff 14 	.long 0xffffff14
> c000000000080cbc:	ff ff ff 14 	.long 0xffffff14
> c000000000080cc0:	ff ff ff 14 	.long 0xffffff14
> c000000000080cc4:	ff ff ff 14 	.long 0xffffff14
> c000000000080cc8:	ff ff ff 14 	.long 0xffffff14
> c000000000080ccc:	ff ff ff 14 	.long 0xffffff14
> c000000000080cd0:	00 00 0b 8c 	.long 0xb8c
> c000000000080cd4:	00 00 0a ec 	.long 0xaec
> c000000000080cd8:	00 00 0a 0c 	.long 0xa0c
> c000000000080cdc:	00 00 09 fc 	.long 0x9fc
> c000000000080ce0:	00 00 09 ec 	.long 0x9ec
> c000000000080ce4:	ff ff ff 14 	.long 0xffffff14
> c000000000080ce8:	ff ff ff 14 	.long 0xffffff14
> c000000000080cec:	ff ff ff 14 	.long 0xffffff14
> c000000000080cf0:	ff ff ff 14 	.long 0xffffff14
> c000000000080cf4:	ff ff ff 14 	.long 0xffffff14
> c000000000080cf8:	00 00 09 dc 	.long 0x9dc
> c000000000080cfc:	00 00 05 1c 	.long 0x51c
> c000000000080d00:	ff ff ff 14 	.long 0xffffff14
> c000000000080d04:	ff ff ff 14 	.long 0xffffff14
> c000000000080d08:	00 00 05 0c 	.long 0x50c
> c000000000080d0c:	ff ff ff 14 	.long 0xffffff14
> c000000000080d10:	00 00 0c fc 	.long 0xcfc
> c000000000080d14:	00 00 01 fc 	.long 0x1fc
> c000000000080d18:	00 00 0c cc 	.long 0xccc
> c000000000080d1c:	00 00 04 fc 	.long 0x4fc
> c000000000080d20:	ff ff ff 14 	.long 0xffffff14
> c000000000080d24:	ff ff ff 14 	.long 0xffffff14
> c000000000080d28:	00 00 02 4c 	.long 0x24c
> c000000000080d2c:	ff ff ff 14 	.long 0xffffff14
> c000000000080d30:	00 00 04 ac 	.long 0x4ac
> c000000000080d34:	60 00 00 00 	nop
> c000000000080d38:	60 00 00 00 	nop
> c000000000080d3c:	60 00 00 00 	nop
>  816                 case 'm':
>  817                         cmd = inchar();
>  818                         switch (cmd) {
>  819                         case 'm':
>  820                         case 's':
>  821                         case 'd':
>  822                                 memops(cmd);
>  823                                 break;
>  824                         case 'l':
>  825                                 memlocate();
>  826                                 break;
>  827                         case 'z':
>  828                                 memzcan();
>  829                                 break;
>  830                         case 'i':
>  831                                 show_mem(0);
>  832                                 break;
>  833                         default:
>  834                                 termch = cmd;
>  835                                 memex();
>  836                         }
>  837                         break;
> c000000000080d40:	4b ff df b1 	bl      c00000000007ecf0 <.inchar>
> c000000000080d44:	2f 83 00 66 	cmpwi   cr7,r3,102
> c000000000080d48:	7c 7a 1b 78 	mr      r26,r3
> c000000000080d4c:	41 9e 15 50 	beq-    cr7,c00000000008229c <.xmon_core+0x1dec>
> c000000000080d50:	41 9d 10 f0 	bgt-    cr7,c000000000081e40 <.xmon_core+0x1990>
> c000000000080d54:	2f 83 00 64 	cmpwi   cr7,r3,100
> c000000000080d58:	41 9e 16 10 	beq-    cr7,c000000000082368 <.xmon_core+0x1eb8>
> c000000000080d5c:	3d 40 80 00 	lis     r10,-32768
> c000000000080d60:	e9 0f 01 08 	ld      r8,264(r15)
> c000000000080d64:	3d 20 80 00 	lis     r9,-32768
> c000000000080d68:	79 4a 07 c6 	rldicr  r10,r10,32,31
> c000000000080d6c:	79 29 07 c6 	rldicr  r9,r9,32,31
> c000000000080d70:	61 4a 40 20 	ori     r10,r10,16416
> c000000000080d74:	61 29 00 20 	ori     r9,r9,32
> c000000000080d78:	7d 0a 50 38 	and     r10,r8,r10
> c000000000080d7c:	7f aa 48 00 	cmpd    cr7,r10,r9
> c000000000080d80:	41 9e 21 4c 	beq-    cr7,c000000000082ecc <.xmon_core+0x2a1c>
> c000000000080d84:	e9 41 02 a0 	ld      r10,672(r1)
> c000000000080d88:	61 08 04 00 	ori     r8,r8,1024
> c000000000080d8c:	f9 0a 01 08 	std     r8,264(r10)
> c000000000080d90:	3c e2 ff d4 	addis   r7,r2,-44
> c000000000080d94:	3f e2 00 0f 	addis   r31,r2,15
> c000000000080d98:	3b ff 3e 10 	addi    r31,r31,15888
> c000000000080d9c:	3c c0 fc 00 	lis     r6,-1024
> c000000000080da0:	3b 07 99 c8 	addi    r24,r7,-26168
> c000000000080da4:	3c e0 fc 00 	lis     r7,-1024
> c000000000080da8:	7f fb fb 78 	mr      r27,r31
> c000000000080dac:	3d 02 ff ed 	addis   r8,r2,-19
> c000000000080db0:	3d 42 ff d4 	addis   r10,r2,-44
> c000000000080db4:	3d 22 ff d4 	addis   r9,r2,-44
> c000000000080db8:	60 da 07 be 	ori     r26,r6,1982
> c000000000080dbc:	60 f7 07 fe 	ori     r23,r7,2046
> c000000000080dc0:	3c c0 7c 00 	lis     r6,31744
> c000000000080dc4:	3c e0 4c 00 	lis     r7,19456
> c000000000080dc8:	3b ff 00 08 	addi    r31,r31,8
> c000000000080dcc:	60 d9 01 24 	ori     r25,r6,292
> c000000000080dd0:	60 f6 00 24 	ori     r22,r7,36
> c000000000080dd4:	3a a8 44 e8 	addi    r21,r8,17640
> c000000000080dd8:	3a 8a 9a 10 	addi    r20,r10,-26096
> c000000000080ddc:	3a 69 99 88 	addi    r19,r9,-26232
> c000000000080de0:	3b db 20 08 	addi    r30,r27,8200
> c000000000080de4:	48 00 00 18 	b       c000000000080dfc <.xmon_core+0x94c>
> c000000000080de8:	60 00 00 00 	nop
> c000000000080dec:	60 00 00 00 	nop
> 
> 
> c000000000080df0:	3b ff 00 20 	addi    r31,r31,32
> c000000000080df4:	7f bf f0 00 	cmpd    cr7,r31,r30
> c000000000080df8:	41 9e 00 50 	beq-    cr7,c000000000080e48 <.xmon_core+0x998>
> c000000000080dfc:	81 3f 00 14 	lwz     r9,20(r31)
> c000000000080e00:	71 26 00 0a 	andi.   r6,r9,10
> c000000000080e04:	41 82 ff ec 	beq+    c000000000080df0 <.xmon_core+0x940>
> c000000000080e08:	3b bf 00 08 	addi    r29,r31,8
> c000000000080e0c:	e8 7f 00 00 	ld      r3,0(r31)
> c000000000080e10:	38 a0 00 04 	li      r5,4
> c000000000080e14:	7f a4 eb 78 	mr      r4,r29
> c000000000080e18:	4b ff b5 a9 	bl      c00000000007c3c0 <.mread>
> c000000000080e1c:	2f 83 00 04 	cmpwi   cr7,r3,4
> c000000000080e20:	41 9e 0a b0 	beq-    cr7,c0000000000818d0 <.xmon_core+0x1420>
> c000000000080e24:	e8 9f 00 00 	ld      r4,0(r31)
> c000000000080e28:	7e 63 9b 78 	mr      r3,r19
> c000000000080e2c:	48 00 2a 15 	bl      c000000000083840 <.xmon_printf>
> c000000000080e30:	60 00 00 00 	nop
> c000000000080e34:	39 20 00 00 	li      r9,0
> c000000000080e38:	91 3f 00 14 	stw     r9,20(r31)
> c000000000080e3c:	3b ff 00 20 	addi    r31,r31,32
> c000000000080e40:	7f bf f0 00 	cmpd    cr7,r31,r30
> c000000000080e44:	40 9e ff b8 	bne+    cr7,c000000000080dfc <.xmon_core+0x94c>
> c000000000080e48:	39 20 00 00 	li      r9,0
> c000000000080e4c:	91 3b 66 50 	stw     r9,26192(r27)
> c000000000080e50:	7c 00 04 ac 	sync    
> c000000000080e54:	3d 22 00 09 	addis   r9,r2,9
> c000000000080e58:	39 40 00 00 	li      r10,0
> c000000000080e5c:	f9 49 2f 00 	std     r10,12032(r9)
> c000000000080e60:	4b ff f8 f0 	b       c000000000080750 <.xmon_core+0x2a0>
> c000000000080e64:	60 00 00 00 	nop
> c000000000080e68:	60 00 00 00 	nop
> c000000000080e6c:	60 00 00 00 	nop
> 
> /*
> 1620 static void super_regs(void)
> 1621 {
> 1622         int cmd;
> 1623         unsigned long val;
> 1624 
> 1625         cmd = skipbl();
> 1626         if (cmd == '\n') {
> 1627                 unsigned long sp, toc;
> 1628                 asm("mr %0,1" : "=r" (sp) :);
> 1629                 asm("mr %0,2" : "=r" (toc) :);
> 1630 
> 1631                 printf("msr  = "REG"  sprg0= "REG"\n",
> 1632                        mfmsr(), mfspr(SPRN_SPRG0));
> 1633                 printf("pvr  = "REG"  sprg1= "REG"\n",
> 1634                        mfspr(SPRN_PVR), mfspr(SPRN_SPRG1));
> 1635                 printf("dec  = "REG"  sprg2= "REG"\n",
> 1636                        mfspr(SPRN_DEC), mfspr(SPRN_SPRG2));
> 1637                 printf("sp   = "REG"  sprg3= "REG"\n", sp, mfspr(SPRN_SPRG3));
> 1638                 printf("toc  = "REG"  dar  = "REG"\n", toc, mfspr(SPRN_DAR));
> 1639 
> 1640                 return;
> 1641         }
> 1642 
> 1643         scanhex(&regno);
> 1644         switch (cmd) {
> */
> c000000000080e70:	4b ff e4 f1 	bl      c00000000007f360 <.skipbl>
> c000000000080e74:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000080e78:	7c 7c 1b 78 	mr      r28,r3
> c000000000080e7c:	41 9e 14 68 	beq-    cr7,c0000000000822e4 <.xmon_core+0x1e34>
> c000000000080e80:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000080e84:	38 7a 66 d8 	addi    r3,r26,26328
> c000000000080e88:	4b ff e5 39 	bl      c00000000007f3c0 <.scanhex>
> c000000000080e8c:	2f 9c 00 72 	cmpwi   cr7,r28,114
> c000000000080e90:	41 9e 09 e0 	beq-    cr7,c000000000081870 <.xmon_core+0x13c0>
> c000000000080e94:	2f 9c 00 77 	cmpwi   cr7,r28,119
> c000000000080e98:	41 9e 09 b4 	beq-    cr7,c00000000008184c <.xmon_core+0x139c>
> c000000000080e9c:	4b ff de e5 	bl      c00000000007ed80 <.scannl>
> c000000000080ea0:	4b ff fb 70 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000080ea4:	60 00 00 00 	nop
> c000000000080ea8:	60 00 00 00 	nop
> c000000000080eac:	60 00 00 00 	nop
> 
> 
> c000000000080eb0:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000080eb4:	38 63 92 48 	addi    r3,r3,-28088
> c000000000080eb8:	48 00 2a 29 	bl      c0000000000838e0 <.xmon_puts>
> c000000000080ebc:	60 00 00 00 	nop
> 
> 
> c000000000080ec0:	4b ff fb 50 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000080ec4:	60 00 00 00 	nop
> c000000000080ec8:	60 00 00 00 	nop
> c000000000080ecc:	60 00 00 00 	nop
> 
> 
> c000000000080ed0:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000080ed4:	38 63 92 30 	addi    r3,r3,-28112
> c000000000080ed8:	48 00 29 69 	bl      c000000000083840 <.xmon_printf>
> c000000000080edc:	60 00 00 00 	nop
> c000000000080ee0:	3c 60 00 1e 	lis     r3,30
> c000000000080ee4:	60 63 84 80 	ori     r3,r3,33920
> c000000000080ee8:	4b f9 c4 29 	bl      c00000000001d310 <.udelay>
> c000000000080eec:	60 00 00 00 	nop
> c000000000080ef0:	4b ff fe a0 	b       c000000000080d90 <.xmon_core+0x8e0>
> c000000000080ef4:	60 00 00 00 	nop
> c000000000080ef8:	60 00 00 00 	nop
> c000000000080efc:	60 00 00 00 	nop
> 
> 
> c000000000080f00:	38 7f 3e 10 	addi    r3,r31,15888
> c000000000080f04:	38 63 25 f0 	addi    r3,r3,9712
> c000000000080f08:	4b ff e4 b9 	bl      c00000000007f3c0 <.scanhex>
> c000000000080f0c:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000080f10:	41 9e fb 00 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000080f14:	3e e2 ff ed 	addis   r23,r2,-19
> c000000000080f18:	3b 97 44 e8 	addi    r28,r23,17640
> c000000000080f1c:	38 7c 00 58 	addi    r3,r28,88
> c000000000080f20:	4b ff e4 a1 	bl      c00000000007f3c0 <.scanhex>
> c000000000080f24:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000080f28:	41 9e fa e8 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000080f2c:	e9 3c 00 58 	ld      r9,88(r28)
> c000000000080f30:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000080f34:	41 9e 20 ac 	beq-    cr7,c000000000082fe0 <.xmon_core+0x2b30>
> c000000000080f38:	3b 40 ff ff 	li      r26,-1
> c000000000080f3c:	3e c2 ff b1 	addis   r22,r2,-79
> c000000000080f40:	3b 80 00 00 	li      r28,0
> c000000000080f44:	7b 5a 04 20 	clrldi  r26,r26,48
> c000000000080f48:	3b 20 00 00 	li      r25,0
> c000000000080f4c:	3a d6 08 f0 	addi    r22,r22,2288
> c000000000080f50:	48 00 00 48 	b       c000000000080f98 <.xmon_core+0xae8>
> c000000000080f54:	60 00 00 00 	nop
> c000000000080f58:	60 00 00 00 	nop
> c000000000080f5c:	60 00 00 00 	nop
> 
> 
> c000000000080f60:	89 21 01 60 	lbz     r9,352(r1)
> c000000000080f64:	39 57 44 e8 	addi    r10,r23,17640
> c000000000080f68:	3b 9c 00 01 	addi    r28,r28,1
> c000000000080f6c:	e9 4a 00 58 	ld      r10,88(r10)
> c000000000080f70:	7b 9c 00 20 	clrldi  r28,r28,32
> c000000000080f74:	7d 29 d2 78 	xor     r9,r9,r26
> c000000000080f78:	7b 5a c2 02 	rldicl  r26,r26,56,8
> c000000000080f7c:	79 29 0d e8 	rldic   r9,r9,1,55
> c000000000080f80:	7f bc 50 40 	cmpld   cr7,r28,r10
> c000000000080f84:	7d 36 4a 14 	add     r9,r22,r9
> c000000000080f88:	7f 99 e3 78 	mr      r25,r28
> c000000000080f8c:	a1 29 01 78 	lhz     r9,376(r9)
> c000000000080f90:	7d 3a d2 78 	xor     r26,r9,r26
> c000000000080f94:	40 9c 1c 14 	bge-    cr7,c000000000082ba8 <.xmon_core+0x26f8>
> c000000000080f98:	3b 1f 3e 10 	addi    r24,r31,15888
> c000000000080f9c:	38 81 01 60 	addi    r4,r1,352
> c000000000080fa0:	e8 78 25 f0 	ld      r3,9712(r24)
> c000000000080fa4:	38 a0 00 01 	li      r5,1
> c000000000080fa8:	7c 79 1a 14 	add     r3,r25,r3
> c000000000080fac:	4b ff b4 15 	bl      c00000000007c3c0 <.mread>
> c000000000080fb0:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000080fb4:	40 9e ff ac 	bne+    cr7,c000000000080f60 <.xmon_core+0xab0>
> c000000000080fb8:	e8 98 25 f0 	ld      r4,9712(r24)
> c000000000080fbc:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000080fc0:	38 63 98 f0 	addi    r3,r3,-26384
> c000000000080fc4:	7c 99 22 14 	add     r4,r25,r4
> c000000000080fc8:	48 00 28 79 	bl      c000000000083840 <.xmon_printf>
> c000000000080fcc:	60 00 00 00 	nop
> c000000000080fd0:	7f 44 07 b4 	extsw   r4,r26
> c000000000080fd4:	3c 62 ff d3 	addis   r3,r2,-45
> c000000000080fd8:	38 63 8a b8 	addi    r3,r3,-30024
> c000000000080fdc:	48 00 28 65 	bl      c000000000083840 <.xmon_printf>
> c000000000080fe0:	60 00 00 00 	nop
> c000000000080fe4:	4b ff fa 2c 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000080fe8:	60 00 00 00 	nop
> c000000000080fec:	60 00 00 00 	nop
> 
> 
> c000000000080ff0:	4b ff dd 01 	bl      c00000000007ecf0 <.inchar>
> c000000000080ff4:	2f 83 00 72 	cmpwi   cr7,r3,114
> c000000000080ff8:	41 9e 1a e4 	beq-    cr7,c000000000082adc <.xmon_core+0x262c>
> c000000000080ffc:	2f 83 00 68 	cmpwi   cr7,r3,104
> c000000000081000:	41 9e 1b 3c 	beq-    cr7,c000000000082b3c <.xmon_core+0x268c>
> c000000000081004:	2f 83 00 70 	cmpwi   cr7,r3,112
> c000000000081008:	40 9e fa 08 	bne+    cr7,c000000000080a10 <.xmon_core+0x560>
> c00000000008100c:	3d 22 00 0b 	addis   r9,r2,11
> c000000000081010:	39 29 6a 30 	addi    r9,r9,27184
> c000000000081014:	e9 29 01 30 	ld      r9,304(r9)
> c000000000081018:	e9 49 00 00 	ld      r10,0(r9)
> c00000000008101c:	f8 41 00 28 	std     r2,40(r1)
> c000000000081020:	7d 49 03 a6 	mtctr   r10
> c000000000081024:	e8 49 00 08 	ld      r2,8(r9)
> c000000000081028:	4e 80 04 21 	bctrl
> c00000000008102c:	e8 41 00 28 	ld      r2,40(r1)
> c000000000081030:	4b ff f9 e0 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081034:	60 00 00 00 	nop
> c000000000081038:	60 00 00 00 	nop
> c00000000008103c:	60 00 00 00 	nop
> 
> 
> c000000000081040:	4b ff ef e1 	bl      c000000000080020 <.dump_segments>
> c000000000081044:	4b ff f9 cc 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081048:	60 00 00 00 	nop
> c00000000008104c:	60 00 00 00 	nop
> 
> 
> c000000000081050:	4b ff ec 31 	bl      c00000000007fc80 <.proccall>
> c000000000081054:	4b ff f9 bc 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081058:	60 00 00 00 	nop
> c00000000008105c:	60 00 00 00 	nop
> 
> c000000000081060:	4b ff dc 91 	bl      c00000000007ecf0 <.inchar>
> c000000000081064:	39 23 ff 9c 	addi    r9,r3,-100
> c000000000081068:	7c 7c 1b 78 	mr      r28,r3
> c00000000008106c:	2b 89 00 16 	cmplwi  cr7,r9,22
> c000000000081070:	40 9d 09 80 	ble-    cr7,c0000000000819f0 <.xmon_core+0x1540>
> c000000000081074:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000081078:	38 7a 25 f0 	addi    r3,r26,9712
> c00000000008107c:	93 9a 24 d8 	stw     r28,9432(r26)
> c000000000081080:	4b ff e3 41 	bl      c00000000007f3c0 <.scanhex>
> c000000000081084:	4b ff e2 dd 	bl      c00000000007f360 <.skipbl>
> c000000000081088:	2f 83 00 3f 	cmpwi   cr7,r3,63
> c00000000008108c:	41 9e 1e fc 	beq-    cr7,c000000000082f88 <.xmon_core+0x2ad8>
> c000000000081090:	3d 22 ff d4 	addis   r9,r2,-44
> c000000000081094:	90 7a 24 d8 	stw     r3,9432(r26)
> c000000000081098:	39 29 8d f8 	addi    r9,r9,-29192
> c00000000008109c:	3f 82 ff ed 	addis   r28,r2,-19
> c0000000000810a0:	f9 3a 26 38 	std     r9,9784(r26)
> c0000000000810a4:	3a c0 00 04 	li      r22,4
> c0000000000810a8:	3a e0 00 02 	li      r23,2
> c0000000000810ac:	3b 40 00 01 	li      r26,1
> c0000000000810b0:	3b 00 00 08 	li      r24,8
> c0000000000810b4:	3b 20 00 00 	li      r25,0
> c0000000000810b8:	60 00 00 00 	nop
> c0000000000810bc:	60 00 00 00 	nop
> c0000000000810c0:	4b ff e2 a1 	bl      c00000000007f360 <.skipbl>
> c0000000000810c4:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c0000000000810c8:	41 9e 00 3c 	beq-    cr7,c000000000081104 <.xmon_core+0xc54>
> c0000000000810cc:	2f 83 00 6c 	cmpwi   cr7,r3,108
> c0000000000810d0:	41 9e 08 80 	beq-    cr7,c000000000081950 <.xmon_core+0x14a0>
> c0000000000810d4:	41 9d 07 cc 	bgt-    cr7,c0000000000818a0 <.xmon_core+0x13f0>
> c0000000000810d8:	2f 83 00 62 	cmpwi   cr7,r3,98
> c0000000000810dc:	41 9e 08 94 	beq-    cr7,c000000000081970 <.xmon_core+0x14c0>
> c0000000000810e0:	2f 83 00 64 	cmpwi   cr7,r3,100
> c0000000000810e4:	41 9e 08 7c 	beq-    cr7,c000000000081960 <.xmon_core+0x14b0>
> c0000000000810e8:	2f 83 00 2e 	cmpwi   cr7,r3,46
> c0000000000810ec:	40 9e ff d4 	bne+    cr7,c0000000000810c0 <.xmon_core+0xc10>
> c0000000000810f0:	39 3f 3e 10 	addi    r9,r31,15888
> c0000000000810f4:	93 29 66 d4 	stw     r25,26324(r9)
> c0000000000810f8:	4b ff e2 69 	bl      c00000000007f360 <.skipbl>
> c0000000000810fc:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000081100:	40 9e ff cc 	bne+    cr7,c0000000000810cc <.xmon_core+0xc1c>
> c000000000081104:	3d 42 ff ed 	addis   r10,r2,-19
> c000000000081108:	39 4a 44 e8 	addi    r10,r10,17640
> c00000000008110c:	81 2a 00 40 	lwz     r9,64(r10)
> c000000000081110:	2f 89 00 00 	cmpwi   cr7,r9,0
> c000000000081114:	40 9d 1b 28 	ble-    cr7,c000000000082c3c <.xmon_core+0x278c>
> c000000000081118:	2f 89 00 08 	cmpwi   cr7,r9,8
> c00000000008111c:	41 9d 18 ac 	bgt-    cr7,c0000000000829c8 <.xmon_core+0x2518>
> c000000000081120:	3d 42 ff d4 	addis   r10,r2,-44
> c000000000081124:	fb 61 01 c0 	std     r27,448(r1)
> c000000000081128:	39 4a 8e 10 	addi    r10,r10,-29168
> c00000000008112c:	fb c1 01 c8 	std     r30,456(r1)
> c000000000081130:	f9 41 01 b8 	std     r10,440(r1)
> c000000000081134:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081138:	3c e2 ff d4 	addis   r7,r2,-44
> c00000000008113c:	3e c2 ff d5 	addis   r22,r2,-43
> c000000000081140:	e8 89 25 f0 	ld      r4,9712(r9)
> c000000000081144:	3d 02 ff b1 	addis   r8,r2,-79
> c000000000081148:	3f 02 ff d4 	addis   r24,r2,-44
> c00000000008114c:	7d 3c 4b 78 	mr      r28,r9
> c000000000081150:	3f 42 ff ed 	addis   r26,r2,-19
> c000000000081154:	39 c7 8e 00 	addi    r14,r7,-29184
> c000000000081158:	3a d6 f5 50 	addi    r22,r22,-2736
> c00000000008115c:	3a 68 08 f0 	addi    r19,r8,2288
> c000000000081160:	3b 18 86 58 	addi    r24,r24,-31144
> c000000000081164:	3e e2 ff 33 	addis   r23,r2,-205
> c000000000081168:	81 3c 66 d4 	lwz     r9,26324(r28)
> c00000000008116c:	2f 89 00 00 	cmpwi   cr7,r9,0
> c000000000081170:	41 9e 1a 00 	beq-    cr7,c000000000082b70 <.xmon_core+0x26c0>
> c000000000081174:	80 bc 66 d0 	lwz     r5,26320(r28)
> c000000000081178:	39 20 ff ae 	li      r9,-82
> c00000000008117c:	7d c3 73 78 	mr      r3,r14
> c000000000081180:	7c a5 00 34 	cntlzw  r5,r5
> c000000000081184:	54 a5 d9 7e 	rlwinm  r5,r5,27,5,31
> c000000000081188:	78 a5 00 20 	clrldi  r5,r5,32
> c00000000008118c:	7c a5 00 d0 	neg     r5,r5
> c000000000081190:	7c a5 48 38 	and     r5,r5,r9
> c000000000081194:	38 a5 00 72 	addi    r5,r5,114
> c000000000081198:	48 00 26 a9 	bl      c000000000083840 <.xmon_printf>
> c00000000008119c:	60 00 00 00 	nop
> c0000000000811a0:	81 3c 66 d4 	lwz     r9,26324(r28)
> c0000000000811a4:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000811a8:	40 9e 00 a8 	bne-    cr7,c000000000081250 <.xmon_core+0xda0>
> c0000000000811ac:	81 3c 66 d0 	lwz     r9,26320(r28)
> c0000000000811b0:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000811b4:	40 9e 18 88 	bne-    cr7,c000000000082a3c <.xmon_core+0x258c>
> c0000000000811b8:	38 60 00 20 	li      r3,32
> c0000000000811bc:	48 00 23 95 	bl      c000000000083550 <.xmon_putchar>
> c0000000000811c0:	60 00 00 00 	nop
> c0000000000811c4:	e9 21 01 60 	ld      r9,352(r1)
> c0000000000811c8:	2f a9 00 00 	cmpdi   cr7,r9,0
> c0000000000811cc:	41 9e 1e 20 	beq-    cr7,c000000000082fec <.xmon_core+0x2b3c>
> c0000000000811d0:	3a a1 01 27 	addi    r21,r1,295
> c0000000000811d4:	3b 60 00 01 	li      r27,1
> c0000000000811d8:	60 00 00 00 	nop
> c0000000000811dc:	60 00 00 00 	nop
> c0000000000811e0:	8c 95 00 01 	lbzu    r4,1(r21)
> c0000000000811e4:	7f 03 c3 78 	mr      r3,r24
> c0000000000811e8:	7f 79 07 b4 	extsw   r25,r27
> c0000000000811ec:	48 00 26 55 	bl      c000000000083840 <.xmon_printf>
> c0000000000811f0:	60 00 00 00 	nop
> c0000000000811f4:	e9 21 01 60 	ld      r9,352(r1)
> c0000000000811f8:	7f a9 d8 40 	cmpld   cr7,r9,r27
> c0000000000811fc:	3b 7b 00 01 	addi    r27,r27,1
> c000000000081200:	41 9d ff e0 	bgt+    cr7,c0000000000811e0 <.xmon_core+0xd30>
> c000000000081204:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000081208:	81 29 00 40 	lwz     r9,64(r9)
> c00000000008120c:	7f 89 c8 00 	cmpw    cr7,r9,r25
> c000000000081210:	40 9d 00 40 	ble-    cr7,c000000000081250 <.xmon_core+0xda0>
> c000000000081214:	60 00 00 00 	nop
> c000000000081218:	60 00 00 00 	nop
> c00000000008121c:	60 00 00 00 	nop
> c000000000081220:	e9 3c 21 4a 	lwa     r9,8520(r28)
> c000000000081224:	7e c3 b3 78 	mr      r3,r22
> c000000000081228:	79 29 1f 24 	rldicr  r9,r9,3,60
> c00000000008122c:	7c 93 48 2a 	ldx     r4,r19,r9
> c000000000081230:	48 00 26 11 	bl      c000000000083840 <.xmon_printf>
> c000000000081234:	60 00 00 00 	nop
> c000000000081238:	39 3a 44 e8 	addi    r9,r26,17640
> c00000000008123c:	81 49 00 40 	lwz     r10,64(r9)
> c000000000081240:	39 39 00 01 	addi    r9,r25,1
> c000000000081244:	7d 39 07 b4 	extsw   r25,r9
> c000000000081248:	7f 8a 48 00 	cmpw    cr7,r10,r9
> c00000000008124c:	41 9d ff d4 	bgt+    cr7,c000000000081220 <.xmon_core+0xd70>
> c000000000081250:	38 60 00 20 	li      r3,32
> c000000000081254:	3b 20 00 00 	li      r25,0
> c000000000081258:	48 00 22 f9 	bl      c000000000083550 <.xmon_putchar>
> c00000000008125c:	60 00 00 00 	nop
> c000000000081260:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000081264:	3b 60 00 00 	li      r27,0
> c000000000081268:	ea 89 00 42 	lwa     r20,64(r9)
> c00000000008126c:	3a a0 00 0a 	li      r21,10
> c000000000081270:	3b c0 00 0d 	li      r30,13
> c000000000081274:	60 00 00 00 	nop
> c000000000081278:	60 00 00 00 	nop
> c00000000008127c:	60 00 00 00 	nop
> c000000000081280:	38 61 01 60 	addi    r3,r1,352
> c000000000081284:	4b ff e1 3d 	bl      c00000000007f3c0 <.scanhex>
> c000000000081288:	2f a3 00 00 	cmpdi   cr7,r3,0
> c00000000008128c:	41 9e 00 6c 	beq-    cr7,c0000000000812f8 <.xmon_core+0xe48>
> c000000000081290:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000081294:	80 e9 00 40 	lwz     r7,64(r9)
> c000000000081298:	2f 87 00 00 	cmpwi   cr7,r7,0
> c00000000008129c:	7c e5 07 b4 	extsw   r5,r7
> c0000000000812a0:	40 9d 00 38 	ble-    cr7,c0000000000812d8 <.xmon_core+0xe28>
> c0000000000812a4:	e8 c1 01 60 	ld      r6,352(r1)
> c0000000000812a8:	39 01 01 27 	addi    r8,r1,295
> c0000000000812ac:	78 e7 18 28 	rldic   r7,r7,3,32
> c0000000000812b0:	7f 69 db 78 	mr      r9,r27
> c0000000000812b4:	60 00 00 00 	nop
> c0000000000812b8:	60 00 00 00 	nop
> c0000000000812bc:	60 00 00 00 	nop
> c0000000000812c0:	39 49 00 08 	addi    r10,r9,8
> c0000000000812c4:	7c c9 4c 36 	srd     r9,r6,r9
> c0000000000812c8:	7f 8a 38 40 	cmplw   cr7,r10,r7
> c0000000000812cc:	9d 28 00 01 	stbu    r9,1(r8)
> c0000000000812d0:	79 49 00 20 	clrldi  r9,r10,32
> c0000000000812d4:	40 9e ff ec 	bne+    cr7,c0000000000812c0 <.xmon_core+0xe10>
> c0000000000812d8:	81 3c 66 d0 	lwz     r9,26320(r28)
> c0000000000812dc:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000812e0:	41 9e 13 90 	beq-    cr7,c000000000082670 <.xmon_core+0x21c0>
> c0000000000812e4:	e8 7c 25 f0 	ld      r3,9712(r28)
> c0000000000812e8:	38 81 01 28 	addi    r4,r1,296
> c0000000000812ec:	4b ff b9 35 	bl      c00000000007cc20 <.mwrite>
> c0000000000812f0:	39 3a 44 e8 	addi    r9,r26,17640
> c0000000000812f4:	ea 89 00 42 	lwa     r20,64(r9)
> c0000000000812f8:	4b ff e0 69 	bl      c00000000007f360 <.skipbl>
> c0000000000812fc:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c000000000081300:	41 9e 18 98 	beq-    cr7,c000000000082b98 <.xmon_core+0x26e8>
> c000000000081304:	38 63 00 01 	addi    r3,r3,1
> c000000000081308:	7f 74 db 78 	mr      r20,r27
> c00000000008130c:	2b 83 00 79 	cmplwi  cr7,r3,121
> c000000000081310:	41 9d ff 70 	bgt+    cr7,c000000000081280 <.xmon_core+0xdd0>
> c000000000081314:	39 37 fa 44 	addi    r9,r23,-1468
> c000000000081318:	78 63 17 88 	rldic   r3,r3,2,30
> c00000000008131c:	7d 49 1a aa 	lwax    r10,r9,r3
> c000000000081320:	7d 2a 4a 14 	add     r9,r10,r9
> c000000000081324:	7d 29 03 a6 	mtctr   r9
> c000000000081328:	4e 80 04 20 	bctr
> c00000000008132c:	00 00 13 14 	.long 0x1314
> c000000000081330:	ff ff ff 54 	.long 0xffffff54
> c000000000081334:	ff ff ff 54 	.long 0xffffff54
> c000000000081338:	ff ff ff 54 	.long 0xffffff54
> c00000000008133c:	ff ff ff 54 	.long 0xffffff54
> c000000000081340:	ff ff ff 54 	.long 0xffffff54
> c000000000081344:	ff ff ff 54 	.long 0xffffff54
> c000000000081348:	ff ff ff 54 	.long 0xffffff54
> c00000000008134c:	ff ff ff 54 	.long 0xffffff54
> c000000000081350:	ff ff ff 54 	.long 0xffffff54
> c000000000081354:	ff ff ff 54 	.long 0xffffff54
> c000000000081358:	ff ff ff 54 	.long 0xffffff54
> c00000000008135c:	ff ff ff 54 	.long 0xffffff54
> c000000000081360:	ff ff ff 54 	.long 0xffffff54
> c000000000081364:	ff ff ff 54 	.long 0xffffff54
> c000000000081368:	ff ff ff 54 	.long 0xffffff54
> c00000000008136c:	ff ff ff 54 	.long 0xffffff54
> c000000000081370:	ff ff ff 54 	.long 0xffffff54
> c000000000081374:	ff ff ff 54 	.long 0xffffff54
> c000000000081378:	ff ff ff 54 	.long 0xffffff54
> c00000000008137c:	ff ff ff 54 	.long 0xffffff54
> c000000000081380:	ff ff ff 54 	.long 0xffffff54
> c000000000081384:	ff ff ff 54 	.long 0xffffff54
> c000000000081388:	ff ff ff 54 	.long 0xffffff54
> c00000000008138c:	ff ff ff 54 	.long 0xffffff54
> c000000000081390:	ff ff ff 54 	.long 0xffffff54
> c000000000081394:	ff ff ff 54 	.long 0xffffff54
> c000000000081398:	ff ff ff 54 	.long 0xffffff54
> c00000000008139c:	ff ff ff 54 	.long 0xffffff54
> c0000000000813a0:	ff ff ff 54 	.long 0xffffff54
> c0000000000813a4:	ff ff ff 54 	.long 0xffffff54
> c0000000000813a8:	ff ff ff 54 	.long 0xffffff54
> c0000000000813ac:	ff ff ff 54 	.long 0xffffff54
> c0000000000813b0:	ff ff ff 54 	.long 0xffffff54
> c0000000000813b4:	ff ff ff 54 	.long 0xffffff54
> c0000000000813b8:	ff ff ff 54 	.long 0xffffff54
> c0000000000813bc:	ff ff ff 54 	.long 0xffffff54
> c0000000000813c0:	ff ff ff 54 	.long 0xffffff54
> c0000000000813c4:	ff ff ff 54 	.long 0xffffff54
> c0000000000813c8:	ff ff ff 54 	.long 0xffffff54
> c0000000000813cc:	00 00 12 48 	.long 0x1248
> c0000000000813d0:	ff ff ff 54 	.long 0xffffff54
> c0000000000813d4:	ff ff ff 54 	.long 0xffffff54
> c0000000000813d8:	ff ff ff 54 	.long 0xffffff54
> c0000000000813dc:	ff ff ff 54 	.long 0xffffff54
> c0000000000813e0:	00 00 12 2c 	.long 0x122c
> c0000000000813e4:	ff ff ff 54 	.long 0xffffff54
> c0000000000813e8:	00 00 12 1c 	.long 0x121c
> c0000000000813ec:	00 00 11 e0 	.long 0x11e0
> c0000000000813f0:	ff ff ff 54 	.long 0xffffff54
> c0000000000813f4:	ff ff ff 54 	.long 0xffffff54
> c0000000000813f8:	ff ff ff 54 	.long 0xffffff54
> c0000000000813fc:	ff ff ff 54 	.long 0xffffff54
> c000000000081400:	ff ff ff 54 	.long 0xffffff54
> c000000000081404:	ff ff ff 54 	.long 0xffffff54
> c000000000081408:	ff ff ff 54 	.long 0xffffff54
> c00000000008140c:	ff ff ff 54 	.long 0xffffff54
> c000000000081410:	ff ff ff 54 	.long 0xffffff54
> c000000000081414:	ff ff ff 54 	.long 0xffffff54
> c000000000081418:	ff ff ff 54 	.long 0xffffff54
> c00000000008141c:	ff ff ff 54 	.long 0xffffff54
> c000000000081420:	00 00 11 a0 	.long 0x11a0
> c000000000081424:	ff ff ff 54 	.long 0xffffff54
> c000000000081428:	00 00 11 74 	.long 0x1174
> c00000000008142c:	00 00 11 60 	.long 0x1160
> c000000000081430:	ff ff ff 54 	.long 0xffffff54
> c000000000081434:	ff ff ff 54 	.long 0xffffff54
> c000000000081438:	ff ff ff 54 	.long 0xffffff54
> c00000000008143c:	ff ff ff 54 	.long 0xffffff54
> c000000000081440:	ff ff ff 54 	.long 0xffffff54
> c000000000081444:	ff ff ff 54 	.long 0xffffff54
> c000000000081448:	ff ff ff 54 	.long 0xffffff54
> c00000000008144c:	ff ff ff 54 	.long 0xffffff54
> c000000000081450:	ff ff ff 54 	.long 0xffffff54
> c000000000081454:	ff ff ff 54 	.long 0xffffff54
> c000000000081458:	ff ff ff 54 	.long 0xffffff54
> c00000000008145c:	ff ff ff 54 	.long 0xffffff54
> c000000000081460:	ff ff ff 54 	.long 0xffffff54
> c000000000081464:	ff ff ff 54 	.long 0xffffff54
> c000000000081468:	ff ff ff 54 	.long 0xffffff54
> c00000000008146c:	ff ff ff 54 	.long 0xffffff54
> c000000000081470:	ff ff ff 54 	.long 0xffffff54
> c000000000081474:	ff ff ff 54 	.long 0xffffff54
> c000000000081478:	ff ff ff 54 	.long 0xffffff54
> c00000000008147c:	ff ff ff 54 	.long 0xffffff54
> c000000000081480:	ff ff ff 54 	.long 0xffffff54
> c000000000081484:	ff ff ff 54 	.long 0xffffff54
> c000000000081488:	ff ff ff 54 	.long 0xffffff54
> c00000000008148c:	ff ff ff 54 	.long 0xffffff54
> c000000000081490:	ff ff ff 54 	.long 0xffffff54
> c000000000081494:	ff ff ff 54 	.long 0xffffff54
> c000000000081498:	ff ff ff 54 	.long 0xffffff54
> c00000000008149c:	ff ff ff 54 	.long 0xffffff54
> c0000000000814a0:	00 00 11 3c 	.long 0x113c
> c0000000000814a4:	ff ff ff 54 	.long 0xffffff54
> c0000000000814a8:	00 00 11 20 	.long 0x1120
> c0000000000814ac:	ff ff ff 54 	.long 0xffffff54
> c0000000000814b0:	ff ff ff 54 	.long 0xffffff54
> c0000000000814b4:	ff ff ff 54 	.long 0xffffff54
> c0000000000814b8:	00 00 11 0c 	.long 0x110c
> c0000000000814bc:	ff ff ff 54 	.long 0xffffff54
> c0000000000814c0:	ff ff ff 54 	.long 0xffffff54
> c0000000000814c4:	ff ff ff 54 	.long 0xffffff54
> c0000000000814c8:	ff ff ff 54 	.long 0xffffff54
> c0000000000814cc:	ff ff ff 54 	.long 0xffffff54
> c0000000000814d0:	ff ff ff 54 	.long 0xffffff54
> c0000000000814d4:	ff ff ff 54 	.long 0xffffff54
> c0000000000814d8:	ff ff ff 54 	.long 0xffffff54
> c0000000000814dc:	ff ff ff 54 	.long 0xffffff54
> c0000000000814e0:	00 00 10 f8 	.long 0x10f8
> c0000000000814e4:	00 00 10 e4 	.long 0x10e4
> c0000000000814e8:	00 00 10 d4 	.long 0x10d4
> c0000000000814ec:	ff ff ff 54 	.long 0xffffff54
> c0000000000814f0:	ff ff ff 54 	.long 0xffffff54
> c0000000000814f4:	ff ff ff 54 	.long 0xffffff54
> c0000000000814f8:	00 00 10 bc 	.long 0x10bc
> c0000000000814fc:	ff ff ff 54 	.long 0xffffff54
> c000000000081500:	ff ff ff 54 	.long 0xffffff54
> c000000000081504:	00 00 10 a8 	.long 0x10a8
> c000000000081508:	00 00 11 0c 	.long 0x110c
> c00000000008150c:	00 00 11 cc 	.long 0x11cc
> c000000000081510:	00 00 13 14 	.long 0x1314
> c000000000081514:	60 00 00 00 	nop
> c000000000081518:	60 00 00 00 	nop
> c00000000008151c:	60 00 00 00 	nop
> c000000000081520:	4b ff e9 a1 	bl      c00000000007fec0 <.symbol_lookup>
> c000000000081524:	4b ff f4 ec 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081528:	60 00 00 00 	nop
> c00000000008152c:	60 00 00 00 	nop
> 
> 
> c000000000081530:	4b ff e5 d1 	bl      c00000000007fb00 <.cacheflush>
> c000000000081534:	4b ff f4 dc 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081538:	60 00 00 00 	nop
> c00000000008153c:	60 00 00 00 	nop
> 
> 
> c000000000081540:	7d e3 7b 78 	mr      r3,r15
> c000000000081544:	4b ff db 1d 	bl      c00000000007f060 <.excprint>
> c000000000081548:	4b ff f4 c8 	b       c000000000080a10 <.xmon_core+0x560>
> c00000000008154c:	60 00 00 00 	nop
> 
> 
> c000000000081550:	4b ff d7 a1 	bl      c00000000007ecf0 <.inchar>
> c000000000081554:	2f 83 00 70 	cmpwi   cr7,r3,112
> c000000000081558:	7c 7c 1b 78 	mr      r28,r3
> c00000000008155c:	41 9e 15 ac 	beq-    cr7,c000000000082b08 <.xmon_core+0x2658>
> c000000000081560:	78 69 00 20 	clrldi  r9,r3,32
> c000000000081564:	39 49 ff d0 	addi    r10,r9,-48
> c000000000081568:	2b 8a 00 09 	cmplwi  cr7,r10,9
> c00000000008156c:	40 9d 04 74 	ble-    cr7,c0000000000819e0 <.xmon_core+0x1530>
> c000000000081570:	39 49 ff 9f 	addi    r10,r9,-97
> c000000000081574:	2b 8a 00 05 	cmplwi  cr7,r10,5
> c000000000081578:	40 9d 0b e8 	ble-    cr7,c000000000082160 <.xmon_core+0x1cb0>
> c00000000008157c:	39 29 ff bf 	addi    r9,r9,-65
> c000000000081580:	2b 89 00 05 	cmplwi  cr7,r9,5
> c000000000081584:	41 9d 04 48 	bgt-    cr7,c0000000000819cc <.xmon_core+0x151c>
> c000000000081588:	2f 9c 00 64 	cmpwi   cr7,r28,100
> c00000000008158c:	40 9e 04 54 	bne-    cr7,c0000000000819e0 <.xmon_core+0x1530>
> c000000000081590:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000081594:	38 7a 25 f0 	addi    r3,r26,9712
> c000000000081598:	4b ff de 29 	bl      c00000000007f3c0 <.scanhex>
> c00000000008159c:	81 3a 24 d8 	lwz     r9,9432(r26)
> c0000000000815a0:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c0000000000815a4:	41 9e 00 0c 	beq-    cr7,c0000000000815b0 <.xmon_core+0x1100>
> c0000000000815a8:	39 20 00 00 	li      r9,0
> c0000000000815ac:	91 3a 24 d8 	stw     r9,9432(r26)
> c0000000000815b0:	2f 9c 00 69 	cmpwi   cr7,r28,105
> c0000000000815b4:	41 9e 12 30 	beq-    cr7,c0000000000827e4 <.xmon_core+0x2334>
> c0000000000815b8:	2f 9c 00 6c 	cmpwi   cr7,r28,108
> c0000000000815bc:	41 9e 15 d4 	beq-    cr7,c000000000082b90 <.xmon_core+0x26e0>
> c0000000000815c0:	2f 9c 00 72 	cmpwi   cr7,r28,114
> c0000000000815c4:	3f 82 ff ed 	addis   r28,r2,-19
> c0000000000815c8:	3b 9c 44 e8 	addi    r28,r28,17640
> c0000000000815cc:	38 7c 00 50 	addi    r3,r28,80
> c0000000000815d0:	41 9e 0b a8 	beq-    cr7,c000000000082178 <.xmon_core+0x1cc8>
> c0000000000815d4:	4b ff dd ed 	bl      c00000000007f3c0 <.scanhex>
> c0000000000815d8:	e8 9c 00 50 	ld      r4,80(r28)
> c0000000000815dc:	2f a4 00 00 	cmpdi   cr7,r4,0
> c0000000000815e0:	40 9e 0a 10 	bne-    cr7,c000000000081ff0 <.xmon_core+0x1b40>
> c0000000000815e4:	39 20 00 40 	li      r9,64
> c0000000000815e8:	38 80 00 40 	li      r4,64
> c0000000000815ec:	f9 3c 00 50 	std     r9,80(r28)
> c0000000000815f0:	3b 9f 3e 10 	addi    r28,r31,15888
> c0000000000815f4:	e8 7c 25 f0 	ld      r3,9712(r28)
> c0000000000815f8:	4b ff d2 99 	bl      c00000000007e890 <.prdump>
> c0000000000815fc:	3d 22 ff ed 	addis   r9,r2,-19
> c000000000081600:	e9 5c 25 f0 	ld      r10,9712(r28)
> c000000000081604:	39 29 44 e8 	addi    r9,r9,17640
> c000000000081608:	e9 09 00 50 	ld      r8,80(r9)
> c00000000008160c:	3d 22 ff db 	addis   r9,r2,-37
> c000000000081610:	39 29 df 10 	addi    r9,r9,-8432
> c000000000081614:	7d 48 52 14 	add     r10,r8,r10
> c000000000081618:	f9 3c 26 38 	std     r9,9784(r28)
> c00000000008161c:	f9 5c 25 f0 	std     r10,9712(r28)
> c000000000081620:	4b ff f3 f0 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081624:	60 00 00 00 	nop
> c000000000081628:	60 00 00 00 	nop
> c00000000008162c:	60 00 00 00 	nop
> 
> 
> c000000000081630:	38 61 01 60 	addi    r3,r1,352
> c000000000081634:	4b ff dd 8d 	bl      c00000000007f3c0 <.scanhex>
> c000000000081638:	2f a3 00 00 	cmpdi   cr7,r3,0
> c00000000008163c:	41 9e 08 1c 	beq-    cr7,c000000000081e58 <.xmon_core+0x19a8>
> c000000000081640:	e8 81 01 60 	ld      r4,352(r1)
> c000000000081644:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081648:	39 09 24 e8 	addi    r8,r9,9448
> c00000000008164c:	7c 8a 36 70 	srawi   r10,r4,6
> c000000000081650:	7d 4a 01 94 	addze   r10,r10
> c000000000081654:	7d 4a 07 b4 	extsw   r10,r10
> c000000000081658:	79 4a 1f 24 	rldicr  r10,r10,3,60
> c00000000008165c:	7d 08 50 2a 	ldx     r8,r8,r10
> c000000000081660:	78 8a 06 a0 	clrldi  r10,r4,58
> c000000000081664:	7d 0a 54 36 	srd     r10,r8,r10
> c000000000081668:	79 48 07 e1 	clrldi. r8,r10,63
> c00000000008166c:	41 82 10 44 	beq-    c0000000000826b0 <.xmon_core+0x2200>
> c000000000081670:	3d 02 ff ed 	addis   r8,r2,-19
> c000000000081674:	38 e0 00 00 	li      r7,0
> c000000000081678:	39 48 44 e8 	addi    r10,r8,17640
> c00000000008167c:	f8 ea 00 28 	std     r7,40(r10)
> c000000000081680:	7c 00 04 ac 	sync    
> c000000000081684:	e8 e1 01 60 	ld      r7,352(r1)
> c000000000081688:	90 e9 66 54 	stw     r7,26196(r9)
> c00000000008168c:	e9 2a 00 28 	ld      r9,40(r10)
> c000000000081690:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000081694:	40 9e 00 30 	bne-    cr7,c0000000000816c4 <.xmon_core+0x1214>
> c000000000081698:	3d 40 00 98 	lis     r10,152
> c00000000008169c:	61 46 96 7f 	ori     r6,r10,38527
> c0000000000816a0:	7c c9 03 a6 	mtctr   r6
> c0000000000816a4:	48 00 00 10 	b       c0000000000816b4 <.xmon_core+0x1204>
> c0000000000816a8:	60 00 00 00 	nop
> c0000000000816ac:	60 00 00 00 	nop
> 
> 
> c0000000000816b0:	42 40 13 e0 	bdz-    c000000000082a90 <.xmon_core+0x25e0>
> c0000000000816b4:	39 28 44 e8 	addi    r9,r8,17640
> c0000000000816b8:	e9 49 00 28 	ld      r10,40(r9)
> c0000000000816bc:	2f aa 00 00 	cmpdi   cr7,r10,0
> c0000000000816c0:	41 9e ff f0 	beq+    cr7,c0000000000816b0 <.xmon_core+0x1200>
> c0000000000816c4:	3b 80 00 01 	li      r28,1
> c0000000000816c8:	4b ff f0 74 	b       c00000000008073c <.xmon_core+0x28c>
> c0000000000816cc:	60 00 00 00 	nop
> 
> 
> c0000000000816d0:	3d 22 ff d4 	addis   r9,r2,-44
> c0000000000816d4:	39 29 9a 90 	addi    r9,r9,-25968
> c0000000000816d8:	e8 69 00 00 	ld      r3,0(r9)
> c0000000000816dc:	e8 89 00 08 	ld      r4,8(r9)
> c0000000000816e0:	e8 a9 00 10 	ld      r5,16(r9)
> c0000000000816e4:	e8 c9 00 18 	ld      r6,24(r9)
> c0000000000816e8:	e8 e9 00 20 	ld      r7,32(r9)
> c0000000000816ec:	e9 09 00 28 	ld      r8,40(r9)
> c0000000000816f0:	81 49 00 30 	lwz     r10,48(r9)
> c0000000000816f4:	89 29 00 34 	lbz     r9,52(r9)
> c0000000000816f8:	f8 61 01 28 	std     r3,296(r1)
> c0000000000816fc:	f8 81 01 30 	std     r4,304(r1)
> c000000000081700:	f8 a1 01 38 	std     r5,312(r1)
> c000000000081704:	f8 c1 01 40 	std     r6,320(r1)
> c000000000081708:	f8 e1 01 48 	std     r7,328(r1)
> c00000000008170c:	f9 01 01 50 	std     r8,336(r1)
> c000000000081710:	91 41 01 58 	stw     r10,344(r1)
> c000000000081714:	99 21 01 5c 	stb     r9,348(r1)
> c000000000081718:	4b ff d5 d9 	bl      c00000000007ecf0 <.inchar>
> c00000000008171c:	2f 83 00 64 	cmpwi   cr7,r3,100
> c000000000081720:	41 9e 09 c4 	beq-    cr7,c0000000000820e4 <.xmon_core+0x1c34>
> c000000000081724:	2f 83 00 69 	cmpwi   cr7,r3,105
> c000000000081728:	41 9e 09 38 	beq-    cr7,c000000000082060 <.xmon_core+0x1bb0>
> c00000000008172c:	2f 83 00 63 	cmpwi   cr7,r3,99
> c000000000081730:	41 9e 08 d8 	beq-    cr7,c000000000082008 <.xmon_core+0x1b58>
> c000000000081734:	3b 9f 3e 10 	addi    r28,r31,15888
> c000000000081738:	90 7c 24 d8 	stw     r3,9432(r28)
> c00000000008173c:	4b ff dc 25 	bl      c00000000007f360 <.skipbl>
> c000000000081740:	2f 83 00 3f 	cmpwi   cr7,r3,63
> c000000000081744:	7c 69 1b 78 	mr      r9,r3
> c000000000081748:	41 9e 14 80 	beq-    cr7,c000000000082bc8 <.xmon_core+0x2718>
> c00000000008174c:	38 61 01 60 	addi    r3,r1,352
> c000000000081750:	91 3c 24 d8 	stw     r9,9432(r28)
> c000000000081754:	4b ff dc 6d 	bl      c00000000007f3c0 <.scanhex>
> c000000000081758:	2f a3 00 00 	cmpdi   cr7,r3,0
> c00000000008175c:	40 9e 11 30 	bne-    cr7,c00000000008288c <.xmon_core+0x23dc>
> c000000000081760:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000081764:	38 63 98 a8 	addi    r3,r3,-26456
> c000000000081768:	48 00 20 d9 	bl      c000000000083840 <.xmon_printf>
> c00000000008176c:	60 00 00 00 	nop
> c000000000081770:	81 3c 66 fc 	lwz     r9,26364(r28)
> c000000000081774:	2f 89 00 00 	cmpwi   cr7,r9,0
> c000000000081778:	40 9e 12 d8 	bne-    cr7,c000000000082a50 <.xmon_core+0x25a0>
> c00000000008177c:	3b 3f 3e 10 	addi    r25,r31,15888
> c000000000081780:	3e c2 ff d4 	addis   r22,r2,-44
> c000000000081784:	3e e2 ff d8 	addis   r23,r2,-40
> c000000000081788:	3f 02 ff d5 	addis   r24,r2,-43
> c00000000008178c:	3b 99 00 08 	addi    r28,r25,8
> c000000000081790:	3b 40 00 00 	li      r26,0
> c000000000081794:	3a d6 98 e0 	addi    r22,r22,-26400
> c000000000081798:	3a f7 b7 38 	addi    r23,r23,-18632
> c00000000008179c:	3b 18 0e 68 	addi    r24,r24,3688
> c0000000000817a0:	3e 82 ff d3 	addis   r20,r2,-45
> c0000000000817a4:	3e a2 ff d4 	addis   r21,r2,-44
> c0000000000817a8:	3b 39 20 08 	addi    r25,r25,8200
> c0000000000817ac:	48 00 00 34 	b       c0000000000817e0 <.xmon_core+0x1330>
> 
> 
> c0000000000817b0:	38 b5 8a a0 	addi    r5,r21,-30048
> c0000000000817b4:	7e c3 b3 78 	mr      r3,r22
> c0000000000817b8:	48 00 20 89 	bl      c000000000083840 <.xmon_printf>
> c0000000000817bc:	60 00 00 00 	nop
> c0000000000817c0:	e8 7c 00 00 	ld      r3,0(r28)
> c0000000000817c4:	7e e4 bb 78 	mr      r4,r23
> c0000000000817c8:	7f 05 c3 78 	mr      r5,r24
> c0000000000817cc:	4b ff aa 95 	bl      c00000000007c260 <.xmon_print_symbol>
> c0000000000817d0:	3b 9c 00 20 	addi    r28,r28,32
> c0000000000817d4:	3b 5a 00 20 	addi    r26,r26,32
> c0000000000817d8:	7f bc c8 40 	cmpld   cr7,r28,r25
> c0000000000817dc:	40 9c f2 34 	bge+    cr7,c000000000080a10 <.xmon_core+0x560>
> c0000000000817e0:	81 3c 00 14 	lwz     r9,20(r28)
> c0000000000817e4:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000817e8:	41 9e ff e8 	beq+    cr7,c0000000000817d0 <.xmon_core+0x1320>
> c0000000000817ec:	79 26 ff e3 	rldicl. r6,r9,63,63
> c0000000000817f0:	7f 44 2e 74 	sradi   r4,r26,5
> c0000000000817f4:	38 84 00 01 	addi    r4,r4,1
> c0000000000817f8:	40 82 ff b8 	bne+    c0000000000817b0 <.xmon_core+0x1300>
> c0000000000817fc:	38 b4 a1 88 	addi    r5,r20,-24184
> c000000000081800:	4b ff ff b4 	b       c0000000000817b4 <.xmon_core+0x1304>
> c000000000081804:	60 00 00 00 	nop
> c000000000081808:	60 00 00 00 	nop
> c00000000008180c:	60 00 00 00 	nop
> 
> 
> c000000000081810:	38 61 01 60 	addi    r3,r1,352
> c000000000081814:	4b ff db ad 	bl      c00000000007f3c0 <.scanhex>
> c000000000081818:	2f a3 00 00 	cmpdi   cr7,r3,0
> c00000000008181c:	40 9e 06 04 	bne-    cr7,c000000000081e20 <.xmon_core+0x1970>
> c000000000081820:	e8 6f 00 08 	ld      r3,8(r15)
> c000000000081824:	e8 8f 01 20 	ld      r4,288(r15)
> c000000000081828:	e8 af 01 00 	ld      r5,256(r15)
> c00000000008182c:	4b ff af 55 	bl      c00000000007c780 <.xmon_show_stack>
> c000000000081830:	4b ff d5 51 	bl      c00000000007ed80 <.scannl>
> c000000000081834:	4b ff f1 dc 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081838:	60 00 00 00 	nop
> c00000000008183c:	60 00 00 00 	nop
> 
> 
> c000000000081840:	7d e3 7b 78 	mr      r3,r15
> c000000000081844:	4b ff df cd 	bl      c00000000007f810 <.prregs>
> c000000000081848:	4b ff f1 c8 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
> 1645         case 'w':
> 1646                 val = read_spr(regno);
> 1647                 scanhex(&val);
> 1648                 write_spr(regno, val);
> 1649                 /* fall through */
> 1650         case 'r':
> 1651                 printf("spr %lx = %lx\n", regno, read_spr(regno));
> 1652                 break;
> 1653         }
> 1654         scannl();
> 1655 }
> */
> c00000000008184c:	e8 7a 66 de 	lwa     r3,26332(r26)
> c000000000081850:	4b ff b6 71 	bl      c00000000007cec0 <.read_spr>
> c000000000081854:	7c 29 0b 78 	mr      r9,r1
> c000000000081858:	f8 69 01 61 	stdu    r3,352(r9)
> c00000000008185c:	7d 23 4b 78 	mr      r3,r9
> c000000000081860:	4b ff db 61 	bl      c00000000007f3c0 <.scanhex>
> c000000000081864:	e8 7a 66 de 	lwa     r3,26332(r26)
> c000000000081868:	e8 81 01 60 	ld      r4,352(r1)
> c00000000008186c:	4b ff b5 75 	bl      c00000000007cde0 <.write_spr>
> c000000000081870:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081874:	eb 89 66 d8 	ld      r28,26328(r9)
> c000000000081878:	7f 83 07 b4 	extsw   r3,r28
> c00000000008187c:	4b ff b6 45 	bl      c00000000007cec0 <.read_spr>
> c000000000081880:	7f 84 e3 78 	mr      r4,r28
> c000000000081884:	7c 65 1b 78 	mr      r5,r3
> c000000000081888:	3c 62 ff d4 	addis   r3,r2,-44
> c00000000008188c:	38 63 91 c8 	addi    r3,r3,-28216
> c000000000081890:	48 00 1f b1 	bl      c000000000083840 <.xmon_printf>
> c000000000081894:	60 00 00 00 	nop
> c000000000081898:	4b ff d4 e9 	bl      c00000000007ed80 <.scannl>
> c00000000008189c:	4b ff f1 74 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c0000000000818a0:	2f 83 00 72 	cmpwi   cr7,r3,114
> c0000000000818a4:	41 9e 00 ec 	beq-    cr7,c000000000081990 <.xmon_core+0x14e0>
> c0000000000818a8:	2f 83 00 77 	cmpwi   cr7,r3,119
> c0000000000818ac:	41 9e 00 d4 	beq-    cr7,c000000000081980 <.xmon_core+0x14d0>
> c0000000000818b0:	2f 83 00 6e 	cmpwi   cr7,r3,110
> c0000000000818b4:	40 9e f8 0c 	bne+    cr7,c0000000000810c0 <.xmon_core+0xc10>
> c0000000000818b8:	39 3f 3e 10 	addi    r9,r31,15888
> c0000000000818bc:	93 49 66 d4 	stw     r26,26324(r9)
> c0000000000818c0:	4b ff f8 00 	b       c0000000000810c0 <.xmon_core+0xc10>
> c0000000000818c4:	60 00 00 00 	nop
> c0000000000818c8:	60 00 00 00 	nop
> c0000000000818cc:	60 00 00 00 	nop
> 
> 
> c0000000000818d0:	81 3f 00 08 	lwz     r9,8(r31)
> c0000000000818d4:	7d 2a d0 38 	and     r10,r9,r26
> c0000000000818d8:	7f 8a c8 00 	cmpw    cr7,r10,r25
> c0000000000818dc:	41 9e 05 24 	beq-    cr7,c000000000081e00 <.xmon_core+0x1950>
> c0000000000818e0:	7d 29 b8 38 	and     r9,r9,r23
> c0000000000818e4:	7f 89 b0 00 	cmpw    cr7,r9,r22
> c0000000000818e8:	41 9e 05 18 	beq-    cr7,c000000000081e00 <.xmon_core+0x1950>
> c0000000000818ec:	7c 00 e8 6c 	dcbst   0,r29
> c0000000000818f0:	7c 00 04 ac 	sync    
> c0000000000818f4:	7c 00 ef ac 	icbi    0,r29
> c0000000000818f8:	4c 00 01 2c 	isync
> c0000000000818fc:	81 3f 00 14 	lwz     r9,20(r31)
> c000000000081900:	79 27 ff e3 	rldicl. r7,r9,63,63
> c000000000081904:	40 82 f4 ec 	bne+    c000000000080df0 <.xmon_core+0x940>
> c000000000081908:	e8 7f 00 00 	ld      r3,0(r31)
> c00000000008190c:	7e a4 ab 78 	mr      r4,r21
> c000000000081910:	38 a0 00 04 	li      r5,4
> c000000000081914:	4b ff b3 0d 	bl      c00000000007cc20 <.mwrite>
> c000000000081918:	2f 83 00 04 	cmpwi   cr7,r3,4
> c00000000008191c:	41 9e 0f 50 	beq-    cr7,c00000000008286c <.xmon_core+0x23bc>
> c000000000081920:	e8 9f 00 00 	ld      r4,0(r31)
> c000000000081924:	7e 83 a3 78 	mr      r3,r20
> c000000000081928:	48 00 1f 19 	bl      c000000000083840 <.xmon_printf>
> c00000000008192c:	60 00 00 00 	nop
> c000000000081930:	81 3f 00 14 	lwz     r9,20(r31)
> c000000000081934:	55 29 e0 7e 	rlwinm  r9,r9,28,1,31
> c000000000081938:	55 29 20 3e 	rotlwi  r9,r9,4
> c00000000008193c:	91 3f 00 14 	stw     r9,20(r31)
> c000000000081940:	4b ff f4 b0 	b       c000000000080df0 <.xmon_core+0x940>
> c000000000081944:	60 00 00 00 	nop
> c000000000081948:	60 00 00 00 	nop
> c00000000008194c:	60 00 00 00 	nop
> 
> 
> c000000000081950:	39 3c 44 e8 	addi    r9,r28,17640
> c000000000081954:	92 c9 00 40 	stw     r22,64(r9)
> c000000000081958:	4b ff f7 68 	b       c0000000000810c0 <.xmon_core+0xc10>
> c00000000008195c:	60 00 00 00 	nop
> 
> 
> c000000000081960:	39 3c 44 e8 	addi    r9,r28,17640
> c000000000081964:	93 09 00 40 	stw     r24,64(r9)
> c000000000081968:	4b ff f7 58 	b       c0000000000810c0 <.xmon_core+0xc10>
> c00000000008196c:	60 00 00 00 	nop
> 
> 
> c000000000081970:	39 3c 44 e8 	addi    r9,r28,17640
> c000000000081974:	93 49 00 40 	stw     r26,64(r9)
> c000000000081978:	4b ff f7 48 	b       c0000000000810c0 <.xmon_core+0xc10>
> c00000000008197c:	60 00 00 00 	nop
> 
> 
> c000000000081980:	39 3c 44 e8 	addi    r9,r28,17640
> c000000000081984:	92 e9 00 40 	stw     r23,64(r9)
> c000000000081988:	4b ff f7 38 	b       c0000000000810c0 <.xmon_core+0xc10>
> c00000000008198c:	60 00 00 00 	nop
> 
> 
> c000000000081990:	39 5f 3e 10 	addi    r10,r31,15888
> c000000000081994:	81 2a 66 d0 	lwz     r9,26320(r10)
> c000000000081998:	7d 29 00 34 	cntlzw  r9,r9
> c00000000008199c:	55 29 d9 7e 	rlwinm  r9,r9,27,5,31
> c0000000000819a0:	91 2a 66 d0 	stw     r9,26320(r10)
> c0000000000819a4:	4b ff f7 1c 	b       c0000000000810c0 <.xmon_core+0xc10>
> c0000000000819a8:	60 00 00 00 	nop
> c0000000000819ac:	60 00 00 00 	nop
> 
> /*
>  796                 xmon_no_auto_backtrace = 1;
>  797                 xmon_show_stack(excp->gpr[1], excp->link, excp->nip);
> */
> c0000000000819b0:	e8 6f 00 08 	ld      r3,8(r15)
> c0000000000819b4:	e8 8f 01 20 	ld      r4,288(r15)
> c0000000000819b8:	39 40 00 01 	li      r10,1
> c0000000000819bc:	e8 af 01 00 	ld      r5,256(r15)
> c0000000000819c0:	91 49 24 e0 	stw     r10,9440(r9)
> c0000000000819c4:	4b ff ad bd 	bl      c00000000007c780 <.xmon_show_stack>
> c0000000000819c8:	4b ff f0 3c 	b       c000000000080a04 <.xmon_core+0x554>
> 
> 
> c0000000000819cc:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c0000000000819d0:	40 be fb c0 	bne-    cr7,c000000000081590 <.xmon_core+0x10e0>
> c0000000000819d4:	60 00 00 00 	nop
> c0000000000819d8:	60 00 00 00 	nop
> c0000000000819dc:	60 00 00 00 	nop
> 
> 
> c0000000000819e0:	39 3f 3e 10 	addi    r9,r31,15888
> c0000000000819e4:	93 89 24 d8 	stw     r28,9432(r9)
> c0000000000819e8:	4b ff fb a8 	b       c000000000081590 <.xmon_core+0x10e0>
> c0000000000819ec:	60 00 00 00 	nop
> 
> 
> c0000000000819f0:	3d 42 ff 33 	addis   r10,r2,-205
> c0000000000819f4:	79 29 17 88 	rldic   r9,r9,2,30
> c0000000000819f8:	39 4a 01 24 	addi    r10,r10,292
> c0000000000819fc:	7d 2a 4a aa 	lwax    r9,r10,r9
> c000000000081a00:	7d 49 52 14 	add     r10,r9,r10
> c000000000081a04:	7d 49 03 a6 	mtctr   r10
> c000000000081a08:	4e 80 04 20 	bctr
> c000000000081a0c:	00 00 02 d4 	.long 0x2d4
> c000000000081a10:	ff ff f6 68 	.long 0xfffff668
> c000000000081a14:	ff ff f6 68 	.long 0xfffff668
> c000000000081a18:	ff ff f6 68 	.long 0xfffff668
> c000000000081a1c:	ff ff f6 68 	.long 0xfffff668
> c000000000081a20:	00 00 02 c4 	.long 0x2c4
> c000000000081a24:	ff ff f6 68 	.long 0xfffff668
> c000000000081a28:	ff ff f6 68 	.long 0xfffff668
> c000000000081a2c:	00 00 01 8c 	.long 0x18c
> c000000000081a30:	00 00 02 d4 	.long 0x2d4
> c000000000081a34:	ff ff f6 68 	.long 0xfffff668
> c000000000081a38:	ff ff f6 68 	.long 0xfffff668
> c000000000081a3c:	ff ff f6 68 	.long 0xfffff668
> c000000000081a40:	ff ff f6 68 	.long 0xfffff668
> c000000000081a44:	ff ff f6 68 	.long 0xfffff668
> c000000000081a48:	00 00 02 d4 	.long 0x2d4
> c000000000081a4c:	ff ff f6 68 	.long 0xfffff668
> c000000000081a50:	ff ff f6 68 	.long 0xfffff668
> c000000000081a54:	ff ff f6 68 	.long 0xfffff668
> c000000000081a58:	ff ff f6 68 	.long 0xfffff668
> c000000000081a5c:	ff ff f6 68 	.long 0xfffff668
> c000000000081a60:	ff ff f6 68 	.long 0xfffff668
> c000000000081a64:	00 00 00 5c 	.long 0x5c
> c000000000081a68:	3b 9f 3e 10 	addi    r28,r31,15888
> c000000000081a6c:	38 7c 66 b0 	addi    r3,r28,26288
> c000000000081a70:	4b ff d9 51 	bl      c00000000007f3c0 <.scanhex>
> c000000000081a74:	81 3c 24 d8 	lwz     r9,9432(r28)
> c000000000081a78:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c000000000081a7c:	41 9e 00 0c 	beq-    cr7,c000000000081a88 <.xmon_core+0x15d8>
> c000000000081a80:	39 20 00 00 	li      r9,0
> c000000000081a84:	91 3c 24 d8 	stw     r9,9432(r28)
> c000000000081a88:	3c 62 ff ed 	addis   r3,r2,-19
> c000000000081a8c:	38 63 44 e8 	addi    r3,r3,17640
> c000000000081a90:	38 63 00 30 	addi    r3,r3,48
> c000000000081a94:	4b ff d9 2d 	bl      c00000000007f3c0 <.scanhex>
> c000000000081a98:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081a9c:	81 49 24 d8 	lwz     r10,9432(r9)
> c000000000081aa0:	2f 8a 00 0a 	cmpwi   cr7,r10,10
> c000000000081aa4:	41 9e 00 0c 	beq-    cr7,c000000000081ab0 <.xmon_core+0x1600>
> c000000000081aa8:	39 40 00 00 	li      r10,0
> c000000000081aac:	91 49 24 d8 	stw     r10,9432(r9)
> c000000000081ab0:	3f 02 ff ed 	addis   r24,r2,-19
> c000000000081ab4:	3b 98 44 e8 	addi    r28,r24,17640
> c000000000081ab8:	38 7c 00 38 	addi    r3,r28,56
> c000000000081abc:	4b ff d9 05 	bl      c00000000007f3c0 <.scanhex>
> c000000000081ac0:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081ac4:	eb 49 66 b0 	ld      r26,26288(r9)
> c000000000081ac8:	e9 3c 00 38 	ld      r9,56(r28)
> c000000000081acc:	7b 5c 00 20 	clrldi  r28,r26,32
> c000000000081ad0:	7f a9 e0 40 	cmpld   cr7,r9,r28
> c000000000081ad4:	7f 9a e3 78 	mr      r26,r28
> c000000000081ad8:	40 9d ef 38 	ble+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000081adc:	3e c2 ff d4 	addis   r22,r2,-44
> c000000000081ae0:	3e e2 ff d4 	addis   r23,r2,-44
> c000000000081ae4:	3a a0 00 00 	li      r21,0
> c000000000081ae8:	3a d6 8c 30 	addi    r22,r22,-29648
> c000000000081aec:	3a f7 8c 20 	addi    r23,r23,-29664
> c000000000081af0:	48 00 00 44 	b       c000000000081b34 <.xmon_core+0x1684>
> c000000000081af4:	60 00 00 00 	nop
> c000000000081af8:	60 00 00 00 	nop
> c000000000081afc:	60 00 00 00 	nop
> 
> 
> c000000000081b00:	40 9e 04 d4 	bne-    cr7,c000000000081fd4 <.xmon_core+0x1b24>
> c000000000081b04:	39 38 44 e8 	addi    r9,r24,17640
> c000000000081b08:	e8 89 00 30 	ld      r4,48(r9)
> c000000000081b0c:	7d 5c 22 14 	add     r10,r28,r4
> c000000000081b10:	7f aa e0 40 	cmpld   cr7,r10,r28
> c000000000081b14:	41 9c 00 64 	blt-    cr7,c000000000081b78 <.xmon_core+0x16c8>
> c000000000081b18:	7f 5a 22 14 	add     r26,r26,r4
> c000000000081b1c:	e9 29 00 38 	ld      r9,56(r9)
> c000000000081b20:	7f 35 cb 78 	mr      r21,r25
> c000000000081b24:	7b 5a 00 20 	clrldi  r26,r26,32
> c000000000081b28:	7f ba 48 40 	cmpld   cr7,r26,r9
> c000000000081b2c:	7f 5c d3 78 	mr      r28,r26
> c000000000081b30:	40 9c 00 48 	bge-    cr7,c000000000081b78 <.xmon_core+0x16c8>
> c000000000081b34:	7f 83 e3 78 	mr      r3,r28
> c000000000081b38:	38 81 01 60 	addi    r4,r1,352
> c000000000081b3c:	38 a0 00 01 	li      r5,1
> c000000000081b40:	4b ff a8 81 	bl      c00000000007c3c0 <.mread>
> c000000000081b44:	2f b5 00 00 	cmpdi   cr7,r21,0
> c000000000081b48:	7c 79 1b 79 	mr.     r25,r3
> c000000000081b4c:	41 82 ff b4 	beq+    c000000000081b00 <.xmon_core+0x1650>
> c000000000081b50:	40 9e ff b4 	bne+    cr7,c000000000081b04 <.xmon_core+0x1654>
> c000000000081b54:	7f 44 d3 78 	mr      r4,r26
> c000000000081b58:	7e e3 bb 78 	mr      r3,r23
> c000000000081b5c:	48 00 1c e5 	bl      c000000000083840 <.xmon_printf>
> c000000000081b60:	60 00 00 00 	nop
> c000000000081b64:	39 38 44 e8 	addi    r9,r24,17640
> c000000000081b68:	e8 89 00 30 	ld      r4,48(r9)
> c000000000081b6c:	7d 5c 22 14 	add     r10,r28,r4
> c000000000081b70:	7f aa e0 40 	cmpld   cr7,r10,r28
> c000000000081b74:	40 9c ff a4 	bge+    cr7,c000000000081b18 <.xmon_core+0x1668>
> c000000000081b78:	2f b9 00 00 	cmpdi   cr7,r25,0
> c000000000081b7c:	41 9e ee 94 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000081b80:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000081b84:	7c 84 e0 50 	subf    r4,r4,r28
> c000000000081b88:	38 63 8c 30 	addi    r3,r3,-29648
> c000000000081b8c:	48 00 1c b5 	bl      c000000000083840 <.xmon_printf>
> c000000000081b90:	60 00 00 00 	nop
> c000000000081b94:	4b ff ee 7c 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000081b98:	3b 9f 3e 10 	addi    r28,r31,15888
> c000000000081b9c:	3d 22 ff d4 	addis   r9,r2,-44
> c000000000081ba0:	39 29 8c 08 	addi    r9,r9,-29688
> c000000000081ba4:	38 7c 66 b0 	addi    r3,r28,26288
> c000000000081ba8:	f9 3c 26 38 	std     r9,9784(r28)
> c000000000081bac:	4b ff d8 15 	bl      c00000000007f3c0 <.scanhex>
> c000000000081bb0:	81 3c 24 d8 	lwz     r9,9432(r28)
> c000000000081bb4:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c000000000081bb8:	41 9e 00 50 	beq-    cr7,c000000000081c08 <.xmon_core+0x1758>
> c000000000081bbc:	3b 40 00 00 	li      r26,0
> c000000000081bc0:	38 7c 66 c8 	addi    r3,r28,26312
> c000000000081bc4:	93 5c 24 d8 	stw     r26,9432(r28)
> c000000000081bc8:	4b ff d7 f9 	bl      c00000000007f3c0 <.scanhex>
> c000000000081bcc:	81 3c 24 d8 	lwz     r9,9432(r28)
> c000000000081bd0:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c000000000081bd4:	41 9e 00 34 	beq-    cr7,c000000000081c08 <.xmon_core+0x1758>
> c000000000081bd8:	38 7c 26 40 	addi    r3,r28,9792
> c000000000081bdc:	93 5c 24 d8 	stw     r26,9432(r28)
> c000000000081be0:	4b ff d7 e1 	bl      c00000000007f3c0 <.scanhex>
> c000000000081be4:	81 3c 24 d8 	lwz     r9,9432(r28)
> c000000000081be8:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c000000000081bec:	39 20 ff ff 	li      r9,-1
> c000000000081bf0:	91 3c 66 cc 	stw     r9,26316(r28)
> c000000000081bf4:	41 9e 00 08 	beq-    cr7,c000000000081bfc <.xmon_core+0x174c>
> c000000000081bf8:	93 5c 24 d8 	stw     r26,9432(r28)
> c000000000081bfc:	38 7f 3e 10 	addi    r3,r31,15888
> c000000000081c00:	38 63 66 cc 	addi    r3,r3,26316
> c000000000081c04:	4b ff d7 bd 	bl      c00000000007f3c0 <.scanhex>
> c000000000081c08:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081c0c:	83 89 66 b4 	lwz     r28,26292(r9)
> c000000000081c10:	81 29 66 c8 	lwz     r9,26312(r9)
> c000000000081c14:	7f 89 e0 40 	cmplw   cr7,r9,r28
> c000000000081c18:	40 9d ed f8 	ble+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000081c1c:	3f 22 ff d4 	addis   r25,r2,-44
> c000000000081c20:	3b 40 00 00 	li      r26,0
> c000000000081c24:	3b 39 8c 10 	addi    r25,r25,-29680
> c000000000081c28:	48 00 00 20 	b       c000000000081c48 <.xmon_core+0x1798>
> c000000000081c2c:	60 00 00 00 	nop
> 
> 
> c000000000081c30:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081c34:	3b 9c 00 04 	addi    r28,r28,4
> c000000000081c38:	81 29 66 c8 	lwz     r9,26312(r9)
> c000000000081c3c:	7f 89 e0 40 	cmplw   cr7,r9,r28
> c000000000081c40:	7b 9c 00 20 	clrldi  r28,r28,32
> c000000000081c44:	40 9d ed cc 	ble+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000081c48:	7f 83 e3 78 	mr      r3,r28
> c000000000081c4c:	38 81 01 28 	addi    r4,r1,296
> c000000000081c50:	38 a0 00 04 	li      r5,4
> c000000000081c54:	4b ff a7 6d 	bl      c00000000007c3c0 <.mread>
> c000000000081c58:	2f 83 00 04 	cmpwi   cr7,r3,4
> c000000000081c5c:	40 9e ff d4 	bne+    cr7,c000000000081c30 <.xmon_core+0x1780>
> c000000000081c60:	88 a1 01 28 	lbz     r5,296(r1)
> c000000000081c64:	89 21 01 29 	lbz     r9,297(r1)
> c000000000081c68:	89 01 01 2a 	lbz     r8,298(r1)
> c000000000081c6c:	89 41 01 2b 	lbz     r10,299(r1)
> c000000000081c70:	55 29 80 1e 	rlwinm  r9,r9,16,0,15
> c000000000081c74:	54 a5 c0 0e 	rlwinm  r5,r5,24,0,7
> c000000000081c78:	7c a5 4a 14 	add     r5,r5,r9
> c000000000081c7c:	55 08 40 2e 	rlwinm  r8,r8,8,0,23
> c000000000081c80:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081c84:	7c a5 42 14 	add     r5,r5,r8
> c000000000081c88:	7c a5 52 14 	add     r5,r5,r10
> c000000000081c8c:	e9 49 26 40 	ld      r10,9792(r9)
> c000000000081c90:	81 29 66 cc 	lwz     r9,26316(r9)
> c000000000081c94:	7c a5 07 b4 	extsw   r5,r5
> c000000000081c98:	7c aa 52 78 	xor     r10,r5,r10
> c000000000081c9c:	7d 46 48 39 	and.    r6,r10,r9
> c000000000081ca0:	40 82 ff 90 	bne+    c000000000081c30 <.xmon_core+0x1780>
> c000000000081ca4:	3b 5a 00 01 	addi    r26,r26,1
> c000000000081ca8:	7f 23 cb 78 	mr      r3,r25
> c000000000081cac:	7f 84 e3 78 	mr      r4,r28
> c000000000081cb0:	48 00 1b 91 	bl      c000000000083840 <.xmon_printf>
> c000000000081cb4:	60 00 00 00 	nop
> c000000000081cb8:	2b 9a 00 09 	cmplwi  cr7,r26,9
> c000000000081cbc:	7b 5a 00 20 	clrldi  r26,r26,32
> c000000000081cc0:	40 9d ff 70 	ble+    cr7,c000000000081c30 <.xmon_core+0x1780>
> c000000000081cc4:	4b ff ed 4c 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081cc8:	60 00 00 00 	nop
> c000000000081ccc:	60 00 00 00 	nop
> 
> 
> c000000000081cd0:	38 60 00 00 	li      r3,0
> c000000000081cd4:	48 38 ae 9d 	bl      c00000000040cb70 <.show_mem>
> c000000000081cd8:	60 00 00 00 	nop
> c000000000081cdc:	4b ff ed 34 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000081ce0:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000081ce4:	38 7a 66 b0 	addi    r3,r26,26288
> c000000000081ce8:	4b ff d6 d9 	bl      c00000000007f3c0 <.scanhex>
> c000000000081cec:	81 3a 24 d8 	lwz     r9,9432(r26)
> c000000000081cf0:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c000000000081cf4:	41 9e 00 0c 	beq-    cr7,c000000000081d00 <.xmon_core+0x1850>
> c000000000081cf8:	39 20 00 00 	li      r9,0
> c000000000081cfc:	91 3a 24 d8 	stw     r9,9432(r26)
> c000000000081d00:	2f 9c 00 73 	cmpwi   cr7,r28,115
> c000000000081d04:	38 7f 3e 10 	addi    r3,r31,15888
> c000000000081d08:	41 9e 0e a8 	beq-    cr7,c000000000082bb0 <.xmon_core+0x2700>
> c000000000081d0c:	38 63 26 48 	addi    r3,r3,9800
> c000000000081d10:	4b ff d6 b1 	bl      c00000000007f3c0 <.scanhex>
> c000000000081d14:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000081d18:	81 49 24 d8 	lwz     r10,9432(r9)
> c000000000081d1c:	2f 8a 00 0a 	cmpwi   cr7,r10,10
> c000000000081d20:	41 9e 00 0c 	beq-    cr7,c000000000081d2c <.xmon_core+0x187c>
> c000000000081d24:	39 40 00 00 	li      r10,0
> c000000000081d28:	91 49 24 d8 	stw     r10,9432(r9)
> c000000000081d2c:	3b 5f 3e 10 	addi    r26,r31,15888
> c000000000081d30:	38 7a 66 b8 	addi    r3,r26,26296
> c000000000081d34:	4b ff d6 8d 	bl      c00000000007f3c0 <.scanhex>
> c000000000081d38:	2f 9c 00 6d 	cmpwi   cr7,r28,109
> c000000000081d3c:	41 9e 0e e8 	beq-    cr7,c000000000082c24 <.xmon_core+0x2774>
> c000000000081d40:	2f 9c 00 73 	cmpwi   cr7,r28,115
> c000000000081d44:	41 9e 0e c8 	beq-    cr7,c000000000082c0c <.xmon_core+0x275c>
> c000000000081d48:	2f 9c 00 64 	cmpwi   cr7,r28,100
> c000000000081d4c:	40 9e ec c4 	bne+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000081d50:	81 3a 24 d8 	lwz     r9,9432(r26)
> c000000000081d54:	2f 89 00 0a 	cmpwi   cr7,r9,10
> c000000000081d58:	41 9e 00 0c 	beq-    cr7,c000000000081d64 <.xmon_core+0x18b4>
> c000000000081d5c:	39 20 00 00 	li      r9,0
> c000000000081d60:	91 3a 24 d8 	stw     r9,9432(r26)
> c000000000081d64:	3b 9f 3e 10 	addi    r28,r31,15888
> c000000000081d68:	38 7c 66 c0 	addi    r3,r28,26304
> c000000000081d6c:	4b ff d6 55 	bl      c00000000007f3c0 <.scanhex>
> c000000000081d70:	81 3c 66 bc 	lwz     r9,26300(r28)
> c000000000081d74:	e8 9c 66 b0 	ld      r4,26288(r28)
> c000000000081d78:	e8 dc 26 48 	ld      r6,9800(r28)
> c000000000081d7c:	82 dc 66 c4 	lwz     r22,26308(r28)
> c000000000081d80:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000081d84:	41 9e ec 8c 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000081d88:	39 29 ff ff 	addi    r9,r9,-1
> c000000000081d8c:	3a e4 00 01 	addi    r23,r4,1
> c000000000081d90:	79 29 00 20 	clrldi  r9,r9,32
> c000000000081d94:	3f 02 ff d4 	addis   r24,r2,-44
> c000000000081d98:	7e f7 4a 14 	add     r23,r23,r9
> c000000000081d9c:	3b 20 00 00 	li      r25,0
> c000000000081da0:	3b 18 8b c8 	addi    r24,r24,-29752
> c000000000081da4:	48 00 00 1c 	b       c000000000081dc0 <.xmon_core+0x1910>
> c000000000081da8:	60 00 00 00 	nop
> c000000000081dac:	60 00 00 00 	nop
> 
> 
> c000000000081db0:	7f ba b8 00 	cmpd    cr7,r26,r23
> c000000000081db4:	7f 44 d3 78 	mr      r4,r26
> c000000000081db8:	7f 86 e3 78 	mr      r6,r28
> c000000000081dbc:	41 9e 10 b0 	beq-    cr7,c000000000082e6c <.xmon_core+0x29bc>
> c000000000081dc0:	88 a4 00 00 	lbz     r5,0(r4)
> c000000000081dc4:	88 e6 00 00 	lbz     r7,0(r6)
> c000000000081dc8:	3b 44 00 01 	addi    r26,r4,1
> c000000000081dcc:	3b 86 00 01 	addi    r28,r6,1
> c000000000081dd0:	7f 85 38 40 	cmplw   cr7,r5,r7
> c000000000081dd4:	41 9e ff dc 	beq+    cr7,c000000000081db0 <.xmon_core+0x1900>
> c000000000081dd8:	39 39 00 01 	addi    r9,r25,1
> c000000000081ddc:	7f 96 48 40 	cmplw   cr7,r22,r9
> c000000000081de0:	79 39 00 20 	clrldi  r25,r9,32
> c000000000081de4:	41 9c ff cc 	blt+    cr7,c000000000081db0 <.xmon_core+0x1900>
> c000000000081de8:	7f 03 c3 78 	mr      r3,r24
> c000000000081dec:	48 00 1a 55 	bl      c000000000083840 <.xmon_printf>
> c000000000081df0:	60 00 00 00 	nop
> c000000000081df4:	4b ff ff bc 	b       c000000000081db0 <.xmon_core+0x1900>
> c000000000081df8:	60 00 00 00 	nop
> c000000000081dfc:	60 00 00 00 	nop
> 
> 
> c000000000081e00:	e8 9f 00 00 	ld      r4,0(r31)
> c000000000081e04:	7f 03 c3 78 	mr      r3,r24
> c000000000081e08:	48 00 1a 39 	bl      c000000000083840 <.xmon_printf>
> c000000000081e0c:	60 00 00 00 	nop
> c000000000081e10:	39 20 00 00 	li      r9,0
> c000000000081e14:	91 3f 00 14 	stw     r9,20(r31)
> c000000000081e18:	4b ff ef d8 	b       c000000000080df0 <.xmon_core+0x940>
> 
> 
> c000000000081e1c:	60 00 00 00 	nop
> c000000000081e20:	e8 61 01 60 	ld      r3,352(r1)
> c000000000081e24:	38 80 00 00 	li      r4,0
> c000000000081e28:	38 a0 00 00 	li      r5,0
> c000000000081e2c:	4b ff a9 55 	bl      c00000000007c780 <.xmon_show_stack>
> c000000000081e30:	4b ff cf 51 	bl      c00000000007ed80 <.scannl>
> c000000000081e34:	4b ff eb dc 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081e38:	60 00 00 00 	nop
> c000000000081e3c:	60 00 00 00 	nop
> 
> 
> /*
> 3213         case 's':
> 3214                 stop_spus();
> 3215                 break;
> 3216         case 'r':
> 3217                 restart_spus();
> 3218                 break;
> */
> c000000000081e40:	2f 83 00 72 	cmpwi   cr7,r3,114
> c000000000081e44:	41 9e 03 2c 	beq-    cr7,c000000000082170 <.xmon_core+0x1cc0>
> c000000000081e48:	2f 83 00 73 	cmpwi   cr7,r3,115
> c000000000081e4c:	40 9e ef 10 	bne+    cr7,c000000000080d5c <.xmon_core+0x8ac>		; for default, return -1
> c000000000081e50:	4b ff b1 81 	bl      c00000000007cfd0 <.stop_spus>
> c000000000081e54:	4b ff eb bc 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000081e58:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000081e5c:	3b 40 ff ff 	li      r26,-1
> c000000000081e60:	38 63 99 08 	addi    r3,r3,-26360
> c000000000081e64:	3a ff 3e 10 	addi    r23,r31,15888
> c000000000081e68:	48 00 19 d9 	bl      c000000000083840 <.xmon_printf>
> c000000000081e6c:	60 00 00 00 	nop
> c000000000081e70:	39 40 ff ff 	li      r10,-1
> c000000000081e74:	3d 22 ff b3 	addis   r9,r2,-77
> c000000000081e78:	f9 41 01 60 	std     r10,352(r1)
> c000000000081e7c:	39 29 19 68 	addi    r9,r9,6504
> c000000000081e80:	3e a2 ff db 	addis   r21,r2,-37
> c000000000081e84:	3e 82 ff d6 	addis   r20,r2,-42
> c000000000081e88:	38 80 ff ff 	li      r4,-1
> c000000000081e8c:	eb 09 00 00 	ld      r24,0(r9)
> c000000000081e90:	3b 80 00 00 	li      r28,0
> c000000000081e94:	7b 5a 00 20 	clrldi  r26,r26,32
> c000000000081e98:	3f 22 00 09 	addis   r25,r2,9
> c000000000081e9c:	3a f7 24 e8 	addi    r23,r23,9448
> c000000000081ea0:	3a c0 00 00 	li      r22,0
> c000000000081ea4:	3a b5 e4 50 	addi    r21,r21,-7088
> c000000000081ea8:	3a 94 8f d0 	addi    r20,r20,-28720
> c000000000081eac:	60 00 00 00 	nop
> c000000000081eb0:	38 a4 00 01 	addi    r5,r4,1
> c000000000081eb4:	7f 03 c3 78 	mr      r3,r24
> c000000000081eb8:	38 80 08 00 	li      r4,2048
> c000000000081ebc:	7c a5 07 b4 	extsw   r5,r5
> c000000000081ec0:	48 39 62 81 	bl      c000000000418140 <.find_next_bit>
> c000000000081ec4:	60 00 00 00 	nop
> c000000000081ec8:	39 39 33 b8 	addi    r9,r25,13240
> c000000000081ecc:	e9 29 00 02 	lwa     r9,0(r9)
> c000000000081ed0:	7c 64 d0 38 	and     r4,r3,r26
> c000000000081ed4:	f8 81 01 60 	std     r4,352(r1)
> c000000000081ed8:	7f a4 48 40 	cmpld   cr7,r4,r9
> c000000000081edc:	40 9c 00 68 	bge-    cr7,c000000000081f44 <.xmon_core+0x1a94>
> c000000000081ee0:	7c 69 36 70 	srawi   r9,r3,6
> c000000000081ee4:	7d 29 01 94 	addze   r9,r9
> c000000000081ee8:	78 63 06 a0 	clrldi  r3,r3,58
> c000000000081eec:	7d 29 07 b4 	extsw   r9,r9
> c000000000081ef0:	79 29 1f 24 	rldicr  r9,r9,3,60
> c000000000081ef4:	7d 37 48 2a 	ldx     r9,r23,r9
> c000000000081ef8:	7d 23 1c 36 	srd     r3,r9,r3
> c000000000081efc:	78 67 07 e1 	clrldi. r7,r3,63
> c000000000081f00:	41 82 00 80 	beq-    c000000000081f80 <.xmon_core+0x1ad0>
> c000000000081f04:	2f bc 00 00 	cmpdi   cr7,r28,0
> c000000000081f08:	41 9e 00 b8 	beq-    cr7,c000000000081fc0 <.xmon_core+0x1b10>
> c000000000081f0c:	38 a4 00 01 	addi    r5,r4,1
> c000000000081f10:	7f 03 c3 78 	mr      r3,r24
> c000000000081f14:	38 80 08 00 	li      r4,2048
> c000000000081f18:	7c a5 07 b4 	extsw   r5,r5
> c000000000081f1c:	48 39 62 25 	bl      c000000000418140 <.find_next_bit>
> c000000000081f20:	60 00 00 00 	nop
> c000000000081f24:	39 39 33 b8 	addi    r9,r25,13240
> c000000000081f28:	3b 9c 00 01 	addi    r28,r28,1
> c000000000081f2c:	7f 9c 07 b4 	extsw   r28,r28
> c000000000081f30:	e9 29 00 02 	lwa     r9,0(r9)
> c000000000081f34:	7c 64 d0 38 	and     r4,r3,r26
> c000000000081f38:	f8 81 01 60 	std     r4,352(r1)
> c000000000081f3c:	7f a4 48 40 	cmpld   cr7,r4,r9
> c000000000081f40:	41 9c ff a0 	blt+    cr7,c000000000081ee0 <.xmon_core+0x1a30>
> c000000000081f44:	2f 9c 00 01 	cmpwi   cr7,r28,1
> c000000000081f48:	40 9d 00 18 	ble-    cr7,c000000000081f60 <.xmon_core+0x1ab0>
> c000000000081f4c:	3c 62 ff db 	addis   r3,r2,-37
> c000000000081f50:	38 80 07 ff 	li      r4,2047
> c000000000081f54:	38 63 e4 50 	addi    r3,r3,-7088
> c000000000081f58:	48 00 18 e9 	bl      c000000000083840 <.xmon_printf>
> c000000000081f5c:	60 00 00 00 	nop
> c000000000081f60:	3c 62 ff d5 	addis   r3,r2,-43
> c000000000081f64:	38 63 0e 68 	addi    r3,r3,3688
> c000000000081f68:	48 00 18 d9 	bl      c000000000083840 <.xmon_printf>
> c000000000081f6c:	60 00 00 00 	nop
> c000000000081f70:	4b ff ea a0 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000081f74:	60 00 00 00 	nop
> c000000000081f78:	60 00 00 00 	nop
> c000000000081f7c:	60 00 00 00 	nop
> 
> 
> c000000000081f80:	2f 9c 00 01 	cmpwi   cr7,r28,1
> c000000000081f84:	40 9d 00 2c 	ble-    cr7,c000000000081fb0 <.xmon_core+0x1b00>
> c000000000081f88:	38 84 ff ff 	addi    r4,r4,-1
> c000000000081f8c:	7e a3 ab 78 	mr      r3,r21
> c000000000081f90:	48 00 18 b1 	bl      c000000000083840 <.xmon_printf>
> c000000000081f94:	60 00 00 00 	nop
> c000000000081f98:	7e dc b3 78 	mr      r28,r22
> c000000000081f9c:	e8 81 01 60 	ld      r4,352(r1)
> c000000000081fa0:	4b ff ff 10 	b       c000000000081eb0 <.xmon_core+0x1a00>
> c000000000081fa4:	60 00 00 00 	nop
> c000000000081fa8:	60 00 00 00 	nop
> c000000000081fac:	60 00 00 00 	nop
> 
> 
> c000000000081fb0:	7e dc b3 78 	mr      r28,r22
> c000000000081fb4:	4b ff fe fc 	b       c000000000081eb0 <.xmon_core+0x1a00>
> c000000000081fb8:	60 00 00 00 	nop
> c000000000081fbc:	60 00 00 00 	nop
> 
> 
> c000000000081fc0:	7e 83 a3 78 	mr      r3,r20
> c000000000081fc4:	48 00 18 7d 	bl      c000000000083840 <.xmon_printf>
> c000000000081fc8:	60 00 00 00 	nop
> 
> 
> c000000000081fcc:	e8 81 01 60 	ld      r4,352(r1)
> c000000000081fd0:	4b ff ff 3c 	b       c000000000081f0c <.xmon_core+0x1a5c>
> 
> 
> c000000000081fd4:	39 38 44 e8 	addi    r9,r24,17640
> c000000000081fd8:	7e c3 b3 78 	mr      r3,r22
> c000000000081fdc:	e8 89 00 30 	ld      r4,48(r9)
> c000000000081fe0:	7c 84 e0 50 	subf    r4,r4,r28
> c000000000081fe4:	48 00 18 5d 	bl      c000000000083840 <.xmon_printf>
> c000000000081fe8:	60 00 00 00 	nop
> c000000000081fec:	4b ff fb 18 	b       c000000000081b04 <.xmon_core+0x1654>
> 
> 
> c000000000081ff0:	3d 20 00 02 	lis     r9,2
> c000000000081ff4:	7f a4 48 40 	cmpld   cr7,r4,r9
> c000000000081ff8:	40 9d f5 f8 	ble+    cr7,c0000000000815f0 <.xmon_core+0x1140>
> c000000000081ffc:	f9 3c 00 50 	std     r9,80(r28)
> c000000000082000:	3c 80 00 02 	lis     r4,2
> c000000000082004:	4b ff f5 ec 	b       c0000000000815f0 <.xmon_core+0x1140>
> 
> 
> c000000000082008:	38 61 01 60 	addi    r3,r1,352
> c00000000008200c:	4b ff d3 b5 	bl      c00000000007f3c0 <.scanhex>
> c000000000082010:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000082014:	40 9e 07 54 	bne-    cr7,c000000000082768 <.xmon_core+0x22b8>
> c000000000082018:	38 e0 01 00 	li      r7,256
> c00000000008201c:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082020:	7c e9 03 a6 	mtctr   r7
> c000000000082024:	39 29 00 1c 	addi    r9,r9,28
> c000000000082028:	39 40 00 00 	li      r10,0
> c00000000008202c:	60 00 00 00 	nop
> c000000000082030:	91 49 00 00 	stw     r10,0(r9)
> c000000000082034:	39 29 00 20 	addi    r9,r9,32
> c000000000082038:	42 00 ff f8 	bdnz+   c000000000082030 <.xmon_core+0x1b80>
> c00000000008203c:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082040:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082044:	39 40 00 00 	li      r10,0
> c000000000082048:	38 63 97 18 	addi    r3,r3,-26856
> c00000000008204c:	f9 49 67 08 	std     r10,26376(r9)
> c000000000082050:	91 49 66 fc 	stw     r10,26364(r9)
> c000000000082054:	48 00 17 ed 	bl      c000000000083840 <.xmon_printf>
> c000000000082058:	60 00 00 00 	nop
> c00000000008205c:	4b ff e9 b4 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082060:	3d 22 00 0b 	addis   r9,r2,11
> c000000000082064:	39 29 69 18 	addi    r9,r9,26904
> c000000000082068:	e9 29 00 00 	ld      r9,0(r9)
> c00000000008206c:	e9 29 00 10 	ld      r9,16(r9)
> c000000000082070:	79 26 e7 e1 	rldicl. r6,r9,28,63
> c000000000082074:	41 82 07 5c 	beq-    c0000000000827d0 <.xmon_core+0x2320>
> c000000000082078:	39 5f 3e 10 	addi    r10,r31,15888
> c00000000008207c:	e9 2a 67 08 	ld      r9,26376(r10)
> c000000000082080:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000082084:	41 9e 00 18 	beq-    cr7,c00000000008209c <.xmon_core+0x1bec>
> c000000000082088:	81 09 00 14 	lwz     r8,20(r9)
> c00000000008208c:	55 08 00 3a 	rlwinm  r8,r8,0,0,29
> c000000000082090:	91 09 00 14 	stw     r8,20(r9)
> c000000000082094:	39 20 00 00 	li      r9,0
> c000000000082098:	f9 2a 67 08 	std     r9,26376(r10)
> c00000000008209c:	38 61 01 60 	addi    r3,r1,352
> c0000000000820a0:	4b ff d3 21 	bl      c00000000007f3c0 <.scanhex>
> c0000000000820a4:	2f a3 00 00 	cmpdi   cr7,r3,0
> c0000000000820a8:	41 9e e9 68 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c0000000000820ac:	e8 61 01 60 	ld      r3,352(r1)
> c0000000000820b0:	4b ff aa 41 	bl      c00000000007caf0 <.check_bp_loc>
> c0000000000820b4:	2f a3 00 00 	cmpdi   cr7,r3,0
> c0000000000820b8:	41 9e e9 58 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c0000000000820bc:	e8 61 01 60 	ld      r3,352(r1)
> c0000000000820c0:	4b ff 9a 11 	bl      c00000000007bad0 <.new_breakpoint>
> c0000000000820c4:	2c 23 00 00 	cmpdi   r3,0
> c0000000000820c8:	41 82 e9 48 	beq+    c000000000080a10 <.xmon_core+0x560>
> c0000000000820cc:	81 03 00 14 	lwz     r8,20(r3)
> c0000000000820d0:	39 5f 3e 10 	addi    r10,r31,15888
> c0000000000820d4:	f8 6a 67 08 	std     r3,26376(r10)
> c0000000000820d8:	61 08 00 03 	ori     r8,r8,3
> c0000000000820dc:	91 03 00 14 	stw     r8,20(r3)
> c0000000000820e0:	4b ff e9 30 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c0000000000820e4:	4b ff cc 0d 	bl      c00000000007ecf0 <.inchar>
> c0000000000820e8:	3b 40 00 05 	li      r26,5
> c0000000000820ec:	2f 83 00 72 	cmpwi   cr7,r3,114
> c0000000000820f0:	41 9e 00 1c 	beq-    cr7,c00000000008210c <.xmon_core+0x1c5c>
> c0000000000820f4:	2f 83 00 77 	cmpwi   cr7,r3,119
> c0000000000820f8:	3b 40 00 06 	li      r26,6
> c0000000000820fc:	41 9e 00 10 	beq-    cr7,c00000000008210c <.xmon_core+0x1c5c>
> c000000000082100:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082104:	3b 40 00 07 	li      r26,7
> c000000000082108:	90 69 24 d8 	stw     r3,9432(r9)
> c00000000008210c:	3b 9f 3e 10 	addi    r28,r31,15888
> c000000000082110:	39 20 00 00 	li      r9,0
> c000000000082114:	38 7c 66 e8 	addi    r3,r28,26344
> c000000000082118:	f9 3c 66 e8 	std     r9,26344(r28)
> c00000000008211c:	91 3c 66 fc 	stw     r9,26364(r28)
> c000000000082120:	4b ff d2 a1 	bl      c00000000007f3c0 <.scanhex>
> c000000000082124:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000082128:	41 9e e8 e8 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c00000000008212c:	3d 20 bf ff 	lis     r9,-16385
> c000000000082130:	e9 5c 66 e8 	ld      r10,26344(r28)
> c000000000082134:	61 29 ff ff 	ori     r9,r9,65535
> c000000000082138:	79 29 07 c6 	rldicr  r9,r9,32,31
> c00000000008213c:	65 29 ff ff 	oris    r9,r9,65535
> c000000000082140:	61 29 ff ff 	ori     r9,r9,65535
> c000000000082144:	7f aa 48 40 	cmpld   cr7,r10,r9
> c000000000082148:	40 9d 0d 74 	ble-    cr7,c000000000082ebc <.xmon_core+0x2a0c>
> c00000000008214c:	79 4a 07 24 	rldicr  r10,r10,0,60
> c000000000082150:	63 5a 00 10 	ori     r26,r26,16
> c000000000082154:	f9 5c 66 e8 	std     r10,26344(r28)
> c000000000082158:	93 5c 66 fc 	stw     r26,26364(r28)
> c00000000008215c:	4b ff e8 b4 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082160:	2f 83 00 66 	cmpwi   cr7,r3,102
> c000000000082164:	41 9e f4 2c 	beq+    cr7,c000000000081590 <.xmon_core+0x10e0>
> c000000000082168:	4b ff f4 20 	b       c000000000081588 <.xmon_core+0x10d8>
> c00000000008216c:	60 00 00 00 	nop
> 
> /*
> 3216         case 'r':
> 3217                 restart_spus();
> 3218                 break;
> */
> c000000000082170:	4b ff b0 41 	bl      c00000000007d1b0 <.restart_spus>
> c000000000082174:	4b ff e8 9c 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082178:	4b ff d2 49 	bl      c00000000007f3c0 <.scanhex>
> c00000000008217c:	ea bc 00 50 	ld      r21,80(r28)
> c000000000082180:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082184:	2f b5 00 00 	cmpdi   cr7,r21,0
> c000000000082188:	40 9e 09 dc 	bne-    cr7,c000000000082b64 <.xmon_core+0x26b4>
> c00000000008218c:	39 40 00 40 	li      r10,64
> c000000000082190:	ea 69 25 f0 	ld      r19,9712(r9)
> c000000000082194:	3a a0 00 40 	li      r21,64
> c000000000082198:	f9 5c 00 50 	std     r10,80(r28)
> c00000000008219c:	3e c2 ff d5 	addis   r22,r2,-43
> c0000000000821a0:	3e e2 ff b1 	addis   r23,r2,-79
> c0000000000821a4:	3f 02 ff d4 	addis   r24,r2,-44
> c0000000000821a8:	3b 21 01 28 	addi    r25,r1,296
> c0000000000821ac:	3a 00 00 00 	li      r16,0
> c0000000000821b0:	3a d6 f5 50 	addi    r22,r22,-2736
> c0000000000821b4:	3a f7 08 f0 	addi    r23,r23,2288
> c0000000000821b8:	3b 18 86 58 	addi    r24,r24,-31144
> c0000000000821bc:	60 00 00 00 	nop
> c0000000000821c0:	2f b5 00 10 	cmpdi   cr7,r21,16
> c0000000000821c4:	7e ba ab 78 	mr      r26,r21
> c0000000000821c8:	40 9d 00 08 	ble-    cr7,c0000000000821d0 <.xmon_core+0x1d20>
> c0000000000821cc:	3b 40 00 10 	li      r26,16
> c0000000000821d0:	7e 63 9b 78 	mr      r3,r19
> c0000000000821d4:	7f 24 cb 78 	mr      r4,r25
> c0000000000821d8:	7f 45 07 b4 	extsw   r5,r26
> c0000000000821dc:	7e 1c 83 78 	mr      r28,r16
> c0000000000821e0:	4b ff a1 e1 	bl      c00000000007c3c0 <.mread>
> c0000000000821e4:	7c 6e 1b 78 	mr      r14,r3
> c0000000000821e8:	7c 74 1b 78 	mr      r20,r3
> c0000000000821ec:	7e 73 1a 14 	add     r19,r19,r3
> c0000000000821f0:	48 00 00 2c 	b       c00000000008221c <.xmon_core+0x1d6c>
> c0000000000821f4:	60 00 00 00 	nop
> c0000000000821f8:	60 00 00 00 	nop
> c0000000000821fc:	60 00 00 00 	nop
> 
> 
> c000000000082200:	7c 99 e0 ae 	lbzx    r4,r25,r28
> c000000000082204:	7f 03 c3 78 	mr      r3,r24
> c000000000082208:	3b 9c 00 01 	addi    r28,r28,1
> c00000000008220c:	48 00 16 35 	bl      c000000000083840 <.xmon_printf>
> c000000000082210:	60 00 00 00 	nop
> c000000000082214:	7f ba e0 00 	cmpd    cr7,r26,r28
> c000000000082218:	40 9d 00 34 	ble-    cr7,c00000000008224c <.xmon_core+0x1d9c>
> c00000000008221c:	7f b4 e0 00 	cmpd    cr7,r20,r28
> c000000000082220:	41 9d ff e0 	bgt+    cr7,c000000000082200 <.xmon_core+0x1d50>
> c000000000082224:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082228:	7e c3 b3 78 	mr      r3,r22
> c00000000008222c:	e9 29 21 4a 	lwa     r9,8520(r9)
> c000000000082230:	3b 9c 00 01 	addi    r28,r28,1
> c000000000082234:	79 29 1f 24 	rldicr  r9,r9,3,60
> c000000000082238:	7c 97 48 2a 	ldx     r4,r23,r9
> c00000000008223c:	48 00 16 05 	bl      c000000000083840 <.xmon_printf>
> c000000000082240:	60 00 00 00 	nop
> c000000000082244:	7f ba e0 00 	cmpd    cr7,r26,r28
> c000000000082248:	41 9d ff d4 	bgt+    cr7,c00000000008221c <.xmon_core+0x1d6c>
> c00000000008224c:	7f ba 70 00 	cmpd    cr7,r26,r14
> c000000000082250:	7e ba a8 50 	subf    r21,r26,r21
> c000000000082254:	41 9d 00 0c 	bgt-    cr7,c000000000082260 <.xmon_core+0x1db0>
> c000000000082258:	2f b5 00 00 	cmpdi   cr7,r21,0
> c00000000008225c:	41 9d ff 64 	bgt+    cr7,c0000000000821c0 <.xmon_core+0x1d10>
> c000000000082260:	3c 62 ff d5 	addis   r3,r2,-43
> c000000000082264:	38 63 0e 68 	addi    r3,r3,3688
> c000000000082268:	48 00 15 d9 	bl      c000000000083840 <.xmon_printf>
> c00000000008226c:	60 00 00 00 	nop
> c000000000082270:	3d 42 ff ed 	addis   r10,r2,-19
> c000000000082274:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082278:	39 4a 44 e8 	addi    r10,r10,17640
> c00000000008227c:	e9 09 25 f0 	ld      r8,9712(r9)
> c000000000082280:	e8 ea 00 50 	ld      r7,80(r10)
> c000000000082284:	3d 42 ff d4 	addis   r10,r2,-44
> c000000000082288:	39 4a 91 20 	addi    r10,r10,-28384
> c00000000008228c:	7d 07 42 14 	add     r8,r7,r8
> c000000000082290:	f9 49 26 38 	std     r10,9784(r9)
> c000000000082294:	f9 09 25 f0 	std     r8,9712(r9)
> c000000000082298:	4b ff e7 78 	b       c000000000080a10 <.xmon_core+0x560>
> /*
> 3223         case 'f':
> 3224                 scanhex(&num);
> 3225                 if (num >= XMON_NUM_SPUS || !spu_info[num].spu) {
> 3226                         printf("*** Error: invalid spu number\n");
> 3227                         return 0;
> 3228                 }
> 3229 
> 3230                 switch (cmd) {
> 3231                 case 'f':
> 3232                         dump_spu_fields(spu_info[num].spu);
> 3233                         break;
> 3234                 default:
> 3235                         dump_spu_ls(num, subcmd);
> 3236                         break;
> 3237                 }
> 3238 
> 3239                 break;
> */
> c00000000008229c:	3b 20 00 00 	li      r25,0
> c0000000000822a0:	3b 9f 3e 10 	addi    r28,r31,15888
> c0000000000822a4:	38 7c 66 e0 	addi    r3,r28,26336
> c0000000000822a8:	4b ff d1 19 	bl      c00000000007f3c0 <.scanhex>
> c0000000000822ac:	e9 3c 66 e0 	ld      r9,26336(r28)
> c0000000000822b0:	2b a9 00 0f 	cmpldi  cr7,r9,15
> c0000000000822b4:	41 9d 01 0c 	bgt-    cr7,c0000000000823c0 <.xmon_core+0x1f10>
> c0000000000822b8:	1d 49 00 28 	mulli   r10,r9,40
> c0000000000822bc:	7f 9c 52 14 	add     r28,r28,r10
> c0000000000822c0:	e8 7c 21 50 	ld      r3,8528(r28)
> c0000000000822c4:	2f a3 00 00 	cmpdi   cr7,r3,0
> c0000000000822c8:	41 9e 00 f8 	beq-    cr7,c0000000000823c0 <.xmon_core+0x1f10>
> c0000000000822cc:	2f 9a 00 66 	cmpwi   cr7,r26,102		; 102 = 'f'
> c0000000000822d0:	41 9e 05 b4 	beq-    cr7,c000000000082884 <.xmon_core+0x23d4>
> c0000000000822d4:	7d 23 4b 78 	mr      r3,r9
> c0000000000822d8:	7f 24 cb 78 	mr      r4,r25
> c0000000000822dc:	4b ff df e5 	bl      c0000000000802c0 <.dump_spu_ls>
> c0000000000822e0:	4b ff e7 30 	b       c000000000080a10 <.xmon_core+0x560>
> 
> /*
> 1627                 unsigned long sp, toc;
> 1628                 asm("mr %0,1" : "=r" (sp) :);
> 1629                 asm("mr %0,2" : "=r" (toc) :);
> 1630 
> 1631                 printf("msr  = "REG"  sprg0= "REG"\n",
> 1632                        mfmsr(), mfspr(SPRN_SPRG0));
> 1633                 printf("pvr  = "REG"  sprg1= "REG"\n",
> 1634                        mfspr(SPRN_PVR), mfspr(SPRN_SPRG1));
> 1635                 printf("dec  = "REG"  sprg2= "REG"\n",
> 1636                        mfspr(SPRN_DEC), mfspr(SPRN_SPRG2));
> 1637                 printf("sp   = "REG"  sprg3= "REG"\n", sp, mfspr(SPRN_SPRG3));
> 1638                 printf("toc  = "REG"  dar  = "REG"\n", toc, mfspr(SPRN_DAR));
> 1639 
> 1640                 return;
> */
> c0000000000822e4:	7c 3a 0b 78 	mr      r26,r1
> c0000000000822e8:	7c 5c 13 78 	mr      r28,r2
> c0000000000822ec:	7c 80 00 a6 	mfmsr   r4
> c0000000000822f0:	7c b0 42 a6 	mfsprg  r5,0
> c0000000000822f4:	3c 62 ff d4 	addis   r3,r2,-44
> c0000000000822f8:	38 63 91 28 	addi    r3,r3,-28376
> c0000000000822fc:	48 00 15 45 	bl      c000000000083840 <.xmon_printf>
> c000000000082300:	60 00 00 00 	nop
> c000000000082304:	7c 9f 42 a6 	mfpvr   r4
> c000000000082308:	7c b1 42 a6 	mfsprg  r5,1
> c00000000008230c:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082310:	38 63 91 48 	addi    r3,r3,-28344
> c000000000082314:	48 00 15 2d 	bl      c000000000083840 <.xmon_printf>
> c000000000082318:	60 00 00 00 	nop
> c00000000008231c:	7c 96 02 a6 	mfdec   r4
> c000000000082320:	7c b2 42 a6 	mfsprg  r5,2
> c000000000082324:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082328:	38 63 91 68 	addi    r3,r3,-28312
> c00000000008232c:	48 00 15 15 	bl      c000000000083840 <.xmon_printf>
> c000000000082330:	60 00 00 00 	nop
> c000000000082334:	7c b3 42 a6 	mfsprg  r5,3
> c000000000082338:	3c 62 ff d4 	addis   r3,r2,-44
> c00000000008233c:	7f 44 d3 78 	mr      r4,r26
> c000000000082340:	38 63 91 88 	addi    r3,r3,-28280
> c000000000082344:	48 00 14 fd 	bl      c000000000083840 <.xmon_printf>
> c000000000082348:	60 00 00 00 	nop
> c00000000008234c:	7c b3 02 a6 	mfdar   r5
> c000000000082350:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082354:	7f 84 e3 78 	mr      r4,r28
> c000000000082358:	38 63 91 a8 	addi    r3,r3,-28248
> c00000000008235c:	48 00 14 e5 	bl      c000000000083840 <.xmon_printf>
> c000000000082360:	60 00 00 00 	nop
> c000000000082364:	4b ff e6 ac 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082368:	4b ff c9 89 	bl      c00000000007ecf0 <.inchar>
> c00000000008236c:	78 69 00 20 	clrldi  r9,r3,32
> c000000000082370:	7c 79 1b 78 	mr      r25,r3
> c000000000082374:	39 49 ff d0 	addi    r10,r9,-48
> c000000000082378:	2b 8a 00 09 	cmplwi  cr7,r10,9
> c00000000008237c:	40 9d 00 24 	ble-    cr7,c0000000000823a0 <.xmon_core+0x1ef0>
> c000000000082380:	39 49 ff 9f 	addi    r10,r9,-97
> c000000000082384:	2b 8a 00 05 	cmplwi  cr7,r10,5
> c000000000082388:	40 9d 00 18 	ble-    cr7,c0000000000823a0 <.xmon_core+0x1ef0>
> c00000000008238c:	39 29 ff bf 	addi    r9,r9,-65
> c000000000082390:	2b 89 00 05 	cmplwi  cr7,r9,5
> c000000000082394:	40 9d 00 0c 	ble-    cr7,c0000000000823a0 <.xmon_core+0x1ef0>
> c000000000082398:	2f 83 00 0a 	cmpwi   cr7,r3,10
> c00000000008239c:	40 9e ff 04 	bne+    cr7,c0000000000822a0 <.xmon_core+0x1df0>
> c0000000000823a0:	3b 9f 3e 10 	addi    r28,r31,15888
> c0000000000823a4:	39 3f 3e 10 	addi    r9,r31,15888
> c0000000000823a8:	38 7c 66 e0 	addi    r3,r28,26336
> c0000000000823ac:	93 29 24 d8 	stw     r25,9432(r9)
> c0000000000823b0:	4b ff d0 11 	bl      c00000000007f3c0 <.scanhex>
> c0000000000823b4:	e9 3c 66 e0 	ld      r9,26336(r28)
> c0000000000823b8:	2b a9 00 0f 	cmpldi  cr7,r9,15
> c0000000000823bc:	40 9d fe fc 	ble+    cr7,c0000000000822b8 <.xmon_core+0x1e08>
> c0000000000823c0:	3c 62 ff d4 	addis   r3,r2,-44
> c0000000000823c4:	38 63 91 d8 	addi    r3,r3,-28200
> c0000000000823c8:	48 00 14 79 	bl      c000000000083840 <.xmon_printf>
> c0000000000823cc:	60 00 00 00 	nop
> c0000000000823d0:	4b ff e6 40 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c0000000000823d4:	39 3a 44 e8 	addi    r9,r26,17640
> c0000000000823d8:	39 40 00 08 	li      r10,8
> c0000000000823dc:	91 49 00 40 	stw     r10,64(r9)
> c0000000000823e0:	7f 74 db 78 	mr      r20,r27
> c0000000000823e4:	4b ff ee 9c 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c0000000000823e8:	81 3c 66 d0 	lwz     r9,26320(r28)
> c0000000000823ec:	7f 74 db 78 	mr      r20,r27
> c0000000000823f0:	7d 29 00 34 	cntlzw  r9,r9
> c0000000000823f4:	55 29 d9 7e 	rlwinm  r9,r9,27,5,31
> c0000000000823f8:	91 3c 66 d0 	stw     r9,26320(r28)
> c0000000000823fc:	4b ff ee 84 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082400:	39 20 00 01 	li      r9,1
> c000000000082404:	7f 74 db 78 	mr      r20,r27
> c000000000082408:	91 3c 66 d4 	stw     r9,26324(r28)
> c00000000008240c:	4b ff ee 74 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082410:	3c c2 00 0f 	addis   r6,r2,15
> c000000000082414:	7f 74 db 78 	mr      r20,r27
> c000000000082418:	38 66 64 00 	addi    r3,r6,25600
> c00000000008241c:	4b ff cf a5 	bl      c00000000007f3c0 <.scanhex>
> c000000000082420:	4b ff ee 60 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082424:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000082428:	39 40 00 04 	li      r10,4
> c00000000008242c:	91 49 00 40 	stw     r10,64(r9)
> c000000000082430:	7f 74 db 78 	mr      r20,r27
> c000000000082434:	4b ff ee 4c 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082438:	39 3a 44 e8 	addi    r9,r26,17640
> c00000000008243c:	39 40 00 01 	li      r10,1
> c000000000082440:	91 49 00 40 	stw     r10,64(r9)
> c000000000082444:	7f 74 db 78 	mr      r20,r27
> c000000000082448:	4b ff ee 38 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c00000000008244c:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000082450:	e9 5c 25 f0 	ld      r10,9712(r28)
> c000000000082454:	7f 74 db 78 	mr      r20,r27
> c000000000082458:	e9 29 00 42 	lwa     r9,64(r9)
> c00000000008245c:	7d 29 50 50 	subf    r9,r9,r10
> c000000000082460:	f9 3c 25 f0 	std     r9,9712(r28)
> c000000000082464:	4b ff ee 1c 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082468:	2f 99 00 00 	cmpwi   cr7,r25,0
> c00000000008246c:	41 9c 07 70 	blt-    cr7,c000000000082bdc <.xmon_core+0x272c>
> c000000000082470:	e9 5c 25 f0 	ld      r10,9712(r28)
> c000000000082474:	39 20 00 10 	li      r9,16
> c000000000082478:	3b 20 ff fc 	li      r25,-4
> c00000000008247c:	7d 29 50 50 	subf    r9,r9,r10
> c000000000082480:	7f 74 db 78 	mr      r20,r27
> c000000000082484:	f9 3c 25 f0 	std     r9,9712(r28)
> c000000000082488:	4b ff ed f8 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c00000000008248c:	e8 61 01 b8 	ld      r3,440(r1)
> c000000000082490:	7f 74 db 78 	mr      r20,r27
> c000000000082494:	48 00 13 ad 	bl      c000000000083840 <.xmon_printf>
> c000000000082498:	60 00 00 00 	nop
> c00000000008249c:	4b ff ed e4 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c0000000000824a0:	39 3a 44 e8 	addi    r9,r26,17640
> c0000000000824a4:	38 61 01 60 	addi    r3,r1,352
> c0000000000824a8:	e9 29 00 42 	lwa     r9,64(r9)
> c0000000000824ac:	7f 74 db 78 	mr      r20,r27
> c0000000000824b0:	f9 21 01 60 	std     r9,352(r1)
> c0000000000824b4:	4b ff cf 0d 	bl      c00000000007f3c0 <.scanhex>
> c0000000000824b8:	e9 3c 25 f0 	ld      r9,9712(r28)
> c0000000000824bc:	e9 41 01 60 	ld      r10,352(r1)
> c0000000000824c0:	7d 2a 4a 14 	add     r9,r10,r9
> c0000000000824c4:	f9 3c 25 f0 	std     r9,9712(r28)
> c0000000000824c8:	4b ff ed b8 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c0000000000824cc:	39 3a 44 e8 	addi    r9,r26,17640
> c0000000000824d0:	38 61 01 60 	addi    r3,r1,352
> c0000000000824d4:	e9 29 00 42 	lwa     r9,64(r9)
> c0000000000824d8:	7f 74 db 78 	mr      r20,r27
> c0000000000824dc:	f9 21 01 60 	std     r9,352(r1)
> c0000000000824e0:	4b ff ce e1 	bl      c00000000007f3c0 <.scanhex>
> c0000000000824e4:	e9 5c 25 f0 	ld      r10,9712(r28)
> c0000000000824e8:	e9 21 01 60 	ld      r9,352(r1)
> c0000000000824ec:	7d 29 50 50 	subf    r9,r9,r10
> c0000000000824f0:	f9 3c 25 f0 	std     r9,9712(r28)
> c0000000000824f4:	4b ff ed 8c 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c0000000000824f8:	39 3a 44 e8 	addi    r9,r26,17640
> c0000000000824fc:	39 40 00 02 	li      r10,2
> c000000000082500:	91 49 00 40 	stw     r10,64(r9)
> c000000000082504:	7f 74 db 78 	mr      r20,r27
> c000000000082508:	4b ff ed 78 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c00000000008250c:	2f 99 00 00 	cmpwi   cr7,r25,0
> c000000000082510:	40 9d 06 a8 	ble-    cr7,c000000000082bb8 <.xmon_core+0x2708>
> c000000000082514:	39 20 00 01 	li      r9,1
> c000000000082518:	e9 1c 25 f0 	ld      r8,9712(r28)
> c00000000008251c:	7d 2a c8 30 	slw     r10,r9,r25
> c000000000082520:	3b 39 00 04 	addi    r25,r25,4
> c000000000082524:	7d 29 c8 30 	slw     r9,r9,r25
> c000000000082528:	7d 4a 07 b4 	extsw   r10,r10
> c00000000008252c:	7d 4a 40 50 	subf    r10,r10,r8
> c000000000082530:	7f 39 07 b4 	extsw   r25,r25
> c000000000082534:	7d 29 07 b4 	extsw   r9,r9
> c000000000082538:	7d 2a 4a 14 	add     r9,r10,r9
> c00000000008253c:	7f 74 db 78 	mr      r20,r27
> c000000000082540:	f9 3c 25 f0 	std     r9,9712(r28)
> c000000000082544:	4b ff ed 3c 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082548:	39 20 00 00 	li      r9,0
> c00000000008254c:	7f 74 db 78 	mr      r20,r27
> c000000000082550:	91 3c 66 d4 	stw     r9,26324(r28)
> c000000000082554:	4b ff ed 2c 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082558:	39 3a 44 e8 	addi    r9,r26,17640
> c00000000008255c:	7f 74 db 78 	mr      r20,r27
> c000000000082560:	e9 49 00 42 	lwa     r10,64(r9)
> c000000000082564:	e9 3c 25 f0 	ld      r9,9712(r28)
> c000000000082568:	7d 2a 4a 14 	add     r9,r10,r9
> c00000000008256c:	f9 3c 25 f0 	std     r9,9712(r28)
> c000000000082570:	4b ff ed 10 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c000000000082574:	4b ff c7 7d 	bl      c00000000007ecf0 <.inchar>
> c000000000082578:	3a 00 00 09 	li      r16,9
> c00000000008257c:	3a 80 00 08 	li      r20,8
> c000000000082580:	2f a3 00 5c 	cmpdi   cr7,r3,92
> c000000000082584:	f8 61 01 60 	std     r3,352(r1)
> c000000000082588:	41 9e 00 8c 	beq-    cr7,c000000000082614 <.xmon_core+0x2164>
> c00000000008258c:	60 00 00 00 	nop
> c000000000082590:	2f a3 00 27 	cmpdi   cr7,r3,39
> c000000000082594:	41 9e 00 f4 	beq-    cr7,c000000000082688 <.xmon_core+0x21d8>
> c000000000082598:	39 3a 44 e8 	addi    r9,r26,17640
> c00000000008259c:	80 e9 00 40 	lwz     r7,64(r9)
> c0000000000825a0:	2f 87 00 00 	cmpwi   cr7,r7,0
> c0000000000825a4:	7c e5 07 b4 	extsw   r5,r7
> c0000000000825a8:	40 9d 00 30 	ble-    cr7,c0000000000825d8 <.xmon_core+0x2128>
> c0000000000825ac:	e8 c1 01 60 	ld      r6,352(r1)
> c0000000000825b0:	39 01 01 27 	addi    r8,r1,295
> c0000000000825b4:	78 e7 18 28 	rldic   r7,r7,3,32
> c0000000000825b8:	7f 69 db 78 	mr      r9,r27
> c0000000000825bc:	60 00 00 00 	nop
> c0000000000825c0:	39 49 00 08 	addi    r10,r9,8
> c0000000000825c4:	7c c9 4c 36 	srd     r9,r6,r9
> c0000000000825c8:	7f 8a 38 40 	cmplw   cr7,r10,r7
> c0000000000825cc:	9d 28 00 01 	stbu    r9,1(r8)
> c0000000000825d0:	79 49 00 20 	clrldi  r9,r10,32
> c0000000000825d4:	40 9e ff ec 	bne+    cr7,c0000000000825c0 <.xmon_core+0x2110>
> c0000000000825d8:	81 3c 66 d0 	lwz     r9,26320(r28)
> c0000000000825dc:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000825e0:	41 9e 00 70 	beq-    cr7,c000000000082650 <.xmon_core+0x21a0>
> c0000000000825e4:	e8 7c 25 f0 	ld      r3,9712(r28)
> c0000000000825e8:	38 81 01 28 	addi    r4,r1,296
> c0000000000825ec:	4b ff a6 35 	bl      c00000000007cc20 <.mwrite>
> c0000000000825f0:	39 3a 44 e8 	addi    r9,r26,17640
> c0000000000825f4:	e9 49 00 42 	lwa     r10,64(r9)
> c0000000000825f8:	e9 3c 25 f0 	ld      r9,9712(r28)
> c0000000000825fc:	7d 2a 4a 14 	add     r9,r10,r9
> c000000000082600:	f9 3c 25 f0 	std     r9,9712(r28)
> c000000000082604:	4b ff c6 ed 	bl      c00000000007ecf0 <.inchar>
> c000000000082608:	2f a3 00 5c 	cmpdi   cr7,r3,92
> c00000000008260c:	f8 61 01 60 	std     r3,352(r1)
> c000000000082610:	40 9e ff 80 	bne+    cr7,c000000000082590 <.xmon_core+0x20e0>
> c000000000082614:	4b ff c6 dd 	bl      c00000000007ecf0 <.inchar>
> c000000000082618:	7e a9 ab 78 	mr      r9,r21
> c00000000008261c:	2f 83 00 6e 	cmpwi   cr7,r3,110
> c000000000082620:	41 9e 00 18 	beq-    cr7,c000000000082638 <.xmon_core+0x2188>
> c000000000082624:	41 9d 02 28 	bgt-    cr7,c00000000008284c <.xmon_core+0x239c>
> c000000000082628:	2f 83 00 62 	cmpwi   cr7,r3,98
> c00000000008262c:	7e 89 a3 78 	mr      r9,r20
> c000000000082630:	41 9e 00 08 	beq-    cr7,c000000000082638 <.xmon_core+0x2188>
> c000000000082634:	7c 69 1b 78 	mr      r9,r3
> c000000000082638:	f9 21 01 60 	std     r9,352(r1)
> c00000000008263c:	4b ff ff 5c 	b       c000000000082598 <.xmon_core+0x20e8>
> 
> 
> c000000000082640:	eb 61 01 c0 	ld      r27,448(r1)
> c000000000082644:	eb c1 01 c8 	ld      r30,456(r1)
> c000000000082648:	4b ff c7 39 	bl      c00000000007ed80 <.scannl>
> c00000000008264c:	4b ff e3 c4 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082650:	7c a4 2b 78 	mr      r4,r5
> c000000000082654:	38 61 01 28 	addi    r3,r1,296
> c000000000082658:	f8 a1 01 d0 	std     r5,464(r1)
> c00000000008265c:	4b ff c7 75 	bl      c00000000007edd0 <.byterev>
> c000000000082660:	e8 a1 01 d0 	ld      r5,464(r1)
> c000000000082664:	4b ff ff 80 	b       c0000000000825e4 <.xmon_core+0x2134>
> c000000000082668:	60 00 00 00 	nop
> c00000000008266c:	60 00 00 00 	nop
> 
> 
> c000000000082670:	7c a4 2b 78 	mr      r4,r5
> c000000000082674:	38 61 01 28 	addi    r3,r1,296
> c000000000082678:	f8 a1 01 d0 	std     r5,464(r1)
> c00000000008267c:	4b ff c7 55 	bl      c00000000007edd0 <.byterev>
> c000000000082680:	e8 a1 01 d0 	ld      r5,464(r1)
> c000000000082684:	4b ff ec 60 	b       c0000000000812e4 <.xmon_core+0xe34>
> 
> 
> c000000000082688:	39 3a 44 e8 	addi    r9,r26,17640
> c00000000008268c:	ea 89 00 42 	lwa     r20,64(r9)
> c000000000082690:	e9 3c 25 f0 	ld      r9,9712(r28)
> c000000000082694:	7d 34 48 50 	subf    r9,r20,r9
> c000000000082698:	f9 3c 25 f0 	std     r9,9712(r28)
> c00000000008269c:	4b ff eb e4 	b       c000000000081280 <.xmon_core+0xdd0>
> 
> 
> c0000000000826a0:	3d 22 00 09 	addis   r9,r2,9
> c0000000000826a4:	3b 80 00 01 	li      r28,1
> c0000000000826a8:	e9 29 2f 00 	ld      r9,12032(r9)
> c0000000000826ac:	4b ff e0 20 	b       c0000000000806cc <.xmon_core+0x21c>
> 
> 
> c0000000000826b0:	7e 43 93 78 	mr      r3,r18
> c0000000000826b4:	48 00 11 8d 	bl      c000000000083840 <.xmon_printf>
> c0000000000826b8:	60 00 00 00 	nop
> c0000000000826bc:	4b ff e3 54 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
>  747                 brk.address = dabr.address;
>  748                 brk.type = (dabr.enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
>  749                 brk.len = 8;
>  750                 set_breakpoint(&brk);
> */
> c0000000000826c0:	55 29 07 7e 	clrlwi  r9,r9,29
> c0000000000826c4:	e9 4a 66 e8 	ld      r10,26344(r10)
> c0000000000826c8:	38 61 01 28 	addi    r3,r1,296
> c0000000000826cc:	61 29 00 38 	ori     r9,r9,56
> c0000000000826d0:	b1 21 01 30 	sth     r9,304(r1)
> c0000000000826d4:	39 20 00 08 	li      r9,8
> c0000000000826d8:	f9 41 01 28 	std     r10,296(r1)
> c0000000000826dc:	b1 21 01 32 	sth     r9,306(r1)
> c0000000000826e0:	4b f9 18 a1 	bl      c000000000013f80 <.set_breakpoint>
> c0000000000826e4:	60 00 00 00 	nop
> c0000000000826e8:	4b ff e0 e8 	b       c0000000000807d0 <.xmon_core+0x320>
> 
> 
> /*
>  533         if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT)) {
>  534                 bp = at_breakpoint(regs->nip);
>  535                 if (bp != NULL) {
>  536                         int stepped = emulate_step(regs, bp->instr[0]);
>  537                         if (stepped == 0) {
>  538                                 regs->nip = (unsigned long) &bp->instr[0];
>  539                                 atomic_inc(&bp->ref_count);
>  540                         } else if (stepped < 0) {
>  541                                 printf("Couldn't single-step %s instruction\n",
>  542                                     (IS_RFID(bp->instr[0])? "rfid": "mtmsrd"));
>  543                         }
>  544                 }
>  545         }
> */
> c0000000000826ec:	e8 e1 02 a0 	ld      r7,672(r1)
> c0000000000826f0:	3b ea 00 08 	addi    r31,r10,8
> c0000000000826f4:	39 4a 20 08 	addi    r10,r10,8200
> c0000000000826f8:	e9 07 01 00 	ld      r8,256(r7)
> c0000000000826fc:	48 00 00 10 	b       c00000000008270c <.xmon_core+0x225c>
> c000000000082700:	3b ff 00 20 	addi    r31,r31,32
> c000000000082704:	7f bf 50 00 	cmpd    cr7,r31,r10
> c000000000082708:	41 9e e0 b4 	beq+    cr7,c0000000000807bc <.xmon_core+0x30c>
> c00000000008270c:	81 3f 00 14 	lwz     r9,20(r31)
> c000000000082710:	2f 89 00 00 	cmpwi   cr7,r9,0
> c000000000082714:	41 9e ff ec 	beq+    cr7,c000000000082700 <.xmon_core+0x2250>
> c000000000082718:	e9 3f 00 00 	ld      r9,0(r31)
> c00000000008271c:	7f a8 48 00 	cmpd    cr7,r8,r9
> c000000000082720:	40 9e ff e0 	bne+    cr7,c000000000082700 <.xmon_core+0x2250>
> c000000000082724:	2f bf 00 00 	cmpdi   cr7,r31,0
> c000000000082728:	41 be e0 94 	beq-    cr7,c0000000000807bc <.xmon_core+0x30c>
> c00000000008272c:	80 9f 00 08 	lwz     r4,8(r31)
> c000000000082730:	e8 61 02 a0 	ld      r3,672(r1)
> c000000000082734:	48 79 b0 ed 	bl      c00000000081d820 <.emulate_step>
> c000000000082738:	60 00 00 00 	nop
> c00000000008273c:	2c 23 00 00 	cmpdi   r3,0
> c000000000082740:	40 82 05 08 	bne-    c000000000082c48 <.xmon_core+0x2798>
> c000000000082744:	e9 01 02 a0 	ld      r8,672(r1)
> c000000000082748:	39 3f 00 08 	addi    r9,r31,8
> c00000000008274c:	f9 28 01 00 	std     r9,256(r8)
> c000000000082750:	39 3f 00 10 	addi    r9,r31,16
> c000000000082754:	7d 40 48 28 	lwarx   r10,0,r9
> c000000000082758:	31 4a 00 01 	addic   r10,r10,1
> c00000000008275c:	7d 40 49 2d 	stwcx.  r10,0,r9
> c000000000082760:	40 a2 ff f4 	bne-    c000000000082754 <.xmon_core+0x22a4>
> c000000000082764:	4b ff e0 58 	b       c0000000000807bc <.xmon_core+0x30c>
> 
> 
> c000000000082768:	e8 81 01 60 	ld      r4,352(r1)
> c00000000008276c:	39 24 ff ff 	addi    r9,r4,-1
> c000000000082770:	2b a9 00 ff 	cmpldi  cr7,r9,255
> c000000000082774:	40 9d 02 70 	ble-    cr7,c0000000000829e4 <.xmon_core+0x2534>
> c000000000082778:	39 5f 3e 10 	addi    r10,r31,15888
> c00000000008277c:	3b 8a 00 08 	addi    r28,r10,8
> c000000000082780:	39 4a 20 08 	addi    r10,r10,8200
> c000000000082784:	48 00 00 18 	b       c00000000008279c <.xmon_core+0x22ec>
> c000000000082788:	60 00 00 00 	nop
> c00000000008278c:	60 00 00 00 	nop
> 
> 
> c000000000082790:	3b 9c 00 20 	addi    r28,r28,32
> c000000000082794:	7f bc 50 00 	cmpd    cr7,r28,r10
> c000000000082798:	41 9e 00 24 	beq-    cr7,c0000000000827bc <.xmon_core+0x230c>
> c00000000008279c:	81 3c 00 14 	lwz     r9,20(r28)
> c0000000000827a0:	2f 89 00 00 	cmpwi   cr7,r9,0
> c0000000000827a4:	41 9e ff ec 	beq+    cr7,c000000000082790 <.xmon_core+0x22e0>
> c0000000000827a8:	e9 3c 00 00 	ld      r9,0(r28)
> c0000000000827ac:	7f a4 48 00 	cmpd    cr7,r4,r9
> c0000000000827b0:	40 9e ff e0 	bne+    cr7,c000000000082790 <.xmon_core+0x22e0>
> c0000000000827b4:	2f bc 00 00 	cmpdi   cr7,r28,0
> c0000000000827b8:	40 be 02 3c 	bne+    cr7,c0000000000829f4 <.xmon_core+0x2544>
> c0000000000827bc:	3c 62 ff d4 	addis   r3,r2,-44
> c0000000000827c0:	38 63 97 38 	addi    r3,r3,-26824
> c0000000000827c4:	48 00 10 7d 	bl      c000000000083840 <.xmon_printf>
> c0000000000827c8:	60 00 00 00 	nop
> c0000000000827cc:	4b ff e2 44 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c0000000000827d0:	3c 62 ff d4 	addis   r3,r2,-44
> c0000000000827d4:	38 63 9a 50 	addi    r3,r3,-26032
> c0000000000827d8:	48 00 10 69 	bl      c000000000083840 <.xmon_printf>
> c0000000000827dc:	60 00 00 00 	nop
> c0000000000827e0:	4b ff e2 30 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c0000000000827e4:	3f 82 ff ed 	addis   r28,r2,-19
> c0000000000827e8:	3b 9c 44 e8 	addi    r28,r28,17640
> c0000000000827ec:	38 7c 00 48 	addi    r3,r28,72
> c0000000000827f0:	4b ff cb d1 	bl      c00000000007f3c0 <.scanhex>
> c0000000000827f4:	e9 3c 00 48 	ld      r9,72(r28)
> c0000000000827f8:	2f a9 00 00 	cmpdi   cr7,r9,0
> c0000000000827fc:	41 9e 01 d8 	beq-    cr7,c0000000000829d4 <.xmon_core+0x2524>
> c000000000082800:	3d 40 00 02 	lis     r10,2
> c000000000082804:	7d 24 4b 78 	mr      r4,r9
> c000000000082808:	7f a9 50 40 	cmpld   cr7,r9,r10
> c00000000008280c:	40 9d 00 0c 	ble-    cr7,c000000000082818 <.xmon_core+0x2368>
> c000000000082810:	f9 5c 00 48 	std     r10,72(r28)
> c000000000082814:	3c 80 00 02 	lis     r4,2
> c000000000082818:	3b 9f 3e 10 	addi    r28,r31,15888
> c00000000008281c:	3d 22 ff f7 	addis   r9,r2,-9
> c000000000082820:	38 c9 b4 68 	addi    r6,r9,-19352
> c000000000082824:	e8 7c 25 f0 	ld      r3,9712(r28)
> c000000000082828:	38 a0 00 01 	li      r5,1
> c00000000008282c:	4b ff 9d 35 	bl      c00000000007c560 <.generic_inst_dump>
> c000000000082830:	e9 5c 25 f0 	ld      r10,9712(r28)
> c000000000082834:	3d 22 ff d4 	addis   r9,r2,-44
> c000000000082838:	39 29 91 18 	addi    r9,r9,-28392
> c00000000008283c:	7c 63 52 14 	add     r3,r3,r10
> c000000000082840:	f9 3c 26 38 	std     r9,9784(r28)
> c000000000082844:	f8 7c 25 f0 	std     r3,9712(r28)
> c000000000082848:	4b ff e1 c8 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c00000000008284c:	2f 83 00 72 	cmpwi   cr7,r3,114
> c000000000082850:	7f c9 f3 78 	mr      r9,r30
> c000000000082854:	41 9e fd e4 	beq+    cr7,c000000000082638 <.xmon_core+0x2188>
> c000000000082858:	2f 83 00 74 	cmpwi   cr7,r3,116
> c00000000008285c:	7e 09 83 78 	mr      r9,r16
> c000000000082860:	41 9e fd d8 	beq+    cr7,c000000000082638 <.xmon_core+0x2188>
> c000000000082864:	7c 69 1b 78 	mr      r9,r3
> c000000000082868:	4b ff fd d0 	b       c000000000082638 <.xmon_core+0x2188>
> 
> 
> c00000000008286c:	e9 3f 00 00 	ld      r9,0(r31)
> c000000000082870:	7c 00 48 6c 	dcbst   0,r9
> c000000000082874:	7c 00 04 ac 	sync    
> c000000000082878:	7c 00 4f ac 	icbi    0,r9
> c00000000008287c:	4c 00 01 2c 	isync
> c000000000082880:	4b ff e5 70 	b       c000000000080df0 <.xmon_core+0x940>
> 
> 
> /*
> 3232                         dump_spu_fields(spu_info[num].spu);
> 3233                         break;
> */
> c000000000082884:	4b ff aa ed 	bl      c00000000007d370 <.dump_spu_fields>
> c000000000082888:	4b ff e1 88 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c00000000008288c:	e8 61 01 60 	ld      r3,352(r1)
> c000000000082890:	4b ff a2 61 	bl      c00000000007caf0 <.check_bp_loc>
> c000000000082894:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000082898:	41 9e e1 78 	beq+    cr7,c000000000080a10 <.xmon_core+0x560>
> c00000000008289c:	e8 61 01 60 	ld      r3,352(r1)
> c0000000000828a0:	4b ff 92 31 	bl      c00000000007bad0 <.new_breakpoint>
> c0000000000828a4:	2c 23 00 00 	cmpdi   r3,0
> c0000000000828a8:	41 82 e1 68 	beq+    c000000000080a10 <.xmon_core+0x560>
> c0000000000828ac:	81 43 00 14 	lwz     r10,20(r3)
> c0000000000828b0:	61 4a 00 08 	ori     r10,r10,8
> c0000000000828b4:	91 43 00 14 	stw     r10,20(r3)
> c0000000000828b8:	4b ff e1 58 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
>  395                 secondary = !(xmon_taken && cpu == xmon_owner);
>  396                 goto cmdloop;
> */
> c0000000000828bc:	3d 02 ff ed 	addis   r8,r2,-19
> c0000000000828c0:	39 08 44 e8 	addi    r8,r8,17640
> c0000000000828c4:	e9 08 00 28 	ld      r8,40(r8)
> c0000000000828c8:	2f a8 00 00 	cmpdi   cr7,r8,0
> c0000000000828cc:	40 9e 05 c0 	bne-    cr7,c000000000082e8c <.xmon_core+0x29dc>
> c0000000000828d0:	80 e1 01 90 	lwz     r7,400(r1)
> c0000000000828d4:	39 40 00 01 	li      r10,1
> c0000000000828d8:	3b 80 00 01 	li      r28,1
> c0000000000828dc:	7d 4a 38 36 	sld     r10,r10,r7
> c0000000000828e0:	f9 41 01 80 	std     r10,384(r1)
> c0000000000828e4:	4b ff dd e8 	b       c0000000000806cc <.xmon_core+0x21c>
> 
> 
> /*
>  659 static struct bpt *at_breakpoint(unsigned long pc)
>  660 {
>  661         int i;
>  662         struct bpt *bp;
>  663 
>  664         bp = bpts;
>  665         for (i = 0; i < NBPTS; ++i, ++bp)
>  666                 if (bp->enabled && pc == bp->address)
>  667                         return bp;
>  668         return NULL;
>  669 }
> */
> c0000000000828e8:	e9 21 02 a0 	ld      r9,672(r1)
> c0000000000828ec:	38 ca 00 08 	addi    r6,r10,8
> c0000000000828f0:	39 4a 20 08 	addi    r10,r10,8200
> c0000000000828f4:	f8 c1 01 70 	std     r6,368(r1)
> c0000000000828f8:	e9 09 01 00 	ld      r8,256(r9)
> c0000000000828fc:	7c c9 33 78 	mr      r9,r6
> c000000000082900:	48 00 00 1c 	b       c00000000008291c <.xmon_core+0x246c>
> c000000000082904:	60 00 00 00 	nop
> c000000000082908:	60 00 00 00 	nop
> c00000000008290c:	60 00 00 00 	nop
> c000000000082910:	39 29 00 20 	addi    r9,r9,32
> c000000000082914:	7f a9 50 00 	cmpd    cr7,r9,r10
> c000000000082918:	41 9e 05 f8 	beq-    cr7,c000000000082f10 <.xmon_core+0x2a60>
> c00000000008291c:	80 c9 00 14 	lwz     r6,20(r9)
> c000000000082920:	2f 86 00 00 	cmpwi   cr7,r6,0
> c000000000082924:	41 9e ff ec 	beq+    cr7,c000000000082910 <.xmon_core+0x2460>
> c000000000082928:	e8 c9 00 00 	ld      r6,0(r9)
> c00000000008292c:	7f a8 30 00 	cmpd    cr7,r8,r6
> c000000000082930:	40 9e ff e0 	bne+    cr7,c000000000082910 <.xmon_core+0x2460>
> c000000000082934:	2f a9 00 00 	cmpdi   cr7,r9,0
> c000000000082938:	f9 21 01 70 	std     r9,368(r1)		; 368(r1) = bp
> c00000000008293c:	41 be df e4 	beq-    cr7,c000000000080920 <.xmon_core+0x470>
> /*
>  409                 get_output_lock();
>  410                 excprint(regs);
>  411                 if (bp) {
>  412                         printf("cpu 0x%x stopped at breakpoint 0x%x (",
>  413                                cpu, BP_NUM(bp));
>  414                         xmon_print_symbol(regs->nip, " ", ")\n");
>  415                 }
>  416                 if (unrecoverable_excp(regs))
>  417                         printf("WARNING: exception is not recoverable, "
>  418                                "can't continue\n");
> */
> c000000000082940:	4b ff 8f 21 	bl      c00000000007b860 <.get_output_lock>
> c000000000082944:	e8 61 02 a0 	ld      r3,672(r1)		; 672(r1) = regs
> c000000000082948:	4b ff c7 19 	bl      c00000000007f060 <.excprint>
> c00000000008294c:	e8 c1 01 70 	ld      r6,368(r1)
> c000000000082950:	2f a6 00 00 	cmpdi   cr7,r6,0		; check bp
> c000000000082954:	41 9e 00 4c 	beq-    cr7,c0000000000829a0 <.xmon_core+0x24f0>
> c000000000082958:	3c a2 00 0f 	addis   r5,r2,15
> c00000000008295c:	e8 81 01 78 	ld      r4,376(r1)
> c000000000082960:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082964:	38 a5 3e 10 	addi    r5,r5,15888
> c000000000082968:	38 63 8b 18 	addi    r3,r3,-29928
> c00000000008296c:	38 a5 00 08 	addi    r5,r5,8
> c000000000082970:	7c a5 30 50 	subf    r5,r5,r6
> c000000000082974:	7c a5 2e 74 	sradi   r5,r5,5
> c000000000082978:	38 a5 00 01 	addi    r5,r5,1
> c00000000008297c:	48 00 0e c5 	bl      c000000000083840 <.xmon_printf>
> c000000000082980:	60 00 00 00 	nop
> c000000000082984:	e8 e1 02 a0 	ld      r7,672(r1)
> c000000000082988:	3c 82 ff d8 	addis   r4,r2,-40
> c00000000008298c:	3c a2 ff da 	addis   r5,r2,-38
> c000000000082990:	38 84 a6 70 	addi    r4,r4,-22928
> c000000000082994:	38 a5 96 70 	addi    r5,r5,-27024
> c000000000082998:	e8 67 01 00 	ld      r3,256(r7)
> c00000000008299c:	4b ff 98 c5 	bl      c00000000007c260 <.xmon_print_symbol>
> c0000000000829a0:	e9 01 02 a0 	ld      r8,672(r1)
> c0000000000829a4:	e9 28 01 08 	ld      r9,264(r8)
> c0000000000829a8:	79 2a ff e3 	rldicl. r10,r9,63,63		; check unrecoverable_excp(regs)
> c0000000000829ac:	41 82 05 50 	beq-    c000000000082efc <.xmon_core+0x2a4c>
> 									; == "if (bp || unrecoverable_excp(regs))"
> c0000000000829b0:	3d 22 00 0f 	addis   r9,r2,15
> c0000000000829b4:	39 40 00 00 	li      r10,0
> c0000000000829b8:	38 c0 00 00 	li      r6,0
> c0000000000829bc:	91 49 3e 10 	stw     r10,15888(r9)		; release_output_lock();
> c0000000000829c0:	f8 c1 02 a8 	std     r6,680(r1)		/* fromipi = 0; */
> c0000000000829c4:	4b ff dc 80 	b       c000000000080644 <.xmon_core+0x194>
> 
> 
> c0000000000829c8:	39 20 00 08 	li      r9,8
> c0000000000829cc:	91 2a 00 40 	stw     r9,64(r10)
> c0000000000829d0:	4b ff e7 50 	b       c000000000081120 <.xmon_core+0xc70>
> 
> 
> c0000000000829d4:	39 20 00 10 	li      r9,16
> c0000000000829d8:	38 80 00 10 	li      r4,16
> c0000000000829dc:	f9 3c 00 48 	std     r9,72(r28)
> c0000000000829e0:	4b ff fe 38 	b       c000000000082818 <.xmon_core+0x2368>
> 
> 
> c0000000000829e4:	3b 9f 3e 10 	addi    r28,r31,15888
> c0000000000829e8:	79 29 2e a4 	rldicr  r9,r9,5,58
> c0000000000829ec:	3b 9c 00 08 	addi    r28,r28,8
> c0000000000829f0:	7f 9c 4a 14 	add     r28,r28,r9
> c0000000000829f4:	38 9f 3e 10 	addi    r4,r31,15888
> c0000000000829f8:	3c 62 ff d4 	addis   r3,r2,-44
> c0000000000829fc:	38 84 00 08 	addi    r4,r4,8
> c000000000082a00:	38 63 97 50 	addi    r3,r3,-26800
> c000000000082a04:	7c 84 e0 50 	subf    r4,r4,r28
> c000000000082a08:	7c 84 2e 74 	sradi   r4,r4,5
> c000000000082a0c:	38 84 00 01 	addi    r4,r4,1
> c000000000082a10:	48 00 0e 31 	bl      c000000000083840 <.xmon_printf>
> c000000000082a14:	60 00 00 00 	nop
> c000000000082a18:	3c 82 ff d8 	addis   r4,r2,-40
> c000000000082a1c:	3c a2 ff da 	addis   r5,r2,-38
> c000000000082a20:	e8 7c 00 00 	ld      r3,0(r28)
> c000000000082a24:	38 84 a6 70 	addi    r4,r4,-22928
> c000000000082a28:	38 a5 96 70 	addi    r5,r5,-27024
> c000000000082a2c:	4b ff 98 35 	bl      c00000000007c260 <.xmon_print_symbol>
> c000000000082a30:	39 20 00 00 	li      r9,0
> c000000000082a34:	91 3c 00 14 	stw     r9,20(r28)
> c000000000082a38:	4b ff df d8 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082a3c:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000082a40:	38 61 01 28 	addi    r3,r1,296
> c000000000082a44:	e8 89 00 42 	lwa     r4,64(r9)
> c000000000082a48:	4b ff c3 89 	bl      c00000000007edd0 <.byterev>
> c000000000082a4c:	4b ff e7 6c 	b       c0000000000811b8 <.xmon_core+0xd08>
> 
> 
> c000000000082a50:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082a54:	e8 9c 66 e8 	ld      r4,26344(r28)
> c000000000082a58:	38 63 98 c8 	addi    r3,r3,-26424
> c000000000082a5c:	48 00 0d e5 	bl      c000000000083840 <.xmon_printf>
> c000000000082a60:	60 00 00 00 	nop
> c000000000082a64:	81 3c 66 fc 	lwz     r9,26364(r28)
> c000000000082a68:	79 28 07 e1 	clrldi. r8,r9,63
> c000000000082a6c:	7d 29 07 b4 	extsw   r9,r9
> c000000000082a70:	40 82 05 58 	bne-    c000000000082fc8 <.xmon_core+0x2b18>
> c000000000082a74:	79 2a ff e3 	rldicl. r10,r9,63,63
> c000000000082a78:	40 82 05 3c 	bne-    c000000000082fb4 <.xmon_core+0x2b04>
> c000000000082a7c:	3c 62 ff d9 	addis   r3,r2,-39
> c000000000082a80:	38 63 80 a0 	addi    r3,r3,-32608
> c000000000082a84:	48 00 0d bd 	bl      c000000000083840 <.xmon_printf>
> c000000000082a88:	60 00 00 00 	nop
> c000000000082a8c:	4b ff ec f0 	b       c00000000008177c <.xmon_core+0x12cc>
> 
> 
> c000000000082a90:	39 29 00 28 	addi    r9,r9,40
> c000000000082a94:	39 40 00 01 	li      r10,1
> c000000000082a98:	7c 20 04 ac 	lwsync
> c000000000082a9c:	7d 00 48 a8 	ldarx   r8,0,r9
> c000000000082aa0:	7d 07 53 78 	or      r7,r8,r10
> c000000000082aa4:	7c e0 49 ad 	stdcx.  r7,0,r9
> c000000000082aa8:	40 a2 ff f4 	bne-    c000000000082a9c <.xmon_core+0x25ec>
> c000000000082aac:	7c 00 04 ac 	sync    
> c000000000082ab0:	79 09 07 e1 	clrldi. r9,r8,63
> c000000000082ab4:	40 82 ec 10 	bne+    c0000000000816c4 <.xmon_core+0x1214>
> c000000000082ab8:	7c 00 04 ac 	sync    
> c000000000082abc:	a1 4d 00 0a 	lhz     r10,10(r13)
> c000000000082ac0:	e8 81 01 60 	ld      r4,352(r1)
> c000000000082ac4:	39 3f 3e 10 	addi    r9,r31,15888
> c000000000082ac8:	e8 61 01 b0 	ld      r3,432(r1)
> c000000000082acc:	91 49 66 54 	stw     r10,26196(r9)
> c000000000082ad0:	48 00 0d 71 	bl      c000000000083840 <.xmon_printf>
> c000000000082ad4:	60 00 00 00 	nop
> c000000000082ad8:	4b ff df 38 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082adc:	3d 22 00 0b 	addis   r9,r2,11
> c000000000082ae0:	38 60 00 00 	li      r3,0
> c000000000082ae4:	39 29 6a 30 	addi    r9,r9,27184
> c000000000082ae8:	e9 29 01 28 	ld      r9,296(r9)
> c000000000082aec:	e9 49 00 00 	ld      r10,0(r9)
> c000000000082af0:	f8 41 00 28 	std     r2,40(r1)
> c000000000082af4:	7d 49 03 a6 	mtctr   r10
> c000000000082af8:	e8 49 00 08 	ld      r2,8(r9)
> c000000000082afc:	4e 80 04 21 	bctrl
> c000000000082b00:	e8 41 00 28 	ld      r2,40(r1)
> c000000000082b04:	4b ff df 0c 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
> 2081 static void dump_pacas(void)
> 2082 {
> 2083         unsigned long num;
> 2084         int c;
> 2085 
> 2086         c = inchar();
> 2087         if (c == 'a') {
> 2088                 dump_all_pacas();
> 2089                 return;
> 2090         }
> 2091 
> 2092         termch = c;     \* Put c back, it wasn't 'a' *\
> 2093 
> 2094         if (scanhex(&num))
> 2095                 dump_one_paca(num);
> */
> c000000000082b08:	4b ff c1 e9 	bl      c00000000007ecf0 <.inchar>
> c000000000082b0c:	2f 83 00 61 	cmpwi   cr7,r3,97
> c000000000082b10:	7c 69 1b 78 	mr      r9,r3
> c000000000082b14:	41 9e 04 08 	beq-    cr7,c000000000082f1c <.xmon_core+0x2a6c>
> c000000000082b18:	3b 9f 3e 10 	addi    r28,r31,15888
> c000000000082b1c:	38 61 01 60 	addi    r3,r1,352		; r3 = &num
> c000000000082b20:	91 3c 24 d8 	stw     r9,9432(r28)
> c000000000082b24:	4b ff c8 9d 	bl      c00000000007f3c0 <.scanhex>
> c000000000082b28:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000082b2c:	41 9e 03 c4 	beq-    cr7,c000000000082ef0 <.xmon_core+0x2a40>
> c000000000082b30:	e8 61 01 66 	lwa     r3,356(r1)		; r3 = (int) num
> c000000000082b34:	4b ff 90 7d 	bl      c00000000007bbb0 <.dump_one_paca>
> c000000000082b38:	4b ff de d8 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082b3c:	3d 22 00 0b 	addis   r9,r2,11
> c000000000082b40:	39 29 6a 30 	addi    r9,r9,27184
> c000000000082b44:	e9 29 01 38 	ld      r9,312(r9)
> c000000000082b48:	e9 49 00 00 	ld      r10,0(r9)
> c000000000082b4c:	f8 41 00 28 	std     r2,40(r1)
> c000000000082b50:	7d 49 03 a6 	mtctr   r10
> c000000000082b54:	e8 49 00 08 	ld      r2,8(r9)
> c000000000082b58:	4e 80 04 21 	bctrl
> c000000000082b5c:	e8 41 00 28 	ld      r2,40(r1)
> c000000000082b60:	4b ff de b0 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082b64:	ea 69 25 f0 	ld      r19,9712(r9)
> c000000000082b68:	41 9d f6 34 	bgt+    cr7,c00000000008219c <.xmon_core+0x1cec>
> c000000000082b6c:	4b ff f6 f4 	b       c000000000082260 <.xmon_core+0x1db0>
> 
> 
> c000000000082b70:	39 3a 44 e8 	addi    r9,r26,17640
> c000000000082b74:	7c 83 23 78 	mr      r3,r4
> c000000000082b78:	e8 a9 00 42 	lwa     r5,64(r9)
> c000000000082b7c:	38 81 01 28 	addi    r4,r1,296
> c000000000082b80:	4b ff 98 41 	bl      c00000000007c3c0 <.mread>
> c000000000082b84:	e8 9c 25 f0 	ld      r4,9712(r28)
> c000000000082b88:	f8 61 01 60 	std     r3,352(r1)
> c000000000082b8c:	4b ff e5 e8 	b       c000000000081174 <.xmon_core+0xcc4>
> 
> 
> c000000000082b90:	4b ff c0 11 	bl      c00000000007eba0 <.dump_log_buf>
> c000000000082b94:	4b ff de 7c 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082b98:	e8 9c 25 f0 	ld      r4,9712(r28)
> c000000000082b9c:	7c 94 22 14 	add     r4,r20,r4
> c000000000082ba0:	f8 9c 25 f0 	std     r4,9712(r28)
> c000000000082ba4:	4b ff e5 c4 	b       c000000000081168 <.xmon_core+0xcb8>
> 
> 
> c000000000082ba8:	7f 44 07 b4 	extsw   r4,r26
> c000000000082bac:	4b ff e4 28 	b       c000000000080fd4 <.xmon_core+0xb24>
> 
> 
> c000000000082bb0:	38 63 26 40 	addi    r3,r3,9792
> c000000000082bb4:	4b ff f1 5c 	b       c000000000081d10 <.xmon_core+0x1860>
> 
> 
> c000000000082bb8:	e9 5c 25 f0 	ld      r10,9712(r28)
> c000000000082bbc:	39 20 00 10 	li      r9,16
> c000000000082bc0:	3b 20 00 04 	li      r25,4
> c000000000082bc4:	4b ff f9 74 	b       c000000000082538 <.xmon_core+0x2088>
> 
> 
> c000000000082bc8:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082bcc:	38 63 97 68 	addi    r3,r3,-26776
> c000000000082bd0:	48 00 0c 71 	bl      c000000000083840 <.xmon_printf>
> c000000000082bd4:	60 00 00 00 	nop
> c000000000082bd8:	4b ff de 38 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082bdc:	7d 19 00 d0 	neg     r8,r25
> c000000000082be0:	39 20 00 01 	li      r9,1
> c000000000082be4:	e9 5c 25 f0 	ld      r10,9712(r28)
> c000000000082be8:	3b 39 ff fc 	addi    r25,r25,-4
> c000000000082bec:	7d 28 40 30 	slw     r8,r9,r8
> c000000000082bf0:	7c f9 00 d0 	neg     r7,r25
> c000000000082bf4:	7d 08 07 b4 	extsw   r8,r8
> c000000000082bf8:	7d 29 38 30 	slw     r9,r9,r7
> c000000000082bfc:	7d 48 52 14 	add     r10,r8,r10
> c000000000082c00:	7f 39 07 b4 	extsw   r25,r25
> c000000000082c04:	7d 29 07 b4 	extsw   r9,r9
> c000000000082c08:	4b ff f8 74 	b       c00000000008247c <.xmon_core+0x1fcc>
> 
> 
> c000000000082c0c:	e8 9a 26 46 	lwa     r4,9796(r26)
> c000000000082c10:	e8 7a 66 b0 	ld      r3,26288(r26)
> c000000000082c14:	e8 ba 66 b8 	ld      r5,26296(r26)
> c000000000082c18:	4b fc c7 dd 	bl      c00000000004f3f4 <.memset>
> c000000000082c1c:	60 00 00 00 	nop
> c000000000082c20:	4b ff dd f0 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082c24:	e8 7a 66 b0 	ld      r3,26288(r26)
> c000000000082c28:	e8 9a 26 48 	ld      r4,9800(r26)
> c000000000082c2c:	e8 ba 66 b8 	ld      r5,26296(r26)
> c000000000082c30:	4b fc c8 c1 	bl      c00000000004f4f0 <.memmove>
> c000000000082c34:	60 00 00 00 	nop
> c000000000082c38:	4b ff dd d8 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082c3c:	39 20 00 01 	li      r9,1
> c000000000082c40:	91 2a 00 40 	stw     r9,64(r10)
> c000000000082c44:	4b ff e4 dc 	b       c000000000081120 <.xmon_core+0xc70>
> 
> 
> c000000000082c48:	2f 83 00 00 	cmpwi   cr7,r3,0
> c000000000082c4c:	40 9c db 70 	bge+    cr7,c0000000000807bc <.xmon_core+0x30c>
> c000000000082c50:	81 5f 00 08 	lwz     r10,8(r31)
> c000000000082c54:	3d 20 fc 00 	lis     r9,-1024
> c000000000082c58:	61 29 07 fe 	ori     r9,r9,2046
> c000000000082c5c:	7d 4a 48 38 	and     r10,r10,r9
> c000000000082c60:	6d 49 4c 00 	xoris   r9,r10,19456
> c000000000082c64:	2f 89 00 24 	cmpwi   cr7,r9,36
> c000000000082c68:	41 9e 03 8c 	beq-    cr7,c000000000082ff4 <.xmon_core+0x2b44>
> c000000000082c6c:	3c 82 ff d4 	addis   r4,r2,-44
> c000000000082c70:	38 84 8a 98 	addi    r4,r4,-30056
> c000000000082c74:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082c78:	38 63 91 f8 	addi    r3,r3,-28168
> c000000000082c7c:	48 00 0b c5 	bl      c000000000083840 <.xmon_printf>
> c000000000082c80:	60 00 00 00 	nop
> c000000000082c84:	4b ff db 38 	b       c0000000000807bc <.xmon_core+0x30c>
> 
> 
> c000000000082c88:	3d 22 ff b3 	addis   r9,r2,-77
> c000000000082c8c:	38 80 08 00 	li      r4,2048
> c000000000082c90:	39 29 19 60 	addi    r9,r9,6496
> c000000000082c94:	e8 69 00 00 	ld      r3,0(r9)
> c000000000082c98:	48 39 26 59 	bl      c0000000004152f0 <.__bitmap_weight>
> c000000000082c9c:	60 00 00 00 	nop
> c000000000082ca0:	e9 41 01 78 	ld      r10,376(r1)
> c000000000082ca4:	7c 7e 1b 78 	mr      r30,r3
> c000000000082ca8:	91 5d 66 54 	stw     r10,26196(r29)
> c000000000082cac:	7c 00 04 ac 	sync    
> c000000000082cb0:	2f 83 00 01 	cmpwi   cr7,r3,1
> c000000000082cb4:	40 9d 00 3c 	ble-    cr7,c000000000082cf0 <.xmon_core+0x2840>
> c000000000082cb8:	3f e0 05 f5 	lis     r31,1525
> c000000000082cbc:	4b fb 55 b5 	bl      c000000000038270 <.smp_send_debugger_break>
> c000000000082cc0:	60 00 00 00 	nop
> c000000000082cc4:	63 ff e1 00 	ori     r31,r31,57600
> c000000000082cc8:	3b bd 24 e8 	addi    r29,r29,9448
> c000000000082ccc:	48 00 00 0c 	b       c000000000082cd8 <.xmon_core+0x2828>
> 
> 
> c000000000082cd0:	37 ff ff ff 	addic.  r31,r31,-1
> c000000000082cd4:	41 82 00 1c 	beq-    c000000000082cf0 <.xmon_core+0x2840>
> c000000000082cd8:	7f a3 eb 78 	mr      r3,r29
> c000000000082cdc:	38 80 08 00 	li      r4,2048
> c000000000082ce0:	48 39 26 11 	bl      c0000000004152f0 <.__bitmap_weight>
> c000000000082ce4:	60 00 00 00 	nop
> c000000000082ce8:	7f 83 f0 40 	cmplw   cr7,r3,r30
> c000000000082cec:	41 9c ff e4 	blt+    cr7,c000000000082cd0 <.xmon_core+0x2820>
> c000000000082cf0:	3f e2 00 0f 	addis   r31,r2,15
> c000000000082cf4:	3f 42 ff d4 	addis   r26,r2,-44
> c000000000082cf8:	3b ff 3e 10 	addi    r31,r31,15888
> c000000000082cfc:	3f 62 ff ed 	addis   r27,r2,-19
> c000000000082d00:	7f fd fb 78 	mr      r29,r31
> c000000000082d04:	3b 5a 8b 78 	addi    r26,r26,-29832
> c000000000082d08:	3b ff 00 08 	addi    r31,r31,8
> c000000000082d0c:	3b dd 20 08 	addi    r30,r29,8200
> c000000000082d10:	48 00 00 1c 	b       c000000000082d2c <.xmon_core+0x287c>
> c000000000082d14:	60 00 00 00 	nop
> c000000000082d18:	60 00 00 00 	nop
> c000000000082d1c:	60 00 00 00 	nop
> 
> 
> c000000000082d20:	3b ff 00 20 	addi    r31,r31,32
> c000000000082d24:	7f bf f0 00 	cmpd    cr7,r31,r30
> c000000000082d28:	41 9e 00 4c 	beq-    cr7,c000000000082d74 <.xmon_core+0x28c4>
> c000000000082d2c:	81 3f 00 14 	lwz     r9,20(r31)
> c000000000082d30:	71 29 00 0a 	andi.   r9,r9,10
> c000000000082d34:	2f 89 00 08 	cmpwi   cr7,r9,8
> c000000000082d38:	40 9e ff e8 	bne+    cr7,c000000000082d20 <.xmon_core+0x2870>
> c000000000082d3c:	e8 7f 00 00 	ld      r3,0(r31)
> c000000000082d40:	38 81 01 60 	addi    r4,r1,352
> c000000000082d44:	38 a0 00 04 	li      r5,4
> c000000000082d48:	4b ff 96 79 	bl      c00000000007c3c0 <.mread>
> c000000000082d4c:	2f 83 00 04 	cmpwi   cr7,r3,4
> c000000000082d50:	41 9e 00 e0 	beq-    cr7,c000000000082e30 <.xmon_core+0x2980>
> c000000000082d54:	e9 3f 00 00 	ld      r9,0(r31)
> c000000000082d58:	7c 00 48 6c 	dcbst   0,r9
> c000000000082d5c:	7c 00 04 ac 	sync    
> c000000000082d60:	7c 00 4f ac 	icbi    0,r9
> c000000000082d64:	4c 00 01 2c 	isync
> c000000000082d68:	3b ff 00 20 	addi    r31,r31,32
> c000000000082d6c:	7f bf f0 00 	cmpd    cr7,r31,r30
> c000000000082d70:	40 9e ff bc 	bne+    cr7,c000000000082d2c <.xmon_core+0x287c>
> c000000000082d74:	3c 62 ff d3 	addis   r3,r2,-45
> c000000000082d78:	38 63 c5 c8 	addi    r3,r3,-14904
> c000000000082d7c:	4b fa 38 85 	bl      c000000000026600 <.rtas_token>
> c000000000082d80:	60 00 00 00 	nop
> c000000000082d84:	78 63 00 20 	clrldi  r3,r3,32
> c000000000082d88:	2f 83 ff ff 	cmpwi   cr7,r3,-1
> c000000000082d8c:	90 7d 66 58 	stw     r3,26200(r29)
> c000000000082d90:	41 9e 00 48 	beq-    cr7,c000000000082dd8 <.xmon_core+0x2928>
> c000000000082d94:	3c 60 40 00 	lis     r3,16384
> c000000000082d98:	39 5d 66 70 	addi    r10,r29,26224
> c000000000082d9c:	78 63 07 c6 	rldicr  r3,r3,32,31
> c000000000082da0:	39 00 00 03 	li      r8,3
> c000000000082da4:	60 63 66 58 	ori     r3,r3,26200
> c000000000082da8:	39 20 00 00 	li      r9,0
> c000000000082dac:	91 1d 66 5c 	stw     r8,26204(r29)
> c000000000082db0:	f9 5d 66 a8 	std     r10,26280(r29)
> c000000000082db4:	39 00 00 01 	li      r8,1
> c000000000082db8:	39 40 23 28 	li      r10,9000
> c000000000082dbc:	7c 7d 1a 14 	add     r3,r29,r3
> c000000000082dc0:	91 1d 66 60 	stw     r8,26208(r29)
> c000000000082dc4:	91 5d 66 64 	stw     r10,26212(r29)
> c000000000082dc8:	91 3d 66 68 	stw     r9,26216(r29)
> c000000000082dcc:	91 3d 66 6c 	stw     r9,26220(r29)
> c000000000082dd0:	4b f8 77 2d 	bl      c00000000000a4fc <.enter_rtas>
> c000000000082dd4:	60 00 00 00 	nop
> c000000000082dd8:	e8 c1 01 70 	ld      r6,368(r1)
> c000000000082ddc:	2f a6 00 00 	cmpdi   cr7,r6,0
> c000000000082de0:	41 9e 01 bc 	beq-    cr7,c000000000082f9c <.xmon_core+0x2aec>
> c000000000082de4:	e9 01 02 a0 	ld      r8,672(r1)
> c000000000082de8:	3d 22 ff f7 	addis   r9,r2,-9
> c000000000082dec:	38 80 00 01 	li      r4,1
> c000000000082df0:	38 c9 b4 68 	addi    r6,r9,-19352
> c000000000082df4:	38 a0 00 00 	li      r5,0
> c000000000082df8:	e8 68 01 00 	ld      r3,256(r8)
> c000000000082dfc:	4b ff 97 65 	bl      c00000000007c560 <.generic_inst_dump>
> c000000000082e00:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082e04:	38 63 8b a0 	addi    r3,r3,-29792
> c000000000082e08:	48 00 0a 39 	bl      c000000000083840 <.xmon_printf>
> c000000000082e0c:	60 00 00 00 	nop
> c000000000082e10:	7c 00 04 ac 	sync    
> c000000000082e14:	3d 22 00 0f 	addis   r9,r2,15
> c000000000082e18:	39 40 00 01 	li      r10,1
> c000000000082e1c:	39 29 3e 10 	addi    r9,r9,15888
> c000000000082e20:	91 49 66 50 	stw     r10,26192(r9)
> c000000000082e24:	3d 22 00 09 	addis   r9,r2,9
> c000000000082e28:	e9 29 2f 00 	ld      r9,12032(r9)
> c000000000082e2c:	4b ff d8 a0 	b       c0000000000806cc <.xmon_core+0x21c>
> 
> 
> c000000000082e30:	81 3b 44 e8 	lwz     r9,17640(r27)
> c000000000082e34:	81 41 01 60 	lwz     r10,352(r1)
> c000000000082e38:	7f 8a 48 00 	cmpw    cr7,r10,r9
> c000000000082e3c:	40 9e ff 18 	bne+    cr7,c000000000082d54 <.xmon_core+0x28a4>
> c000000000082e40:	e8 7f 00 00 	ld      r3,0(r31)
> c000000000082e44:	38 9f 00 08 	addi    r4,r31,8
> c000000000082e48:	38 a0 00 04 	li      r5,4
> c000000000082e4c:	4b ff 9d d5 	bl      c00000000007cc20 <.mwrite>
> c000000000082e50:	2f 83 00 04 	cmpwi   cr7,r3,4
> c000000000082e54:	41 9e ff 00 	beq+    cr7,c000000000082d54 <.xmon_core+0x28a4>
> c000000000082e58:	e8 9f 00 00 	ld      r4,0(r31)
> c000000000082e5c:	7f 43 d3 78 	mr      r3,r26
> c000000000082e60:	48 00 09 e1 	bl      c000000000083840 <.xmon_printf>
> c000000000082e64:	60 00 00 00 	nop
> c000000000082e68:	4b ff fe b8 	b       c000000000082d20 <.xmon_core+0x2870>
> 
> 
> c000000000082e6c:	7f 96 c8 40 	cmplw   cr7,r22,r25
> c000000000082e70:	40 9c db a0 	bge+    cr7,c000000000080a10 <.xmon_core+0x560>
> c000000000082e74:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082e78:	7f 24 cb 78 	mr      r4,r25
> c000000000082e7c:	38 63 8b e8 	addi    r3,r3,-29720
> c000000000082e80:	48 00 09 c1 	bl      c000000000083840 <.xmon_printf>
> c000000000082e84:	60 00 00 00 	nop
> c000000000082e88:	4b ff db 88 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082e8c:	e9 01 01 78 	ld      r8,376(r1)
> c000000000082e90:	81 4a 66 54 	lwz     r10,26196(r10)
> c000000000082e94:	80 c1 01 90 	lwz     r6,400(r1)
> c000000000082e98:	7d 4a 42 78 	xor     r10,r10,r8
> c000000000082e9c:	39 00 00 01 	li      r8,1
> c000000000082ea0:	7d 4a 00 34 	cntlzw  r10,r10
> c000000000082ea4:	7d 08 30 36 	sld     r8,r8,r6
> c000000000082ea8:	f9 01 01 80 	std     r8,384(r1)
> c000000000082eac:	55 4a d9 7e 	rlwinm  r10,r10,27,5,31
> c000000000082eb0:	69 4a 00 01 	xori    r10,r10,1
> c000000000082eb4:	7d 5c 07 b4 	extsw   r28,r10
> c000000000082eb8:	4b ff d8 14 	b       c0000000000806cc <.xmon_core+0x21c>
> 
> 
> c000000000082ebc:	38 61 01 28 	addi    r3,r1,296
> c000000000082ec0:	48 00 09 81 	bl      c000000000083840 <.xmon_printf>
> c000000000082ec4:	60 00 00 00 	nop
> c000000000082ec8:	4b ff db 48 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
>  859                 case 's':
>  860                         if (do_spu_cmd() == 0)
>  861                                 break;
>  862                         if (do_step(excp))
>  863                                 return cmd;
>  864                         break;
> */
> c000000000082ecc:	e8 6f 01 00 	ld      r3,256(r15)
> c000000000082ed0:	38 81 01 60 	addi    r4,r1,352
> c000000000082ed4:	38 a0 00 04 	li      r5,4
> c000000000082ed8:	4b ff 94 e9 	bl      c00000000007c3c0 <.mread>
> c000000000082edc:	2f 83 00 04 	cmpwi   cr7,r3,4
> c000000000082ee0:	41 9e 01 20 	beq-    cr7,c000000000083000 <.xmon_core+0x2b50>
> c000000000082ee4:	e9 21 02 a0 	ld      r9,672(r1)
> c000000000082ee8:	e9 09 01 08 	ld      r8,264(r9)
> c000000000082eec:	4b ff de 98 	b       c000000000080d84 <.xmon_core+0x8d4>
> 
> 
> /*
> 2096         else
> 2097                 dump_one_paca(xmon_owner);
> 2098 }
> */
> c000000000082ef0:	e8 7c 66 56 	lwa     r3,26196(r28)
> c000000000082ef4:	4b ff 8c bd 	bl      c00000000007bbb0 <.dump_one_paca>
> c000000000082ef8:	4b ff db 18 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
>  417                         printf("WARNING: exception is not recoverable, "
>  418                                "can't continue\n");
> */
> c000000000082efc:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082f00:	38 63 8b 40 	addi    r3,r3,-29888
> c000000000082f04:	48 00 09 3d 	bl      c000000000083840 <.xmon_printf>
> c000000000082f08:	60 00 00 00 	nop
> c000000000082f0c:	4b ff fa a4 	b       c0000000000829b0 <.xmon_core+0x2500>
> 
> 
> /*
>  668         return NULL;
>  669 }
> */
> c000000000082f10:	39 00 00 00 	li      r8,0
> c000000000082f14:	f9 01 01 70 	std     r8,368(r1)
> c000000000082f18:	4b ff da 08 	b       c000000000080920 <.xmon_core+0x470>
> 
> 
> /*
> 2068 static void dump_all_pacas(void)
> 2069 {
> 2070         int cpu;
> 2071 
> 2072         if (num_possible_cpus() == 0) {
> 2073                 printf("No possible cpus, use 'dp #' to dump individual cpus\n");
> 2074                 return;
> 2075         }
> 2077         for_each_possible_cpu(cpu)
> 2078                 dump_one_paca(cpu);
> 2079 }
> */
> c000000000082f1c:	3d 22 ff b3 	addis   r9,r2,-77
> c000000000082f20:	38 80 08 00 	li      r4,2048
> c000000000082f24:	39 29 19 68 	addi    r9,r9,6504
> c000000000082f28:	3b 80 ff ff 	li      r28,-1
> c000000000082f2c:	3f 22 00 09 	addis   r25,r2,9
> c000000000082f30:	eb 49 00 00 	ld      r26,0(r9)
> c000000000082f34:	7f 43 d3 78 	mr      r3,r26
> c000000000082f38:	48 39 23 b9 	bl      c0000000004152f0 <.__bitmap_weight>
> c000000000082f3c:	60 00 00 00 	nop
> c000000000082f40:	2f a3 00 00 	cmpdi   cr7,r3,0
> c000000000082f44:	40 9e 00 14 	bne-    cr7,c000000000082f58 <.xmon_core+0x2aa8>
> c000000000082f48:	48 00 00 e4 	b       c00000000008302c <.xmon_core+0x2b7c>
> c000000000082f4c:	60 00 00 00 	nop
> c000000000082f50:	7f 83 e3 78 	mr      r3,r28
> c000000000082f54:	4b ff 8c 5d 	bl      c00000000007bbb0 <.dump_one_paca>
> c000000000082f58:	38 bc 00 01 	addi    r5,r28,1
> c000000000082f5c:	7f 43 d3 78 	mr      r3,r26
> c000000000082f60:	38 80 08 00 	li      r4,2048
> c000000000082f64:	7c a5 07 b4 	extsw   r5,r5
> c000000000082f68:	48 39 51 d9 	bl      c000000000418140 <.find_next_bit>
> c000000000082f6c:	60 00 00 00 	nop
> c000000000082f70:	39 39 33 b8 	addi    r9,r25,13240
> c000000000082f74:	81 29 00 00 	lwz     r9,0(r9)
> c000000000082f78:	7c 7c 07 b4 	extsw   r28,r3
> c000000000082f7c:	7f 89 e0 00 	cmpw    cr7,r9,r28
> c000000000082f80:	41 9d ff d0 	bgt+    cr7,c000000000082f50 <.xmon_core+0x2aa0>
> c000000000082f84:	4b ff da 8c 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082f88:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000082f8c:	38 63 8c 38 	addi    r3,r3,-29640
> c000000000082f90:	48 00 08 b1 	bl      c000000000083840 <.xmon_printf>
> c000000000082f94:	60 00 00 00 	nop
> c000000000082f98:	4b ff da 78 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> c000000000082f9c:	e8 e1 02 a0 	ld      r7,672(r1)
> c000000000082fa0:	e9 27 01 40 	ld      r9,320(r7)
> c000000000082fa4:	79 29 06 e4 	rldicr  r9,r9,0,59
> c000000000082fa8:	2f a9 0d 00 	cmpdi   cr7,r9,3328
> c000000000082fac:	40 9e fe 54 	bne+    cr7,c000000000082e00 <.xmon_core+0x2950>
> c000000000082fb0:	4b ff fe 34 	b       c000000000082de4 <.xmon_core+0x2934>
> 
> 
> c000000000082fb4:	3c 62 ff d9 	addis   r3,r2,-39
> c000000000082fb8:	38 63 ae e8 	addi    r3,r3,-20760
> c000000000082fbc:	48 00 08 85 	bl      c000000000083840 <.xmon_printf>
> c000000000082fc0:	60 00 00 00 	nop
> c000000000082fc4:	4b ff fa b8 	b       c000000000082a7c <.xmon_core+0x25cc>
> 
> 
> c000000000082fc8:	3c 62 ff da 	addis   r3,r2,-38
> c000000000082fcc:	38 63 35 20 	addi    r3,r3,13600
> c000000000082fd0:	48 00 08 71 	bl      c000000000083840 <.xmon_printf>
> c000000000082fd4:	60 00 00 00 	nop
> c000000000082fd8:	e9 3c 66 fe 	lwa     r9,26364(r28)
> c000000000082fdc:	4b ff fa 98 	b       c000000000082a74 <.xmon_core+0x25c4>
> 
> 
> c000000000082fe0:	38 80 ff ff 	li      r4,-1
> c000000000082fe4:	78 84 04 20 	clrldi  r4,r4,48
> c000000000082fe8:	4b ff df ec 	b       c000000000080fd4 <.xmon_core+0xb24>
> 
> 
> c000000000082fec:	3b 20 00 00 	li      r25,0
> c000000000082ff0:	4b ff e2 14 	b       c000000000081204 <.xmon_core+0xd54>
> 
> 
> c000000000082ff4:	3c 82 ff d4 	addis   r4,r2,-44
> c000000000082ff8:	38 84 8a 90 	addi    r4,r4,-30064
> c000000000082ffc:	4b ff fc 78 	b       c000000000082c74 <.xmon_core+0x27c4>
> 
> 
> /* static int do_step(struct pt_regs *regs) */
> /* { */
> c000000000083000:	80 81 01 60 	lwz     r4,352(r1)
> c000000000083004:	7d e3 7b 78 	mr      r3,r15
> c000000000083008:	48 79 a8 19 	bl      c00000000081d820 <.emulate_step>
> c00000000008300c:	60 00 00 00 	nop
> c000000000083010:	2f 83 00 00 	cmpwi   cr7,r3,0
> c000000000083014:	41 9c 00 dc 	blt-    cr7,c0000000000830f0 <.xmon_core+0x2c40>
> c000000000083018:	2f a3 00 00 	cmpdi   cr7,r3,0
> c00000000008301c:	40 9e 00 80 	bne-    cr7,c00000000008309c <.xmon_core+0x2bec>
> c000000000083020:	e8 e1 02 a0 	ld      r7,672(r1)
> c000000000083024:	e9 07 01 08 	ld      r8,264(r7)
> c000000000083028:	4b ff dd 5c 	b       c000000000080d84 <.xmon_core+0x8d4>
> /* } */
> 
> 
> /*
> 3269 2073                 printf("No possible cpus, use 'dp #' to dump individual cpus\n");
> 3270 2074                 return;
> */
> c00000000008302c:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000083030:	38 63 90 e0 	addi    r3,r3,-28448
> c000000000083034:	48 00 08 0d 	bl      c000000000083840 <.xmon_printf>
> c000000000083038:	60 00 00 00 	nop
> c00000000008303c:	4b ff d9 d4 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
>  377         if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
>  378                 get_output_lock();
>  379                 excprint(regs);
>  380                 printf("cpu 0x%x: Exception %lx %s in xmon, "
>  381                        "returning to main loop\n",
>  382                        cpu, regs->trap, getvecname(TRAP(regs)));
>  383                 release_output_lock();
>  384                 longjmp(xmon_fault_jmp[cpu], 1);
>  385         }
> */
> c000000000083040:	4b ff 88 21 	bl      c00000000007b860 <.get_output_lock>
> c000000000083044:	e8 61 02 a0 	ld      r3,672(r1)
> c000000000083048:	4b ff c0 19 	bl      c00000000007f060 <.excprint>
> c00000000008304c:	e9 21 02 a0 	ld      r9,672(r1)
> c000000000083050:	eb a9 01 40 	ld      r29,320(r9)
> c000000000083054:	7b a3 06 e4 	rldicr  r3,r29,0,59
> c000000000083058:	4b ff 88 a9 	bl      c00000000007b900 <.getvecname>
> c00000000008305c:	e8 81 01 78 	ld      r4,376(r1)
> c000000000083060:	7f a5 eb 78 	mr      r5,r29
> c000000000083064:	7c 66 1b 78 	mr      r6,r3
> c000000000083068:	3c 62 ff d4 	addis   r3,r2,-44
> c00000000008306c:	38 63 8a a8 	addi    r3,r3,-30040
> c000000000083070:	48 00 07 d1 	bl      c000000000083840 <.xmon_printf>
> c000000000083074:	60 00 00 00 	nop
> c000000000083078:	e9 41 01 78 	ld      r10,376(r1)
> c00000000008307c:	38 80 00 01 	li      r4,1
> c000000000083080:	79 49 1f 24 	rldicr  r9,r10,3,60
> c000000000083084:	7f de 4a 14 	add     r30,r30,r9
> c000000000083088:	39 20 00 00 	li      r9,0
> c00000000008308c:	e8 7e 26 50 	ld      r3,9808(r30)
> c000000000083090:	91 3f 3e 10 	stw     r9,15888(r31)
> c000000000083094:	4b f9 e5 c9 	bl      c00000000002165c <.longjmp>
> c000000000083098:	60 00 00 00 	nop
> 
> 
> /*
>  946                                 regs->trap = 0xd00 | (regs->trap & 1);
>  947                                 printf("stepped to ");
>  948                                 xmon_print_symbol(regs->nip, " ", "\n");
>  949                                 ppc_inst_dump(regs->nip, 1, 0);
>  950                                 return 0;
> */
> c00000000008309c:	e9 2f 01 40 	ld      r9,320(r15)
> c0000000000830a0:	3c 62 ff d4 	addis   r3,r2,-44
> c0000000000830a4:	38 63 92 20 	addi    r3,r3,-28128
> c0000000000830a8:	79 29 07 e0 	clrldi  r9,r9,63
> c0000000000830ac:	61 29 0d 00 	ori     r9,r9,3328
> c0000000000830b0:	f9 2f 01 40 	std     r9,320(r15)
> c0000000000830b4:	48 00 07 8d 	bl      c000000000083840 <.xmon_printf>
> c0000000000830b8:	60 00 00 00 	nop
> c0000000000830bc:	e8 6f 01 00 	ld      r3,256(r15)
> c0000000000830c0:	3c 82 ff d8 	addis   r4,r2,-40
> c0000000000830c4:	3c a2 ff d5 	addis   r5,r2,-43
> c0000000000830c8:	38 84 a6 70 	addi    r4,r4,-22928
> c0000000000830cc:	38 a5 0e 68 	addi    r5,r5,3688
> c0000000000830d0:	4b ff 91 91 	bl      c00000000007c260 <.xmon_print_symbol>
> c0000000000830d4:	3d 22 ff f7 	addis   r9,r2,-9
> c0000000000830d8:	e8 6f 01 00 	ld      r3,256(r15)
> c0000000000830dc:	38 80 00 01 	li      r4,1
> c0000000000830e0:	38 c9 b4 68 	addi    r6,r9,-19352
> c0000000000830e4:	38 a0 00 00 	li      r5,0
> c0000000000830e8:	4b ff 94 79 	bl      c00000000007c560 <.generic_inst_dump>
> c0000000000830ec:	4b ff d9 24 	b       c000000000080a10 <.xmon_core+0x560>
> 
> 
> /*
>  941                                 printf("Couldn't single-step %s instruction\n",
>  942                                        (IS_RFID(instr)? "rfid": "mtmsrd"));
>  943                                 return 0;
> */
> c0000000000830f0:	3d 20 fc 00 	lis     r9,-1024
> c0000000000830f4:	81 41 01 60 	lwz     r10,352(r1)
> c0000000000830f8:	61 29 07 fe 	ori     r9,r9,2046
> c0000000000830fc:	7d 4a 48 38 	and     r10,r10,r9
> c000000000083100:	6d 49 4c 00 	xoris   r9,r10,19456
> c000000000083104:	2f 89 00 24 	cmpwi   cr7,r9,36
> c000000000083108:	41 9e 00 20 	beq-    cr7,c000000000083128 <.xmon_core+0x2c78>
> c00000000008310c:	3c 82 ff d4 	addis   r4,r2,-44
> c000000000083110:	38 84 8a 98 	addi    r4,r4,-30056
> c000000000083114:	3c 62 ff d4 	addis   r3,r2,-44
> c000000000083118:	38 63 91 f8 	addi    r3,r3,-28168
> c00000000008311c:	48 00 07 25 	bl      c000000000083840 <.xmon_printf>
> c000000000083120:	60 00 00 00 	nop
> c000000000083124:	4b ff d8 ec 	b       c000000000080a10 <.xmon_core+0x560>
> c000000000083128:	3c 82 ff d4 	addis   r4,r2,-44
> c00000000008312c:	38 84 8a 90 	addi    r4,r4,-30064
> c000000000083130:	4b ff ff e4 	b       c000000000083114 <.xmon_core+0x2c64>
> c000000000083134:	60 00 00 00 	nop
> c000000000083138:	60 00 00 00 	nop
> c00000000008313c:	60 00 00 00 	nop
> 
> 
> 
> On 07/26/2013 12:11 PM, Chen Gang wrote:
>> On 07/24/2013 08:38 AM, Chen Gang wrote:
>>> On 07/23/2013 09:58 PM, Michael Ellerman wrote:
>>>> On Mon, Jul 22, 2013 at 03:02:53PM +0800, Chen Gang wrote:
>>>>> Hello Maintainers:
>>>>>
>>>>> With allmodconfig and EXTRA_CFLAGS=-W", it reports warnings below:
>>>>
>>>>>
>>>>> arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>>>> arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>>>
>>>> In both these cases we are inside the body of a for loop and we do a
>>>> if (setjmp) / else block. Although looking at the source the value of i
>>>> is not modified by the setjmp, I guess it's possible that the compiler
>>>> might reorder the increment of i inside the setjmp and loose the value
>>>> when we longjmp.
>>>>
>>>
>>> I should continue to confirm the details based on your valuable
>>> information, thanks.
>>>
>>>
>>
>>
>> For stop_spus() and restart_spus(), at least now, the related warnings
>> are not issue: the variable 'i' is stored in stack "120(r1)".
>>
>> The related warning:
>>
>>   arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>   arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>
>> The related source code:
>>
>> 3024 static void stop_spus(void)
>> 3025 {
>> 3026         struct spu *spu;
>> 3027         int i;
>> 3028         u64 tmp;
>> 3029 
>> 3030         for (i = 0; i < XMON_NUM_SPUS; i++) { /* XMON_NUM_SPUS == 16 */
>> 3031                 if (!spu_info[i].spu)
>> 3032                         continue;
>> 3033 
>> 3034                 if (setjmp(bus_error_jmp) == 0) {
>> 3035                         catch_memory_errors = 1;
>> 3036                         sync();
>> 3037 
>> 3038                         spu = spu_info[i].spu;
>> 3039 
>> 3040                         spu_info[i].saved_spu_runcntl_RW =
>> 3041                                 in_be32(&spu->problem->spu_runcntl_RW);
>> 3042 
>> 3043                         tmp = spu_mfc_sr1_get(spu);
>> 3044                         spu_info[i].saved_mfc_sr1_RW = tmp;
>> 3045 
>> 3046                         tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
>> 3047                         spu_mfc_sr1_set(spu, tmp);
>> 3048 
>> 3049                         sync();
>> 3050                         __delay(200);
>> 3051 
>> 3052                         spu_info[i].stopped_ok = 1;
>> 3053 
>> 3054                         printf("Stopped spu %.2d (was %s)\n", i,
>> 3055                                         spu_info[i].saved_spu_runcntl_RW ?
>> 3056                                         "running" : "stopped");
>> 3057                 } else {
>> 3058                         catch_memory_errors = 0;
>> 3059                         printf("*** Error stopping spu %.2d\n", i);
>> 3060                 }
>> 3061                 catch_memory_errors = 0;
>> 3062         }
>> 3063 }
>> 3064 
>>
>>
>>
>> The related disassembly code:
>>
>>   "make ARCH=powerpc EXTRA_CFLAGS=-W"
>>   "powerpc64-linux-gnu-objdump -d vmlinux.o > vmlinux.S"
>>   "gcc version 4.7.1 20120606 (Red Hat 4.7.1-0.1.20120606) (GCC)"
>>   "GNU objdump version 2.23.51.0.3-1.fc16 20120918"
>>
>> c00000000007cfd0 <.stop_spus>:
>> /* { */
>> c00000000007cfd0:	7c 08 02 a6 	mflr    r0
>> c00000000007cfd4:	fb c1 ff f0 	std     r30,-16(r1)
>> c00000000007cfd8:	fb e1 ff f8 	std     r31,-8(r1)
>> c00000000007cfdc:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007cfe0:	39 29 3e 10 	addi    r9,r9,15888
>> c00000000007cfe4:	3d 02 ff d4 	addis   r8,r2,-44
>> c00000000007cfe8:	39 29 21 50 	addi    r9,r9,8528
>> c00000000007cfec:	3d 42 ff d4 	addis   r10,r2,-44
>> c00000000007cff0:	39 08 83 f8 	addi    r8,r8,-31752
>> c00000000007cff4:	39 4a 83 d8 	addi    r10,r10,-31784
>> c00000000007cff8:	f8 01 00 10 	std     r0,16(r1)
>> c00000000007cffc:	f8 21 ff 51 	stdu    r1,-176(r1)
>> c00000000007d000:	f9 21 00 70 	std     r9,112(r1)
>> c00000000007d004:	39 20 00 00 	li      r9,0
>> c00000000007d008:	f9 21 00 78 	std     r9,120(r1)	; i = 0;
>> c00000000007d00c:	f9 01 00 88 	std     r8,136(r1)
>> c00000000007d010:	f9 41 00 90 	std     r10,144(r1)
>> c00000000007d014:	48 00 01 28 	b       c00000000007d13c <.stop_spus+0x16c>
>> c00000000007d018:	60 00 00 00 	nop
>> c00000000007d01c:	60 00 00 00 	nop
>>
>>
>> /*	 	if (setjmp(bus_error_jmp) == 0) { */
>> c00000000007d020:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007d024:	39 40 00 01 	li      r10,1
>> c00000000007d028:	39 29 3e 10 	addi    r9,r9,15888
>> c00000000007d02c:	91 49 20 c0 	stw     r10,8384(r9)
>> c00000000007d030:	7c 00 04 ac 	sync    
>> c00000000007d034:	4c 00 01 2c 	isync
>> c00000000007d038:	e9 01 00 80 	ld      r8,128(r1)
>> c00000000007d03c:	eb e8 00 00 	ld      r31,0(r8)
>> c00000000007d040:	e9 3f 00 20 	ld      r9,32(r31)
>> c00000000007d044:	7c 00 04 ac 	sync    
>> c00000000007d048:	81 29 40 1c 	lwz     r9,16412(r9)
>> c00000000007d04c:	0c 09 00 00 	twi     0,r9,0
>> c00000000007d050:	4c 00 01 2c 	isync
>> c00000000007d054:	91 28 00 10 	stw     r9,16(r8)
>> c00000000007d058:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007d05c:	3b c9 f5 e8 	addi    r30,r9,-2584
>> c00000000007d060:	7f e3 fb 78 	mr      r3,r31
>> c00000000007d064:	e9 3e 00 00 	ld      r9,0(r30)
>> c00000000007d068:	e9 29 00 60 	ld      r9,96(r9)
>> c00000000007d06c:	e9 49 00 00 	ld      r10,0(r9)
>> c00000000007d070:	f8 41 00 28 	std     r2,40(r1)
>> c00000000007d074:	7d 49 03 a6 	mtctr   r10
>> c00000000007d078:	e8 49 00 08 	ld      r2,8(r9)
>> c00000000007d07c:	4e 80 04 21 	bctrl
>> c00000000007d080:	e8 41 00 28 	ld      r2,40(r1)
>> c00000000007d084:	e9 01 00 80 	ld      r8,128(r1)
>> c00000000007d088:	e9 3e 00 00 	ld      r9,0(r30)
>> c00000000007d08c:	f8 68 00 08 	std     r3,8(r8)
>> c00000000007d090:	7c 64 1b 78 	mr      r4,r3
>> c00000000007d094:	78 84 d0 42 	rldicl  r4,r4,58,1
>> c00000000007d098:	7f e3 fb 78 	mr      r3,r31
>> c00000000007d09c:	78 84 30 00 	rotldi  r4,r4,6
>> c00000000007d0a0:	e9 29 00 58 	ld      r9,88(r9)
>> c00000000007d0a4:	e9 49 00 00 	ld      r10,0(r9)
>> c00000000007d0a8:	f8 41 00 28 	std     r2,40(r1)
>> c00000000007d0ac:	7d 49 03 a6 	mtctr   r10
>> c00000000007d0b0:	e8 49 00 08 	ld      r2,8(r9)
>> c00000000007d0b4:	4e 80 04 21 	bctrl
>> c00000000007d0b8:	e8 41 00 28 	ld      r2,40(r1)
>> c00000000007d0bc:	7c 00 04 ac 	sync    
>> c00000000007d0c0:	4c 00 01 2c 	isync
>> c00000000007d0c4:	38 60 00 c8 	li      r3,200
>> c00000000007d0c8:	4b fa 01 e9 	bl      c00000000001d2b0 <.__delay>	; __delay(200)
>> c00000000007d0cc:	60 00 00 00 	nop
>> c00000000007d0d0:	e9 01 00 80 	ld      r8,128(r1)
>> c00000000007d0d4:	39 40 00 01 	li      r10,1
>> c00000000007d0d8:	81 28 00 10 	lwz     r9,16(r8)
>> c00000000007d0dc:	99 48 00 20 	stb     r10,32(r8)
>> c00000000007d0e0:	3d 02 ff d4 	addis   r8,r2,-44
>> c00000000007d0e4:	38 a8 83 c8 	addi    r5,r8,-31800
>> c00000000007d0e8:	2f 89 00 00 	cmpwi   cr7,r9,0
>> c00000000007d0ec:	40 9e 00 0c 	bne-    cr7,c00000000007d0f8 <.stop_spus+0x128>
>> c00000000007d0f0:	3d 22 ff d4 	addis   r9,r2,-44
>> c00000000007d0f4:	38 a9 83 d0 	addi    r5,r9,-31792
>> c00000000007d0f8:	e8 61 00 90 	ld      r3,144(r1)
>> c00000000007d0fc:	e8 81 00 78 	ld      r4,120(r1)		; 120(r1) = i
>> c00000000007d100:	48 00 67 41 	bl      c000000000083840 <.xmon_printf>
>> c00000000007d104:	60 00 00 00 	nop
>>
>>
>> /* 		catch_memory_errors = 0; */
>> c00000000007d108:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007d10c:	39 40 00 00 	li      r10,0
>> c00000000007d110:	39 29 3e 10 	addi    r9,r9,15888
>> c00000000007d114:	91 49 20 c0 	stw     r10,8384(r9)
>>
>>
>> /* 	for (i = 0; i < XMON_NUM_SPUS; i++) { */
>> c00000000007d118:	e9 01 00 78 	ld      r8,120(r1)		; 120(r1) = i;
>> c00000000007d11c:	39 28 00 01 	addi    r9,r8,1			; i++
>> c00000000007d120:	2f 89 00 10 	cmpwi   cr7,r9,16		; i < XMON_NUM_SPUS
>> c00000000007d124:	7d 29 07 b4 	extsw   r9,r9
>> c00000000007d128:	f9 21 00 78 	std     r9,120(r1)		; 120(r1) = i;
>> c00000000007d12c:	e9 21 00 70 	ld      r9,112(r1)		;
>> c00000000007d130:	39 29 00 28 	addi    r9,r9,40		; 112(r1) =  [i] for spu_info;
>> c00000000007d134:	f9 21 00 70 	std     r9,112(r1)		;
>> c00000000007d138:	41 9e 00 58 	beq-    cr7,c00000000007d190 <.stop_spus+0x1c0>
>>
>> /* 		if (!spu_info[i].spu) */
>> /*			continue; */
>> c00000000007d13c:	e9 01 00 70 	ld      r8,112(r1)
>> c00000000007d140:	3d 42 00 0f 	addis   r10,r2,15
>> c00000000007d144:	38 6a 5e 18 	addi    r3,r10,24088
>> c00000000007d148:	e9 28 00 00 	ld      r9,0(r8)
>> c00000000007d14c:	f9 01 00 80 	std     r8,128(r1)
>> c00000000007d150:	2f a9 00 00 	cmpdi   cr7,r9,0				
>> c00000000007d154:	41 9e ff c4 	beq+    cr7,c00000000007d118 <.stop_spus+0x148>
>>
>> /* 		if (setjmp(bus_error_jmp) == 0) { */
>> c00000000007d158:	4b fa 44 99 	bl      c0000000000215f0 <.setjmp>
>> c00000000007d15c:	60 00 00 00 	nop
>> c00000000007d160:	2f a3 00 00 	cmpdi   cr7,r3,0
>> c00000000007d164:	e8 81 00 78 	ld      r4,120(r1)	; 120(r1) = i for 2nd param of printf in exception processing after setjmp.
>> c00000000007d168:	e8 61 00 88 	ld      r3,136(r1)
>> c00000000007d16c:	41 9e fe b4 	beq+    cr7,c00000000007d020 <.stop_spus+0x50>
>>
>> /* 		} else { */
>> c00000000007d170:	3d 42 00 0f 	addis   r10,r2,15
>> c00000000007d174:	39 00 00 00 	li      r8,0
>> c00000000007d178:	39 4a 3e 10 	addi    r10,r10,15888
>> c00000000007d17c:	91 0a 20 c0 	stw     r8,8384(r10)				/* catch_memory_errors = 0; */
>> c00000000007d180:	48 00 66 c1 	bl      c000000000083840 <.xmon_printf>		/* called with correct i */
>> c00000000007d184:	60 00 00 00 	nop
>> c00000000007d188:	4b ff ff 80 	b       c00000000007d108 <.stop_spus+0x138>
>> c00000000007d18c:	60 00 00 00 	nop
>> /*	 } */
>>
>> c00000000007d190:	38 21 00 b0 	addi    r1,r1,176
>> c00000000007d194:	e8 01 00 10 	ld      r0,16(r1)
>> c00000000007d198:	eb c1 ff f0 	ld      r30,-16(r1)
>> c00000000007d19c:	eb e1 ff f8 	ld      r31,-8(r1)
>> c00000000007d1a0:	7c 08 03 a6 	mtlr    r0
>> c00000000007d1a4:	4e 80 00 20 	blr
>> c00000000007d1a8:	60 00 00 00 	nop
>> c00000000007d1ac:	60 00 00 00 	nop
>> /* } */
>>
>>
>> The related assembly code (they really save and restore 'r1'):
>>
>> _GLOBAL(setjmp)
>>         mflr    r0
>>         PPC_STL r0,0(r3)
>>         PPC_STL r1,SZL(r3)
>>         PPC_STL r2,2*SZL(r3)
>>         mfcr    r0
>>         PPC_STL r0,3*SZL(r3)
>>         PPC_STL r13,4*SZL(r3)
>>         PPC_STL r14,5*SZL(r3)
>>         PPC_STL r15,6*SZL(r3)
>>         PPC_STL r16,7*SZL(r3)
>>         PPC_STL r17,8*SZL(r3)
>>         PPC_STL r18,9*SZL(r3)
>>         PPC_STL r19,10*SZL(r3)
>>         PPC_STL r20,11*SZL(r3)
>>         PPC_STL r21,12*SZL(r3)
>>         PPC_STL r22,13*SZL(r3)
>>         PPC_STL r23,14*SZL(r3)
>>         PPC_STL r24,15*SZL(r3)
>>         PPC_STL r25,16*SZL(r3)
>>         PPC_STL r26,17*SZL(r3)
>>         PPC_STL r27,18*SZL(r3)
>>         PPC_STL r28,19*SZL(r3)
>>         PPC_STL r29,20*SZL(r3)
>>         PPC_STL r30,21*SZL(r3)
>>         PPC_STL r31,22*SZL(r3)
>>         li      r3,0
>>         blr
>>
>> _GLOBAL(longjmp)
>>         PPC_LCMPI r4,0
>>         bne     1f
>>         li      r4,1
>> 1:      PPC_LL  r13,4*SZL(r3)
>>         PPC_LL  r14,5*SZL(r3)
>>         PPC_LL  r15,6*SZL(r3)
>>         PPC_LL  r16,7*SZL(r3)
>>         PPC_LL  r17,8*SZL(r3)
>>         PPC_LL  r18,9*SZL(r3)
>>         PPC_LL  r19,10*SZL(r3)
>>         PPC_LL  r20,11*SZL(r3)
>>         PPC_LL  r21,12*SZL(r3)
>>         PPC_LL  r22,13*SZL(r3)
>>         PPC_LL  r23,14*SZL(r3)
>>         PPC_LL  r24,15*SZL(r3)
>>         PPC_LL  r25,16*SZL(r3)
>>         PPC_LL  r26,17*SZL(r3)
>>         PPC_LL  r27,18*SZL(r3)
>>         PPC_LL  r28,19*SZL(r3)
>>         PPC_LL  r29,20*SZL(r3)
>>         PPC_LL  r30,21*SZL(r3)
>>         PPC_LL  r31,22*SZL(r3)
>>         PPC_LL  r0,3*SZL(r3)
>>         mtcrf   0x38,r0
>>         PPC_LL  r0,0(r3)
>>         PPC_LL  r1,SZL(r3)
>>         PPC_LL  r2,2*SZL(r3)
>>         mtlr    r0
>>         mr      r3,r4
>>         blr
>>
>>
>>
>>
>> The same to resetart_spus()
>>
>>
>> 3065 static void restart_spus(void)
>> 3066 {
>> 3067         struct spu *spu;
>> 3068         int i;
>> 3069 
>> 3070         for (i = 0; i < XMON_NUM_SPUS; i++) {
>> 3071                 if (!spu_info[i].spu)
>> 3072                         continue;
>> 3073 
>> 3074                 if (!spu_info[i].stopped_ok) {
>> 3075                         printf("*** Error, spu %d was not successfully stopped"
>> 3076                                         ", not restarting\n", i);
>> 3077                         continue;
>> 3078                 }
>> 3079 
>> 3080                 if (setjmp(bus_error_jmp) == 0) {
>> 3081                         catch_memory_errors = 1;
>> 3082                         sync();
>> 3083 
>> 3084                         spu = spu_info[i].spu;
>> 3085                         spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
>> 3086                         out_be32(&spu->problem->spu_runcntl_RW,
>> 3087                                         spu_info[i].saved_spu_runcntl_RW);
>> 3088 
>> 3089                         sync();
>> 3090                         __delay(200);
>> 3091 
>> 3092                         printf("Restarted spu %.2d\n", i);
>> 3093                 } else {
>> 3094                         catch_memory_errors = 0;
>> 3095                         printf("*** Error restarting spu %.2d\n", i);
>> 3096                 }
>> 3097                 catch_memory_errors = 0;
>> 3098         }
>> 3099 }
>> 3100 
>>
>> c00000000007d1b0 <.restart_spus>:
>> /* { */
>> c00000000007d1b0:	7c 08 02 a6 	mflr    r0
>> c00000000007d1b4:	fb e1 ff f8 	std     r31,-8(r1)
>> c00000000007d1b8:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007d1bc:	3c e2 ff d4 	addis   r7,r2,-44
>> c00000000007d1c0:	39 29 3e 10 	addi    r9,r9,15888
>> c00000000007d1c4:	3d 02 ff d4 	addis   r8,r2,-44
>> c00000000007d1c8:	39 29 21 50 	addi    r9,r9,8528
>> c00000000007d1cc:	3d 42 ff d4 	addis   r10,r2,-44
>> c00000000007d1d0:	38 e7 84 70 	addi    r7,r7,-31632
>> c00000000007d1d4:	39 08 84 58 	addi    r8,r8,-31656
>> c00000000007d1d8:	f8 01 00 10 	std     r0,16(r1)
>> c00000000007d1dc:	39 4a 84 18 	addi    r10,r10,-31720
>> c00000000007d1e0:	f8 21 ff 51 	stdu    r1,-176(r1)
>> c00000000007d1e4:	f9 21 00 70 	std     r9,112(r1)
>> c00000000007d1e8:	39 20 00 00 	li      r9,0
>> c00000000007d1ec:	f9 21 00 78 	std     r9,120(r1)		; i = 0;
>> c00000000007d1f0:	f8 e1 00 88 	std     r7,136(r1)
>> c00000000007d1f4:	f9 01 00 98 	std     r8,152(r1)
>> c00000000007d1f8:	f9 41 00 90 	std     r10,144(r1)
>> c00000000007d1fc:	48 00 00 34 	b       c00000000007d230 <.restart_spus+0x80>
>>
>> /*		if (!spu_info[i].stopped_ok) { */
>> /*			printf(....); */
>> /*			continue; */
>> c00000000007d200:	e8 61 00 90 	ld      r3,144(r1)
>> c00000000007d204:	48 00 66 3d 	bl      c000000000083840 <.xmon_printf>
>> c00000000007d208:	60 00 00 00 	nop
>>
>> /*	for (i = 0; i < XMON_NUM_SPUS; i++) { */
>> c00000000007d20c:	e9 01 00 78 	ld      r8,120(r1)
>> c00000000007d210:	39 28 00 01 	addi    r9,r8,1		; i++
>> c00000000007d214:	2f 89 00 10 	cmpwi   cr7,r9,16	; i < XMON_NUM_SPUS
>> c00000000007d218:	7d 29 07 b4 	extsw   r9,r9
>> c00000000007d21c:	f9 21 00 78 	std     r9,120(r1)
>> c00000000007d220:	e9 21 00 70 	ld      r9,112(r1)
>> c00000000007d224:	39 29 00 28 	addi    r9,r9,40
>> c00000000007d228:	f9 21 00 70 	std     r9,112(r1)
>> c00000000007d22c:	41 9e 01 0c 	beq-    cr7,c00000000007d338 <.restart_spus+0x188>
>>
>> /*		if (!spu_info[i].spu) */
>> /*			continue; */
>> c00000000007d230:	e9 01 00 70 	ld      r8,112(r1)
>> c00000000007d234:	3d 42 00 0f 	addis   r10,r2,15
>> c00000000007d238:	e8 81 00 78 	ld      r4,120(r1) 	; i as 2nd parameter for xmon_printf().
>> c00000000007d23c:	38 6a 5e 18 	addi    r3,r10,24088
>> c00000000007d240:	e9 28 00 00 	ld      r9,0(r8)
>> c00000000007d244:	f9 01 00 80 	std     r8,128(r1)
>> c00000000007d248:	2f a9 00 00 	cmpdi   cr7,r9,0
>> c00000000007d24c:	41 9e ff c0 	beq+    cr7,c00000000007d20c <.restart_spus+0x5c>
>>
>> /*		if (!spu_info[i].stopped_ok) { */
>> c00000000007d250:	89 28 00 20 	lbz     r9,32(r8)
>> c00000000007d254:	2f 89 00 00 	cmpwi   cr7,r9,0
>> c00000000007d258:	41 9e ff a8 	beq+    cr7,c00000000007d200 <.restart_spus+0x50>
>> /*		} */
>>
>> /*		if (setjmp(bus_error_jmp) == 0) { */
>> c00000000007d25c:	4b fa 43 95 	bl      c0000000000215f0 <.setjmp>
>> c00000000007d260:	60 00 00 00 	nop
>> c00000000007d264:	2f a3 00 00 	cmpdi   cr7,r3,0
>> c00000000007d268:	e8 81 00 78 	ld      r4,120(r1)	; i as 2nd parameter for xmon_printf() after setjmp().
>> c00000000007d26c:	e8 61 00 88 	ld      r3,136(r1)
>> c00000000007d270:	40 9e 00 e0 	bne-    cr7,c00000000007d350 <.restart_spus+0x1a0>
>>
>> c00000000007d274:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007d278:	39 40 00 01 	li      r10,1
>> c00000000007d27c:	39 29 3e 10 	addi    r9,r9,15888
>> c00000000007d280:	91 49 20 c0 	stw     r10,8384(r9)
>> c00000000007d284:	7c 00 04 ac 	sync    
>> c00000000007d288:	4c 00 01 2c 	isync
>> c00000000007d28c:	3d 02 00 0f 	addis   r8,r2,15
>> c00000000007d290:	e9 41 00 80 	ld      r10,128(r1)
>> c00000000007d294:	39 28 f5 e8 	addi    r9,r8,-2584
>> c00000000007d298:	eb ea 00 00 	ld      r31,0(r10)
>> c00000000007d29c:	e8 8a 00 08 	ld      r4,8(r10)
>> c00000000007d2a0:	e9 29 00 00 	ld      r9,0(r9)
>> c00000000007d2a4:	7f e3 fb 78 	mr      r3,r31
>> c00000000007d2a8:	e9 29 00 58 	ld      r9,88(r9)
>> c00000000007d2ac:	e9 49 00 00 	ld      r10,0(r9)
>> c00000000007d2b0:	f8 41 00 28 	std     r2,40(r1)
>> c00000000007d2b4:	7d 49 03 a6 	mtctr   r10
>> c00000000007d2b8:	e8 49 00 08 	ld      r2,8(r9)
>> c00000000007d2bc:	4e 80 04 21 	bctrl
>> c00000000007d2c0:	e8 41 00 28 	ld      r2,40(r1)
>> c00000000007d2c4:	e9 01 00 80 	ld      r8,128(r1)
>> c00000000007d2c8:	e9 3f 00 20 	ld      r9,32(r31)
>> c00000000007d2cc:	81 48 00 10 	lwz     r10,16(r8)
>> c00000000007d2d0:	7c 00 04 ac 	sync    
>> c00000000007d2d4:	91 49 40 1c 	stw     r10,16412(r9)
>> c00000000007d2d8:	39 20 00 01 	li      r9,1
>> c00000000007d2dc:	99 2d 02 74 	stb     r9,628(r13)
>> c00000000007d2e0:	7c 00 04 ac 	sync    
>> c00000000007d2e4:	4c 00 01 2c 	isync
>> c00000000007d2e8:	38 60 00 c8 	li      r3,200
>> c00000000007d2ec:	4b f9 ff c5 	bl      c00000000001d2b0 <.__delay>
>> c00000000007d2f0:	60 00 00 00 	nop
>> c00000000007d2f4:	e8 61 00 98 	ld      r3,152(r1)
>> c00000000007d2f8:	e8 81 00 78 	ld      r4,120(r1)
>> c00000000007d2fc:	48 00 65 45 	bl      c000000000083840 <.xmon_printf>
>> c00000000007d300:	60 00 00 00 	nop
>> /*		} */
>>
>> /*	for (i = 0; i < XMON_NUM_SPUS; i++) { */
>> c00000000007d304:	e9 01 00 78 	ld      r8,120(r1)
>> c00000000007d308:	3d 22 00 0f 	addis   r9,r2,15
>> c00000000007d30c:	39 40 00 00 	li      r10,0
>> c00000000007d310:	39 29 3e 10 	addi    r9,r9,15888
>> c00000000007d314:	91 49 20 c0 	stw     r10,8384(r9)		; catch_memory_errors = 0;
>> c00000000007d318:	39 28 00 01 	addi    r9,r8,1
>> c00000000007d31c:	2f 89 00 10 	cmpwi   cr7,r9,16		; i < XMON_NUM_SPUS
>> c00000000007d320:	7d 29 07 b4 	extsw   r9,r9
>> c00000000007d324:	f9 21 00 78 	std     r9,120(r1)		; i++;
>> c00000000007d328:	e9 21 00 70 	ld      r9,112(r1)
>> c00000000007d32c:	39 29 00 28 	addi    r9,r9,40		; [i] for spu_info
>> c00000000007d330:	f9 21 00 70 	std     r9,112(r1)
>> c00000000007d334:	40 9e fe fc 	bne+    cr7,c00000000007d230 <.restart_spus+0x80>
>>
>> /* 	} */
>> c00000000007d338:	38 21 00 b0 	addi    r1,r1,176
>> c00000000007d33c:	e8 01 00 10 	ld      r0,16(r1)
>> c00000000007d340:	eb e1 ff f8 	ld      r31,-8(r1)
>> c00000000007d344:	7c 08 03 a6 	mtlr    r0
>> c00000000007d348:	4e 80 00 20 	blr
>> c00000000007d34c:	60 00 00 00 	nop
>> /* } */
>>
>> /*		} else { */
>> c00000000007d350:	3d 42 00 0f 	addis   r10,r2,15
>> c00000000007d354:	39 00 00 00 	li      r8,0
>> c00000000007d358:	39 4a 3e 10 	addi    r10,r10,15888
>> c00000000007d35c:	91 0a 20 c0 	stw     r8,8384(r10)		; catch_memory_errors = 0;
>> c00000000007d360:	48 00 64 e1 	bl      c000000000083840 <.xmon_printf>
>> c00000000007d364:	60 00 00 00 	nop
>> c00000000007d368:	4b ff ff 9c 	b       c00000000007d304 <.restart_spus+0x154>
>> c00000000007d36c:	60 00 00 00 	nop
>>
>>
>>
>>>>> arch/powerpc/xmon/xmon.c:352:48: warning: argument ‘fromipi’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>>>
>>>> This one I can't see, but I assume it's a similar case.
>>>>
>>>
>>> OK, I should continue for it.
>>>
>>>
>>>>> Excuse me, I am not quite sure about it whether can cause issue or not.
>>>>
>>>> I've never seen it get stuck in those loops or anything, but I guess
>>>> it's possible.
>>>>
>>>
>>> OK, I should make the confirmation.
>>>
>>>> The first thing to do would be to analyse the generated assembler code
>>>> to determine if there really is any possiblity of the value being
>>>> clobbered, or if it's just a theoretical bug.
>>>>
>>>
>>> Thank you for your valuable information again.
>>>
>>> Excuse me, I have to do another things within this month, so I should
>>> provide the confirmation within next month (2013-08-31), is it OK (no
>>> reply means OK).
>>>
>>> Welcome any suggestions or completions.
>>>
>>>
>>> Thanks.
>>>
>>
>>
> 
> 


-- 
Chen Gang
