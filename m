Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10DBADDFDB
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 09:49:55 +1100 (EST)
Date: Wed, 15 Oct 2008 00:49:46 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Message-ID: <20081014224946.GA2503@www.tglx.de>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2008-10-14 16:23:05 [-0500]:

>>Not sure if this is intendent or a gcc bug but with -mno-spe
>>the spe opcodes were not used floating point anymore but
>>for 64bit save/restore for instance.
>
>what code is getting generated for you that is causing issue?
Without the patch do_syslog() looks like this:

|c0025840 <do_syslog>:
|c0025840:       94 21 ff 50     stwu    r1,-176(r1)
|c0025844:       7c 08 02 a6     mflr    r0
|c0025848:       13 21 73 21     evstdd  r25,112(r1)
|c002584c:       13 41 7b 21     evstdd  r26,120(r1)
|c0025850:       7c 9a 23 78     mr      r26,r4
|c0025854:       13 61 83 21     evstdd  r27,128(r1)
|c0025858:       7c bb 2b 78     mr      r27,r5
|c002585c:       13 e1 a3 21     evstdd  r31,160(r1)
|c0025860:       7c 7f 1b 78     mr      r31,r3
|c0025864:       90 01 00 b4     stw     r0,180(r1)
|c0025868:       12 21 33 21     evstdd  r17,48(r1)
|c002586c:       12 41 3b 21     evstdd  r18,56(r1)
|c0025870:       12 61 43 21     evstdd  r19,64(r1)
|c0025874:       12 81 4b 21     evstdd  r20,72(r1)
|c0025878:       12 a1 53 21     evstdd  r21,80(r1)
|c002587c:       12 c1 5b 21     evstdd  r22,88(r1)
|c0025880:       12 e1 63 21     evstdd  r23,96(r1)
|c0025884:       13 01 6b 21     evstdd  r24,104(r1)
|c0025888:       13 81 8b 21     evstdd  r28,136(r1)
|c002588c:       13 a1 93 21     evstdd  r29,144(r1)
|c0025890:       13 c1 9b 21     evstdd  r30,152(r1)
|c0025894:       48 0f 00 b5     bl      c0115948 <cap_syslog>
|c0025898:       7c 79 1b 79     mr.     r25,r3
|c002589c:       40 82 04 54     bne-    c0025cf0 <do_syslog+0x4b0>
|c00258a0:       2b 9f 00 0a     cmplwi  cr7,r31,10
|c00258a4:       41 9d 04 40     bgt-    cr7,c0025ce4 <do_syslog+0x4a4>
|c00258a8:       3d 20 c0 27     lis     r9,-16345
|c00258ac:       57 e0 10 3a     rlwinm  r0,r31,2,0,29
|c00258b0:       39 29 a6 e4     addi    r9,r9,-22812
|c00258b4:       7c 09 00 2e     lwzx    r0,r9,r0
|c00258b8:       7c 00 4a 14     add     r0,r0,r9
|c00258bc:       7c 09 03 a6     mtctr   r0
|c00258c0:       4e 80 04 20     bctr
|c00258c4:       3b e0 00 00     li      r31,0
....

do_syslog() is not the only one.

>>1 files changed, 3 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>>index b7d4c4c..3727e4f 100644
>>--- a/arch/powerpc/Makefile
>>+++ b/arch/powerpc/Makefile
>>@@ -108,7 +108,10 @@ endif
>>KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
>>
>># No SPE instruction when building kernel
>>+# (We use all available options to help semi-broken compilers)
>>KBUILD_CFLAGS += $(call cc-option,-mno-spe)
>>+KBUILD_CFLAGS += $(call cc-option,-mspe=no)
>
>Why does -mno-spe work?
Good question. Without this option and only with -mabi=no-spe the
do_syslog() looks like the following:

|c0025270 <do_syslog>:
|c0025270:       94 21 ff 90     stwu    r1,-112(r1)
|c0025274:       7c 08 02 a6     mflr    r0
|c0025278:       be 21 00 34     stmw    r17,52(r1)
|c002527c:       7c 9a 23 78     mr      r26,r4
|c0025280:       90 01 00 74     stw     r0,116(r1)
|c0025284:       7c bb 2b 78     mr      r27,r5
|c0025288:       7c 7f 1b 78     mr      r31,r3
|c002528c:       48 0e ce c5     bl      c0112150 <cap_syslog>
|c0025290:       7c 79 1b 79     mr.     r25,r3
|c0025294:       40 82 04 54     bne-    c00256e8 <do_syslog+0x478>
|c0025298:       2b 9f 00 0a     cmplwi  cr7,r31,10
|c002529c:       41 9d 04 40     bgt-    cr7,c00256dc <do_syslog+0x46c>
|c00252a0:       3d 20 c0 26     lis     r9,-16346
|c00252a4:       57 e0 10 3a     rlwinm  r0,r31,2,0,29
|c00252a8:       39 29 36 e4     addi    r9,r9,14052
|c00252ac:       7c 09 00 2e     lwzx    r0,r9,r0
|c00252b0:       7c 00 4a 14     add     r0,r0,r9
|c00252b4:       7c 09 03 a6     mtctr   r0
|c00252b8:       4e 80 04 20     bctr
|c00252bc:       3b e0 00 00     li      r31,0
|c00252c0:       48 00 01 c4     b       c0025484 <do_syslog+0x214>
|c00252c4:       2f 9a 00 00     cmpwi   cr7,r26,0
|c00252c8:       41 9e 04 14     beq-    cr7,c00256dc <do_syslog+0x46c>
|c00252cc:       2f 9b 00 00     cmpwi   cr7,r27,0
|c00252d0:       41 9c 04 0c     blt-    cr7,c00256dc <do_syslog+0x46c>
|c00252d4:       41 9e 04 14     beq-    cr7,c00256e8 <do_syslog+0x478>
|c00252d8:       80 02 03 3c     lwz     r0,828(r2)
|c00252dc:       7f 9a 00 40     cmplw   cr7,r26,r0
|c00252e0:       41 9d 04 04     bgt-    cr7,c00256e4 <do_syslog+0x474>
|c00252e4:       7c 1a 00 50     subf    r0,r26,r0
|c00252e8:       39 3b ff ff     addi    r9,r27,-1
|c00252ec:       7f 89 00 40     cmplw   cr7,r9,r0
|c00252f0:       41 9d 03 f4     bgt-    cr7,c00256e4 <do_syslog+0x474>
|c00252f4:       3d 20 c0 39     lis     r9,-16327
|c00252f8:       39 09 8e f8     addi    r8,r9,-28936
|c00252fc:       81 29 8e f8     lwz     r9,-28936(r9)
|c0025300:       80 08 00 04     lwz     r0,4(r8)
|c0025304:       7f 80 48 00     cmpw    cr7,r0,r9
|c0025308:       40 be 00 a4     bne+    cr7,c00253ac <do_syslog+0x13c>
|c002530c:       3d 20 c0 04     lis     r9,-16380
|c0025310:       39 61 00 14     addi    r11,r1,20
|c0025314:       39 29 ae 78     addi    r9,r9,-20872
|c0025318:       10 00 02 16     evxor   r0,r0,r0
|c002531c:       10 01 0b 21     evstdd  r0,8(r1)
|c0025320:       7d 1f 43 78     mr      r31,r8

boom.

>
>From my gcc-4.3 info pages:
>
>`-mspe=YES/NO'
>     This option has been deprecated.  Use `-mspe' and `-mno-spe'
>     instead.
>
so it could be gcc bug then and I should open a bugzilla. I didn't know
that it is deprecated.

>>+KBUILD_CFLAGS += $(call cc-option,-mabi=no-spe)
>
>is the -mabi=no-spe really needed?
It seems to work the other way around (without -mabi=no-spe but with
-mabi=no-spe) alteast I did not find anything in do_syslog() or while
browsing through the dissasm. I do a boot check tomorrow.

>
>- k

Sebastian
