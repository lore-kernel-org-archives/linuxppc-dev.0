Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A808C67A3D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 14:56:44 +1000 (EST)
Subject: Re: [PATCH][0/2] RTAS MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1154024154.29826.229.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 06:56:39 +0200
Message-Id: <1154062599.21801.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-07-27 at 13:15 -0500, Jake Moilanen wrote:
> Here is a rebased RTAS MSI which uses the IRQ layer rewrite.  Please try
> getting it into 2.6.18.  
> 
> I mistakenly forgot to export the MSI symbols.  So modules weren't too
> happy...
> 
> The RTAS patch skips the intel-centric MSI layer and uses
> pci_enable/disable_msi() calls directly.  It does not correctly handle
> multi-vector MSI either.  

Multi-vector MSIs aren't handled by the linux API anyway it seems (the
doc says pci_enable_msi() only ever enables one MSI) so that's fine if
you don't handle them :) The word on the street is that multivector MSIs
aren't useful, MSI-X are.

Ben.
