Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 00CCBB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:34:08 +1000 (EST)
Message-ID: <4C270CFE.2040600@redhat.com>
Date: Sun, 27 Jun 2010 11:34:06 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-27-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-27-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2010 02:25 AM, Alexander Graf wrote:
> We just introduced a new PV interface that screams for documentation. So here
> it is - a shiny new and awesome text file describing the internal works of
> the PPC KVM paravirtual interface.
>
>
> +Querying for existence
> +======================
> +
> +To find out if we're running on KVM or not, we overlay the PVR register. Usually
> +the PVR register contains an id that identifies your CPU type. If, however, you
> +pass KVM_PVR_PARA in the register that you want the PVR result in, the register
> +still contains KVM_PVR_PARA after the mfpvr call.
> +
> +	LOAD_REG_IMM(r5, KVM_PVR_PARA)
> +	mfpvr	r5
> +	[r5 still contains KVM_PVR_PARA]
> +
> +Once determined to run under a PV capable KVM, you can now use hypercalls as
> +described below.
>    

On x86 we allow host userspace to determine whether the guest sees the 
paravirt interface (and what features are exposed).  This allows you to 
live migrate from a newer host to an older host, by not exposing the 
newer features.

-- 
error compiling committee.c: too many arguments to function
