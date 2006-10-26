Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DE9667E01
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 23:50:11 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id k9QDo1gA195514
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 13:50:01 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k9QDqbeb2248846
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 14:52:37 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k9QDo0WC004453
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 14:50:01 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2.6.19-rc3 2/2] ehea: 64K page support fix
Date: Thu, 26 Oct 2006 15:00:20 +0200
References: <200610251312.01235.ossthema@de.ibm.com>
	<20061025162126.GB25324@krispykreme>
In-Reply-To: <20061025162126.GB25324@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610261500.20898.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

that is right, I'll send a new patch

Thanks,
Jan-Bernd

On Wednesday 25 October 2006 18:21, Anton Blanchard wrote:
> 
> Hi,
> 
> > +#ifdef CONFIG_PPC_64K_PAGES
> > +	/* To support 64k pages we must round to 64k page boundary */
> > +	epas->kernel.addr =
> > +		ioremap((paddr_kernel & 0xFFFFFFFFFFFF0000), PAGE_SIZE) +
> > +		(paddr_kernel & 0xFFFF);
> > +#else
> >  	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
> > +#endif
> 
> Cant you just use PAGE_MASK, ~PAGE_MASK and remove the ifdefs
> completely?
> 
> Anton
> 
