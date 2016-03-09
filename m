Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9E71A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 21:03:33 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5DDEF140B0D
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 21:03:31 +1100 (AEDT)
Date: Wed, 9 Mar 2016 11:03:28 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309100328.GB23039@lst.de>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de> <20160309094423.GH10940@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309094423.GH10940@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 10:44:23AM +0100, Petr Mladek wrote:
> find a solution that would work transparently. I mean that adding
> an extra hacks into selected functions in the patch might be quite
> error prone and problems hard to debug. I think that we all want this
> but I wanted to be sure :-)

Full ACK. Again, the TOC restore needs to go _after_ the replacement function,
and the klp_return_helper works as transparently as possible, so this
was my first choice. Arguments on the stack? I thought we'll deal with them
once we get there (e.g. _really_ need to patch a varargs function or one
with a silly signature).

	Torsten
