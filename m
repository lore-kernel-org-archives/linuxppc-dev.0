Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 86B63DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 22:23:18 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <48AF5818.7010802@hypersurf.com>
References: <48AF5818.7010802@hypersurf.com>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: checkpatch nits ...
Date: Sun, 24 Aug 2008 13:23:05 +0100
Message-ID: <31720.1219580585@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs <kevdig@hypersurf.com> wrote:

> The entire block is:
> 
> 	__asm__ __volatile__ (
> 		"addi %0,%3,-1\n"
> 		"andc %1,%3,%0\n"
> 		"cntlzw %1,%1\n"
> 		"subfic %1,%1,31\n"
> 		"cntlzw %0,%2\n":
> 		"=r"(cntlz), "=r"(cnttz):
> 		"r"(tmp), "b"(cnttz)
> 	);

As long as this has no side effects, the __volatile__ isn't necessary.  If the
only effect is to produce the specified outputs based on the specified inputs,
the code can be moved or eliminated if the outputs aren't used.

David
