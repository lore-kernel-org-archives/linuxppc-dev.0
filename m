Return-Path: <paulus@ozlabs.org>
Date: Fri, 8 Nov 2013 21:58:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH v3 0/2] powerpc kvm: fix deadlock scene
Message-ID: <20131108105837.GC16470@iris.ozlabs.ibm.com>
References: <1383895794-16164-1-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383895794-16164-1-git-send-email-pingfank@linux.vnet.ibm.com>
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

On Fri, Nov 08, 2013 at 03:29:52PM +0800, Liu Ping Fan wrote:
> v2->v3:
>   introduce kvmppc_hv_unlock_hpte() to pair with kvmppc_hv_find_lock_hpte()
>   and hide the preemption detail inside this pair from the callers

Actually, I preferred v2.  This version seems a bit over-engineered.

Making a kvmppc_hv_unlock_hpte() is not such a bad idea, though I
would make it identical to the existing unlock_hpte() from
book3s_hv_rm_mmu.c, just in a header.  I'm really not convinced about
putting the preempt_disable/enable inside the lock/unlock functions,
with the consequent need to pass in a 'vmode' parameter, given that
there is just one caller that needs to do the preempt_disable/enable.

Regards,
Paul.
