Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D97EC679E9
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 03:32:35 +1000 (EST)
Date: Sat, 15 Apr 2006 12:31:16 -0500
To: Carl Love <cel@us.ibm.com>
Subject: Re: patch for powerpc lparcfg.c
Message-ID: <20060415173116.GA21864@pb15.lixom.net>
References: <1144969793.5286.10.camel@dyn9047021119.beaverton.ibm.com>
	<20060414002539.GC25138@localdomain>
	<1145035146.5214.16.camel@dyn9047021119.beaverton.ibm.com>
	<20060414175039.GD25138@localdomain>
	<1145060162.5214.30.camel@dyn9047021119.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145060162.5214.30.camel@dyn9047021119.beaverton.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 14, 2006 at 05:16:02PM -0700, Carl Love wrote:
> Nathan Lynch:
> 
> Oops, lost the cc line the last time.
> 
> I wasn't aware that the partition name was already being printed in
> the /proc/device-tree.  Yes, my tool could use that entry.  It just
> means opening multiple locations to get all the information.  I will go
> ahead and use it since it is there.   
> 
> The patch becomes a bit more academic.  The question becomes, should the
> partition name also be printed in /proc/ppc64/lparcfg along with the
> rest of the partition information?  Seems like a good idea to me since
> it makes the information in lparcfg more complete.  I will leave it up
> to the maintainers to decide. 

IMHO, duplicating the information is just extra overhead. It's not a
piece of data I would expect applications to have performance-critical
access requirements for, so the extra file open isn't that much of a
bother.

In general, adding things to an interface like lparcfg just means we
will need to maintain it there forever. The less we can get away with
in such ways, the better.

I think lparcfg is a leftover from the iseries days, where there was no
more convenient way to pass the information to userspace (since there is
no native device tree in that environment). We have since then added one
in linux, but the hypervisor doesn't provide it to us.


-Olfo
