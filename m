Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76FB8DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Jan 2007 23:01:03 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0GC0i3h021215
	for <linuxppc-embedded@ozlabs.org>; Tue, 16 Jan 2007 13:00:44 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45ACBE65.6050602@246tNt.com>
Date: Tue, 16 Jan 2007 13:00:37 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrea Galbusera <andrea.galbusera@teamware.it>
Subject: Re: Ethernet fails on MPC5200 based target
References: <1168439212.5271.70.camel@localhost.localdomain>	<45A4FDAF.8020909@246tNt.com>
	<1168935615.22089.31.camel@localhost.localdomain>
In-Reply-To: <1168935615.22089.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrea Galbusera wrote:
>> Maybe some things (like xlb pipelining, cache snooping, ...) is not properly
>> setup in you platform support code ?
>>     
>
> Following your suggestion, I started from here... Comparing the
> unaffected kernel (from DENX) with yours I tryed commenting out the
> following in mpc52xx_setup_cpu() :
>
>   /* Disable XLB pipelining */
>   /* (cfr errate 292. We could do this only just before ATA PIO
>      transaction and re-enable it after ...) */
>   out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
>
> In fact this gives much better results, but does not completely solve
> the problem. Network packets corruption seems to be gone, but, after
> massive pinging (about 1k ping packets) it comes back with about the
> same frequency as before the change.
>   
And does the problem also appears on the denx kernel after 1k ping packets ?

Are the fec driver the same ?
Are the fec task code the same ? (in bestcomm/fec.c )
> I can't figure out what is the impact of keeping XLB pipelining enabled
> on the eth behavior. I'm sharing this results in the hope someone have
> any other valuable suggestion
>   
Well me neither, it should only affect performance, not create
corruption ...
AFAI understand it anyway.


    Sylvain
