Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 3BBDFDDF36
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:26:53 +1000 (EST)
In-Reply-To: <20070423223910.4955.18106.stgit@localhost.localdomain>
References: <20070423223649.4955.77579.stgit@localhost.localdomain>
	<20070423223910.4955.18106.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5AC8BD28-125C-4552-97E9-D35E85D0E555@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2/2] POWERPC: Remove global CPM mappings
Date: Mon, 23 Apr 2007 21:26:59 -0400
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 23, 2007, at 6:39 PM, Vitaly Bordug wrote:

>
> Gets rid or direct IMMR accesses/dereferences for PQ SoC targets and
> relevant drivers.

Can we find a way to do this without the constant
ioremapping and unmapping?  It's a quick and
dirty hack, but it would be nice if we could map once
during an initialization, keep the pointer around
and at least use it within the file context.  I know it
doesn't cost much, but all of these cycles add up,
and someday ioremap could grow into something
more complex.  Please?

The whole of the CPM supporting functions need this,
it could be mapped once and shared at least among
them.  Any drivers that use the IMMR should also be
cleaner about managing this space as they would
any other mapped resource that is typically done
only once for the life of the driver.

There are also many different methods used that
I don't understand the reason.  Sometimes the
mappings are hidden in macros, sometimes done
in a function that is called, other times ioremap()
is called explicitly.  It just looks, well....  icky.  :-)


Thanks.

	-- Dan
