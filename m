Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1v7B3ZDyzDqSs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 11:21:58 +1100 (AEDT)
Message-ID: <1484526112.2660.1.camel@russell.cc>
Subject: Re: [PATCH] powerpc: Use octal numbers for file permissions
From: Russell Currey <ruscur@russell.cc>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 16 Jan 2017 11:21:52 +1100
In-Reply-To: <20170113081122.GA14043@localhost.localdomain>
References: <20170112035413.26544-1-ruscur@russell.cc>
 <20170113081122.GA14043@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-13 at 13:41 +0530, Balbir Singh wrote:
> On Thu, Jan 12, 2017 at 02:54:13PM +1100, Russell Currey wrote:
> > Symbolic macros are unintuitive and hard to read, whereas octal constants
> > are much easier to interpret.  Replace macros for the basic permission
> > flags (user/group/other read/write/execute) with numeric constants
> > instead, across the whole powerpc tree.
> > 
> 
> I know Linus said otherwise, but I wonder if the churn is worth it.
> At user mode (do man 2 chmod), these constants are used frequently,
> even with chmod the command we use chmod a+r equivalents or chmod
> u+r. My big concern with numbers is how do you know you did not
> turn on the sticky bit for a file? Can you imagine if someone used
> 0x644 or 0x444 would we catch it?

I would certainly expect something like that would be caught.

> 
> Not resisting, but thinking if the churn and what follows might be
> OK.

So long as the constants are still in the tree people will still send patches
with them (which continues to happen even though there's a checkpatch warning). 
Constants have the issue that the same value can be written multiple ways (which
is misleading) - some of the files I touched come about the same set of
permissions different ways or even mix octal values and macros within the same
file.

I think using octal values for rwx (and sticking to macros for things like the
sticky bit) is on the side of simplicity and consistency.

> 
> Balbir Singh.
