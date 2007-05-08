Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89D0EDDE44
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 05:33:14 +1000 (EST)
Date: Tue, 8 May 2007 12:32:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-Id: <20070508123214.11b4f25c.akpm@linux-foundation.org>
In-Reply-To: <20070508162650.704.83752.stgit@localhost.localdomain>
References: <20070508162650.704.83752.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, wli@holomorphy.com, pavel@ucw.cz,
	dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 08 May 2007 16:26:51 +0000
Maxim Uvarov <muvarov@ru.mvista.com> wrote:

> From: Maxim Uvarov <muvarov@ru.mvista.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: pavel@ucw.cz
> Cc: linuxppc-dev@ozlabs.org
> Cc: wli@holomorphy.com
> Cc: dada1@cosmosbay.com
> Cc: pavel@ucw.cz

Strange that linux-ppc was the only mailing list you copied?

> Subject: [PATCH] Performance Stats: Kernel patch
> Date: Tue, 08 May 2007 16:26:51 +0000
> User-Agent: StGIT/0.12.1
> 
> 
> Patch makes available to the user the following
> task and process performance statistics:
> 	* Involuntary Context Switches (task_struct->nivcsw)
> 	* Voluntary Context Switches (task_struct->nvcsw)
> 	* Number of system calls (added new counter
> 	  thread_info->sysall_count)
> 	           
> Statistics information is available from:
>         1. taskstats interface (Documentation/accounting/)
> 	2. /proc/PID/status (task only).
> 
> This data is useful for detecting hyperactivity
> patterns between processes.

syscall entry is a super-hotpath and there will be a developer revolt
if we go adding an incl to that path, sorry.

(Did that incl also cover the int 80 entry?)
