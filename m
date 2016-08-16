Return-Path: <dave.hansen@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sDKKS3McnzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 03:36:27 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: christophe leroy <christophe.leroy@c-s.fr>,
 Holger Brunck <holger.brunck@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
 <3f1dff88-cd24-b36e-da9a-e84627929975@c-s.fr>
Cc: "mingo@kernel.org" <mingo@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <57B34F0F.8080100@linux.intel.com>
Date: Tue, 16 Aug 2016 10:36:15 -0700
MIME-Version: 1.0
In-Reply-To: <3f1dff88-cd24-b36e-da9a-e84627929975@c-s.fr>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/16/2016 10:27 AM, christophe leroy wrote:
> If I debug a very small app, it gets stuck quickly after the app has
> stopped: indeed, the console seems ok but as soon as I try to execute
> something simple, like a ps or top, it get stuck. The target still
> responds to pings, but nothing else.

This one is a pretty common symptom when the kernel crashes holding a
per-process lock of some kind, probably most commonly mmap_sem.

Do you have a serial console?  Can you do a sysrq-t on it to get stack
dumps of the hung processes and ps?

It's time to turn on all the debugging options we can find.  Can you
build a kernel with all this stuff enabled (=y on all of these):

CONFIG_SLUB_DEBUG
CONFIG_DEBUG_VM
CONFIG_DEBUG_PAGEALLOC
CONFIG_PAGE_POISONING
CONFIG_SLUB_DEBUG_ON
CONFIG_KASAN
CONFIG_*LOCKUP_DETECTOR
CONFIG_DETECT_HUNG_TASK
CONFIG_SCHED_DEBUG
CONFIG_DEBUG_PREEMPT
CONFIG_MAGIC_SYSRQ

And all of the spinlock/lockdep stuff enabled too:

CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_STACKTRACE=y
CONFIG_DEBUG_LIST=y

Let's hope that these turn something up.
