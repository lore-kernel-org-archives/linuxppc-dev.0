Return-Path: <mikey@ozlabs.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] dtc: add setting of physical boot cpu 
In-reply-to: <7AC7793A-74F3-4596-BF28-19BCA9E388CF@watson.ibm.com> 
References: <20060518035734.2B2CA67A6D@ozlabs.org>
	<7AC7793A-74F3-4596-BF28-19BCA9E388CF@watson.ibm.com>
Date: Thu, 18 May 2006 11:59:13 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060518170017.B15E367A6C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> How does this interact with "linux,boot-cpu"?

Currently, the -b option only changes the value in blob header.
linux,boot-cpu is still taken from whatever the input dts/dtb/fs
specifies.

> If -b is defined then the absence of "linux,boot-cpu" should no  
> longer cause a warning.

For version 2 of the blob, this property should be in the header.
Perhaps we should warn if linux,boot-cpu is _missing_ when using <
version 2 and warn if it's _there_ for >= version 2.

I should add an error if someone specifies -b with version < 2.

> Perhaps if -b is missing the header value is set from "linux,boot-
> cpu" property?

I believe they're suppose to be mutually exclusive, so probably not a
good idea.

> Should we extend the "linux,boot-cpu" to actually contain a thread-id
> or are we deprecating this prop?

Yeah, the linux,boot-cpu is deprecated in version >= 2.

The dtc docs say that the boot_cpuid_phys field should match the "reg"
property in the CPU node.  Their should be a "reg" property for each
thread, which I think solves your problem.

On a different note, dtc reading blobs on little endian machines is
broken.  Just look at reserve mem entries in the output.  I think the
main issue is with flat_read_chunk using memcpy.  

Mikey
