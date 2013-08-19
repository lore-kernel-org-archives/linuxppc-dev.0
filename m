Return-Path: <toshi.kani@hp.com>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 351EE2C012D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 01:24:45 +1000 (EST)
Message-ID: <1376925802.10300.452.camel@misato.fc.hp.com>
Subject: Re: [PATCH 4/4] hotplug, powerpc, x86: Remove
 cpu_hotplug_driver_lock()
From: Toshi Kani <toshi.kani@hp.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 09:23:22 -0600
In-Reply-To: <521237A9.8010109@linux.vnet.ibm.com>
References: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
 <1376768819-28975-5-git-send-email-toshi.kani@hp.com>
 <521237A9.8010109@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fenghua.yu@intel.com, bp@suse.de, gregkh@linuxfoundation.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl,
 isimatu.yasuaki@jp.fujitsu.com, mingo@redhat.com,
 srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de, hpa@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 10:20 -0500, Nathan Fontenot wrote:
> On 08/17/2013 02:46 PM, Toshi Kani wrote:
> > cpu_hotplug_driver_lock() serializes CPU online/offline operations
> > when ARCH_CPU_PROBE_RELEASE is set.  This lock interface is no longer
> > necessary with the following reason:
> > 
> >  - lock_device_hotplug() now protects CPU online/offline operations,
> >    including the probe & release interfaces enabled by
> >    ARCH_CPU_PROBE_RELEASE.  The use of cpu_hotplug_driver_lock() is
> >    redundant.
> >  - cpu_hotplug_driver_lock() is only valid when ARCH_CPU_PROBE_RELEASE
> >    is defined, which is misleading and is only enabled on powerpc.
> > 
> > This patch removes the cpu_hotplug_driver_lock() interface.  As
> > a result, ARCH_CPU_PROBE_RELEASE only enables / disables the cpu
> > probe & release interface as intended.  There is no functional change
> > in this patch.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> 
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Thanks Nathan!
-Toshi
