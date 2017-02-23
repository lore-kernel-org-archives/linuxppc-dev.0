Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTZ4c3tH8zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 23:56:48 +1100 (AEDT)
Date: Thu, 23 Feb 2017 13:56:43 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-mm@kvack.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] memory-hotplug: Use dev_online for memhp_auto_offline
Message-ID: <20170223125643.GA29064@dhcp22.suse.cz>
References: <20170221172234.8047.33382.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <878toy1sgd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878toy1sgd.fsf@vitty.brq.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 22-02-17 10:32:34, Vitaly Kuznetsov wrote:
[...]
> > There is a workaround in that a user could online the memory or have
> > a udev rule to online the memory by using the sysfs interface. The
> > sysfs interface to online memory goes through device_online() which
> > should updated the dev->offline flag. I'm not sure that having kernel
> > memory hotplug rely on userspace actions is the correct way to go.
> 
> Using udev rule for memory onlining is possible when you disable
> memhp_auto_online but in some cases it doesn't work well, e.g. when we
> use memory hotplug to address memory pressure the loop through userspace
> is really slow and memory consuming, we may hit OOM before we manage to
> online newly added memory.

How does the in-kernel implementation prevents from that?

> In addition to that, systemd/udev folks
> continuosly refused to add this udev rule to udev calling it stupid as
> it actually is an unconditional and redundant ping-pong between kernel
> and udev.

This is a policy and as such it doesn't belong to the kernel. The whole
auto-enable in the kernel is just plain wrong IMHO and we shouldn't have
merged it.
-- 
Michal Hocko
SUSE Labs
