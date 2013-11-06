Return-Path: <paulus@ozlabs.org>
Date: Wed, 6 Nov 2013 16:01:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/kvm: simplify the entering logic for
 secondary thread
Message-ID: <20131106050100.GC14842@drongo>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 05, 2013 at 03:42:42PM +0800, Liu Ping Fan wrote:
> After the primary vcpu changes vcore_state to VCORE_RUNNING, there is
> very little chance to schedule to secondary vcpu. So if we change the

Why do you say there is very little chance to run the secondary vcpu?

> code sequence around set vcore_state to VCORE_RUNNING and disable
> preemption, we lost little. But we simplify the entering logi, based on
> the fact that if primary vcpu runs, the secondary vcpu can not be scheduled.

If a vcpu does a hypercall or something else that requires the host
(kernel or userspace) to do something, that can happen in the context
of the vcpu task for that vcpu.  That vcpu task can run on another
core (unless it has been pinned).  When it is finished we would like
the vcpu to continue executing in the guest as soon as possible.  The
code that you remove in this patch enables that to happen without
having to wait until the other threads exit the guest.  So I don't
think it is a good idea to remove this code.

Regards,
Paul.
