Return-Path: <orenl@cs.columbia.edu>
Received: from brinza.cc.columbia.edu (brinza.cc.columbia.edu [128.59.29.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF0B2DDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 20:15:45 +1100 (EST)
Message-ID: <49C0BB99.7090609@cs.columbia.edu>
Date: Wed, 18 Mar 2009 05:15:05 -0400
From: Oren Laadan <orenl@cs.columbia.edu>
MIME-Version: 1.0
To: Cedric Le Goater <legoater@free.fr>
Subject: Re: [PATCH 1/3] powerpc: bare minimum
	checkpoint/restart	implementation
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>	<1233182478-27113-2-git-send-email-ntl@pobox.com>	<49814FA2.9060108@cs.columbia.edu>
	<20090129214035.GB6913@localdomain>	<20090217010355.58afd5cf@thinkcentre.lan>	<49B9D37A.1070503@cs.columbia.edu>
	<20090316133745.4f636979@thinkcentre.lan>
	<49BF4969.3080308@free.fr>
In-Reply-To: <49BF4969.3080308@free.fr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: containers@lists.osdl.org, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, "Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


An alternative: the task that created the container namely, is the parent
(outside the container) of the container init(1). In turn, init(1) creates
a special 'monitor' thread that monitors the restart, and the outside task
reaps the exit status of that thread (and only that thread).

[Hmmm... thinking about this - what happens if the container init(1) calls
clone() with CLONE_PARENT ??  does it not generate sort of a competing
container init(1) ??!!

Oren.


Cedric Le Goater wrote:
>> Again, how would 'cr' obtain exit status for these tasks, and how would
>> it distinguish failure from normal operation?
> 
> Here's our solution to this issue.
> 
> mcr maintains in its kernel container object an exitcode attribute for 
> the mcr-restart process. This process is detached from the fork tree of 
> the restarted application.  
> 
> when the restart is finished, an mcr-wait command can be called to reap 
> this exitcode. This make it possible to distinguish an exit of the 
> application process from an exit of the mcr-restart process.
> 
> This is a must-have for batch managers in an HPC environment. 
> 
> Cheers,
> 
> C.
> 
