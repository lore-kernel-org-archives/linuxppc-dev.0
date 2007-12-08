Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62A23DDDEA
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 15:45:47 +1100 (EST)
Date: Fri, 7 Dec 2007 20:45:21 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
In-Reply-To: <475A1E6E.3010303@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.0.9999.0712072040300.26622@chino.kir.corp.google.com>
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207221106.GH16824@localdomain>
	<4759C89B.9000709@linux.vnet.ibm.com>
	<alpine.DEB.0.9999.0712071510370.27689@chino.kir.corp.google.com>
	<475A1E6E.3010303@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 8 Dec 2007, Balbir Singh wrote:

> > You're going to want to distribute the cpu's based on how they match up 
> > physically with the actual platform that you're running on.  x86_64 does 
> 
> Could you explain this better, how does it match up CPU's with fake NUMA
> memory? Is there some smartness there? I'll try and look at the code and
> also see what I can do for PowerPC
> 

numa_cpumask_lookup_table[] would return the correct cpumask for the fake 
node index.  Then all the code that uses node_to_cpumask() in generic 
kernel code like the scheduler and VM still preserve their true NUMA 
affinity that matches the underlying hardware.  I tried to make x86_64 
fake NUMA as close to the real thing as possible.

You also probably want to make all you changes dependent on 
CONFIG_NUMA_EMU like the x86_64 case.  That'll probably be helpful as you 
extend this tool more and more.

		David
