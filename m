Return-Path: <paulus@ozlabs.org>
Date: Thu, 30 Jan 2014 17:00:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 07/10] KVM: PPC: BOOK3S: PR: Emulate facility status
 and control register
Message-ID: <20140130060000.GB10611@iris.ozlabs.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390927455-3312-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 28, 2014 at 10:14:12PM +0530, Aneesh Kumar K.V wrote:
> We allow priv-mode update of this. The guest value is saved in fscr,
> and the value actually used is saved in shadow_fscr. shadow_fscr
> only contains values that are allowed by the host. On
> facility unavailable interrupt, if the facility is allowed by fscr
> but disabled in shadow_fscr we need to emulate the support. Currently
> all but EBB is disabled. We still don't support performance monitoring
> in PR guest.

...

> +	/*
> +	 * Save the current fscr in shadow fscr
> +	 */
> +	mfspr r3,SPRN_FSCR
> +	PPC_STL r3, VCPU_SHADOW_FSCR(r7)

I don't think you need to do this.  What could possibly have changed
FSCR since we loaded it on the way into the guest?

Paul.
