Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 4DABEDDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 03:25:35 +1100 (EST)
Date: Tue, 13 Nov 2007 10:25:22 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] fix multiple bugs in rtas_ibm_suspend_me code
Message-ID: <20071113162522.GJ26313@localdomain>
References: <20071106044309.GK9695@localdomain>
	<20071109204408.GS9695@localdomain>
	<18233.12821.992452.841806@cargo.ozlabs.ibm.com>
	<20071113161513.GI26313@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113161513.GI26313@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> 
> 3.) H_JOIN must be called with MSR[EE] off, but lazy interrupt
> disabling may cause the caller of rtas_ibm_suspend_me to call H_JOIN
> with it on; the local_irq_disable() in on_each_cpu() is not
> sufficient.
> 
> Fix this by explicitly saving the MSR and clearing the EE bit before
> calling H_JOIN.

...

> +	atomic_inc(&data->working);
> +
> +	/* really need to ensure MSR.EE is off for H_JOIN */
> +	msr_save = mfmsr();
> +	mtmsr(msr_save & ~(MSR_EE));
> +
> +	rc = plpar_hcall_norets(H_JOIN);
> +
> +	mtmsr(msr_save);

BTW, I'm wondering if this is the right way to do this.  I think
there's the possibility that we could enter this routine hard-enabled
and take take an interrupt between the mfmsr and the first mtmsr, but
I haven't worked out all the implications.  Would hard_irq_disable be
better?
