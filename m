Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D20D61A0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 15:36:48 +1000 (EST)
Message-ID: <1408426607.16286.24.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: Cleanup kvmppc_load/save_fp
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Date: Tue, 19 Aug 2014 15:36:47 +1000
In-Reply-To: <20140819052407.GA30652@drongo>
References: <1408424370-16960-1-git-send-email-mikey@neuling.org>
 <20140819052407.GA30652@drongo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-19 at 15:24 +1000, Paul Mackerras wrote:
> On Tue, Aug 19, 2014 at 02:59:29PM +1000, Michael Neuling wrote:
> > This cleans up kvmppc_load/save_fp.  It removes unnecessary isyncs.
>=20
> NAK - they are necessary on PPC970, which we (still) support.  You
> could put them in a feature section if they are really annoying you.

I'm not fussed, but we should at least have a comment there for why we
need them.

> >  It also
> > removes the unnecessary resetting of the MSR bits on exit of kvmppc_sav=
e_fp.
>=20
> ... except it doesn't. :)  That got folded into e4e38121507a ("KVM:
> PPC: Book3S HV: Add transactional memory support").

Arrh, thanks.  This patch was cleaning up stuff from an old local tree
and couldn't see where it had been upstreamed.  I missed this.

Mikey
