Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B65682C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 07:51:36 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 17:51:33 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3F53D38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 17:51:31 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3BLpUap279354
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 17:51:31 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3BLsHS9013688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 15:54:18 -0600
Date: Thu, 11 Apr 2013 14:51:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/9] powerpc,kvm: fix imbalance srcu_read_[un]lock()
Message-ID: <20130411215129.GU29861@linux.vnet.ibm.com>
References: <1363366257-4886-1-git-send-email-laijs@cn.fujitsu.com>
 <1363366257-4886-2-git-send-email-laijs@cn.fujitsu.com>
 <20130317212648.GA4259@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130317212648.GA4259@iris.ozlabs.ibm.com>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, Gleb Natapov <gleb@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 18, 2013 at 08:26:48AM +1100, Paul Mackerras wrote:
> On Sat, Mar 16, 2013 at 12:50:49AM +0800, Lai Jiangshan wrote:
> > At the point of up_out label in kvmppc_hv_setup_htab_rma(),
> > srcu read lock is still held.
> > 
> > We have to release it before return.
> > 
> > Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Gleb Natapov <gleb@redhat.com>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: kvm@vger.kernel.org
> > Cc: kvm-ppc@vger.kernel.org
> > ---
> >  arch/powerpc/kvm/book3s_hv.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 80dcc53..c26740e 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -1799,7 +1799,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
> >  
> >   up_out:
> >  	up_read(&current->mm->mmap_sem);
> > -	goto out;
> > +	goto out_srcu;
> 
> Acked-by: Paul Mackerras <paulus@samba.org>

Thank you both, queued for 3.11 (assuming no one has beat me to it).

							Thanx, Paul
