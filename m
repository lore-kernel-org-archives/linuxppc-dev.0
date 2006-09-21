Return-Path: <vgoyal@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE06D67BB4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 00:11:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8LEBSQs012879
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 10:11:28 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8LEBSCi297010
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 10:11:28 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8LEBRw7028950
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 10:11:28 -0400
Date: Thu, 21 Sep 2006 10:10:49 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] kdump: don't call __ioremap() for pfn = 0
Message-ID: <20060921141049.GB1542@in.ibm.com>
References: <451216EE.8010404@in.ibm.com>
	<1158836557.7062.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158836557.7062.52.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Fastboot mailing list <fastboot@lists.osdl.org>
Reply-To: vgoyal@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 09:02:37PM +1000, Michael Ellerman wrote:
> On Thu, 2006-09-21 at 10:07 +0530, Sachin P. Sant wrote:
> > Hi
> > 
> > While using dd command to retrive the dump from /dev/oldmem, there comes
> > a rare case where pfn value is zero. In this case the __ioremap() call 
> > returns
> > NULL and hence copying fails.
> > 
> > # dd if=/dev/oldmem of=/dev/null
> > dd: reading `/dev/oldmem': Bad address
> > 0+0 records in
> > 0+0 records out
> > 0 bytes (0 B) copied, 0.000121 seconds, 0.0 kB/s
> > 
> > Attached is a patch to fix this problem. During such rare cases don't call
> > __ioremap() to do the address translation, instead use __va() .
> 
> It's not really rare, it's just when we're reading /dev/oldmem directly.
> 
> We can actually use the __va() trick for the whole linear mapping rather
> than just pfn 0, which saves the ioremap. We also shouldn't really be
> trying to iounmap(__va(0)).
> 

Makes sense. We can take advantage of linear mappings mapped till max_pfn
and avoid ioremap().

> +
> +static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
> +				unsigned long offset, int userbuf)
> +{
> +	if (userbuf) {
> +		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
> +			return -EFAULT;
> +		}

Probably you can get rid of above pair of braces as there is only single
statement under if.

>  
> -	if (userbuf) {
> -		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
> -			iounmap(vaddr);
> -			return -EFAULT;
> -		}
> -	} else
> -		memcpy(buf, (vaddr + offset), csize);
> +	if (pfn < max_pfn) {

Should this be (pfn <= max_pfn) ?

-Vivek
