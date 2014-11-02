Return-Path: <bharata@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF1211A0320
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 15:59:05 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Sun, 2 Nov 2014 10:29:01 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 54148E003F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 10:28:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA24xUcw4522284
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Nov 2014 10:29:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA24wtKg003096
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Nov 2014 10:28:56 +0530
Date: Sun, 2 Nov 2014 10:28:51 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH] powerpc: use device_online/offline() instead of
 cpu_up/down()
Message-ID: <20141102045851.GA8334@in.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <CALZtONCwrBb+HPY7j7x4R-xmyhajFNCwaS3sns50RMDxHxyiEQ@mail.gmail.com>
 <1414784494-12573-1-git-send-email-ddstreet@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414784494-12573-1-git-send-email-ddstreet@ieee.org>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Neil Zhang <zhangwm@marvell.com>,
 linuxppc-dev@lists.ozlabs.org, Daniel Walter <dwalter@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2014 at 03:41:34PM -0400, Dan Streetman wrote:
> In powerpc pseries platform dlpar operations, Use device_online() and
> device_offline() instead of cpu_up() and cpu_down().
> 
> Calling cpu_up/down directly does not update the cpu device offline
> field, which is used to online/offline a cpu from sysfs.  Calling
> device_online/offline instead keeps the sysfs cpu online value correct.
> The hotplug lock, which is required to be held when calling
> device_online/offline, is already held when dlpar_online/offline_cpu
> are called, since they are called only from cpu_probe|release_store.
> 
> This patch fixes errors on PowerVM systems that have cpu(s) added/removed
> using dlpar operations; without this patch, the
> /sys/devices/system/cpu/cpuN/online nodes do not correctly show the
> online state of added/removed cpus.

Verified the patch to be working as expected when I online and offline
CPUs of a PowerKVM guest using QEMU (plus my RFC hotplug patchset for
QEMU)

Regards,
Bharata.
