Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 33B31B71B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:56:20 +1000 (EST)
Subject: Re: [PATCH] Re:[BUILD FAILURE 04/04] Next June 04:PPC64 randconfig
	[drivers/net/ucc_geth.o]
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
	Li Yang <leoli@freescale.com>
In-Reply-To: <20090611110523.1fd56a41.sfr@canb.auug.org.au>
References: <20090610174323.28045.70169.sendpatchset@subratamodak.linux.ibm.com>
	<20090611110523.1fd56a41.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2009 07:26:04 +0530
Message-Id: <1244685364.6494.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-11 at 11:05 +1000, Stephen Rothwell wrote:
> Hi Subrata,
> 
> On Wed, 10 Jun 2009 23:13:23 +0530 Subrata Modak <subrata@linux.vnet.ibm.com> wrote:
> >
> >  	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
> > -	ph = of_get_property(np, "tbi-handle", NULL);
> > +	ph = (phandle *)of_get_property(np, "tbi-handle", NULL);
> 
> You don't need this cast because of_get_property() returns "void *".

Stephen,

True. But without this gcc complains:

CC [M]  drivers/net/ucc_geth.o
drivers/net/ucc_geth.c: In function ‘ucc_geth_probe’:
drivers/net/ucc_geth.c:3824: warning: assignment discards qualifiers
from pointer target type

Else gcc just builds fine:

CC [M]  drivers/net/ucc_geth.o

This is an just an extra caution to fix both the build and warning
regression(s).

Regards--
Subrata

> 
