Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A73D01A034F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 15:25:42 +1100 (AEDT)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1EFD140297
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 15:25:41 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id 1so7048160pal.3
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 20:25:41 -0800 (PST)
Date: Fri, 11 Mar 2016 15:25:31 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [PATCH 1/2] powerpc: Batch up loads/stores on saving and
 restoring Altivec
Message-ID: <20160311152531.216861e2@camb691>
In-Reply-To: <20160310163747.00fee71a@camb691>
References: <1456811735-1289-1-git-send-email-cyrilbur@gmail.com>
 <1457564467.17010.1.camel@neuling.org>
 <20160310163747.00fee71a@camb691>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 10 Mar 2016 16:37:47 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> On Thu, 10 Mar 2016 10:01:07 +1100
> Michael Neuling <mikey@neuling.org> wrote:
> 
> > On Tue, 2016-03-01 at 16:55 +1100, Cyril Bur wrote:
> >   
> > > Currently the assembly to save and restore Altivec registers boils down to
> > > a load immediate of the offset of the specific Altivec register in memory
> > > followed by the load/store which repeats in sequence for each Altivec
> > > register.
> > > 
> > > This patch attempts to do better by loading up four registers with
> > > immediates so that the loads and stores can be batched up and better
> > > pipelined by the processor.
> > > 
> > > This patch results in four load/stores in sequence and one add between
> > > groups of four. Also, by using a pair of base registers it means that the
> > > result of the add is not needed by the following instruction.    
> > 
> > What the performance improvement?  
> 
> So I have some numbers. This is the same context switch benchmark that was used
> for my other series, a modified version of:
> http://www.ozlabs.org/~anton/junkcode/context_switch2.c
> 
> We pingpong across a pipe and touch FP/VMX/VSX or some combinations of both.
> The numbers are the number of pingpongs per second, the tests run for 52
> seconds with the first two seconds of results being ignored to allow for the
> test to stabilise.
> 
> Run 1
> Touched Facility  Average  Stddev   Speedup   %Speedup  Speedup/Stddev
> None              1845984  8261.28  15017.32  100.8201  1.817793
> FPU               1639296  3966.94  54770.04  103.4565  13.80660
> FPU + VEC         1555836  3708.59  34533.72  102.2700  9.311813
> FPU + VSX         1523202  78984.7  -362.64   99.97619  -0.00459
> VEC               1631529  23665.5  -11818.0  99.28085  -0.49937
> VEC + VSX         1543007  24614.0  32330.52  102.1401  1.313500
> VSX               1554007  28723.0  40296.56  102.6621  1.402932
> FPU + VEC + VSX   1546072  17201.1  41687.28  102.7710  2.423519
> 
> Run 2
> Touched Facility  Average  Stddev   Speedup  %Speedup  Speedup/Stddev
> None              1837869  30263.4  -7780.6  99.57843  -0.25709
> FPU               1587883  70260.6  -23927   98.51546  -0.34055
> FPU + VEC         1552703  13563.6  37243.4  102.4575  2.745831
> FPU + VSX         1558519  13706.7  32365.9  102.1207  2.361308
> VEC               1651599  1388.83  13474.3  100.8225  9.701918
> VEC + VSX         1552319  1752.77  42443.2  102.8110  24.21487
> VSX               1559806  7891.66  55542.5  103.6923  7.038124
> FPU + VEC + VSX   1549330  22148.1  29010.8  101.9082  1.309849
> 
> 
> I can't help but notice these are noisy. These were run on KVM on a fairly
> busy box. I wonder if the numbers smooth out on an otherwise idle machine. It
> doesn't look super consistent across two runs.

Did four runs on a OpenPower system, booted into a buildroot ramfs with
basically nothing running except ssh daemon and busybox.

Run 1
Touched         Average         Stddev          % of Average    Speedup         %Speedup        Speedup/Stddev
None		1772303.48	1029.674394	0.05809808564	-2514.2 	99.85834038	-2.441742764
FPU		1564827.36	623.4840148	0.03984362945	21815.16	101.4138035	34.98912479
FPU + VEC 	1485572.76	865.0766997	0.05823186336	34317.64	102.3646869	39.6700547
FPU + VSX	1485859.72	606.5295067	0.04082010559	47010.68	103.267242	77.50765541
VEC		1571237.88	927.2565997	0.0590143995	8459.76 	100.5413283	9.123429268
VEC + VSX	1480972.92	652.0581181	0.04402903722	47769.32	103.3330449	73.25929802
VSX		1468496.12	140955.9898	9.598662731	10461.72	100.7175222	0.0742197619
All		1480732.36	777.801684	0.05252817491	50908.56408	103.5604782	65.45185634

Run 2
Touched         Average         Stddev          % of Average     Speedup        %Speedup        Speedup/Stddev
None		1773836.72	868.7485496	0.0489756774	-2374.68	99.86630645	-2.733449168
FPU		1564397.8	688.6031113	0.04401713626	21650.48	101.4033717	31.44115913
FPU + VEC	1484855.48	905.2225623	0.06096368128	33020.52	102.274399	36.47779162
FPU + VSX	1486762.64	933.4386234	0.06278329831	48576.48	103.3776212	52.04035786
VEC		1571551.44	785.1688538	0.04996138426	7980.44 	100.5103983	10.16397933
VEC + VSX	1480887.72	574.0000725	0.03876053969	49535.16	103.4607239	86.29817725
VSX		1489902.32	546.0581355	0.03665059972	35301.64	102.4268956	64.64813489
All		1480020.88	733.4377717	0.04955590705	54243.28	103.8044699	73.95757636

Run 3
Touched         Average         Stddev          % of Average    Speedup         %Speedup        Speedup/Stddev
None		1766262.8	614.1256934	0.03476978021	-5233.36	99.70457966	-8.521643136
FPU		1565494.04	627.6075064	0.04009006041	22975.6 	101.4894862	36.60823009
FPU + VEC	1484286.4	569.3538049	0.03835875643	34148.76	102.3548634	59.97810098
FPU + VSX	1486067.76	847.4846952	0.0570286711	45883.84	103.1859709	54.14120191
VEC		1570977.16	860.8764485	0.05479878832	11356.4 	100.7281514	13.1916723
VEC + VSX	1480634.88	912.5305617	0.06163103234	48774.88	103.4064001	53.45013312
VSX		1488969.72	697.1188532	0.04681887374	29984.4 	102.0551543	43.01189082
All		1479573.16	681.8953286	0.04608730052	47822.32	103.3401286	70.13146739

Run 4
Touched         Average         Stddev          % of Average    Speedup         %Speedup        Speedup/Stddev
None		1773258.28	1230.022665	0.06936511613	-252.88 	99.98574128	-0.2055897075
FPU		1564657.04	665.6801021	0.04254479321	20985.88	101.3594787	31.52547287
FPU + VEC	1485552 	542.697721	0.03653172161	34167.56	102.3541358	62.95873132
FPU + VSX	1487035.84	659.5565412	0.04435377571	44355.44	103.074516	67.25039815
VEC		1570597.04	726.2013259	0.0462372784	10325.4 	100.6617694	14.21837118
VEC + VSX	1480685.84	874.2851391	0.05904595799	49180.12	103.4355518	56.25180825
VSX		1489545.44	718.5865991	0.0482420059	34501.6 	102.3711725	48.01314141
All		1480782.08	702.6882445	0.04745385928	49976.52	103.4928939	71.12189565

Compared to the two runs done under KVM, these are so much more consistent. I
can't explain Run 1 VSX result, there are a few possibilities. Based on all
the other results I'm seeing being so much more consistent, I'm liking the
effect bare metal.

To add fuel to the green fire, the lack of speedup on the None case is
expected, the optimisation would not be used.


> 
> >   
> > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > > ---
> > > These patches need to be applied on to of my rework of FPU/VMX/VSX
> > > switching: https://patchwork.ozlabs.org/patch/589703/
> > > 
> > > I left in some of my comments indicating if functions are called from C or
> > > not. Looking at them now, they might be a bit much, let me know what you
> > > think.    
> > 
> > I think that's ok, although they are likely to get stale quickly.
> >   
> > > 
> > > Tested 64 bit BE and LE under KVM, not sure how I can test 32bit.
> > > 
> > > 
> > >  arch/powerpc/include/asm/ppc_asm.h | 63 ++++++++++++++++++++++++++++++--------
> > >  arch/powerpc/kernel/tm.S           |  6 ++--
> > >  arch/powerpc/kernel/vector.S       | 20 +++++++++---
> > >  3 files changed, 70 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> > > index 499d9f8..5ba69ed 100644
> > > --- a/arch/powerpc/include/asm/ppc_asm.h
> > > +++ b/arch/powerpc/include/asm/ppc_asm.h
> > > @@ -110,18 +110,57 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
> > >  #define REST_16FPRS(n, base)  	  REST_8FPRS(n, base); REST_8FPRS(n+8, base)
> > >  #define REST_32FPRS(n, base)  	  REST_16FPRS(n, base); REST_16FPRS(n+16, base)
> > >  
> > > -#define SAVE_VR(n,b,base)  	  li b,16*(n);  stvx n,base,b
> > > -#define SAVE_2VRS(n,b,base)  	  SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
> > > -#define SAVE_4VRS(n,b,base)  	  SAVE_2VRS(n,b,base); SAVE_2VRS(n+2,b,base)
> > > -#define SAVE_8VRS(n,b,base)  	  SAVE_4VRS(n,b,base); SAVE_4VRS(n+4,b,base)
> > > -#define SAVE_16VRS(n,b,base)  	  SAVE_8VRS(n,b,base); SAVE_8VRS(n+8,b,base)
> > > -#define SAVE_32VRS(n,b,base)  	  SAVE_16VRS(n,b,base); SAVE_16VRS(n+16,b,base)
> > > -#define REST_VR(n,b,base)  	  li b,16*(n); lvx n,base,b
> > > -#define REST_2VRS(n,b,base)  	  REST_VR(n,b,base); REST_VR(n+1,b,base)
> > > -#define REST_4VRS(n,b,base)  	  REST_2VRS(n,b,base); REST_2VRS(n+2,b,base)
> > > -#define REST_8VRS(n,b,base)  	  REST_4VRS(n,b,base); REST_4VRS(n+4,b,base)
> > > -#define REST_16VRS(n,b,base)  	  REST_8VRS(n,b,base); REST_8VRS(n+8,b,base)
> > > -#define REST_32VRS(n,b,base)  	  REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)    
> > 
> > Can you use consistent names between off and reg? in the below
> >   
> > > +#define __SAVE_4VRS(n,off0,off1,off2,off3,base) \
> > > +  	  stvx n,base,off0; \
> > > +  	  stvx n+1,base,off1; \
> > > +  	  stvx n+2,base,off2; \
> > > +  	  stvx n+3,base,off3
> > > +
> > > +/* Restores the base for the caller */    
> > 
> > Can you make this:
> > /* Base: non-volatile, reg[0-4]: volatile */
> >   
> > > +#define SAVE_32VRS(reg0,reg1,reg2,reg3,reg4,base) \
> > > +  	  addi reg4,base,64; \
> > > +  	  li reg0,0; li reg1,16; li reg2,32; li reg3,48; \
> > > +  	  __SAVE_4VRS(0,reg0,reg1,reg2,reg3,base); \
> > > +  	  addi base,base,128; \
> > > +  	  __SAVE_4VRS(4,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  addi reg4,reg4,128; \
> > > +  	  __SAVE_4VRS(8,reg0,reg1,reg2,reg3,base); \
> > > +  	  addi base,base,128; \
> > > +  	  __SAVE_4VRS(12,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  addi reg4,reg4,128; \
> > > +  	  __SAVE_4VRS(16,reg0,reg1,reg2,reg3,base); \
> > > +  	  addi base,base,128; \
> > > +  	  __SAVE_4VRS(20,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  addi reg4,reg4,128; \
> > > +  	  __SAVE_4VRS(24,reg0,reg1,reg2,reg3,base); \
> > > +  	  __SAVE_4VRS(28,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  subi base,base,384    
> > 
> > You can swap these last two lines which will make base reuse quicker
> > later.  Although that might not be needed.
> >   
> > > +#define __REST_4VRS(n,off0,off1,off2,off3,base) \
> > > +  	  lvx n,base,off0; \
> > > +  	  lvx n+1,base,off1; \
> > > +  	  lvx n+2,base,off2; \
> > > +  	  lvx n+3,base,off3
> > > +
> > > +/* Restores the base for the caller */
> > > +#define REST_32VRS(reg0,reg1,reg2,reg3,reg4,base) \
> > > +  	  addi reg4,base,64; \
> > > +  	  li reg0,0; li reg1,16; li reg2,32; li reg3,48; \
> > > +  	  __REST_4VRS(0,reg0,reg1,reg2,reg3,base); \
> > > +  	  addi base,base,128; \
> > > +  	  __REST_4VRS(4,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  addi reg4,reg4,128; \
> > > +  	  __REST_4VRS(8,reg0,reg1,reg2,reg3,base); \
> > > +  	  addi base,base,128; \
> > > +  	  __REST_4VRS(12,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  addi reg4,reg4,128; \
> > > +  	  __REST_4VRS(16,reg0,reg1,reg2,reg3,base); \
> > > +  	  addi base,base,128; \
> > > +  	  __REST_4VRS(20,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  addi reg4,reg4,128; \
> > > +  	  __REST_4VRS(24,reg0,reg1,reg2,reg3,base); \
> > > +  	  __REST_4VRS(28,reg0,reg1,reg2,reg3,reg4); \
> > > +  	  subi base,base,384
> > >  
> > >  #ifdef __BIG_ENDIAN__
> > >  #define STXVD2X_ROT(n,b,base)  	  	> STXVD2X(n,b,base)
> > > diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> > > index bf8f34a..81e1305 100644
> > > --- a/arch/powerpc/kernel/tm.S
> > > +++ b/arch/powerpc/kernel/tm.S
> > > @@ -96,6 +96,8 @@ _GLOBAL(tm_abort)
> > >   * they will abort back to the checkpointed state we save out here.
> > >   *
> > >   * Call with IRQs off, stacks get all out of sync for some periods in here!
> > > + *
> > > + * Is called from C
> > >   */
> > >  _GLOBAL(tm_reclaim)
> > >    	  mfcr  	  r6
> > > @@ -151,7 +153,7 @@ _GLOBAL(tm_reclaim)
> > >    	  beq  	  dont_backup_vec
> > >  
> > >    	  addi  	  r7, r3, THREAD_TRANSACT_VRSTATE
> > > -  	  SAVE_32VRS(0, r6, r7)  	  /* r6 scratch, r7 transact vr state */
> > > +  	  SAVE_32VRS(r6,r8,r9,r10,r11,r7)  	  /* r6,r8,r9,r10,r11 scratch, r7 transact vr state */    
> > 
> > Line wrapping here.
> >   
> > >    	  mfvscr  	  v0
> > >    	  li  	  r6, VRSTATE_VSCR
> > >    	  stvx  	  v0, r7, r6
> > > @@ -361,7 +363,7 @@ _GLOBAL(__tm_recheckpoint)
> > >    	  li  	  r5, VRSTATE_VSCR
> > >    	  lvx  	  v0, r8, r5
> > >    	  mtvscr  	  v0
> > > -  	  REST_32VRS(0, r5, r8)  	  	  	  /* r5 scratch, r8 ptr */
> > > +  	  REST_32VRS(r5,r6,r9,r10,r11,r8)  	  	  	  /* r5,r6,r9,r10,r11 scratch, r8 ptr */    
> > 
> > wrapping here too
> > 
> >   
> > >  dont_restore_vec:
> > >    	  ld  	  r5, THREAD_VRSAVE(r3)
> > >    	  mtspr  	  SPRN_VRSAVE, r5
> > > diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> > > index 1c2e7a3..8d587fb 100644
> > > --- a/arch/powerpc/kernel/vector.S
> > > +++ b/arch/powerpc/kernel/vector.S
> > > @@ -13,6 +13,8 @@
> > >   * This is similar to load_up_altivec but for the transactional version of the
> > >   * vector regs.  It doesn't mess with the task MSR or valid flags.
> > >   * Furthermore, VEC laziness is not supported with TM currently.
> > > + *
> > > + * Is called from C
> > >   */
> > >  _GLOBAL(do_load_up_transact_altivec)
> > >    	  mfmsr  	  r6
> > > @@ -27,7 +29,7 @@ _GLOBAL(do_load_up_transact_altivec)
> > >    	  lvx  	  v0,r10,r3
> > >    	  mtvscr  	  v0
> > >    	  addi  	  r10,r3,THREAD_TRANSACT_VRSTATE
> > > -  	  REST_32VRS(0,r4,r10)
> > > +  	  REST_32VRS(r4,r5,r6,r7,r8,r10)
> > >  
> > >    	  blr
> > >  #endif
> > > @@ -35,20 +37,24 @@ _GLOBAL(do_load_up_transact_altivec)
> > >  /*
> > >   * Load state from memory into VMX registers including VSCR.
> > >   * Assumes the caller has enabled VMX in the MSR.
> > > + *
> > > + * Is called from C
> > >   */
> > >  _GLOBAL(load_vr_state)
> > >    	  li  	  r4,VRSTATE_VSCR
> > >    	  lvx  	  v0,r4,r3
> > >    	  mtvscr  	  v0
> > > -  	  REST_32VRS(0,r4,r3)
> > > +  	  REST_32VRS(r4,r5,r6,r7,r8,r3)
> > >    	  blr
> > >  
> > >  /*
> > >   * Store VMX state into memory, including VSCR.
> > >   * Assumes the caller has enabled VMX in the MSR.
> > > + *
> > > + * NOT called from C
> > >   */
> > >  _GLOBAL(store_vr_state)
> > > -  	  SAVE_32VRS(0, r4, r3)
> > > +  	  SAVE_32VRS(r4,r5,r6,r7,r8,r3)
> > >    	  mfvscr  	  v0
> > >    	  li  	  r4, VRSTATE_VSCR
> > >    	  stvx  	  v0, r4, r3
> > > @@ -63,6 +69,8 @@ _GLOBAL(store_vr_state)
> > >   *
> > >   * Note that on 32-bit this can only use registers that will be
> > >   * restored by fast_exception_return, i.e. r3 - r6, r10 and r11.
> > > + *
> > > + * NOT called from C
> > >   */
> > >  _GLOBAL(load_up_altivec)
> > >    	  mfmsr  	  r5  	  	  	  /* grab the current MSR */
> > > @@ -101,13 +109,15 @@ _GLOBAL(load_up_altivec)
> > >    	  stw  	  r4,THREAD_USED_VR(r5)
> > >    	  lvx  	  v0,r10,r6
> > >    	  mtvscr  	  v0
> > > -  	  REST_32VRS(0,r4,r6)
> > > +  	  REST_32VRS(r3,r4,r5,r10,r11,r6)
> > >    	  /* restore registers and return */
> > >    	  blr
> > >  
> > >  /*
> > >   * save_altivec(tsk)
> > >   * Save the vector registers to its thread_struct
> > > + *
> > > + * Is called from C
> > >   */
> > >  _GLOBAL(save_altivec)
> > >    	  addi  	  r3,r3,THREAD  	  	> /* want THREAD of task */
> > > @@ -116,7 +126,7 @@ _GLOBAL(save_altivec)
> > >    	  PPC_LCMPI  	  0,r7,0
> > >    	  bne  	  2f
> > >    	  addi  	  r7,r3,THREAD_VRSTATE
> > > -2:  	  SAVE_32VRS(0,r4,r7)
> > > +2:  	  SAVE_32VRS(r4,r5,r6,r8,r9,r7)
> > >    	  mfvscr  	  v0
> > >    	  li  	  r4,VRSTATE_VSCR
> > >    	  stvx  	  v0,r4,r7    
> 
