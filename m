Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQt0j16zDzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 02:43:01 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQt0h4pvTz9sD5
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2016 02:43:00 +1100 (AEDT)
Date: Thu, 17 Mar 2016 16:42:56 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160317154256.GA32575@lst.de>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 05:59:40PM +1100, Balbir Singh wrote:
> 
> Changelog v6:
> 	1. Experimental changes -- need loads of testing
> 	   Based on the assumption that very far TOC and LR values
> 	   indicate the call happened through a stub and the
> 	   stub return works differently from a local call which
> 	   uses klp_return_helper.

Well, this is true, but the inverse is not.
Less than 2GiB between LR and TOC is a necessary but not a sufficient
condition for a local call.

I see the problem with your code that it hardly detects calls from one module
to another nearby. It will fail iff you mistake a global call to a module loaded
earlier to be local while patching AND you access global data / 64-bit constants
after that call before the TOC is sanitised again.

	Torsten
