Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E3AC2DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:18:54 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH REPOST] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
References: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
	<adatzg15ol2.fsf@cisco.com>
	<200806101701.47090.ossrosch@linux.vnet.ibm.com>
Date: Tue, 10 Jun 2008 09:18:50 -0700
In-Reply-To: <200806101701.47090.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Tue, 10 Jun 2008 17:01:45 +0200")
Message-ID: <adaabht5klx.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > So just to be clear: this is a workaround for a hardware/firmware bug?

 > Yes it is.

OK, so paulus et al... does it seem like a good approach to call H_EOI
from driver code (given that this driver makes tons of other hcalls)?

How critical is this?  Since you said "corner case testing" I suspect we
can defer this to 2.6.27 and maybe get it into -stable later?

Also, out of curiousity:

 > +u64 hipz_h_eoi(int irq)
 > +{
 > +	int value;
 > +	unsigned long xirr;
 > +
 > +	iosync();

what is the iosync() required for here?

 > +	value = (0xff << 24) | irq;
 > +	xirr = value & 0xffffffff;

given that irq and value are ints, is there any possible way value could
have bits outside of the low 32 set?  If you're worried about sign
extension isn't it simpler to just make value unsigned?

 > +	return plpar_hcall_norets(H_EOI, xirr);
 > +}

ie why not:

u64 hipz_h_eoi(int irq)
{
	unsigned xirr;

	iosync();
	xirr = (0xff << 24) | irq;
	return plpar_hcall_norets(H_EOI, xirr);
}
