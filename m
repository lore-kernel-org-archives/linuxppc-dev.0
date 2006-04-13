Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD891679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 09:12:31 +1000 (EST)
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 09:12:13 +1000
Message-Id: <1144969933.4935.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-04-12 at 22:05 -0400, Jimi Xenidis wrote:
> A devtree compiler (dtc) generated devtree blob is "relocatable" and  
> so does not contain a reserved_map entry for the blob itself.
> This means that if passed to Linux, Linux will not get lmb_reserve()  
> the blob and it could be over.
> The following patch will explicitly reserve the "blob" as it was  
> given to us and stops prom_init.c from creating a reserved mapping  
> for the blob.
> 
> NOTE: that the dtc must also not generate the blob reservation  
> entry.  Should we try to detect this redundant entry? Should we bump  
> the DT version number?

We should make lmb_reserve() of redudant/overlapping entries become
harmless I think. We need to be backward compatible with earlier blobs
that do contain themselves in the reserve map

Ben.
