Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp14.wanadoo.fr (smtp14.wanadoo.fr [193.252.23.69])
	by ozlabs.org (Postfix) with ESMTP id B0CBA688F8
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 22:09:10 +1100 (EST)
Received: from smtp14.wanadoo.fr (mwinf1406 [172.22.145.34])
	by mwinf1405.wanadoo.fr (SMTP Server) with ESMTP id DB4D61C06E96
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 11:48:47 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1406.wanadoo.fr (SMTP Server) with ESMTP id A1CEB70000B7
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 11:48:44 +0100 (CET)
Received: from pegasos (AStrasbourg-251-1-13-240.w82-126.abo.wanadoo.fr
	[82.126.203.240])
	by mwinf1406.wanadoo.fr (SMTP Server) with ESMTP id 80DC27000096
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 11:48:44 +0100 (CET)
Received: from sven by pegasos with local (Exim 4.50) id 1ErYqw-0003NT-DM
	for linuxppc-dev@ozlabs.org; Wed, 28 Dec 2005 11:48:18 +0100
Date: Wed, 28 Dec 2005 11:48:13 +0100
To: linuxppc-dev@ozlabs.org
Message-ID: <20051228104813.GA12862@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Sven Luther <sven.luther@wanadoo.fr>
Subject: ARCH=powerpc kexec seems to be broken ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, ...

I have for some time tried to build 2.6.15-rc debian kernels with
ARCH=powerpc, and never quite succeeded. Thanks to Johannes Berg
for helping investigating the issue.

The problem seems to be that my .config enables KEXEC, and SWSUSP,
which has nasty problems with ARCH=powerpc. In a 32bit config, i get :

00:03 < svenl> arch/ppc/kernel/built-in.o: In function `swsusp_arch_resume': multiple definition of `machine_shutdown'
00:03 < svenl> arch/powerpc/kernel/built-in.o: first defined here

Which seems to indicate that machine_shutdown is built twice, once in the
arch/ppc stuff and a second time in the arch/powerpc stuff.

I have a similar problem for the 64bit case, but have not yet reached the
point of the build where this happens, so i can't paste the error message
here, but it was of the same kind as above if i remember well.

Johannes said :

11:23 < johill> you enabled kexec, right?
11:24 < svenl> yeah, i did.
11:24 < svenl> is it broken for ARCH=powerpc right now ?
11:24 < johill> seems so
11:28 < johill> yeah. I don't think I can fix it, know too little about kexec
11:30 < johill> machine_shutdown should at least be moved from
arch/ppc/kernel/machine_kexec.c to some file that is ARCH=ppc specific
11:31 < svenl> johill: as i understand this, i think it is already in some
ARCH=ppc specific file, which is the cause of this trouble.
11:32 < johill> the way I interpret it is that the machine_kexec.c file is
compiled for ARCH=powerpc too since it contains the 32bit specific
implementation of kexec
11:32 < johill> but it contains a non-static machine_shutdown() function which
ARCH=powerpc already moved to some non-32bit specific file

So, it would be neat to either fix it, or at least mark the option as broken
on 64bit powerpc, or something such.

Friendly,

Sven Luther
