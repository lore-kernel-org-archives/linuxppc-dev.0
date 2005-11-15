Return-Path: <SRS0+a1262849d8085329be4a+814+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EB0668742
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Nov 2005 11:19:33 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17270.58406.370195.733887@cargo.ozlabs.ibm.com>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
	<17270.58406.370195.733887@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed; boundary="=-IjrOtLJatJQwdx1ZCEtQ"
Date: Tue, 15 Nov 2005 00:19:20 +0000
Message-Id: <1132013961.28963.34.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Attempt to clean up sigsuspend et al
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IjrOtLJatJQwdx1ZCEtQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-11-13 at 17:58 +1100, Paul Mackerras wrote:
> I'll be upset if you can shorten it by a lot - I thought I had it
> pretty tight already. :)

The patch appears to speed up a null syscall benchmark by about 3%.

With the old kernel I get an average of 5863600 cycles for 100000
getpid() calls; with the new kernel it's 5695256 cycles.

I still haven't done much testing for correctness, but it needs at least
this (d'oh)...

--- arch/powerpc/kernel/entry_64.S~	2005-11-14 23:41:22.000000000 +0000
+++ arch/powerpc/kernel/entry_64.S	2005-11-14 23:45:35.000000000 +0000
@@ -295,7 +295,7 @@ save_user_nvgprs:
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
 
-	ld	r10,TI_SIGFRAME(r9)
+	ld	r10,TI_SIGFRAME(r12)
 	andi.	r0,r9,_TIF_32BIT
 	beq-	save_user_nvgprs_64
 


-- 
dwmw2


--=-IjrOtLJatJQwdx1ZCEtQ
Content-Disposition: inline; filename=newkernel.txt
Content-Type: text/plain; name=newkernel.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Used 5687730 cycles
Used 5721828 cycles
Used 5686992 cycles
Used 5658466 cycles
Used 5630346 cycles
Used 5640494 cycles
Used 5709830 cycles
Used 5654279 cycles
Used 5659045 cycles
Used 5747328 cycles
Used 5635214 cycles
Used 5694711 cycles
Used 5646751 cycles
Used 5738407 cycles
Used 5898139 cycles
Used 5787047 cycles
Used 5670900 cycles
Used 5707616 cycles
Used 5694654 cycles
Used 5722101 cycles
Used 5666626 cycles
Used 5702401 cycles
Used 5723496 cycles
Used 5708662 cycles
Used 5675878 cycles
Used 5772019 cycles
Used 5653936 cycles
Used 5675029 cycles
Used 5657729 cycles
Used 5694485 cycles
Used 5781104 cycles
Used 5687276 cycles
Used 5668391 cycles
Used 5661477 cycles
Used 5729791 cycles
Used 5667902 cycles
Used 5669606 cycles
Used 5655594 cycles
Used 5703992 cycles
Used 5685671 cycles
Used 5659003 cycles
Used 5710373 cycles
Used 5754017 cycles
Used 5677565 cycles
Used 5699307 cycles
Used 5734777 cycles
Used 5647465 cycles
Used 5630120 cycles
Used 5688174 cycles
Used 5697787 cycles
Used 5735130 cycles
Used 5795555 cycles
Used 5657136 cycles
Used 5705851 cycles
Used 5708684 cycles
Used 5680934 cycles
Used 5666883 cycles
Used 5650389 cycles
Used 5702600 cycles
Used 5692186 cycles
Used 5667843 cycles
Used 5612066 cycles
Used 5675461 cycles
Used 5663601 cycles
Used 5667161 cycles
Used 5736776 cycles
Used 5727070 cycles
Used 5720203 cycles
Used 5824526 cycles
Used 5694799 cycles
Used 5600060 cycles
Used 5767003 cycles
Used 5691184 cycles
Used 5705613 cycles
Used 5670786 cycles
Used 5728827 cycles
Used 5685249 cycles
Used 5742188 cycles
Used 5699514 cycles
Used 5670884 cycles
Used 5758295 cycles
Used 5712180 cycles
Used 5697514 cycles
Used 5757201 cycles
Used 5694345 cycles
Used 5669453 cycles
Used 5674303 cycles
Used 5647565 cycles
Used 5663152 cycles
Used 5683005 cycles
Used 5666470 cycles
Used 5714193 cycles
Used 5689820 cycles
Used 5679402 cycles
Used 5672894 cycles
Used 5682461 cycles
Used 5701143 cycles
Used 5683074 cycles
Used 5760015 cycles
Used 5663922 cycles
Used 5677554 cycles
Used 5690482 cycles

--=-IjrOtLJatJQwdx1ZCEtQ
Content-Disposition: inline; filename=oldkernel.txt
Content-Type: text/plain; name=oldkernel.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Used 5882164 cycles
Used 5850099 cycles
Used 5930877 cycles
Used 5841572 cycles
Used 5809251 cycles
Used 5845593 cycles
Used 5832703 cycles
Used 5819283 cycles
Used 5885083 cycles
Used 5888057 cycles
Used 5857240 cycles
Used 5838354 cycles
Used 5829058 cycles
Used 5826108 cycles
Used 5892050 cycles
Used 5907373 cycles
Used 5837317 cycles
Used 5885804 cycles
Used 5944564 cycles
Used 5837752 cycles
Used 5832153 cycles
Used 5883830 cycles
Used 5883603 cycles
Used 5804154 cycles
Used 5852603 cycles
Used 5826546 cycles
Used 5843635 cycles
Used 5797480 cycles
Used 5846276 cycles
Used 5891924 cycles
Used 5849252 cycles
Used 5857151 cycles
Used 5881152 cycles
Used 5924924 cycles
Used 5872509 cycles
Used 5805744 cycles
Used 5831126 cycles
Used 5844736 cycles
Used 5827185 cycles
Used 5848652 cycles
Used 5863982 cycles
Used 5873140 cycles
Used 5937342 cycles
Used 6000375 cycles
Used 5840141 cycles
Used 5906836 cycles
Used 5974467 cycles
Used 5811534 cycles
Used 5866358 cycles
Used 5850431 cycles
Used 5822444 cycles
Used 5817241 cycles
Used 5836811 cycles
Used 5912106 cycles
Used 5859462 cycles
Used 5861770 cycles
Used 5897209 cycles
Used 5779781 cycles
Used 5844075 cycles
Used 5801599 cycles
Used 5852515 cycles
Used 6151891 cycles
Used 5809307 cycles
Used 5817957 cycles
Used 5842894 cycles
Used 5878106 cycles
Used 5867384 cycles
Used 5905804 cycles
Used 5856291 cycles
Used 5916764 cycles
Used 5851960 cycles
Used 5846597 cycles
Used 5833760 cycles
Used 5806083 cycles
Used 5838144 cycles
Used 6102020 cycles
Used 5883813 cycles
Used 5853801 cycles
Used 5883441 cycles
Used 5827994 cycles
Used 5918981 cycles
Used 5788855 cycles
Used 5824117 cycles
Used 5890999 cycles
Used 5828463 cycles
Used 5870945 cycles
Used 5876589 cycles
Used 5789181 cycles
Used 5843746 cycles

--=-IjrOtLJatJQwdx1ZCEtQ
Content-Disposition: inline; filename=syscalltest.S
Content-Type: text/plain; name=syscalltest.S; charset=UTF-8
Content-Transfer-Encoding: 7bit


	.globl main

main:
	subi 1,1,12
	stw 14,0(1)
	stw 15,4(1)
	stw 16,8(1)
	
	li 14, 10000
	mftb 15
1:	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	li 0, 24
	sc
	addic. 14,14,-1
	bne	1b
	mftb 16
	sub 4,16,15
	lwz 14,0(1)
	lwz 15,4(1)
	lwz 16,8(1)
	addi 1,1,12
	lis 3,msg@ha
	la 3,msg@l(3)
	b printf

msg:	.string "Used %d cycles\n"
	

--=-IjrOtLJatJQwdx1ZCEtQ--
