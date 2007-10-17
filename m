Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9BC1DDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:04:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HN4oJS011575
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 19:04:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HN4ohO408494
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 17:04:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HN4nSH031096
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 17:04:50 -0600
Date: Wed, 17 Oct 2007 18:04:49 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-ID: <20071017230449.GZ4891@austin.ibm.com>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 17, 2007 at 05:12:27PM +1000, Michael Ellerman wrote:

> +struct device_node *of_get_pci_dev_node(struct pci_dev *pdev)
> +{
> +       return of_node_get(pci_device_to_OF_node(pdev));
> +}

[...]

> -	dn = of_node_get(pci_device_to_OF_node(dev));
> +	dn = of_get_pci_dev_node(dev);

Is this really useful or wise?

As a matter of personal taste, I find stuff like this clutters
and confuses my mind. I go to read new code, and I run across some
routine I haven't heard of before ... e.g. of_get_pci_dev_node(),
so now I have to look it up to see what it does.  A few minutes later, 
I realize that its just a pair of old freinds (of_node_get and 
pci_device_to_OF_node) and so now I have to make mental room for it.  

Tommorrow, or 3 days later, I'm again looking at of_get_pci_dev_node()
and I'm thinking "gee what did that thing do again??"

I don't much like this style, and I've been known to submit
patches that remove stuff like this ... 

--linas
