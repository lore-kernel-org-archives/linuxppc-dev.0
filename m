Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE98C68A00
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2006 21:58:34 +1100 (EST)
Date: Tue, 7 Feb 2006 11:58:28 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] missing refcounting of of_find_node_by_name users
Message-ID: <20060207105828.GA30948@suse.de>
References: <20060118151840.GA24381@suse.de> <20060204115541.GB19392@suse.de>
	<20060204122013.GA20324@suse.de>
	<17384.31565.896220.384684@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17384.31565.896220.384684@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Feb 07, Paul Mackeras wrote:

> This one isn't necessary, since np is NULL by the time we get out of
> the loop.  Same applies to the other places in this file that this
> patch affects.

Ok.

> > Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pci.c
> > ===================================================================
> > --- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/pci.c
> > +++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pci.c
> > @@ -695,6 +695,7 @@ static void __init fixup_nec_usb2(void)
> >  				nec->intrs[0].line);
> >  		}
> >  	}
> > +	of_put_node(nec);
> 
> Once again, nec is NULL by the time we get here.  And of_put_node
> doesn't exist. :(  Did you compile-test this?

Only with a pegasos only config, which doesnt cover these files.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
