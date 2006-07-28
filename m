Return-Path: <moilanen@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18FC967B5B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2006 04:45:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6SIjq7g011122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 14:45:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6SIjpdj151624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 12:45:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6SIjplY031558
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 12:45:51 -0600
Subject: Re: [PATCH][0/2] RTAS MSI
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 13:42:21 -0500
Message-Id: <1154112142.29826.297.camel@goblue>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-28 at 20:43 +0200, Segher Boessenkool wrote:
> >> The RTAS patch skips the intel-centric MSI layer and uses
> >> pci_enable/disable_msi() calls directly.  It does not correctly  
> >> handle
> >> multi-vector MSI either.
> >
> > Multi-vector MSIs aren't handled by the linux API anyway it seems (the
> > doc says pci_enable_msi() only ever enables one MSI) so that's fine if
> > you don't handle them :) The word on the street is that multivector  
> > MSIs
> > aren't useful, MSI-X are.
> 
> pci_enable_msi() should always enable exactly one or zero MSIs.  Maybe
> Jake's patch doesn't follow this rule, and that is what he alluded to?

Sorry, I was less-than-clear.  I was going to use this same framework
for MSI-X, and I was saying that it is not being correctly handled at
this point.

Jake
