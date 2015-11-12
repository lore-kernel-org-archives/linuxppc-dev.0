Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 132DE1A03F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:58:22 +1100 (AEDT)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA1121402B3
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 15:58:20 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so53005631pad.1
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2015 20:58:19 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, mahesh@linux.vnet.ibm.com,
 agraf@suse.de, michaele@au1.ibm.com, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
In-Reply-To: <20151112033816.GJ5852@voom.redhat.com>
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
Date: Thu, 12 Nov 2015 15:58:14 +1100
Message-ID: <87bnazizkp.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> So, IIUC.  Once the qemu pieces are in place as well it shouldn't
> change this behaviour: KVM will exit to qemu, qemu will log the error
> information (new), then reinject the MC to the guest which can still
> handle it as you describe above.

Ah, that makes *much* more sense now! Thanks for the explanation: I
don't really follow qemu development.

>
> But, there could be a problem if you have a new kernel with an old
> qemu, in that case qemu might not understand the new exit type and
> treat it as a fatal error, even though the guest could actually cope
> with it.
>
> Aravinda, do we need to change this so that qemu has to explicitly
> enable the new NMI behaviour?  Or have I missed something that will
> make that case work already.

<puts on CAPI hat>Yeah, it would be good not to break this.</hat>

Regards,
Daniel


> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
