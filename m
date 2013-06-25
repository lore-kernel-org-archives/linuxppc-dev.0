Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A24C2C0091
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 21:23:16 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 21:16:02 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7B5A52CE804A
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 21:23:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PB8FuN852264
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 21:08:15 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PBNCjr030271
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 21:23:13 +1000
Message-ID: <51C97D7F.4030405@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 16:52:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] powerpc/perf: Rework disable logic in pmu_disable()
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-2-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> In pmu_disable() we disable the PMU by setting the FC (Freeze Counters)
> bit in MMCR0. In order to do this we have to read/modify/write MMCR0.
> 
> It's possible that we read a value from MMCR0 which has PMAO (PMU Alert
> Occurred) set. When we write that value back it will cause an interrupt
> to occur. We will then end up in the PMU interrupt handler even though
> we are supposed to have just disabled the PMU.
> 

Is that possible ? First of all MMCR0[PMAO] could not be written by SW.
Even if you try writing it, how its going to generate PMU interrupt ?
HW sets this bit MMCR0[PMAO] after a PMU interrupt has already occurred
not that if we set this, a PMU interrupt would be generated.

> We can avoid this by making sure we never write PMAO back. We should not

Making sure that we dont write PMAO back is a good idea though.

> lose interrupts because when the PMU is re-enabled the overflowed values
> will cause another interrupt.
> 

I doubt this theory.

> We also reorder the clearing of SAMPLE_ENABLE so that is done after the
> PMU is frozen. Otherwise there is a small window between the clearing of
> SAMPLE_ENABLE and the setting of FC where we could take an interrupt and
> incorrectly see SAMPLE_ENABLE not set. This would for example change the
> logic in perf_read_regs().
> 

Agreed
