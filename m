Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32F7FDDE21
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 10:03:37 +1100 (EST)
Subject: Re: [RFC/PATCH] Add a device_initcall to machdep_calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20071130225043.12499.86364.stgit@trillian.secretlab.ca>
References: <20071130225043.12499.86364.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 09:58:06 +1100
Message-Id: <1196463486.13230.116.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 15:51 -0700, Grant Likely wrote:
> 
> Add a device_initcall hook to machdep_calls so that platform code
> doesn't
> need to register device_initcalls that must first check what platform
> it is running on.
> 
> This should (slightly) speed boot time on kernels that support a lot
> of
> boards and make device_initcall hooks slightly simpler to implement
> because the platform doesn't need to be tested when called.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Please comment; I think this is a good change, but I'd like some
> feedback.

Hrm... I'm not too sure about it... 

My initial idea for dealing with that issue was more along the lines of
defining a set of

machine_xxx_initcall(mach, function)

Where xxx is (arch,core,subsys,fs,device, whatever...)

Those could, at first be implemented as a simple macro wrapper that
expands to a function that tests machine_is() and calls the function,
and later one, we can do more fancy things, such as ELF sections with
function pointers in them.

Ben.
