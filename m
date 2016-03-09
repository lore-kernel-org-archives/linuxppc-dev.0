Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3728A1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 21:13:10 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B43D8140307
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 21:13:09 +1100 (AEDT)
Date: Wed, 9 Mar 2016 11:13:05 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Torsten Duwe <duwe@lst.de>
cc: Petr Mladek <pmladek@suse.com>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
In-Reply-To: <20160309100328.GB23039@lst.de>
Message-ID: <alpine.LNX.2.00.1603091110510.3656@cbobk.fhfr.pm>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de> <20160309094423.GH10940@pathway.suse.cz>
 <20160309100328.GB23039@lst.de>
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

On Wed, 9 Mar 2016, Torsten Duwe wrote:

> > find a solution that would work transparently. I mean that adding
> > an extra hacks into selected functions in the patch might be quite
> > error prone and problems hard to debug. I think that we all want this
> > but I wanted to be sure :-)
> 
> Full ACK. Again, the TOC restore needs to go _after_ the replacement function,
> and the klp_return_helper works as transparently as possible, so this
> was my first choice. Arguments on the stack? I thought we'll deal with them
> once we get there (e.g. _really_ need to patch a varargs function or one
> with a silly signature).

Well, the problem is, once such need arises, it's too late already.

You need to be able to patch the kernels which are already out there, 
running on machines potentially for ages once all of a sudden there is a 
CVE for >8args / varargs function.
At that time, only starting to put support in the kernel for that is waaay 
to late :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
