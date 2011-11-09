Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
 by ozlabs.org (Postfix) with SMTP id 4139B1007DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 05:02:45 +1100 (EST)
Received: by mail-qw0-f43.google.com with SMTP id g1so1966198qab.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2011 10:02:42 -0800 (PST)
From: Tirumala Marri <tmarri@apm.com>
References: <1317954637-11802-1-git-send-email-tmarri@apm.com>
 <CAHM4w1=OiZA4S4TBE_Hgx3yBptcWdtLu2iQiy17wb2=NaSjwZw@mail.gmail.com>
In-Reply-To: <CAHM4w1=OiZA4S4TBE_Hgx3yBptcWdtLu2iQiy17wb2=NaSjwZw@mail.gmail.com>
MIME-Version: 1.0
Date: Wed, 9 Nov 2011 10:02:41 -0800
Message-ID: <dbe3a7c6582240de54396a033990a604@mail.gmail.com>
Subject: RE: [PATCH v14 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
 Layer (CIL)
To: Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org,
 Mark Miesfeld <mmiesfeld@apm.com>, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>-----Original Message-----
>From: linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org
>[mailto:linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org] On Behalf
>Of Pratyush Anand
>Sent: Thursday, October 20, 2011 2:12 AM
>To: tmarri@apm.com
>Cc: Mark Miesfeld; greg@kroah.com; linux-usb@vger.kernel.org; linuxppc-
>dev@lists.ozlabs.org; Fushen Chen
>Subject: Re: [PATCH v14 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
>Interface Layer (CIL)
>
>On Fri, Oct 7, 2011 at 8:00 AM,  <tmarri@apm.com> wrote:
>> From: Tirumala Marri <tmarri@apm.com>
>>
>
>[...]
>
>> + * Do core a soft reset of the core.  Be careful with this because it
>> + * resets all the internal state machines of the core.
>> + */
>> +static void dwc_otg_core_reset(struct core_if *core_if)
>> +{
>> +       ulong global_regs = core_if->core_global_regs;
>> +       u32 greset = 0;
>> +       int count = 0;
>> +
>> +       /* Wait for AHB master IDLE state. */
>> +       do {
>> +               udelay(10);
>> +               greset = dwc_reg_read(global_regs, DWC_GRSTCTL);
>> +               if (++count > 100000) {
>> +                       pr_warning("%s() HANG! AHB Idle
>GRSTCTL=%0x\n",
>> +                                  __func__, greset);
>> +                       return;
>> +               }
>> +       } while (greset & DWC_RSTCTL_AHB_IDLE);
>
>As per sepcs:
>Bit 31:  AHB Master Idle (AHBIdle): Indicates that the AHB Master State
>Machine is in the IDLE condition.
>So when this bit is 1 , AHB would be idle. So, what do you want here?
>If AHB is idle, control wil return from above loop rather going ahead to
>execute
>this function.


What we are trying to do is waiting for the idle before we reset the core.
We want to make sure state machine is settle down and all the transactions
Are finished before reset.
>
>> +               nptxsize =
>> +                   DWC_RX_FIFO_START_ADDR_WR(nptxsize,
>> +                                             params-
>>dev_rx_fifo_size);
>> +               dwc_reg_write(regs, DWC_GNPTXFSIZ, nptxsize);
>> +
>> +               ptxsize = DWC_RX_FIFO_START_ADDR_WR(ptxsize,
>> +
>(DWC_RX_FIFO_START_ADDR_RD
>> +                                                    (nptxsize) +
>> +
>DWC_RX_FIFO_DEPTH_RD
>> +                                                    (nptxsize)));
>> +               for (i = 0;
>> +                    i < DWC_HWCFG4_NUM_DEV_PERIO_IN_EP_RD(core_if-
>>hwcfg4);
>> +                    i++) {
>
>
>Reading hwcfg4 will give you maximum nuber of fifos provided by
>hardware.
>But, a particular application (platform) may not need all those fifo.
>Since, you
>have a vriable fifo_num in your param list, so why not use that?
>
I am not sure about that. I think it should come from device tree
Based on how board is going to be configured.
