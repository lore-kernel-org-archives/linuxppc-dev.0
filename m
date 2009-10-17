Return-Path: <wilbur512@gmail.com>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 9FACAB7B70
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 12:21:51 +1100 (EST)
Received: by ywh37 with SMTP id 37so2372295ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 18:21:49 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 17 Oct 2009 09:21:49 +0800
Message-ID: <e997b7420910161821g3d71c5fcy6fbf72f40d52c1c3@mail.gmail.com>
Subject: ppc rfi in head.s result in a reset?
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc 6xx

In platform_init function of  sandpoint.c , I delete the code of
getting command line from uboot, and set command_line to a fixed value
, which are like this:

            sandpoint.c-->  platform_init
                 #if 0
                 if (r3 && r6) {
		/* copy board info structure */
		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
		/* copy command line */
		*(char *)(r7+KERNELBASE) = 0;
		strcpy(cmd_line, (char *)(r6+KERNELBASE));
	}
                #endif
                strcpy(cmd_line, "xxx");


But I found that , when calling start_kernel in head.S (by rfi
instruction), the borad was reset into uboot, that is :

                li              r4,MSR_KERNEL
	FIX_SRR1(r4,r5)
	lis	r3,start_kernel@h
	ori	r3,r3,start_kernel@l
	mtspr	SPRN_SRR0,r3
	mtspr	SPRN_SRR1,r4
	SYNC
	RFI              //reset,why?


The RFI  instruction  here, caused the board reset to uboot.  Can
someone give me some advice on how could this happened?

Thank you
