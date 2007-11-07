Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id E30FCDDD0D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 06:20:02 +1100 (EST)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 145B82F9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 14:20:20 -0500 (EST)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E315493336
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 14:20:19 -0500 (EST)
Date: Wed, 7 Nov 2007 13:19:42 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Fix rtas_ibm_suspend_me bugs
Message-ID: <20071107191942.GN9695@localdomain>
References: <20071106044309.GK9695@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071106044309.GK9695@localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> (very rfc for now, no sign-off, needs more testing)
> 
> There are a couple of bugs in the rtas_ibm_suspend_me() and
> rtas_percpu_suspend_me() functions:
> 
> 1.  rtas_ibm_suspend_me() uses on_each_cpu() to invoke
> rtas_percpu_suspend_me() via IPI:
> 
> if (on_each_cpu(rtas_percpu_suspend_me, &data, 1, 0))
> ...
> 
> 'data' is on the stack, and rtas_ibm_suspend_me() takes no measures to
> ensure that all instances of rtas_percpu_suspend_me() are finished
> accessing 'data' before returning.  This can result in the IPI'd cpus
> accessing random stack data and getting stuck in H_JOIN.

Another possible issue is that H_JOIN requires MSR.EE to be off, but
lazy interrupt disabling could conceivably allow that constraint to be
violated if we end up doing H_JOIN on the cpu which calls on_each_cpu().
At least I think so...
