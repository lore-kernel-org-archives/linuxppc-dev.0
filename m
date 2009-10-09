Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 9FE84B7B7C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 11:15:31 +1100 (EST)
Date: Thu, 8 Oct 2009 17:15:27 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/6] 8xx MMU fixes
Message-ID: <20091009001527.GA6196@compile2.chatsunix.int.mrv.com>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Joakim Tjernlund (Joakim.Tjernlund@transmode.se):

> So here we go again. This time I am
> fairly confindent I got most things correct :)
> Also manged to use even less instructions in the
> TLB Miss handlers.
> 
> Scott and Rex, forget previous versions and
> try this one out.

This patch set is better, userspace seems more stable but I am still
seeing some odd problems. This is from straceing mount, which displays
nothing even though /proc/mounts shows everything mounted properly:

open("/proc/mounts", O_RDONLY)          = 3
fstat64(0x3, 0x7fe7e2a8)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001f000
read(3, 0x3001f000, 1024)               = -1 EFAULT (Bad address)
exit_group(0)                           = ?

it looks like the memory allocated using mmap is bad?

take care!
/rex.
