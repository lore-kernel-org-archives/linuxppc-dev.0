Return-Path: <toshi.kani@hp.com>
Received: from g4t0017.houston.hp.com (g4t0017.houston.hp.com [15.201.24.20])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 561A62C016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 06:47:02 +1000 (EST)
Message-ID: <1380141899.14046.18.camel@misato.fc.hp.com>
Subject: Re: [PATCH v2 4/4] hotplug, powerpc, x86: Remove
 cpu_hotplug_driver_lock()
From: Toshi Kani <toshi.kani@hp.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 25 Sep 2013 14:44:59 -0600
In-Reply-To: <7232059.d6LGFPRAoP@vostro.rjw.lan>
References: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
 <1377822129-4143-5-git-send-email-toshi.kani@hp.com>
 <7232059.d6LGFPRAoP@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "bp@suse.de" <bp@suse.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>,
 "nfont@linux.vnet.ibm.com" <nfont@linux.vnet.ibm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "hpa@linux.intel.com" <hpa@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 08:27 +0000, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, August 29, 2013 06:22:09 PM Toshi Kani wrote:
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
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> Can you please rebase this patch on top of 3.12-rc2?  It doesn't apply for
> me any more.

Yes, I will send this patch on top of 3.12-rc2.

Thanks,
-Toshi
