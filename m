Return-Path: <felix@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E290D1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 19:29:26 +1000 (AEST)
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D44C1140F91
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2015 19:29:25 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Mon, 1 Jun 2015 10:29:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id BC4B71B08F9B
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2015 10:23:57 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t519N3JG21495852
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Jun 2015 09:23:03 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t519N30g023050
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Jun 2015 03:23:03 -0600
Message-ID: <556C2513.2060900@linux.vnet.ibm.com>
Date: Mon, 01 Jun 2015 11:25:39 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com, vaibhav@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: Set up and enable PSL Timebase
References: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
 <1433140899.24546.14.camel@neuling.org> <556C0BCE.1080302@linux.vnet.ibm.com>
 <1433149688.24546.18.camel@neuling.org>
In-Reply-To: <1433149688.24546.18.camel@neuling.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> On Mon, 2015-06-01 at 09:37 +0200, Philippe Bergheaud wrote:
> 
>>Michael Neuling wrote:
>>
>>>On Thu, 2015-05-28 at 15:12 +0200, Philippe Bergheaud wrote:
>>>
>>>
>>>>This patch configures the PSL Timebase function and enables it,
>>>>after the CAPP has been initialized by OPAL. Failures are reported
>>>>and ignored.
>>>
>>>
>>>Needs an Signed-off-by.
>>
>>Yes.
>>
>>>Comments inline.
>>>
>>>
>>>
>>>>---
>>>>drivers/misc/cxl/cxl.h |    5 +++++
>>>>drivers/misc/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
>>>>2 files changed, 40 insertions(+), 0 deletions(-)
>>>>
>>>>diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
>>>>index a1cee47..38a7cf9 100644
>>>>--- a/drivers/misc/cxl/cxl.h
>>>>+++ b/drivers/misc/cxl/cxl.h
>>>>@@ -82,8 +82,10 @@ static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
>>>>/* 0x00C0:7EFF Implementation dependent area */
>>>>static const cxl_p1_reg_t CXL_PSL_FIR1      = {0x0100};
>>>>static const cxl_p1_reg_t CXL_PSL_FIR2      = {0x0108};
>>>>+static const cxl_p1_reg_t CXL_PSL_Timebase  = {0x0110};
>>>>static const cxl_p1_reg_t CXL_PSL_VERSION   = {0x0118};
>>>>static const cxl_p1_reg_t CXL_PSL_RESLCKTO  = {0x0128};
>>>>+static const cxl_p1_reg_t CXL_PSL_TB_CTLSTAT = {0x0140};
>>>>static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  = {0x0148};
>>>>static const cxl_p1_reg_t CXL_PSL_DSNDCTL   = {0x0150};
>>>>static const cxl_p1_reg_t CXL_PSL_SNWRALLOC = {0x0158};
>>>>@@ -151,6 +153,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
>>>>#define CXL_PSL_SPAP_Size_Shift 4
>>>>#define CXL_PSL_SPAP_V    0x0000000000000001ULL
>>>>
>>>>+/****** CXL_PSL_Control ****************************************************/
>>>>+#define CXL_PSL_Control_tb 0x0000000000000001ULL
>>>>+
>>>>/****** CXL_PSL_DLCNTL *****************************************************/
>>>>#define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
>>>>#define CXL_PSL_DLCNTL_C (0x1ull << (63-29))
>>>>diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
>>>>index fc938de..afd89cc 100644
>>>>--- a/drivers/misc/cxl/pci.c
>>>>+++ b/drivers/misc/cxl/pci.c
>>>>@@ -360,6 +360,38 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
>>>>	return 0;
>>>>}
>>>>
>>>>+#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
>>>>+
>>>>+static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
>>>>+{
>>>>+	u64 psl_tb;
>>>>+	int delta;
>>>>+	unsigned int retry = 0;
>>>>+
>>>>+	/*
>>>>+	 * Setup PSL Timebase Control and Status register
>>>>+	 * with the recommended Timebase Sync Count value
>>>>+	 */
>>>>+	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT, TBSYNC_CNT(2));  
>>>
>>>
>>>2?  
>>
>>Quoting the PSL workbook description of the PSL_TB_CTLSTAT register:
>>
>>4:6 tbsync_cnt
>>TimebaseSyncCount. Number of 250MHz cycles x 2048 before initiating another Timebase Recalibration sequence.
>>Processor chipTimebase facilities receive a tod_sync pulse every 16us or 4000 250 MHz cycles so '010' is the Recommended value.
>>000 = never
>>001 = 2048
>>010 = 4096 (2 * 2048)
>>...
>>111 = 14336 (7 * 2048)
>>
>>Will make the TimebaseSyncCount unit explicit. Something like:
>>
>>#define _2048_250MHZ_CYCLES 1
>>cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT, TBSYNC_CNT(2 * _2048_250MHZ_CYCLES));
> 
> 
> Sounds good!
> 
> 
>>>>+
>>>>+	/* Enable PSL Timebase */
>>>>+	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
>>>>+	/* Wait until CORE TB and PSL TB difference <= 16usecs */
>>>
>>>
>>>How many tries does this normally take?
>>
>>Two. The second attempt always succeds.
> 
> 
> Ok
> 
> 
>>>Should we have a sleep in here to wait for it to sync rather than just
>>>coming back around right away?
>>
>>Yes, will add msleep(1) at the beginning of the loop (as the first attempt always fails).
> 
> 
> Humm, ok.  Is there any documentation to say how long it's suppose to
> take?  
Could not find any.
With msleep(1) at the beginning if the loop, the first attempt always succeeds, as far as I can see.

Philippe
