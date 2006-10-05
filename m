Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 4FBA067DDE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 00:33:01 +1000 (EST)
Date: Thu, 5 Oct 2006 09:32:44 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] linux,tce-size property is 32 bits
Message-ID: <20061005143244.GJ24705@localdomain>
References: <20061005032800.GH24705@localdomain>
	<1160039899.22232.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160039899.22232.54.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	matthltc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2006-10-04 at 22:28 -0500, Nathan Lynch wrote:
> > The "linux,tce-size" property is only 32 bits (see
> > prom_initialize_tce_table() in arch/powerpc/kernel/prom_init.c).
> > Treating it as an unsigned long in iommu_table_setparms() leads to
> > access beyond the end of the property's buffer, so we pass garbage to
> > the memset() in that function.
> 
> Probably needs to go into stable as well. Do you know if RHEL5 is
> affected too ?

AFAICT this was introduced by the "Constify & voidify get_property()"
series which went in post-2.6.18 so no backport for -stable is
needed.  Not sure about RHEL5.
