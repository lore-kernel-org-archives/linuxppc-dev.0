Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1DA7E2C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 14:12:20 +1000 (EST)
Message-ID: <51F1F6E3.7040502@asianux.com>
Date: Fri, 26 Jul 2013 12:11:15 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Suggestion] powerpc: xmon: about 'longjmp' related warning.
References: <51ECD91D.7090903@asianux.com> <20130723135809.GG31944@concordia>
 <51EF21FD.9020509@asianux.com>
In-Reply-To: <51EF21FD.9020509@asianux.com>
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

On 07/24/2013 08:38 AM, Chen Gang wrote:
> On 07/23/2013 09:58 PM, Michael Ellerman wrote:
>> On Mon, Jul 22, 2013 at 03:02:53PM +0800, Chen Gang wrote:
>>> Hello Maintainers:
>>>
>>> With allmodconfig and EXTRA_CFLAGS=-W", it reports warnings below:
>>
>>>
>>> arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>> arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>
>> In both these cases we are inside the body of a for loop and we do a
>> if (setjmp) / else block. Although looking at the source the value of i
>> is not modified by the setjmp, I guess it's possible that the compiler
>> might reorder the increment of i inside the setjmp and loose the value
>> when we longjmp.
>>
> 
> I should continue to confirm the details based on your valuable
> information, thanks.
> 
> 


For stop_spus() and restart_spus(), at least now, the related warnings
are not issue: the variable 'i' is stored in stack "120(r1)".

The related warning:

  arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
  arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]

The related source code:

3024 static void stop_spus(void)
3025 {
3026         struct spu *spu;
3027         int i;
3028         u64 tmp;
3029 
3030         for (i = 0; i < XMON_NUM_SPUS; i++) { /* XMON_NUM_SPUS == 16 */
3031                 if (!spu_info[i].spu)
3032                         continue;
3033 
3034                 if (setjmp(bus_error_jmp) == 0) {
3035                         catch_memory_errors = 1;
3036                         sync();
3037 
3038                         spu = spu_info[i].spu;
3039 
3040                         spu_info[i].saved_spu_runcntl_RW =
3041                                 in_be32(&spu->problem->spu_runcntl_RW);
3042 
3043                         tmp = spu_mfc_sr1_get(spu);
3044                         spu_info[i].saved_mfc_sr1_RW = tmp;
3045 
3046                         tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
3047                         spu_mfc_sr1_set(spu, tmp);
3048 
3049                         sync();
3050                         __delay(200);
3051 
3052                         spu_info[i].stopped_ok = 1;
3053 
3054                         printf("Stopped spu %.2d (was %s)\n", i,
3055                                         spu_info[i].saved_spu_runcntl_RW ?
3056                                         "running" : "stopped");
3057                 } else {
3058                         catch_memory_errors = 0;
3059                         printf("*** Error stopping spu %.2d\n", i);
3060                 }
3061                 catch_memory_errors = 0;
3062         }
3063 }
3064 



The related disassembly code:

  "make ARCH=powerpc EXTRA_CFLAGS=-W"
  "powerpc64-linux-gnu-objdump -d vmlinux.o > vmlinux.S"
  "gcc version 4.7.1 20120606 (Red Hat 4.7.1-0.1.20120606) (GCC)"
  "GNU objdump version 2.23.51.0.3-1.fc16 20120918"

c00000000007cfd0 <.stop_spus>:
/* { */
c00000000007cfd0:	7c 08 02 a6 	mflr    r0
c00000000007cfd4:	fb c1 ff f0 	std     r30,-16(r1)
c00000000007cfd8:	fb e1 ff f8 	std     r31,-8(r1)
c00000000007cfdc:	3d 22 00 0f 	addis   r9,r2,15
c00000000007cfe0:	39 29 3e 10 	addi    r9,r9,15888
c00000000007cfe4:	3d 02 ff d4 	addis   r8,r2,-44
c00000000007cfe8:	39 29 21 50 	addi    r9,r9,8528
c00000000007cfec:	3d 42 ff d4 	addis   r10,r2,-44
c00000000007cff0:	39 08 83 f8 	addi    r8,r8,-31752
c00000000007cff4:	39 4a 83 d8 	addi    r10,r10,-31784
c00000000007cff8:	f8 01 00 10 	std     r0,16(r1)
c00000000007cffc:	f8 21 ff 51 	stdu    r1,-176(r1)
c00000000007d000:	f9 21 00 70 	std     r9,112(r1)
c00000000007d004:	39 20 00 00 	li      r9,0
c00000000007d008:	f9 21 00 78 	std     r9,120(r1)	; i = 0;
c00000000007d00c:	f9 01 00 88 	std     r8,136(r1)
c00000000007d010:	f9 41 00 90 	std     r10,144(r1)
c00000000007d014:	48 00 01 28 	b       c00000000007d13c <.stop_spus+0x16c>
c00000000007d018:	60 00 00 00 	nop
c00000000007d01c:	60 00 00 00 	nop


/*	 	if (setjmp(bus_error_jmp) == 0) { */
c00000000007d020:	3d 22 00 0f 	addis   r9,r2,15
c00000000007d024:	39 40 00 01 	li      r10,1
c00000000007d028:	39 29 3e 10 	addi    r9,r9,15888
c00000000007d02c:	91 49 20 c0 	stw     r10,8384(r9)
c00000000007d030:	7c 00 04 ac 	sync    
c00000000007d034:	4c 00 01 2c 	isync
c00000000007d038:	e9 01 00 80 	ld      r8,128(r1)
c00000000007d03c:	eb e8 00 00 	ld      r31,0(r8)
c00000000007d040:	e9 3f 00 20 	ld      r9,32(r31)
c00000000007d044:	7c 00 04 ac 	sync    
c00000000007d048:	81 29 40 1c 	lwz     r9,16412(r9)
c00000000007d04c:	0c 09 00 00 	twi     0,r9,0
c00000000007d050:	4c 00 01 2c 	isync
c00000000007d054:	91 28 00 10 	stw     r9,16(r8)
c00000000007d058:	3d 22 00 0f 	addis   r9,r2,15
c00000000007d05c:	3b c9 f5 e8 	addi    r30,r9,-2584
c00000000007d060:	7f e3 fb 78 	mr      r3,r31
c00000000007d064:	e9 3e 00 00 	ld      r9,0(r30)
c00000000007d068:	e9 29 00 60 	ld      r9,96(r9)
c00000000007d06c:	e9 49 00 00 	ld      r10,0(r9)
c00000000007d070:	f8 41 00 28 	std     r2,40(r1)
c00000000007d074:	7d 49 03 a6 	mtctr   r10
c00000000007d078:	e8 49 00 08 	ld      r2,8(r9)
c00000000007d07c:	4e 80 04 21 	bctrl
c00000000007d080:	e8 41 00 28 	ld      r2,40(r1)
c00000000007d084:	e9 01 00 80 	ld      r8,128(r1)
c00000000007d088:	e9 3e 00 00 	ld      r9,0(r30)
c00000000007d08c:	f8 68 00 08 	std     r3,8(r8)
c00000000007d090:	7c 64 1b 78 	mr      r4,r3
c00000000007d094:	78 84 d0 42 	rldicl  r4,r4,58,1
c00000000007d098:	7f e3 fb 78 	mr      r3,r31
c00000000007d09c:	78 84 30 00 	rotldi  r4,r4,6
c00000000007d0a0:	e9 29 00 58 	ld      r9,88(r9)
c00000000007d0a4:	e9 49 00 00 	ld      r10,0(r9)
c00000000007d0a8:	f8 41 00 28 	std     r2,40(r1)
c00000000007d0ac:	7d 49 03 a6 	mtctr   r10
c00000000007d0b0:	e8 49 00 08 	ld      r2,8(r9)
c00000000007d0b4:	4e 80 04 21 	bctrl
c00000000007d0b8:	e8 41 00 28 	ld      r2,40(r1)
c00000000007d0bc:	7c 00 04 ac 	sync    
c00000000007d0c0:	4c 00 01 2c 	isync
c00000000007d0c4:	38 60 00 c8 	li      r3,200
c00000000007d0c8:	4b fa 01 e9 	bl      c00000000001d2b0 <.__delay>	; __delay(200)
c00000000007d0cc:	60 00 00 00 	nop
c00000000007d0d0:	e9 01 00 80 	ld      r8,128(r1)
c00000000007d0d4:	39 40 00 01 	li      r10,1
c00000000007d0d8:	81 28 00 10 	lwz     r9,16(r8)
c00000000007d0dc:	99 48 00 20 	stb     r10,32(r8)
c00000000007d0e0:	3d 02 ff d4 	addis   r8,r2,-44
c00000000007d0e4:	38 a8 83 c8 	addi    r5,r8,-31800
c00000000007d0e8:	2f 89 00 00 	cmpwi   cr7,r9,0
c00000000007d0ec:	40 9e 00 0c 	bne-    cr7,c00000000007d0f8 <.stop_spus+0x128>
c00000000007d0f0:	3d 22 ff d4 	addis   r9,r2,-44
c00000000007d0f4:	38 a9 83 d0 	addi    r5,r9,-31792
c00000000007d0f8:	e8 61 00 90 	ld      r3,144(r1)
c00000000007d0fc:	e8 81 00 78 	ld      r4,120(r1)		; 120(r1) = i
c00000000007d100:	48 00 67 41 	bl      c000000000083840 <.xmon_printf>
c00000000007d104:	60 00 00 00 	nop


/* 		catch_memory_errors = 0; */
c00000000007d108:	3d 22 00 0f 	addis   r9,r2,15
c00000000007d10c:	39 40 00 00 	li      r10,0
c00000000007d110:	39 29 3e 10 	addi    r9,r9,15888
c00000000007d114:	91 49 20 c0 	stw     r10,8384(r9)


/* 	for (i = 0; i < XMON_NUM_SPUS; i++) { */
c00000000007d118:	e9 01 00 78 	ld      r8,120(r1)		; 120(r1) = i;
c00000000007d11c:	39 28 00 01 	addi    r9,r8,1			; i++
c00000000007d120:	2f 89 00 10 	cmpwi   cr7,r9,16		; i < XMON_NUM_SPUS
c00000000007d124:	7d 29 07 b4 	extsw   r9,r9
c00000000007d128:	f9 21 00 78 	std     r9,120(r1)		; 120(r1) = i;
c00000000007d12c:	e9 21 00 70 	ld      r9,112(r1)		;
c00000000007d130:	39 29 00 28 	addi    r9,r9,40		; 112(r1) =  [i] for spu_info;
c00000000007d134:	f9 21 00 70 	std     r9,112(r1)		;
c00000000007d138:	41 9e 00 58 	beq-    cr7,c00000000007d190 <.stop_spus+0x1c0>

/* 		if (!spu_info[i].spu) */
/*			continue; */
c00000000007d13c:	e9 01 00 70 	ld      r8,112(r1)
c00000000007d140:	3d 42 00 0f 	addis   r10,r2,15
c00000000007d144:	38 6a 5e 18 	addi    r3,r10,24088
c00000000007d148:	e9 28 00 00 	ld      r9,0(r8)
c00000000007d14c:	f9 01 00 80 	std     r8,128(r1)
c00000000007d150:	2f a9 00 00 	cmpdi   cr7,r9,0				
c00000000007d154:	41 9e ff c4 	beq+    cr7,c00000000007d118 <.stop_spus+0x148>

/* 		if (setjmp(bus_error_jmp) == 0) { */
c00000000007d158:	4b fa 44 99 	bl      c0000000000215f0 <.setjmp>
c00000000007d15c:	60 00 00 00 	nop
c00000000007d160:	2f a3 00 00 	cmpdi   cr7,r3,0
c00000000007d164:	e8 81 00 78 	ld      r4,120(r1)	; 120(r1) = i for 2nd param of printf in exception processing after setjmp.
c00000000007d168:	e8 61 00 88 	ld      r3,136(r1)
c00000000007d16c:	41 9e fe b4 	beq+    cr7,c00000000007d020 <.stop_spus+0x50>

/* 		} else { */
c00000000007d170:	3d 42 00 0f 	addis   r10,r2,15
c00000000007d174:	39 00 00 00 	li      r8,0
c00000000007d178:	39 4a 3e 10 	addi    r10,r10,15888
c00000000007d17c:	91 0a 20 c0 	stw     r8,8384(r10)				/* catch_memory_errors = 0; */
c00000000007d180:	48 00 66 c1 	bl      c000000000083840 <.xmon_printf>		/* called with correct i */
c00000000007d184:	60 00 00 00 	nop
c00000000007d188:	4b ff ff 80 	b       c00000000007d108 <.stop_spus+0x138>
c00000000007d18c:	60 00 00 00 	nop
/*	 } */

c00000000007d190:	38 21 00 b0 	addi    r1,r1,176
c00000000007d194:	e8 01 00 10 	ld      r0,16(r1)
c00000000007d198:	eb c1 ff f0 	ld      r30,-16(r1)
c00000000007d19c:	eb e1 ff f8 	ld      r31,-8(r1)
c00000000007d1a0:	7c 08 03 a6 	mtlr    r0
c00000000007d1a4:	4e 80 00 20 	blr
c00000000007d1a8:	60 00 00 00 	nop
c00000000007d1ac:	60 00 00 00 	nop
/* } */


The related assembly code (they really save and restore 'r1'):

_GLOBAL(setjmp)
        mflr    r0
        PPC_STL r0,0(r3)
        PPC_STL r1,SZL(r3)
        PPC_STL r2,2*SZL(r3)
        mfcr    r0
        PPC_STL r0,3*SZL(r3)
        PPC_STL r13,4*SZL(r3)
        PPC_STL r14,5*SZL(r3)
        PPC_STL r15,6*SZL(r3)
        PPC_STL r16,7*SZL(r3)
        PPC_STL r17,8*SZL(r3)
        PPC_STL r18,9*SZL(r3)
        PPC_STL r19,10*SZL(r3)
        PPC_STL r20,11*SZL(r3)
        PPC_STL r21,12*SZL(r3)
        PPC_STL r22,13*SZL(r3)
        PPC_STL r23,14*SZL(r3)
        PPC_STL r24,15*SZL(r3)
        PPC_STL r25,16*SZL(r3)
        PPC_STL r26,17*SZL(r3)
        PPC_STL r27,18*SZL(r3)
        PPC_STL r28,19*SZL(r3)
        PPC_STL r29,20*SZL(r3)
        PPC_STL r30,21*SZL(r3)
        PPC_STL r31,22*SZL(r3)
        li      r3,0
        blr

_GLOBAL(longjmp)
        PPC_LCMPI r4,0
        bne     1f
        li      r4,1
1:      PPC_LL  r13,4*SZL(r3)
        PPC_LL  r14,5*SZL(r3)
        PPC_LL  r15,6*SZL(r3)
        PPC_LL  r16,7*SZL(r3)
        PPC_LL  r17,8*SZL(r3)
        PPC_LL  r18,9*SZL(r3)
        PPC_LL  r19,10*SZL(r3)
        PPC_LL  r20,11*SZL(r3)
        PPC_LL  r21,12*SZL(r3)
        PPC_LL  r22,13*SZL(r3)
        PPC_LL  r23,14*SZL(r3)
        PPC_LL  r24,15*SZL(r3)
        PPC_LL  r25,16*SZL(r3)
        PPC_LL  r26,17*SZL(r3)
        PPC_LL  r27,18*SZL(r3)
        PPC_LL  r28,19*SZL(r3)
        PPC_LL  r29,20*SZL(r3)
        PPC_LL  r30,21*SZL(r3)
        PPC_LL  r31,22*SZL(r3)
        PPC_LL  r0,3*SZL(r3)
        mtcrf   0x38,r0
        PPC_LL  r0,0(r3)
        PPC_LL  r1,SZL(r3)
        PPC_LL  r2,2*SZL(r3)
        mtlr    r0
        mr      r3,r4
        blr




The same to resetart_spus()


3065 static void restart_spus(void)
3066 {
3067         struct spu *spu;
3068         int i;
3069 
3070         for (i = 0; i < XMON_NUM_SPUS; i++) {
3071                 if (!spu_info[i].spu)
3072                         continue;
3073 
3074                 if (!spu_info[i].stopped_ok) {
3075                         printf("*** Error, spu %d was not successfully stopped"
3076                                         ", not restarting\n", i);
3077                         continue;
3078                 }
3079 
3080                 if (setjmp(bus_error_jmp) == 0) {
3081                         catch_memory_errors = 1;
3082                         sync();
3083 
3084                         spu = spu_info[i].spu;
3085                         spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
3086                         out_be32(&spu->problem->spu_runcntl_RW,
3087                                         spu_info[i].saved_spu_runcntl_RW);
3088 
3089                         sync();
3090                         __delay(200);
3091 
3092                         printf("Restarted spu %.2d\n", i);
3093                 } else {
3094                         catch_memory_errors = 0;
3095                         printf("*** Error restarting spu %.2d\n", i);
3096                 }
3097                 catch_memory_errors = 0;
3098         }
3099 }
3100 

c00000000007d1b0 <.restart_spus>:
/* { */
c00000000007d1b0:	7c 08 02 a6 	mflr    r0
c00000000007d1b4:	fb e1 ff f8 	std     r31,-8(r1)
c00000000007d1b8:	3d 22 00 0f 	addis   r9,r2,15
c00000000007d1bc:	3c e2 ff d4 	addis   r7,r2,-44
c00000000007d1c0:	39 29 3e 10 	addi    r9,r9,15888
c00000000007d1c4:	3d 02 ff d4 	addis   r8,r2,-44
c00000000007d1c8:	39 29 21 50 	addi    r9,r9,8528
c00000000007d1cc:	3d 42 ff d4 	addis   r10,r2,-44
c00000000007d1d0:	38 e7 84 70 	addi    r7,r7,-31632
c00000000007d1d4:	39 08 84 58 	addi    r8,r8,-31656
c00000000007d1d8:	f8 01 00 10 	std     r0,16(r1)
c00000000007d1dc:	39 4a 84 18 	addi    r10,r10,-31720
c00000000007d1e0:	f8 21 ff 51 	stdu    r1,-176(r1)
c00000000007d1e4:	f9 21 00 70 	std     r9,112(r1)
c00000000007d1e8:	39 20 00 00 	li      r9,0
c00000000007d1ec:	f9 21 00 78 	std     r9,120(r1)		; i = 0;
c00000000007d1f0:	f8 e1 00 88 	std     r7,136(r1)
c00000000007d1f4:	f9 01 00 98 	std     r8,152(r1)
c00000000007d1f8:	f9 41 00 90 	std     r10,144(r1)
c00000000007d1fc:	48 00 00 34 	b       c00000000007d230 <.restart_spus+0x80>

/*		if (!spu_info[i].stopped_ok) { */
/*			printf(....); */
/*			continue; */
c00000000007d200:	e8 61 00 90 	ld      r3,144(r1)
c00000000007d204:	48 00 66 3d 	bl      c000000000083840 <.xmon_printf>
c00000000007d208:	60 00 00 00 	nop

/*	for (i = 0; i < XMON_NUM_SPUS; i++) { */
c00000000007d20c:	e9 01 00 78 	ld      r8,120(r1)
c00000000007d210:	39 28 00 01 	addi    r9,r8,1		; i++
c00000000007d214:	2f 89 00 10 	cmpwi   cr7,r9,16	; i < XMON_NUM_SPUS
c00000000007d218:	7d 29 07 b4 	extsw   r9,r9
c00000000007d21c:	f9 21 00 78 	std     r9,120(r1)
c00000000007d220:	e9 21 00 70 	ld      r9,112(r1)
c00000000007d224:	39 29 00 28 	addi    r9,r9,40
c00000000007d228:	f9 21 00 70 	std     r9,112(r1)
c00000000007d22c:	41 9e 01 0c 	beq-    cr7,c00000000007d338 <.restart_spus+0x188>

/*		if (!spu_info[i].spu) */
/*			continue; */
c00000000007d230:	e9 01 00 70 	ld      r8,112(r1)
c00000000007d234:	3d 42 00 0f 	addis   r10,r2,15
c00000000007d238:	e8 81 00 78 	ld      r4,120(r1) 	; i as 2nd parameter for xmon_printf().
c00000000007d23c:	38 6a 5e 18 	addi    r3,r10,24088
c00000000007d240:	e9 28 00 00 	ld      r9,0(r8)
c00000000007d244:	f9 01 00 80 	std     r8,128(r1)
c00000000007d248:	2f a9 00 00 	cmpdi   cr7,r9,0
c00000000007d24c:	41 9e ff c0 	beq+    cr7,c00000000007d20c <.restart_spus+0x5c>

/*		if (!spu_info[i].stopped_ok) { */
c00000000007d250:	89 28 00 20 	lbz     r9,32(r8)
c00000000007d254:	2f 89 00 00 	cmpwi   cr7,r9,0
c00000000007d258:	41 9e ff a8 	beq+    cr7,c00000000007d200 <.restart_spus+0x50>
/*		} */

/*		if (setjmp(bus_error_jmp) == 0) { */
c00000000007d25c:	4b fa 43 95 	bl      c0000000000215f0 <.setjmp>
c00000000007d260:	60 00 00 00 	nop
c00000000007d264:	2f a3 00 00 	cmpdi   cr7,r3,0
c00000000007d268:	e8 81 00 78 	ld      r4,120(r1)	; i as 2nd parameter for xmon_printf() after setjmp().
c00000000007d26c:	e8 61 00 88 	ld      r3,136(r1)
c00000000007d270:	40 9e 00 e0 	bne-    cr7,c00000000007d350 <.restart_spus+0x1a0>

c00000000007d274:	3d 22 00 0f 	addis   r9,r2,15
c00000000007d278:	39 40 00 01 	li      r10,1
c00000000007d27c:	39 29 3e 10 	addi    r9,r9,15888
c00000000007d280:	91 49 20 c0 	stw     r10,8384(r9)
c00000000007d284:	7c 00 04 ac 	sync    
c00000000007d288:	4c 00 01 2c 	isync
c00000000007d28c:	3d 02 00 0f 	addis   r8,r2,15
c00000000007d290:	e9 41 00 80 	ld      r10,128(r1)
c00000000007d294:	39 28 f5 e8 	addi    r9,r8,-2584
c00000000007d298:	eb ea 00 00 	ld      r31,0(r10)
c00000000007d29c:	e8 8a 00 08 	ld      r4,8(r10)
c00000000007d2a0:	e9 29 00 00 	ld      r9,0(r9)
c00000000007d2a4:	7f e3 fb 78 	mr      r3,r31
c00000000007d2a8:	e9 29 00 58 	ld      r9,88(r9)
c00000000007d2ac:	e9 49 00 00 	ld      r10,0(r9)
c00000000007d2b0:	f8 41 00 28 	std     r2,40(r1)
c00000000007d2b4:	7d 49 03 a6 	mtctr   r10
c00000000007d2b8:	e8 49 00 08 	ld      r2,8(r9)
c00000000007d2bc:	4e 80 04 21 	bctrl
c00000000007d2c0:	e8 41 00 28 	ld      r2,40(r1)
c00000000007d2c4:	e9 01 00 80 	ld      r8,128(r1)
c00000000007d2c8:	e9 3f 00 20 	ld      r9,32(r31)
c00000000007d2cc:	81 48 00 10 	lwz     r10,16(r8)
c00000000007d2d0:	7c 00 04 ac 	sync    
c00000000007d2d4:	91 49 40 1c 	stw     r10,16412(r9)
c00000000007d2d8:	39 20 00 01 	li      r9,1
c00000000007d2dc:	99 2d 02 74 	stb     r9,628(r13)
c00000000007d2e0:	7c 00 04 ac 	sync    
c00000000007d2e4:	4c 00 01 2c 	isync
c00000000007d2e8:	38 60 00 c8 	li      r3,200
c00000000007d2ec:	4b f9 ff c5 	bl      c00000000001d2b0 <.__delay>
c00000000007d2f0:	60 00 00 00 	nop
c00000000007d2f4:	e8 61 00 98 	ld      r3,152(r1)
c00000000007d2f8:	e8 81 00 78 	ld      r4,120(r1)
c00000000007d2fc:	48 00 65 45 	bl      c000000000083840 <.xmon_printf>
c00000000007d300:	60 00 00 00 	nop
/*		} */

/*	for (i = 0; i < XMON_NUM_SPUS; i++) { */
c00000000007d304:	e9 01 00 78 	ld      r8,120(r1)
c00000000007d308:	3d 22 00 0f 	addis   r9,r2,15
c00000000007d30c:	39 40 00 00 	li      r10,0
c00000000007d310:	39 29 3e 10 	addi    r9,r9,15888
c00000000007d314:	91 49 20 c0 	stw     r10,8384(r9)		; catch_memory_errors = 0;
c00000000007d318:	39 28 00 01 	addi    r9,r8,1
c00000000007d31c:	2f 89 00 10 	cmpwi   cr7,r9,16		; i < XMON_NUM_SPUS
c00000000007d320:	7d 29 07 b4 	extsw   r9,r9
c00000000007d324:	f9 21 00 78 	std     r9,120(r1)		; i++;
c00000000007d328:	e9 21 00 70 	ld      r9,112(r1)
c00000000007d32c:	39 29 00 28 	addi    r9,r9,40		; [i] for spu_info
c00000000007d330:	f9 21 00 70 	std     r9,112(r1)
c00000000007d334:	40 9e fe fc 	bne+    cr7,c00000000007d230 <.restart_spus+0x80>

/* 	} */
c00000000007d338:	38 21 00 b0 	addi    r1,r1,176
c00000000007d33c:	e8 01 00 10 	ld      r0,16(r1)
c00000000007d340:	eb e1 ff f8 	ld      r31,-8(r1)
c00000000007d344:	7c 08 03 a6 	mtlr    r0
c00000000007d348:	4e 80 00 20 	blr
c00000000007d34c:	60 00 00 00 	nop
/* } */

/*		} else { */
c00000000007d350:	3d 42 00 0f 	addis   r10,r2,15
c00000000007d354:	39 00 00 00 	li      r8,0
c00000000007d358:	39 4a 3e 10 	addi    r10,r10,15888
c00000000007d35c:	91 0a 20 c0 	stw     r8,8384(r10)		; catch_memory_errors = 0;
c00000000007d360:	48 00 64 e1 	bl      c000000000083840 <.xmon_printf>
c00000000007d364:	60 00 00 00 	nop
c00000000007d368:	4b ff ff 9c 	b       c00000000007d304 <.restart_spus+0x154>
c00000000007d36c:	60 00 00 00 	nop



>>> arch/powerpc/xmon/xmon.c:352:48: warning: argument ‘fromipi’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>>
>> This one I can't see, but I assume it's a similar case.
>>
> 
> OK, I should continue for it.
> 
> 
>>> Excuse me, I am not quite sure about it whether can cause issue or not.
>>
>> I've never seen it get stuck in those loops or anything, but I guess
>> it's possible.
>>
> 
> OK, I should make the confirmation.
> 
>> The first thing to do would be to analyse the generated assembler code
>> to determine if there really is any possiblity of the value being
>> clobbered, or if it's just a theoretical bug.
>>
> 
> Thank you for your valuable information again.
> 
> Excuse me, I have to do another things within this month, so I should
> provide the confirmation within next month (2013-08-31), is it OK (no
> reply means OK).
> 
> Welcome any suggestions or completions.
> 
> 
> Thanks.
> 


-- 
Chen Gang
