Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DB14B7334
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 17:00:55 +1100 (EST)
In-Reply-To: <20091009001527.GA6196@compile2.chatsunix.int.mrv.com>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091009001527.GA6196@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH 0/6] 8xx MMU fixes
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OF505AFA1E.D2D84793-ONC125764A.0020E20A-C125764A.00210186@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 9 Oct 2009 08:00:30 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

Rex Feany <RFeany@mrv.com> wrote on 09/10/2009 02:15:27:
>
> Thus spake Joakim Tjernlund (Joakim.Tjernlund@transmode.se):
>
> > So here we go again. This time I am
> > fairly confindent I got most things correct :)
> > Also manged to use even less instructions in the
> > TLB Miss handlers.
> >
> > Scott and Rex, forget previous versions and
> > try this one out.
>
> This patch set is better, userspace seems more stable but I am still
> seeing some odd problems. This is from straceing mount, which displays
> nothing even though /proc/mounts shows everything mounted properly:
>
> open("/proc/mounts", O_RDONLY)          = 3
> fstat64(0x3, 0x7fe7e2a8)                = 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001f000
> read(3, 0x3001f000, 1024)               = -1 EFAULT (Bad address)
> exit_group(0)                           = ?
>
> it looks like the memory allocated using mmap is bad?

Try making the tlbil_va in fault.c unconditional, just to make sure
there isn't any old TLBs  around.
