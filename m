Return-Path: <bernhard@bwalle.de>
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de
	[80.67.18.14]) by ozlabs.org (Postfix) with ESMTP id 610861007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 05:39:16 +1100 (EST)
Message-ID: <4B101CCD.8030909@bwalle.de>
Date: Fri, 27 Nov 2009 19:39:09 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
References: <20091125131747.GA28857@in.ibm.com>
	<4B0D7CF4.8040402@bwalle.de>	<4B0E628A.9070009@in.ibm.com>
	<4B0ED674.6050501@bwalle.de> <4B0FCC0C.8060103@in.ibm.com>
In-Reply-To: <4B0FCC0C.8060103@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kexec@lists.infradead.org, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

M. Mohan Kumar schrieb:
> Hi,
> 
> As of now the kdump kernel base is fixed to be 32MB. The intention of 
> this patch is to modify that behaviour (for relocatable kernels)
> 
> * Regular kernel size may exceed 32MB, in this case we can't have kdump 
> kernelbase as 32MB.
> 
> * crashkernel=auto also assumes that kdump kernelbase as 32MB, and it 
> may also fail in reserving memory for kdump kernel.

I'm not opposed to remove the 32MB restriction, but I would like to make
the behaviour independent of CONFIG_RELOCATABLE like it's on x86:

 - Use 32M if one specifies xxx@32M
 - Use preferrably 32M, but fall back to another address if one
   specifies xxx or xxx@0M.

I don't see any problem with that. But it would make behaviour equal
accross platforms.



Regards,
Bernhard
