Return-Path: <jschopp@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E74AD2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 05:03:54 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jschopp@linux.vnet.ibm.com>;
 Mon, 28 Oct 2013 14:03:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AA5D3C90026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 14:03:48 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9SI3nYL61800524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 18:03:49 GMT
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9SI3mTm002940
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 12:03:48 -0600
Message-ID: <526EA6FF.2080401@linux.vnet.ibm.com>
Date: Mon, 28 Oct 2013 13:03:43 -0500
From: Joel Schopp <jschopp@linux.vnet.ibm.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>,
 linuxppc-dev@lists.ozlabs.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [tpmdd-devel] Has anyone a ATMEL TPM Chip on PPC64
 (CONFIG_TCG_ATMEL)?
References: <201310272306.09310.PeterHuewe@gmx.de>
In-Reply-To: <201310272306.09310.PeterHuewe@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/27/2013 05:06 PM, Peter Hüwe wrote:
> Hi,
> 
> I was wondering if anyone here on this list still has a machine with an old 
> ATMEL TPM (trusted platform module) lying around?
> 
>>From the kconfig entry it becomes evident that it was only supported on ppc64 
> machines.
> 
> config TCG_ATMEL
> 	tristate "Atmel TPM Interface"
> 	depends on PPC64 || HAS_IOPORT
> 	---help---
> 	  If you have a TPM security chip from Atmel say Yes and it 
> 	  will be accessible from within Linux.  To compile this driver 
> 	  as a module, choose M here; the module will be called tpm_atmel.
> 
> The hardware/driver is pretty old and the driver might have contained a bug 
> that made it unusable for the last 6 years ;)
> 
> So if anyone still has this kind of hardware around, please reply.
> 

As near as I can tell this was on a single machine type (the js21 circa
2006).  The firmware on the machine didn't support establishing a root
of trust, so use of the TPM was as a practical matter effective only for
the other functions like random number generation and key management.
The number of users who used the TPM for this on this machine was likely
very small 7 years ago.  The number of those machines still in service
today is likely smaller still.  The cross section of those two small
numbers combined with those who want to run on a shiny new kernel has to
be quickly approaching zero.

I reccomend removing the driver.  If the stars align and a user actually
appears who wants to use one I'll clean up the driver and resubmit it
for inclusion.  I just don't think that will happen.

-Joel
