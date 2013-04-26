Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0C3982C0123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 11:19:06 +1000 (EST)
Message-ID: <5179D5D8.8080102@asianux.com>
Date: Fri, 26 Apr 2013 09:18:16 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] PowerPC: kernel: compiling issue, make additional
 room in exception vector area
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <517918AB.4020508@asianux.com>
 <30269.1366931768@ale.ozlabs.ibm.com> <5179D302.9060203@asianux.com>
In-Reply-To: <5179D302.9060203@asianux.com>
Content-Type: text/plain; charset=GB2312
Cc: sfr@canb.auug.org.au, matt@ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mike Qiu <qiudayu@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013Äê04ÔÂ26ÈÕ 09:06, Chen Gang wrote:
>> CFAR is the Come From Register.  It saves the location of the last
>> > branch and is hence overwritten by any branch.
>> > 
> Do we process it just like others done (e.g. 0x300, 0xe00, 0xe20 ...) ?
> 	. = 0x900
> 	.globl decrementer_pSeries
> decrementer_pSeries:
>  	HMT_MEDIUM_PPR_DISCARD
> 	SET_SCRATCH0(r13)
> 	b decrementer_pSeries_0
> 
> 	...
> 
> 

Such as the fix below, is it OK (just like 0x300 or 0x200 has done) ?

Please check, thanks.

---------------------------diff begin-------------------------------------

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e789ee7..a0a5ff2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -254,7 +254,14 @@ hardware_interrupt_hv:
 	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
 
-	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
+	. = 0x900
+	.globl decrementer_pSeries
+decrementer_pSeries:
+	HMT_MEDIUM_PPR_DISCARD
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	decrementer_pSeries_0
+
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
 	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
@@ -536,6 +543,12 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 #endif
 
 	.align	7
+	/* moved from 0x900 */
+decrementer_pSeries_0:
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, 0x900)
+	EXCEPTION_PROLOG_PSERIES_1(decrementer_common, EXC_STD)
+
+	.align	7
 	/* moved from 0xe00 */
 	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)

---------------------------diff end---------------------------------------

-- 
Chen Gang

Asianux Corporation
