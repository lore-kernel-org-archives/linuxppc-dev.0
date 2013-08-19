Return-Path: <toshi.kani@hp.com>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 084752C013C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 00:55:12 +1000 (EST)
Message-ID: <1376924024.10300.450.camel@misato.fc.hp.com>
Subject: Re: [PATCH 2/4] hotplug, x86: Add hotplug lock to missing places
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2013 08:53:44 -0600
In-Reply-To: <20130817231552.GA20169@kroah.com>
References: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
 <1376768819-28975-3-git-send-email-toshi.kani@hp.com>
 <20130817231552.GA20169@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fenghua.yu@intel.com, bp@suse.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, rjw@sisk.pl, isimatu.yasuaki@jp.fujitsu.com,
 mingo@redhat.com, srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de,
 hpa@linux.intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-08-17 at 16:15 -0700, Greg KH wrote:
> On Sat, Aug 17, 2013 at 01:46:57PM -0600, Toshi Kani wrote:
> > lock_device_hotplug() serializes CPU & Memory online/offline and hotplug
> > operations.  However, this lock is not held in the debug interfaces below
> > that initiate CPU online/offline operations.
> > 
> >  - _debug_hotplug_cpu(), cpu0 hotplug test interface enabled by
> >    CONFIG_DEBUG_HOTPLUG_CPU0.
> >  - cpu_probe_store() and cpu_release_store(), cpu hotplug test interface
> >    enabled by CONFIG_ARCH_CPU_PROBE_RELEASE.
> > 
> > This patch changes the above interfaces to hold lock_device_hotplug().
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >  arch/x86/kernel/topology.c |    2 ++
> >  drivers/base/cpu.c         |   16 ++++++++++++++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks Greg!
-Toshi
