Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2hYW1vZdzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 18:29:03 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id f144so15664385pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 23:29:03 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Jan 2017 12:58:55 +0530
To: Russell Currey <ruscur@russell.cc>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Use octal numbers for file permissions
Message-ID: <20170117072855.GF8963@dhcp-9-109-223-248.in.ibm.com>
References: <20170112035413.26544-1-ruscur@russell.cc>
 <20170113081122.GA14043@localhost.localdomain>
 <1484526112.2660.1.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484526112.2660.1.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 11:21:52AM +1100, Russell Currey wrote:
> On Fri, 2017-01-13 at 13:41 +0530, Balbir Singh wrote:
> > On Thu, Jan 12, 2017 at 02:54:13PM +1100, Russell Currey wrote:
> > > Symbolic macros are unintuitive and hard to read, whereas octal constants
> > > are much easier to interpret.  Replace macros for the basic permission
> > > flags (user/group/other read/write/execute) with numeric constants
> > > instead, across the whole powerpc tree.
> > > 
> > 
> > I know Linus said otherwise, but I wonder if the churn is worth it.
> > At user mode (do man 2 chmod), these constants are used frequently,
> > even with chmod the command we use chmod a+r equivalents or chmod
> > u+r. My big concern with numbers is how do you know you did not
> > turn on the sticky bit for a file? Can you imagine if someone used
> > 0x644 or 0x444 would we catch it?
> 
> I would certainly expect something like that would be caught.
>

OK.. Lets hope so.
 
> > 
> > Not resisting, but thinking if the churn and what follows might be
> > OK.
> 
> So long as the constants are still in the tree people will still send patches
> with them (which continues to happen even though there's a checkpatch warning). 
> Constants have the issue that the same value can be written multiple ways (which
> is misleading) - some of the files I touched come about the same set of
> permissions different ways or even mix octal values and macros within the same
> file.

I don't think anyone prevents 0444 | 0200 from being sent. It's just that
associativity rules allow for composing things differently.

> 
> I think using octal values for rwx (and sticking to macros for things like the
> sticky bit) is on the side of simplicity and consistency.
>

Fair enough, maintainer gets to decide :)

Balbir Singh. 
