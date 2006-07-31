Return-Path: <moilanen@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CBDF67B58
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 05:58:59 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6VJwqCR000405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 15:58:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6VJwYpg174342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:58:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6VJwYpS030956
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:58:34 -0600
Subject: Re: [PATCH][2/2] RTAS MSI
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17613.33279.61050.840408@cargo.ozlabs.ibm.com>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<17613.33279.61050.840408@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 14:55:01 -0500
Message-Id: <1154375701.29826.389.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-31 at 14:07 +1000, Paul Mackerras wrote:
> Jake Moilanen writes:
> 
> > -msiobj-y := msi.o msi-apic.o
> > -msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
> > -msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
> > +msiobj-$(CONFIG_X86) += msi.o msi-apic.o
> > +msiobj-$(CONFIG_IA64) += msi.o msi-apic.o
> > +msiobj-$(CONFIG_IA64_GENERIC) += msi.o msi-apic.o msi-altix.o
> > +msiobj-$(CONFIG_IA64_SGI_SN2) += msi.o msi-apic.o msi-altix.o
> 
> Doesn't this mean that ia64 configs might now get msi.o and msi-apic.o
> listed twice?  Why did you need to change the
> msiobj-$(CONFIG_IA64_GENERIC) and msiobj-$(CONFIG_IA64_SGI_SN2) lines
> at all?

Yup...see the second patch I posted where I fixed up the ia64 configs so
msi.o and msi-apic.o are listed once and msiobj-$(CONFIG_IA64_GENERIC)
and msiobj-$(CONFIG_IA64_SGI_SN2) are not changed.

In a few, I'll be posting another version of the patch which address
Michael's concerns.
