Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0455DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:29:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49GTkiN019781
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:29:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49GTjlj540868
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:29:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49GTjjw027381
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:29:45 -0400
Date: Wed, 9 May 2007 11:29:45 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/4] powerpc: EEH: capture and log pci state on error
Message-ID: <20070509162945.GU4452@austin.ibm.com>
References: <20070508230952.GN4452@austin.ibm.com>
	<20070508233532.GR4452@austin.ibm.com>
	<20070509045439.GB1771@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070509045439.GB1771@lixom.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 11:54:39PM -0500, Olof Johansson wrote:
> Hi,
> 
> > +#define EEH_PCI_REGS_LOG_LEN 4096
> > +static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
> 
> I'm guessing this has to be in BSS because of the requrements of being
> addressable in realmode for RTAS? Could be nice to document in a comment
> so noone tries to make it a local variable later on.

Yep, exactly. Funny, I thought exactly that: "Someone is going to want
me to change this to a kmalloc. What should I do to avoid this
question?" It never occured to me that all I needed was a mere comment.

--linas
