Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3F800DDE48
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:51:56 +1100 (EST)
Date: Sun, 28 Jan 2007 15:51:55 -0800 (PST)
Message-Id: <20070128.155155.51857352.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
References: <m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
	<1170026259.26655.114.camel@localhost.localdomain>
	<m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, brice@myri.com,
	greg@kroah.com, shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 16:38:28 -0700

> That isn't even the reason it is that way.  It is because allocating
> 4096 irqs in a single vector is a bad idea, and because it requires you
> to pass type information of what kind of msi you are dealing with to the
> lower levels in an allocation routine that make it bad idea.  Because
> if you don't consider the IBM HV it provides not benefit and just puts
> unnecessary loops, and type information in architecture code.

Eric, get over it, sparc64 will need this kind of abstraction
too in order to support MSI properly.

There are specific calls into the sparc64 hypervisor for MSI vs. MSI-X
configuration operations.  So a type is necessary.

Sun Niagara and IBM RTAS hypervisors are not going to get
rearchitected because you peed your pants over this on some Linux
mailing list :-)  Trust me on that one :))
