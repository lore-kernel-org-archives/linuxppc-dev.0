Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 831881A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 23:58:43 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 120651401CA
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 23:58:42 +1100 (AEDT)
Date: Thu, 10 Mar 2016 13:58:39 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: Torsten Duwe <duwe@lst.de>, jeyu@redhat.com, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] ppc64le live patch: get rid of mini stack frame
In-Reply-To: <20160310125116.GS10940@pathway.suse.cz>
Message-ID: <alpine.LNX.2.00.1603101357100.3656@cbobk.fhfr.pm>
References: <20160309172821.GC27913@lst.de> <20160309173017.GD27913@lst.de>
 <20160310122508.GR10940@pathway.suse.cz>
 <20160310125116.GS10940@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 10 Mar 2016, Petr Mladek wrote:

> BTW: How is this solved in kretprobes? Or is it easier there?

Is that really a problem? With kretprobes you're never performing the 
module->core->module transition in "one" redirection, right?

The 'kretprobe_trampoline' is a global symbol, and hence everybody is 
generating 'global call' for it, and that's pretty much it.

-- 
Jiri Kosina
SUSE Labs
