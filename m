Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 278692C00A2
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jul 2013 10:15:36 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 9 Jul 2013 18:15:34 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B0DF41FF001E
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jul 2013 18:10:12 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6A0FVO9380218
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Jul 2013 18:15:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6A0FU70025885
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Jul 2013 18:15:30 -0600
Date: Tue, 9 Jul 2013 17:15:23 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] powerpc/perf: Rework disable logic in pmu_disable()
Message-ID: <20130710001523.GA24980@us.ibm.com>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-2-git-send-email-michael@ellerman.id.au>
 <51C97D7F.4030405@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51C97D7F.4030405@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
| On 06/24/2013 04:58 PM, Michael Ellerman wrote:
| > In pmu_disable() we disable the PMU by setting the FC (Freeze Counters)
| > bit in MMCR0. In order to do this we have to read/modify/write MMCR0.
| > 
| > It's possible that we read a value from MMCR0 which has PMAO (PMU Alert
| > Occurred) set. When we write that value back it will cause an interrupt
| > to occur. We will then end up in the PMU interrupt handler even though
| > we are supposed to have just disabled the PMU.
| > 
| 
| Is that possible ? First of all MMCR0[PMAO] could not be written by SW.
| Even if you try writing it, how its going to generate PMU interrupt ?
| HW sets this bit MMCR0[PMAO] after a PMU interrupt has already occurred
| not that if we set this, a PMU interrupt would be generated.

Looks like writing 1 MMCR0[PMAO] is allowed (to save interrupts across
partition swaps) and it does generate the interrupt.

| 
| > We can avoid this by making sure we never write PMAO back. We should not
| 
| Making sure that we dont write PMAO back is a good idea though.
| 
| > lose interrupts because when the PMU is re-enabled the overflowed values
| > will cause another interrupt.


Is it enough to set the FC and clear the PMAO - or should we also clear the
PMAE in pmu_disable() (and set it back in pmu_enable()) ?

The PMU spec says "...Alert will occur when enabled condition or event exists
and Performance Monitor Alerts are enabled through MMCR0[PMAE] field"

The condition of overflowing counter will still exist and the PMAE is still
set. So, won't the PMU simply turn PMAO back on after we clear it ?

Or is it that PMAO is only set when counting is enabled but the interrupt is
generated even when counting is disabled ?
| > 
| 
| I doubt this theory.
| 
| > We also reorder the clearing of SAMPLE_ENABLE so that is done after the
| > PMU is frozen. Otherwise there is a small window between the clearing of
| > SAMPLE_ENABLE and the setting of FC where we could take an interrupt and
| > incorrectly see SAMPLE_ENABLE not set. This would for example change the
| > logic in perf_read_regs().
| > 
Good point.
