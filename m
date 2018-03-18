Return-Path: <fengguang.wu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 403g5D61PyzDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 11:27:37 +1100 (AEDT)
Date: Sun, 18 Mar 2018 08:27:00 +0800
From: kbuild test robot <lkp@intel.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: kbuild-all@01.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mathieu Malaterre <malat@debian.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/19] xmon: Use __printf markup to silence compiler
Message-ID: <201803180834.z1vl3Wv7%fengguang.wu@intel.com>
References: <20180316110224.12260-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <20180316110224.12260-2-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mathieu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[also build test ERROR on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mathieu-Malaterre/Start-using-__printf-attribute-single-commit-series/20180318-035038
config: powerpc-currituck_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/xmon/xmon.c: In function 'xmon_core':
>> arch/powerpc/xmon/xmon.c:523:47: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'int' [-Werror=format=]
       printf("cpu 0x%x stopped at breakpoint 0x%lx (",
                                                ~~^
                                                %x
   arch/powerpc/xmon/xmon.c: In function 'cpu_cmd':
   arch/powerpc/xmon/xmon.c:1168:18: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
      printf("cpu 0x%x isn't in xmon\n", cpu);
                    ~^
                    %lx
   arch/powerpc/xmon/xmon.c:1182:19: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
       printf("cpu 0x%x didn't take control\n", cpu);
                     ~^
                     %lx
   arch/powerpc/xmon/xmon.c: In function 'bpt_cmds':
   arch/powerpc/xmon/xmon.c:1365:32: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Werror=format=]
      printf("Cleared breakpoint %lx (", BP_NUM(bp));
                                 ~~^
                                 %x
   arch/powerpc/xmon/xmon.c: In function 'excprint':
   arch/powerpc/xmon/xmon.c:1607:31: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'struct pt_regs *' [-Werror=format=]
     printf("Vector: %lx %s at [%lx]\n", fp->trap, getvecname(trap), fp);
                                ~~^
   arch/powerpc/xmon/xmon.c:1611:9: error: too many arguments for format [-Werror=format-extra-args]
     printf("    lr: ", fp->link);
            ^~~~~~~~~~
   arch/powerpc/xmon/xmon.c:1623:26: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'struct task_struct *' [-Werror=format=]
     printf("  current = 0x%lx\n", current);
                           ~~^
   arch/powerpc/xmon/xmon.c:1629:25: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'pid_t {aka int}' [-Werror=format=]
      printf("    pid   = %ld, comm = %s\n",
                          ~~^
                          %d
             current->pid, current->comm);
             ~~~~~~~~~~~~    
   arch/powerpc/xmon/xmon.c: In function 'prregs':
   arch/powerpc/xmon/xmon.c:1674:22: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Werror=format=]
      printf("R%.2d = %.8x%s", n, fp->gpr[n],
                      ~~~^        ~~~~~~~~~~
                      %.8lx
   arch/powerpc/xmon/xmon.c: In function 'dump_by_size':
   arch/powerpc/xmon/xmon.c:2567:16: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
       printf("%0*lx", size * 2, val);
               ~~~~^
               %0*llx
   arch/powerpc/xmon/xmon.c: In function 'generic_inst_dump':
   arch/powerpc/xmon/xmon.c:197:14: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Werror=format=]
    #define REG  "%.8lx"
                 ^
   arch/powerpc/xmon/xmon.c:2731:11: note: in expansion of macro 'REG'
       printf(REG"  %.8x", adr, inst);
              ^~~
   arch/powerpc/xmon/xmon.c:2731:20: note: format string is defined here
       printf(REG"  %.8x", adr, inst);
                    ~~~^
                    %.8lx
   arch/powerpc/xmon/xmon.c: In function 'memdiffs':
   arch/powerpc/xmon/xmon.c:2863:17: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'unsigned char *' [-Werror=format=]
        printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
                ~~~~^                       ~~~~~~
                %.16hhn
   arch/powerpc/xmon/xmon.c:2863:30: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'unsigned char *' [-Werror=format=]
        printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
                             ~~~~^
                             %.16hhn
         p1[-1], p2 - 1, p2[-1]);
                 ~~~~~~           
   arch/powerpc/xmon/xmon.c: In function 'memzcan':
   arch/powerpc/xmon/xmon.c:2923:15: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
       printf("%.8x\n", a - mskip);
               ~~~^     ~~~~~~~~~
               %.8lx
   arch/powerpc/xmon/xmon.c:2929:14: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
      printf("%.8x\n", a - mskip);
              ~~~^     ~~~~~~~~~
              %.8lx
   arch/powerpc/xmon/xmon.c: In function 'dump_tlb_44x':
   arch/powerpc/xmon/xmon.c:3445:21: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Werror=format=]
      printf("[%02x] %08x %08x %08x ", i, w0, w1, w2);
                     ~~~^
                     %08lx
   arch/powerpc/xmon/xmon.c:3445:26: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=format=]
      printf("[%02x] %08x %08x %08x ", i, w0, w1, w2);
                          ~~~^
                          %08lx
   arch/powerpc/xmon/xmon.c:3445:31: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Werror=format=]
      printf("[%02x] %08x %08x %08x ", i, w0, w1, w2);
                               ~~~^
                               %08lx
   arch/powerpc/xmon/xmon.c:3447:17: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
       printf("V %08x -> %01x%08x %c%c%c%c%c",
                 ~~~^
                 %08lx
   arch/powerpc/xmon/xmon.c:3447:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Werror=format=]
       printf("V %08x -> %01x%08x %c%c%c%c%c",
                         ~~~^
                         %01lx
   arch/powerpc/xmon/xmon.c:3447:29: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=format=]
       printf("V %08x -> %01x%08x %c%c%c%c%c",
                             ~~~^
                             %08lx
   cc1: all warnings being treated as errors

vim +523 arch/powerpc/xmon/xmon.c

^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  466  
f13659e0 arch/powerpc/xmon/xmon.c Anton Blanchard  2007-03-21  467  	local_irq_save(flags);
a71d64b4 arch/powerpc/xmon/xmon.c Anton Blanchard  2014-08-05  468  	hard_irq_disable();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  469  
ed49f7fd arch/powerpc/xmon/xmon.c Breno Leitao     2017-08-02  470  	tracing_enabled = tracing_is_on();
ed49f7fd arch/powerpc/xmon/xmon.c Breno Leitao     2017-08-02  471  	tracing_off();
ed49f7fd arch/powerpc/xmon/xmon.c Breno Leitao     2017-08-02  472  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  473  	bp = in_breakpoint_table(regs->nip, &offset);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  474  	if (bp != NULL) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  475  		regs->nip = bp->address + offset;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  476  		atomic_dec(&bp->ref_count);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  477  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  478  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  479  	remove_cpu_bpts();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  480  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  481  #ifdef CONFIG_SMP
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  482  	cpu = smp_processor_id();
104699c0 arch/powerpc/xmon/xmon.c KOSAKI Motohiro  2011-04-28  483  	if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
31cdd0c3 arch/powerpc/xmon/xmon.c Paul Mackerras   2016-04-13  484  		/*
31cdd0c3 arch/powerpc/xmon/xmon.c Paul Mackerras   2016-04-13  485  		 * We catch SPR read/write faults here because the 0x700, 0xf60
31cdd0c3 arch/powerpc/xmon/xmon.c Paul Mackerras   2016-04-13  486  		 * etc. handlers don't call debugger_fault_handler().
31cdd0c3 arch/powerpc/xmon/xmon.c Paul Mackerras   2016-04-13  487  		 */
31cdd0c3 arch/powerpc/xmon/xmon.c Paul Mackerras   2016-04-13  488  		if (catch_spr_faults)
31cdd0c3 arch/powerpc/xmon/xmon.c Paul Mackerras   2016-04-13  489  			longjmp(bus_error_jmp, 1);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  490  		get_output_lock();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  491  		excprint(regs);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  492  		printf("cpu 0x%x: Exception %lx %s in xmon, "
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  493  		       "returning to main loop\n",
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  494  		       cpu, regs->trap, getvecname(TRAP(regs)));
5cb4cc0d arch/ppc64/xmon/xmon.c   Haren Myneni     2005-08-03  495  		release_output_lock();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  496  		longjmp(xmon_fault_jmp[cpu], 1);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  497  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  498  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  499  	if (setjmp(recurse_jmp) != 0) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  500  		if (!in_xmon || !xmon_gate) {
5cb4cc0d arch/ppc64/xmon/xmon.c   Haren Myneni     2005-08-03  501  			get_output_lock();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  502  			printf("xmon: WARNING: bad recursive fault "
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  503  			       "on cpu 0x%x\n", cpu);
5cb4cc0d arch/ppc64/xmon/xmon.c   Haren Myneni     2005-08-03  504  			release_output_lock();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  505  			goto waiting;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  506  		}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  507  		secondary = !(xmon_taken && cpu == xmon_owner);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  508  		goto cmdloop;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  509  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  510  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  511  	xmon_fault_jmp[cpu] = recurse_jmp;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  512  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  513  	bp = NULL;
9f0b0793 arch/powerpc/xmon/xmon.c Michael Ellerman 2011-04-07  514  	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  515  		bp = at_breakpoint(regs->nip);
daf8f403 arch/powerpc/xmon/xmon.c Josh Boyer       2009-09-23  516  	if (bp || unrecoverable_excp(regs))
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  517  		fromipi = 0;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  518  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  519  	if (!fromipi) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  520  		get_output_lock();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  521  		excprint(regs);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  522  		if (bp) {
736256e4 arch/powerpc/xmon/xmon.c Michael Ellerman 2014-05-26 @523  			printf("cpu 0x%x stopped at breakpoint 0x%lx (",
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  524  			       cpu, BP_NUM(bp));
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  525  			xmon_print_symbol(regs->nip, " ", ")\n");
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  526  		}
daf8f403 arch/powerpc/xmon/xmon.c Josh Boyer       2009-09-23  527  		if (unrecoverable_excp(regs))
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  528  			printf("WARNING: exception is not recoverable, "
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  529  			       "can't continue\n");
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  530  		release_output_lock();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  531  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  532  
d2b496e5 arch/powerpc/xmon/xmon.c Michael Ellerman 2013-12-23  533  	cpumask_set_cpu(cpu, &cpus_in_xmon);
d2b496e5 arch/powerpc/xmon/xmon.c Michael Ellerman 2013-12-23  534  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  535   waiting:
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  536  	secondary = 1;
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  537  	spin_begin();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  538  	while (secondary && !xmon_gate) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  539  		if (in_xmon == 0) {
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  540  			if (fromipi) {
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  541  				spin_end();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  542  				goto leave;
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  543  			}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  544  			secondary = test_and_set_bit(0, &in_xmon);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  545  		}
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  546  		spin_cpu_relax();
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  547  		touch_nmi_watchdog();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  548  	}
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  549  	spin_end();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  550  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  551  	if (!secondary && !xmon_gate) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  552  		/* we are the first cpu to come in */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  553  		/* interrupt other cpu(s) */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  554  		int ncpus = num_online_cpus();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  555  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  556  		xmon_owner = cpu;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  557  		mb();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  558  		if (ncpus > 1) {
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  559  			/*
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  560  			 * A system reset (trap == 0x100) can be triggered on
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  561  			 * all CPUs, so when we come in via 0x100 try waiting
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  562  			 * for the other CPUs to come in before we send the
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  563  			 * debugger break (IPI). This is similar to
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  564  			 * crash_kexec_secondary().
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  565  			 */
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  566  			if (TRAP(regs) != 0x100 || !wait_for_other_cpus(ncpus))
e0476371 arch/powerpc/xmon/xmon.c Milton Miller    2011-05-10  567  				smp_send_debugger_break();
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  568  
1cd6ed7c arch/powerpc/xmon/xmon.c Nicholas Piggin  2016-12-20  569  			wait_for_other_cpus(ncpus);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  570  		}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  571  		remove_bpts();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  572  		disable_surveillance();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  573  		/* for breakpoint or single step, print the current instr. */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  574  		if (bp || TRAP(regs) == 0xd00)
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  575  			ppc_inst_dump(regs->nip, 1, 0);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  576  		printf("enter ? for help\n");
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  577  		mb();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  578  		xmon_gate = 1;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  579  		barrier();
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  580  		touch_nmi_watchdog();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  581  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  582  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  583   cmdloop:
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  584  	while (in_xmon) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  585  		if (secondary) {
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  586  			spin_begin();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  587  			if (cpu == xmon_owner) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  588  				if (!test_and_set_bit(0, &xmon_taken)) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  589  					secondary = 0;
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  590  					spin_end();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  591  					continue;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  592  				}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  593  				/* missed it */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  594  				while (cpu == xmon_owner)
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  595  					spin_cpu_relax();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  596  			}
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  597  			spin_cpu_relax();
064996d6 arch/powerpc/xmon/xmon.c Nicholas Piggin  2017-09-29  598  			touch_nmi_watchdog();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  599  		} else {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  600  			cmd = cmds(regs);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  601  			if (cmd != 0) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  602  				/* exiting xmon */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  603  				insert_bpts();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  604  				xmon_gate = 0;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  605  				wmb();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  606  				in_xmon = 0;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  607  				break;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  608  			}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  609  			/* have switched to some other cpu */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  610  			secondary = 1;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  611  		}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  612  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  613   leave:
104699c0 arch/powerpc/xmon/xmon.c KOSAKI Motohiro  2011-04-28  614  	cpumask_clear_cpu(cpu, &cpus_in_xmon);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  615  	xmon_fault_jmp[cpu] = NULL;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  616  #else
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  617  	/* UP is simple... */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  618  	if (in_xmon) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  619  		printf("Exception %lx %s in xmon, returning to main loop\n",
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  620  		       regs->trap, getvecname(TRAP(regs)));
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  621  		longjmp(xmon_fault_jmp[0], 1);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  622  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  623  	if (setjmp(recurse_jmp) == 0) {
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  624  		xmon_fault_jmp[0] = recurse_jmp;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  625  		in_xmon = 1;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  626  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  627  		excprint(regs);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  628  		bp = at_breakpoint(regs->nip);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  629  		if (bp) {
736256e4 arch/powerpc/xmon/xmon.c Michael Ellerman 2014-05-26  630  			printf("Stopped at breakpoint %lx (", BP_NUM(bp));
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  631  			xmon_print_symbol(regs->nip, " ", ")\n");
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  632  		}
daf8f403 arch/powerpc/xmon/xmon.c Josh Boyer       2009-09-23  633  		if (unrecoverable_excp(regs))
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  634  			printf("WARNING: exception is not recoverable, "
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  635  			       "can't continue\n");
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  636  		remove_bpts();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  637  		disable_surveillance();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  638  		/* for breakpoint or single step, print the current instr. */
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  639  		if (bp || TRAP(regs) == 0xd00)
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  640  			ppc_inst_dump(regs->nip, 1, 0);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  641  		printf("enter ? for help\n");
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  642  	}
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  643  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  644  	cmd = cmds(regs);
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  645  
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  646  	insert_bpts();
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  647  	in_xmon = 0;
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  648  #endif
^1da177e arch/ppc64/xmon/xmon.c   Linus Torvalds   2005-04-16  649  

:::::: The code at line 523 was first introduced by commit
:::::: 736256e4f1bc50bb8198c9b61dffd5fd0de17477 powerpc/xmon: Fix up xmon format strings

:::::: TO: Michael Ellerman <mpe@ellerman.id.au>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKesrVoAAy5jb25maWcAjFzdc9u4rn8/f4WnO3Pn3ofdJk7Sj7mTB0qiLK4lUSUpO+mL
xk3cbWazdk6c7Lb//QEoySIl0D1n5szWBPgFgsAPIJRf/vXLjL2+7P/avDzcbR4ff8z+2O62
z5uX7f3s68Pj9v9niZyV0sx4IsxvwJw/7F6/v33a/7N9frqbXf52/u63s1+f7y5ny+3zbvs4
i/e7rw9/vMIID/vdv36BHrEsU7Foqip+dzl7OMx2+5fZYfvyL0usnvd328Nh/zw7vD497Z9f
Rl2aSMrlhW4u5m5Xj+PD1ffvYWKAdnnmtfetl9+vfwxMfH52RnDhuGlVA2ff7fv34QcumA8/
K8Obd5eRME5TdqsnbTBmUdRNKTOmM3cRLaXRuYi5JveSShXzRhcVsVZoHSYpVRNXtb6+HPrC
0TaxzLjiJfyDxRkPijKRUkU8z4lZVomWF/NhIpiliVCAZSJY6e3SZbuYezJgKs5a4bAkUY0Z
y8jSk4IFyCC+EW9RsKpRZQJrMbop2M31+ftTDKK8Pj+nGWJZVMz8fCCPrx3vKMSMreCYuKmr
puL2KKAzZ6TAS86TIxcvIviVCqXhjLK6XBJHAGcr1Cd9fXU+PzYVohGVGISiDYuXRjHUlrqq
pHKk1zbDEGnOFnpKz2W8THg1Jai15kVzE2cLOJaG5QuphMmKgWHBS65E3GRrLhbZ+DxB3e2Z
glwGRSyYXnpa416IfrxY1wUhCM5UfttUSpTGHYOV0MWIgsvaXJ9/OBuvrlwp5ixaw01IGlkI
06RA4E0lYUCuxhrGbttjRZOQxP59rpNo0Zy/u7o6mwrDRPq2dPhZDfbVjjnljeqFZ5UqVik0
M4bUnISnrM5NU4uCLTghoFbsIuKqZEbIEramtYhyPtqbrnUFF5ggW2sQqwb7r/jYWCGlKIQM
WE4gTyayKgV6wGGrcFQLznLQtxBbXSkZce2vhyWrrr/iiyBNsBjNH0lLkDYP0FYnaCxuFCsX
roAWhoHEmpyveO50hOvVrKVy9DKqRZ6gWjb8pu2j29tl/eDC+uJHFOHrE7T0w5SgK7xcgVzg
YgpQ0uuL4xyxgvOydkjAmb15MxxO19YYrg1xOCBxlq+40qAT2I9oBjU1cli81fwl6BHPm8Vn
4XgasrHXzExqU8Kdun7zv7v9bvt/x6n0mjns+lavRBVPGvC/sckdaUstbpriU81rTrdOurRC
Kngh1W3DDNhFz+fWmuciIq+XvaiE9KwsrJ5aDpwQlLg/SDh4ADhfDj8OL9u/hoPsbzjqhc7k
enr3e0qrSjS9EAtlb/JAxuZEFkyM2ixUSBqTgd9JRLlwhFsxpa0DoGytHQ+1PdXE3o9GDfV4
NWx9bLDRh8A2SqOvp07AiHjZREqyJGbanOx9kq2QaCESZngvfPPw1/b5QMk/+4w+VshEeB6m
lEgRSU6DIUsmKRk4OLA/2kpC6QnaBWf+1mwOf85eYEmzze5+dnjZvBxmm7u7/evu5WH3x7A2
Kw+LEeJY1qVpT+s41UooMyJ39phcGR6gPZ6BneSLNBh8JQFqamSlXYwB9wxYwlC6gEsSWua9
Qtp9q7ie6an4jeK8AZq7L/gJphBOhbpkumV2u+tRf7s2HIXojmPDuvMcTWHh3hekWMil+SKO
cmE1axAKGmnAdOU8poW7bP9BGlXsnsIdFingjku3HUUFWNKlDy7G4pdGs5SPx7hwLPpCybqi
owK0sHCpQ0FDC3DQntsxaJ5bnaJXrhSP4T4lJJPiObuldSlfQueVdVcqoXQlbmQFWik+c7RM
eBfhPwUrYw9UjNk0/INSjpGNZyU4LFHKxIUKLRNoWMwrC34s7nX8cZUOP1o9dCIM8F4CfIMD
YPSCG0SrzcTqtcIbml2p4hI6CrGRNGNlkk9cWWtTnNYxxG1VBlC/Cy8cE8/zFBRfubtlYPLT
2l12Wht+M/rZuEEEr6S3TbEoWZ4mzrXEdboN1mi7DToDz+sclHAwBeAqoXkvHWe70CViSgkr
/UE3Mh4vLTZHu2tgd4RAlzjSbeEM1rc0o7MZ2iOwYbB31Em4pycGbYWIt2AMhkGXqFN2UYay
iCilLsfRMQ4bb3CoCGI47cUDGB0mnBqjDU1glubodgeoHp+fTfMxXRan2j5/3T//tdndbWf8
7+0OfBQDbxWjlwJfOphwf/DeNxVtU2Ndjae0Oq+jFkk4YKyLmS0uHq5JziLqlsMAPpuk2VgE
klML3sPO8dgQ13GOlh7BO2Al2gJ6jBlTCcAMStJ2X2jQAUYZwXw7YCBABkDCGoDRIhXxCKyB
v01F7qExa5WsWjuyky2jc3/t+TrNgx63IRK5p9/rompgX5yyPUNs5actbK4FbgvcdnQbMQKE
kMLxFPYo8Pzr0u8xgn1wAaxvBTQCwMMD/3YgAdcZEyuwJjMiLccxYNuquKEJbWsDBj8dWXxL
94zmAOUtayalY2V7nKlBiIgQOyxNAFpwVUaktxDQ1WoyIQap4KGSNifTiadh1XgZNt1VifGV
GS62H+0O7WhcusGTuhhL1i5yUITx4gANtcEoqv5ka628WmwSFxWmfkY8a86WaBI5mkYWf6qF
Gg+zZqAfGM21cUcfdxLL1DxGC9GAjnsJmFC77bkA0FDl9UKUni47zYT2mgwUEecEQz4WKoG3
x9o6hdgjjkIm3ZYqHqMhcLybTOocFBSvBPpp9CfE+PwGbiHCGgwL8XAJvbPdrUkDnEQJ1Mt6
jhNaHm2SvewnyWgcrBncZ6vGFNrLZQn3HRa9Bjvq2jUA1wAjunzTpJ3FnbkcnH6FiXLHzqQp
beqGNa9wX1ZiIVcrLR5keZ+7UOsbd84QT+9eTnlwbcBimMDAEyKddhiN1erLmH3MbJPpRqIV
8WIsnloNtdBvAgEWsVz9+mVz2N7P/mzRwNPz/uvDYxudOldJrrpVn1qCZes81BhttTe1M6ho
6foEMBW7wZ4Ri7oX0yIvXeCoZ6OL5E7Tyap9Jsklo/x3x1OXSA92bsnkAQFfZ8NoVezGgXD1
mEsLwMKeU9ARekdG06dGTngIgpUoYLFgTJJmiSA1uGPdRtE5+LjacRIRJluGn3mUsNSlQrwT
awGK9Knmo1i5C/oiHUgwDPRQim2IGw1fKGFOR5efZRmITJEjLhJAVrz1MirIto4onWunwBxv
qsd7RNHKik2vT7V5fnnAx8+Z+fG0PXjvmYgNbdQJUQ5GuaQm6kTqgdUJo1JBNeNiik8A58Ux
2Shn+u7b9v710YPqQrYxfymlc9J9awIgBiU1pcSplxLss7h9B2ILPUugJy7gRK9u3us3d1//
fUwNww7DK3WIy9vIDxB7QpR+osyULs+dHZdWV3QFMACvOmCnNh/q0xHvdfRTNLLvGvSZhzq7
RL+3/wDCDPj2uFGFkzC2xrFdOuiXXJcuJGrf6AJEO9uYNjwug3n47N+cXpur+PL7d1Q8TJSo
Ft57L0E3IqbtExJFXJ1KWPYs2eoEWYNbYOEpbk4NjkTMele0VYDAMa0WbHq9HzcvGBqH6hVi
HjDrPfHkpj/NWUIZa+x8+d4rTohYEUkZsGholWVJT8IjWdImVbPi8vKMB5KBYOuloF+rDRM6
YyVJWzJTMEGSFBOlCFhlwIj0OvAqBCLbmJW3sswB+9L0Rc7i0HyKJ2spaUfCxSLQ61bCxYJL
G4DD+vI7VWYS1wpueh17+Y5UV3SNC1viidEnLeC/JOEGEwo3NmrhN3Cow2OyZIreJd7ny++A
O4oq8PDR3fhFJejVdHQZU+/yl+/fpZWXpGhbGq7U5TtadVZFs6hHr5Wjd3DwiAx3SYunEjGx
lKLy33vwdrWjZYBVBZ3kx04Q2IqA9Cy50AtaT6y5+jC/+hikBg0ZPqW31QnheeuLJjO2/iM4
foH5PlrMSP74/gwME33jkF69H5P7B61Z+rz99+t2d/djdrjbjKMEDNXAhXyieor7x+3s/vnh
7+0zNB3Hw+bxEMG3OOsY8eVGH/kw6wgaTB9TqvOmzsX51furgNkv4ShoDWhvxkT93bzp/gmR
nwO68EXQS3Znn5vzszMvCvrczK/OyBmBdHEWJME4VHla9vkaKOOXnkzhgyLlWsDBFxWistIv
5ejaVzKHUJEp2mV0XBR4FmVaGMxGeC8Q/gME/rL5qSP6w+xFBiDKyxp3Y+lYicqLNtoAX9b0
9e+6FUJTVgDn9lNjBTNZw4s6HyVo/fb+wWS4gj45WwOEs6pSQChLYnwhsdYv43nlJbTWQpo8
GqE+XtpMXFerkEmD+Ssi7bNmGAhYrp+NoOBf/lOF4ljmYXN+1HLVp8a+mmLxoD92CpuGgbs5
HESb53zB8r5sqlkxwCRDlN51c96ZoKHBtzpcJkh0nLDERxAfM3vNXddJt97rLdzgtpS2eqqd
31elrh0AeSrtmFSqv8qFaSpj5+3qKY8qVVTHdFWvHdPqjBM1jpGsSzdZbNOORmJazcvva8rF
9nfIJvEKzGXCHNeXZx/fjQwmJl8h8s8qW3JDY6mcQ4QaLAhNlYQhgp0LGid+rqSk0fHnqKYN
9meb35GBh3c091gvZjP1y1BRQ/uG10xKFgarX1dNxMs4K5iibKQ2CdiS2oh8VFl2ubTTTyKf
83cdIehQ310SHD2ctk8Kw3t/L3Obg8KKAcx5SAU20svQ2ggDX4NsYoyyeF0yBLTcrYVqW/1S
sY7TTkmMxG9A4AD71YIb7fXssri0zxqKDmm5UErdpfkd06JZ/yzSZzyi18PU9aKQxplPW+OB
nbt0sKE21xaCLCxfzsuFIWoyu0X42iDKRCgemy4Z08NcgMRaeoATUUgeUU7JYi2IqONMCtcO
eCMiQ1vdpf1GotoAmjlmDcCAUNNBJ5ux942R2xtALZXNRwq+6yz1mN9mzOjzxSWams76IVHI
QLQPtErRQaSlMS0CKtf6S+SaQtDN/RYfuIG2nd3tdy/P+8fHtlJsGtqDGCG+TMBIcFvAOBkt
2R4e/titN892wFm8h3/o40Bt7gDav+0PL85kHf49uCx8d/+0f9iN58dqeutOpzkJ6HT45+Hl
7hs9sn8AawQaJs4Mp41qFcehEBFxhoJ7lwQCwFM0wJd44eDuTB8N7BrZ/d9Yb3CPLbbadfBZ
Xba0e3+Z1tUl26+b10fbgEV0h9nX/fNs0493536S0tuJGR7U62F7PxiMXK7R92N50fXZdwDe
9n9HhUc3I9NUcwPUuxG1e76BHSqKjB5fwNU8MpyNGIytIWpnPnb2nfa0TOFor44Fw+X25Z/9
858gg6k9BGSy5P7tti1NIhhVugYg1nuowt8T3iEFlNO+7iZVhX2MppWC48vXLTG7KP21iqot
v8Kqz0CsP+iJgoiAzFkCU1W6vsT+bpIsnjYiFqxGS8B2FcpM4WZEJU4RFxjuQKhAP/K1PI2p
y9H9GLzrbQkuXi5FAFngCHVycghkSWVNyxCJLPC4izSu6d2JdunoqMN0qwonVmaZfka3gxSI
9gGBlBpd23/F/F8PG3FOhbOWC7XfzdrjeuOqb/ZHxGMI3hbLodj6JxxIBX3RRkk6/MbZ4Z+L
Uw9KR564jtySgz5a6OnXb+5evzzcvfFHL5Kr0EukqFZ0QgmWjl85IHQLAGrcXGVg3pxpLdJb
H6O1vcFm2noKMJlFFYL2wNzWf4RsQhLHAZUEABgbmqYCCWQDKk6noQydncvngRkiJRLy65y2
vAbPXo+Qq20iB1vlrGw+nM3PP5HkhMclp29JnseBpLNh+ZKk3MzpzFnOqgCwy2RoesE5x3Vf
XYYOt81e0duKqcK/pNRYCSrxkxX/ucQUzD68koNJCFpWLS6iRazx64NA+AjrhGhpGb7MRRXw
jrjDMlBNk+mwz2xXmnB6M8iRX+BXdJh6OcVVxiS4V5UTWKjUfgrgVonduHRryrCKXd82fm1w
9MkLRbAe9nfy4xnrk3L8ysV+zOSDmdnL9vAySitb+7E0EI0Ft5YoCdZLlsJIWo4ZKxQLodU4
8JoV0YrMUhCBChmHtFnGgfpSA5F+QVQndPS1wCo6/2U1Thd4Z86pAL8j2cIM6GqrsxEP8UXi
5BWPbFht1hceIQtiMW+uXESTudpz6Bex227vD7OX/ezLdrbdbb484ofjgL4LFluGAX/2LYiB
bQ2ZTWW0mHeYcS2glTbK6VIE3lbxvD8GUlFMpDSBV1kTKkEp00BspFnwdcxCoJSm5esTACTR
pz69Xihp343DBgQuOJofQh/w81Q8445jlByNuwvZ37dk+/cDhMOJH5HabxAf7rrmmRyHFXVb
6j1OZnvNoOAmu37z9vDlYff22/7l6fH1jzcDDlmZokq1i0zaFri+dekkR0FxyoTl0q39qFQ7
USpUsWaqLSh2igjTtS35cpfWJq/6Dl726sjd1s92q0+7sntCwpibXNs6JOc5wfG89gNRJVYB
gNIx8JUKAPqWAb/Y7IZp2uQ9DU+QjeGHxT2zLXsORBK6yW5hdyuhAwby+EldVeMSx39/gODC
z4nslI734AsvLd/+bsTcS4jZL8AzOI0Ev3RKfWkdU3z3VkEd3YP/lDwGA+/qg4wnHyQUxq/p
M4mVVeDB1aDBTDD8s/VWYS6nuIz8Fg55ZNqSx/Mz9X7ab1RA9rR5Pjg3sYYfs2KPdV3t5xjm
ebM7PLZpjXzzw6v2wjmifAnn5svhWNo36LwJGNUQQQQpKk2Cw2mdJoF31SLYyUpQBr5wQ2Lw
CQKJx2o5UKsWDE2ErVjxVsnibfq4OXyb3X17eKLyZvawUwopIeV3Dgh7pPbYjm/JffN4KPv9
OJHOcrjwmkQMYOVaJCZrzv3BR9T5SerleAUj+oegCMeLoAM+gtP/gy2jzYvRZmzbnBKToCOD
Izm8cksuDcCnGwpyHs+hAPc7sQ5IAW/DTnTE16Bxt2CRBtICnxhZYxDpUdWz1b5i8/SEqbxO
Iy2usiq6ucM/mjPRUInY5AZPAuPl8KXBbGTBqBpMhwqWa7w9K85mpZoy4DFs95yZkRzsQvX2
8euvmJ7ePOwAIwJrZ89DF64q4qur8/DNz09Ju8pOUeH/p8jWRM5xhZNE88Phz1/l7tcYT2GC
l7xBEhkvLoJTlCzwRmYtXsnHdDt6XiWJmv1P+9/5rIKg4q/tX/vnHyERth2CEqzEyZOsI8ri
JcbJIfk6Ar6uhngr8PclgIqv/Mb7pAga2z/YQpKWMvrda8B3Ku87MmjzCmXhd5s4Hn5DB0A5
6AL8B38gAZBSo6+Xe1xnP4bBv1dz/Psu4E26v3wzhANtE9G/q073wt+uYL2s8xx/0PFlx5SG
S9qRjM9RWqMii+pifkMHTD1zwuKP7+gqop6lBtmcZIgB5bYfzZ9ky0el3dO1qOj0zsqf0PXN
h7C4G+9v+DiN7Zeo1+fvKJoNQS+uvBeXOAF7jSmGOFnRC8LvOVF/Gm7o/E1XgglAm8U0Bj8u
4id7Vto/4TY7siq488A4FSTSSVwHhMaPb1tv83C4cyD2sNHkan510yRV6A8O1UVxi7cwkP1j
pQl9XbvAJ9+YdvFGpIUNqmgMGuuPF3N9eUY7CF7GudQ1ZkAwwgn9EYQMApGcTgCxKtEfP5zN
WSDwFjqffzw7oy18S5zTdw5cPURcujHAdBUo/Ot5ouz8/fvTLHahH89oE5AV8buLq/9Qdm3N
bfM4+35/hWev2pnt1vJR/r7ZC5qSbDY6RZRtJTcaN3Fbz+Y0jjP79t8vQUm2KAFS96JpQoAU
zwRB4AGu4nWkNbNx0kYuSxVj7km2mNhEFahDtP5a3YIbup4xQoLdq8SrzkfNrVVPSteNQZJC
nugLilqXI3xClXSwS+P4a0rJEbBsZhP2oSXLYswzXBQuGZQMnNuLdexSrVvOrWFrehdwNYe/
9u8D8fJ+Pn08a9f791/7kxKZznDdg1YPnpQINXhU6/X4Br8aqxUeQxgIr3H7iV28nA9Pg0Bw
JUScDk8a5fHdtFG4ssCN2zGscyUXHpK8VXt+O/Va0BpMHigi358esc+Q/K9vF8hIeVYtUFLy
y/7nAXpq8IlHMvjc1GBB/S7FXQeKrwnVb+a3DKgMIvM2lX6FupoCG6VbjDo/cFkUTZMVhEMt
U+QsLJyFHePWKZz2PAMPvkoEv06CammDe18QGRejhAkHwLIS7MYKGWqaOsjesL3SaeVTCb6d
6G/eYh61Jo/W8XhtzYluUdmUwfn322HwSS2Sf/9jcN6/Hf4x4M4XtTQ/Xxt5kSmMZvJ1UqTi
NajIkSQYLqXikvWlePyp6EImHqJ0B3BtSxMSqinN4kerFfVoqhkkh+cwUBbi/ZhWu40hDBRZ
1cWhNQ9MFo/3cQj9s4dJMvknLGqpScJ9ouBJ4r5i/GinIdZoDqdjQCLpaJgjwRqvTVdhsT7F
QHYs7KFCh6HQSCVayDKS2kEmMt4yJVDjAHHHqBmx/ed4/qWoL1+k5w1e9me1/w2OgN7yY/9g
nBi6NLYmdpsLVV/sAZ4JF5eAg7tb/IFaU2+jROAyov6G6j5uzUb4cVnUAuzSWjWtc0jhjybN
job2o/soLnQXRq205OltZMN+tTihXNcdWOPFZPDJO54OO/XvMyaleCJx4VUPL7skqskhcREl
YFzJVJFclycQthWrPbZU15uPtKXrxXWjikKH2iK0UI8LOLcb5ov7DoMu4u1MW8u4lNqFcbBi
QGnbjKKoXJKwYlRfg10yoh/r4K2arCgQYZtNE/UL0dZ0g9dKpedb3eEaZZKowZa6N4Y+dctm
SdOQo5hZ8MR5FQ4bFqXOUQmSx+8fIOvJwkiUnR5+Hc+Hh/PHqa59qwY4XcOTcGpOnq2S56Mk
H/PIUKJsI3AwxLvhLl5HZkva5TGHxalrvAWVSdpU0hMooFe9gJVrzmo3tcYWhopRz+QzDr7W
JuonQGxHKKyRkTV1TTQSdbtXWxc+YIUwnqLW+PVCA3ZfdxAxSIZwov60LcsilQ4xzBACLF3l
zbPV0i1Rmjhmf17/slrooTrR8GolHE+HyRNJcw/2KRsjH7+9A4Fw91MUqqtpm8qqbht1jmIq
fb1WC9tu068LtTCqlVjgkJorYjnBr59LHsBTKSEzhhneR5yaWqlYRSGufYDCiGNUY5GRNpMq
I2Wdc20wdJTR3pDq0jIPZ1uxCdDZwteuLzX6X03+1Ul5ik+NCxlv+oWMj8GVvPV6Kq3EU6Ne
zTWOZAG8r9CQ81ZuoMSay46Kn7Qham9aK9gx98fCStYX2PtNPVdp8XH9kD8i7l0bJYWGqJ9P
rTxwcHQNg/ClO+qtu3vP18KwiShS8jAGIP1Qbd/gJZk3VwZSUsZMIXhEmG5tM9SwslbU2qjQ
OrZQP9p6hg3buQKdwmJprH71p+opRrirlcT8PhC4tH3hSFa9LCllqF0xwA98HVxYwqiwu+Np
Qrz1V5wBU/KQr9oL8ic4cvwBu34vgOtLd+/qZ0VjiliE07NLuDzrdFPhscKVLyp9i18HREZl
gTMTp0yGPTMNfP4zY9F8C3qyBCxR11DzaXk7m4yzjDz0g21A2TEGIIiyfEko4G9WhHXQzR32
fl+vpqojCyOjbYGfTXLCJFPTyEuVok47qXLXSfZ2PbUVPDHn2I207aml8uLz/kbe2/akpYRD
Sr5LhNEH6m9rSHSr5zI/7JFNQ5YCpoix4xdJuHwj7bE96tm/1K9JFEaBi25h9ngxNA+Y0U1/
w8OtcIRx2hXg8o1J2s4Y3RiNU/wRdbKWDkpuuBImOMFaSczqGEF75M4FmzxP9Nw8bv1oZcKA
3PpMrTJccrr1SUns1idGW30sc8OczId6a9RrqC7asIcadVQJ9AGTBL3HaOLCpcQQDGxrvCCc
JICUEihDiW3NFn0fC13JJDrrEsfo/GQ2nPTM4gRM8BO0MMkCJcUYTjhSX3V6Z6N03Vu8SOEz
454n+WI0HGNm10Yu4+6j/lwQZ5kiWYueFgOOfuKpf8bkl4SCRaWDqSrvu3PLQBpd78aCUycu
8C4si7hOAHHSt/nIiIMJXoYrFGQKe7MhaqskLb70Dt0mNPeEOL4LXEaocNX0IGwcOPgghcT2
KjDs71olUne9SY0NrUjpyWXmEDmP1QnHCFVR2tB/tcvbmjux+jNP1oIAAAPqFgA/GtCK7WJ3
4r7hhlmk5LspNWEuDOM+obqwj6gXXlpMwPbmU6BaJY/vq35ubIPIDLkLo1iaLg3OjueZv6K2
UM9x8JmgLi0x8SCnhK/SQJqmN/zvrwqb9R31UBjHBBIbfveDR/vC8UUrhuttBhJnBKwREG/U
/YYQLoEcuysmiQYAPUl92yJMGa502tZAze+5TZy8QFf/qOszkEW8xjeLXWMLr9xp8h2Ksgfs
V8VkUByTGC019IYA/0ODHijqlBKnzEKDuotVnVRTMyHUSlWBkKqbFUFKpGnCCrgGFAZYImRg
uukhhV7vLhjRVfIi2acJMz1UDNpFZsGI9XfnOqEeHaienhL893dOXVSpk7Qm1A21cqewQtGe
ToPdEZyVPrW97j+DR9T74TA4/6q4EBPNHfXgEWSgxaWESrDpF/hRJqRDeMRt2xa54uXt49y2
ALgWFsab9mvDen96/A+AJ4iv0aD9PgzhlJBZgthTalZDW8YCF7X54b/2p/3DGTAtmh4gaWr4
Dm8x6ReACxZ2Hqd3teEtzIDIxNJgcDSdmW1jPvVwe+3q6D6iLmv5SuIDV0ZlpEwjDITC5R28
XKAigZoaDStXlXLTMO4szbFPx/1T+/WnbKQ2yuX1N4mSYI/q4QxribU4QZVjgyHU1Tg92HxQ
nKUaEy9e7/BvGXA4dUKpJUQoYZJvtCPOBKMmANgfuF0sSoJVu4HrUK0KWAgOsJTDUJ2VyRgw
hrbwtZ5u0F5RzbBsZrenADlE2V8ajZSYqt4YGemT39n1l5+ObJu4KtQ7Kso66gEOU6WlQbXb
hq8vXyCn4taTVj9zIhtWWQL0alN+NDlMEMJaYm3WNUv9Rqzckiw5DzMKObfksGZCzgkxp2Qq
Xwy/pWzVnBwEax9bKTDHspdT7dFd5ITApy3JGtMq7vsGh5sghP5wxErwyCfcD0puDRRPyJ1q
5y9DXuHi+rYIwIofk3Eg8iLKFuEbvuuKCkSjsSbjxQxXuavLKTwvE9kACYT2Ek25+oeCo6kO
avokqPH27xqdVhz3I9628yv8MK9/FPjAAH9oJhcxmgwNO6TqiEg4vADQG0A3NUrpWVvGE73U
7yJcgD3pexM9ayADSKchtIyPM4B5HeNmvBf6jDDgruhZBz1w5lPcCLgkw0s9SRc2YbuuiZT5
HxBjITLiXUdRQ62GxZcq0KWQ0+mC7hZFn43xq1xJXszwLQzIWwIhvKTFSRs6V89LHRly8B2c
fEtnt0/Papiffg8Oz98Pj4+Hx8HXkuuLOg3AC+5zc8AdF+AOtBN4p61akxe9mulRWAa5MHXE
elYTOA9Ai+AUITwGYOg4669bnDHS+LcYgoDCbgNyseG3utn9SwnQL+r0VDxfi4W0f9y/nekF
5IgI7kAbKurl6OITlfsg2ZNcSbSMUm9zf59HkkBjALaURTJ3t3THpCK8axo960pH6pp1qjWs
No+ajSLxBzXRZ1T8VD1nwBefdkm5sEAQ9B4W6lSThI5JxsSVYo2jM8YNSFLZoaEI0xg4Wr0K
aQ9Px8IFAYt2IHPu6/hLNzrmI3FzuXD5TgOIGWNC0bWhJj91LOzz66l9MKSxqufrw7/bxxtg
TFlT2y6iBzdu76XqDcLwkphTtWv8/vFRu+WrJaS/9v5PozdESD6iQ5soJd8OPwTiaAfH45ZQ
GmoqODbii66gQ7wQHzfiXO8C9JUADFWCevTCMiF3dSzFEC7HUHbkeWpC+ewuD+QV1bliNr1C
q1SIbqKBqNNExJj6rWKsgMlWERjhu3G+E9LFSqwzekwkxWUJF6GQLEWIvJjyzsOylMPia7Rs
Qnat8tG1Qhg72wkMSxau9I/eb/5hs/7X5lwAzlEubdxd8bbWL+NqW1Oi+ngyzGAtnZ4N1UNN
IQaoVhGGRilBDR1JKZaN2xnqA7PkAUPZlw1o6sLz8ePpfPzx8fKgkTQ6vNI9p8MKwYMol6m9
mExxEUgzyPGckAkr8ggX3WKI+MOceDol3Ap1ftAh557vZtRN48q19jmBxwE8qp+miyFxV9UM
zmI6t4IdLvzrz2TxaJjBmUc3yGGL4Zj+CJCnI7KICwsuzVbkGd6jFzLhpV+QqWcNTfZDuuiA
W2BN0Fn5tZhNRpbuCnybTrnGNuZ4FX0dBAm/KACNukTAp7+x8D7nQUQaDimeGzeIfQKmQJFt
Ow5s4hnwSqfHRtNnhOeq7kKWWZPpfN7FMJ/POhZEwWATqCUXhgU9BTSDPelksBfDzjraCwIz
8UJf9ORfEDgnQE9n467sbuiNrGVAT8KtiMHRiFJnA0vipjhgLBBj7k3VIqJ7KHH4eESYEGh6
Oh12ZefTdGp30G/sId09SThNZxZNly7v3tOlmMxnWQ9PMCUu85p6c2ereUxvFWBHgSuNltl0
2HYTNjOnQdxBvZOcOLKBnAIAzng8zfJUctZxHvjxeNGxCPzYntt0J6vP+EHHDGJ+QLjvpbGc
WcMp4WGiiNPhnJ5ZBUPH8i8YFvQGohlGFr2+oGmq8R2HWMkxndF7QPmVjg4EBpvQu1wYFlb3
WamY1H49xmdquvMnw3HHZFMMYKPVPRt3vjWaj7t5/GA87VjvKR9P7UVHU4OOI2ub2R3SAEvE
fRSyzk7aBfak41BT5LHVfaoDy3TYx7JY4Dq8xF2BoE3h8sAjehUJsiXIrk77t1/HB/S6zlaY
0ch2xVSv1LBBywSNzbmC4DZW7QXUSdoPiUq2H3xiH4/H1wF/jSvf/M/gi3pF3a+u6ixwBv7x
+2l/+j04vX6cjy8m1ggnY0urT4ObL6KW1/m90/75MPj+8ePH4VQCMxkFe0SoWcZvtO4qV9Iw
1q0XTtUvrXgh10tItAkxY04wTonA99UXaapuvm6oRq/2pqpxNoqPmomF6byZdon0tOaOQTHZ
iqfRS9V0zjDUYYXy0N1hSI4X+JfD09P+5fD68T4ALVsrggCUVd2GY7AeMUP/avJdyECwD0QY
Ee7WulNSddlbi9T1BeFFX3EtfT1EMs3XhOIOOCmPSaDtdIcumddqMjRSg1Nc/aYxNC+dfzbP
1Emsup78TgYD3WCokd2S3OwxnZ4A2KRqYJ6iBgwVW5rCEBbhcX+3qI2Rz+DJT9HUNxGdMFIz
bWVg6m5McpfiWo9XthlZw3Xc2U1CxpalBKo+nvFs1MnjqdmhvtbR4xHR45HZ3pzw7sBYCQNN
hLWnTtgyjf64ozfIVDMYpG9bVidHYrOZkhjmnUxQGQ0qG0QIgAgsnxIDjz/t31GVu95+CPBr
vVsl2hCNXrwOnTc1LzWFqUCUuv830F2gjlC2cgePh7fDy+P74PWlwLX4/nEeXIE/Bs/739Xh
tH961zDWAGl9ePz/ASh+6yWtD09vGoPxGWL7HF9+vDZbWnFiPSWe9z81mGP7cNI7mMOpu7Qm
g5F0w2imziBiWubS+fVwOsQLv965d4SWoSTS1pvgzyccF9d6Vct5biLQXbql4bJudqe2AkCz
macVkd8NBKH7Kakj/GagJ62zSYkwLUXVttLFdbF6dYlo2jGavruKUtC90hwdq5Lf6Wjb6v85
J5RXBZtWx9Kj4gTRhkAh0hts6ojcpaAXdB/FEGdVjW4DQ9HsKSHVf9sVPT0IFZNe4gk4pm7F
MiElYt2UaMcS1ec0BwlCVpxw0i1wynJPZOmmYx0JCdKih9tCAcOdyk1PG/de9yzh7K3X6Eab
O4+mVkaLO2sJQX/lUl0z6PGvmCbq1kb3PcStUMPnJq0uuqy1+Nfv9+PD/qnAmKYWW7zG50AY
xYV4xF2BK4svJz6hQwH6ijkr4rErvYuJ13B9VPqxIF9bNzu8jwNKXeYGshlG99pQJVyr5YB/
CQJowGuEksNSvJ+E+hmKJUMvEq7DAFApAtFa8mRTk/k1qXWJSFIO1yUzQUfbMZPWPI3kHZ5Y
XhX+9ffT+WH49zoD4AgoacXMVSY2cl3vtSlvv0HXaGFpuVrAcoOvQgVWVLuBAKMSGDz4mNeo
tU4HaDAkuQHFWk/PN8LVj1v4bRxqnWzxxQE3fKgpsiKqfGy5nN67El+lV6bMJtTgFYsj1fLA
tVB1ljmhU7iyzOb43lOxrO8Cm7KKqngAIJFya6t4Ejnl455vCelbI0J3a/IQj2IVU6ZYcK1P
xRFzz56OupuleajnIINp/CdMf8JjqrWb3TyxUnvYnLdXihKO8R2xYlvejgnIh4pDjqfjxRA/
miseLxhbhEHYZbDV/LV6WaY2vr/XSyEeSioWNxgPR93LINnatnkqFvbusWis1fpeAPZ6oUbE
rnYg4AfLkD9Y444cjwjIndpgj6zeiqu2LUw5u7Bvedqf1bXjua8ePIjww6e2/EeEMrzGMiUe
qOss0+65raFlp7nHAkEYoNQ455PuvnPkaEJIMJdpnN5Y85R17yTBxE57Wg8shMVonWW66GaR
wWzU06jl7URN9u75EE85IRFVLDBjupfd/V14iwAFvr584fGmb0KVoV26d4dU/da3+GVIGDJd
2jpvCH+Fq5FwBvLwAlCvRE2dgFH6TEVabryaEvOqrYUAOZ4gdDlsk3VeaSjUGQjUTmPyAVlE
8Bq7MR11dTJl7VnlChCbuOD4cHp9f/1xHqx/vx1OX7aDnx+H9zOm+i/i/MATX8wowI+UkXCh
653aDEMwoGtVgmuzO/n6ccItZgpTk1gQPgFrbWyXqJ2rhyFIN4TzQcWREu+LblAyyJTw3mXC
X0aonXoUBJuaaP23ejgsTRzE+5+HszYmbIR6Tg7Pr+cDQBWjC8wNohSAotsKrOTt+f0nmicO
ZDUj8K6AR4gmtGRxlqnvfJKFiXX0MoDgFZ8H72+Hh+OPS2CvC14ge356/amS5StvQgkuT6/7
x4fXZ4x2/GeQYem3H/snlaWZ51rrTZgJGklcVT1P26G7s+PT8eUvqszS5WXL8SkRByD3e4mL
e0y5GSBHUve/KCGub1TY6xS/YgIIP+kTvkOcNZPbIvZL24UjuS0xtqpFlwT5Ct5gWJaHyb+s
2nIsKdtxLgg3NQGYK2TNtMlpHy6mh+hlQTsgP74XFvz1sarCh1HqgyUP8ht4swWlCMkFdrtg
Nj+yw0ArPvq5oDycCxRznAorxdvW57G6pirxDIKND55fX45ndV4hu3DC2ocUe3k8vR4fjS0z
dJKIiGavbvTh1hEBvlYchkILNT1CJRGrtojuQ6AAeDGhwPMkYbAuIsLRzRcB5p7kHdUuWsyP
mnTuSdiG6wHk1PIc5Z5h3l4m5RlgPFNretxADL9SJnldlVAmgPWoyHLG/TZJunyTCNPzWNPc
kCd3MWkkq3koHci3pWNEwIK/SWaIjbjUMSON66ErpAvhWj189X6jSRlNWnlyRNGWacfnQuF3
ZPVGdE5FwSczNS5wQjfnRJFWBHNqAvVXxSkhMAe6CGtxvQNw7k7VRt+k1+uHD/WFHkZpEda6
WpvNBFEkaGtto2hWENB+ud1EKb4MNYUTUfTAy86TE7K3IUQoQSsjJGFo+3z/8KthZCFbYUwL
sgbe/wqRdGCVXxf5de+R0WI2G1K12DgeVgMnkl89ln4NU6rcQCoeqtStykvO3bQ1O4u9/v3w
8fg6+GF8rjo4irAE1zHWCTems7FOA6u81G8kgmxeBSw2nHeAqE5430lcbLJBAN/6Vxuq0Sq2
6qW8IrTqZRmhzS946P10vVm5qb/MyftE8V+rD6thgRAWsLgKQFqjelHCwpVL7w3M6aB5NM3V
65WirumMihT7G5K87KjrsqM6Xdt0e9usulXJyfXBLf4u9riGjrskNaLYXY/h2w2Ta2pldBwH
gGibkdtF0NGPMU27DbNJJ3VGU5Ouj8bwJP/fxq6tt3FcB/+VYp/OAc4ZNGlnpn3og2IriSe+
1Zem6YvR7QRtMdML2hRn9t8fkpIcSxaVLnbRjflZ1oWiKIoi2Qy4V6zA4TjXXBSzmdcQ6S37
99XU+X3i/rbXMnpm5TDAJ2yaUwXvGDMRehXlnISb15QbWsc8ib15SA1IJwmP7ZgeQPUdVi0o
lkmJ4V0GbkrEos5P1dLBt6ArxmdZSHAd4mDbWJWR+7tb2KnS9VP+6iMlAWc6KEo4QhELXgJx
jJMOGSOtjSPdxV/Pg0MyJEDxktaC0xO/wdgCff8UiMlmZYHOmJsuDsi/aXJAn/rcJyp+xuQt
dEB+9ndAn6k4c2bjgPzGaAf0mS745jdHOyC/tdkCnZ98oqTzzwzwOXOSYYNOP1GnM+YwEkGg
752dfT1nEg9bxUymn6k2oHgmEHXEBNMe1oV/3yD4njEInn0M4nCf8IxjEPxYGwQ/tQyCH8C+
Pw43ZnK4NRO+OasiOeuYNDKG7LfgIZmipBcZ455kEJFMG8YatIfkjWwrxnxnQFUhmuTQxzZV
kqYHPrcQ8iCkkoynn0EkETpmMfHHDCZvGbu71X2HGtW01SphnPIR0zZzb0bWJBeVjtAzN8Zz
j+t/D28qiWcnTpjnK6n83vd0n8KhbYh1U+VRCZtVzMCoN9YeSCpzhorhMzGvdz0mYUpLY4ka
6Ngw6FHiddoG2uSbC24mxzETAQPJSdN2TFknU6esk2lXy3TOJFvWAOA0OduceV5VFCZNhoKI
as1deFCIGcNfQGUL9kumNJlRkf55AST/QiHaOGkUg6gAReEjS7o6Eu63G7xjkuSYjdrixOsb
TMPhN50RqZtFPzzliRrDH4PoIEauxMAChFc5gKNk5j6iiCqWzROfq2yKRrFdpOravhXqLxNd
nFQYDY7LS4kQOqn028Oisu0q68vx5WBvskiLmRWwEX6HOjOnnN7juaQc2b4NdP8ovekaYRUe
FVXMDCSX1DypLjs3q5fZtZaJ5Q4HP+bxME94grdcFwnIB8usW2PolTTxta7Go4Ji0D39BZ2a
LjIlw+0KTBVHdsCXknzh7T6Slavt2/P299HD7R0GFjXHaa9vj8+7X+SZ8vNp+37vO99WUdHo
2NM3xirCHSaIpISH/Ubke99Xsq5RpxohTgdDoO/5jLZWqiIvT6+Pv7f/3T0+bY/uHrZ3v96p
ynfq+Zuv1iouDkYe81Ra5hQ5ZC2qfBBncmABVvSsrRtM8hMNYsXOK5GpNy8mx9NTewBKmKBZ
V28y7rhLxFSwYIL/tTksJHjLNpsVTKJoUk+LdW4fllmNHtoMlvBJWOb6Vjj9U8PsToocLWgZ
Bsvw8aUDUb1W5OlmXBzFCuvWUqxwv47z3zd3BJ4Z1pu6GkTKHzzs74SpUbg4/jPxoZQ3/0C0
UA2UZcEoCNn26QX0g3j798f9vWJ7uyMpCKebgNFpFAJJOPLjURagn+Zs8sO+GOAA/2qtIMXs
B3Q2E8kpbWcG5q8tIfBSoU8Uk+qjuwjWiBSGaDx8hhKoIpQfrUDd4Qy1CsUE3VJEdepN+U1D
3aX4BxcuZu0h2DJZLJ14tOMWU6Xx6AGTE3kmwZAcavvSiYqqTg2QuY7Sl7tfH69KLC1vn+9t
p4Ri3qCBqi11eFVvUlcdeXXZ5pg1tF4NWVtNiJ5Ewrhom4vJ9Hj/mVlRNKUA+TQAlsKfaIzF
dlcibWHS7YtdX3oD6QxmAL4GEqLwawEWvS/edA1ePlT9a61m9NiV3jZ5xOrO24pVZR4r4RcY
WOzNlZSlM4HVHgM9knoBcvSv99fHZwrX9Z+jp4/d9s8W/me7u/vy5cu/x8sPKl5tI6+ZEH6a
rTzeUO6UOVjIeq1AIAWKNWiuzK1nwtIJZkCiVTAXzDGlX73GAtikXTponb5dkEK/HqgL6i2i
THrdxd9O+ijMHLxPw9+/2fcDr0cSY1CE7CHL0bIGvQKLcC1lDAwUCNmq5aUS2OxCDP/ppMtj
ocPeVNbiLzmEYBJ+KyId+iaSuTKtIw9W0ErMyGlrGsptLGqZVZOYo2JcoQ4OD7yIkn0eRnDF
DCC4NMA4Yt4OLQqnkyF9NLz4UF6G4hbqiXSptZhqpL84SOUJABoEun8xlhE9DCrnNsizH0qZ
8oKVjA9jcB+ZR5um8GZrLErV7mq41YPhmre50uHC1EUlyqUfY/TzuelXqwAVbT6jGPeg4uBW
y4HgCTUNFiJBW8qb4ZEyvW5CKprxQqkwa+fzYV1g+wBfQLzlYQF/GhyHep2gguq2YFAUib01
nX/Z37fK0w/GR0fzEVs5XcsIVCmzssHtJDWA8ZSrLmuMgxgoSK1rAcByDQwSAuiNjVEoFJJx
49A5BNTIMeF06P2uzkFJWxa+uTrDG5dLFBvk/JIXduI18xxDSjQU61+9wKx1PRxYKQhUa3+g
I8yVbczeWglvstIWvoYpv2jILOeK4dN932NQCdgDLhZcj+6Zv5vBLF5momKu0wwY9vNITHDd
gIrJilY1oBI0MNSqeZd1tOrgesxer9PJDfBD+H3XCz1dxYxPIN2JpegbNRcYhSAsdWZWblrf
A6vIrIFJx9MpSgB2RBgGSxUuNCzdWJ682obdpKW8jtvMrwqpNisDjopkzjAQ4lYAbBhnSAIo
GzlPV7Yjnt62jLsoUSsMqUOBVwNt5aLuqPFfBZiDoo1GRel3WFP1L/2Nmyeg6kPjDkwZfS+7
yjBad2A4yKcqUFGKVxsaTtHAgrmSm9BYZgUTJU9mLDspE0AXi0agVbNqeQ/RWmRlKll7AFkY
V4vYMpTib5/l2Vgj21ktcigZtu/JDYni4dsEWwuQjRqYF13eMllRCRH6lso/0yW1WreHJjqc
LlHjyVADEt2i+Sc2unEktbICknLm27gCSBGH0h/Ft1peYlk2y4tvp3axKrCt2n8ySz0eM8O2
GHQVzmQ7XIUxiACI9SAsqxM9r8M4rCDqIWiRgEWgXrFC/tryj8Ffvd3WeQrdWNcym6VD/1Qs
dWG7os7iRGtoTF9TkqDeFuAndKenfywFwiHDgAPFa4YYF4Qe/LhfRhPjsfrnEBrtTQCfHh/b
dSgbV7rrtEh3H2+Pu3/Gwa9QMFgNUQGwKPy53OBSwPgA6ncZ9Y68EmXMQ4DQxcuugO9R+GUu
u5BySQddQNZ0T4OmVBAbJHqdmEgIUc6PHKqMoh8l/z6AtH1268D80wUUB3SDrou2YgJWa8GM
xWAYIrXeerfwSkfed4WILkYmud53/68+ogENQZ+GJHr753X3cnSHMX5e3o4etr9ft297NlBg
DPEvykEOKuvxdPxcivjiyfNwDAVFN8KEhhVPGb+EC7j34RhawcbJrQk88wJ7CTKqOlsTwdV+
VZYeNB7bej5dW+lM9dPYr6Noqoxin5zS1EzkYuGplX4+9XwOGe5ggf2iRHYwTymL+WR65kSX
sBG42o46GB/6KlXSX74wdE69bGUrPe/SH7/6Yhp1GCLaZglSKwTxHmeKj93D9nn3eHe72/48
ks93OM0w3Pr/HncPR+L9/eXukUjx7e7WCgmpK88EETPdHCZHSwH/To/LIt1MTphYERpby0s7
UI3LZ3i0m1zBkKlLkXQF9unl59CdxXx2FvnGgXGq78l+z2/99ZmnxLRa86+U/lpcc7qOnq5y
s67EeIFc3r4/9K0dVd2fkdfII6BCr40qAvUL1eTKKVQd4jzeb9934w4nJxIv70eMY+MeEHTO
UVzGbpRMX3+Cv7LYl0a1J3711B6eotISLDUBvpRpx4WSN5I1i0EeHUIwXrd7xJRJfLVHnDCB
CcwkWwq/v+WA7jZ5hIBaePgJCF8nwbEGhN+30dCzILlZVJPz4AfWpVMDNVceXx+s0CO9HuBb
OOBpx1xZN4i8nSXBSSx4RyytURTrOefcZyaGyGSaMmm9ekzdBHkeAd/4sYy9PTAfrXUjIbUU
NyK4XNUirUWYFc3aEF4TZPgzsiphJxBeFYNd2KwLdyR6V5q37fu7CqI8UokkeaqFCk5v/Eey
mnzGBCrp3w4yEJCXnhgGt88/X56O8o+nv7dvKmKCiQI95mHYCEdllfu2tKaR1UzbLF0tiSi0
rHi0RaI58noMGZX5I2kaWUm84V5uPOKFDF5obT20FvTAWqvEnwJXzBGui8PNQ2Cphbp1Oouj
W8TSpyuIepNlEveMtOHEmHoDx7Y9sWxnqcbU7cyGXX89Pu8iiRu6BP2zMDuc5WZbrqL6e+9e
1lP3W2qiK0ObZLanyQL3lKVUd3OvZKU+5hjUFKdt33YY4QLUyneK2/r+eP98u/t40z5p6qTU
FEyXubqmamu9Ha+sI6YxvcYt5L5iii6vm0oMO4HbZBeYQHrjfs+PVkXvI2GHwOjd2Yo0uRn1
yf8BZyOeV+vvAAA=

--Q68bSM7Ycu6FN28Q--
