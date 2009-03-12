Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 52241DE0D9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:57:25 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 4570B29EC9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 14:56:05 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07240-01 for <linuxppc-dev@ozlabs.org>;
	Thu, 12 Mar 2009 14:56:05 +0100 (CET)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 0B89A29EBA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 14:56:05 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: Proposal: [PATCH] Workaround for MPC5121 DTLB errata
Date: Thu, 12 Mar 2009 15:00:13 +0100
References: <200903121430.49077.david.jander@protonic.nl>
In-Reply-To: <200903121430.49077.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903121500.13283.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Please note: the proposed patch is actually incomplete, someone with better 
knowledge of PowerPC assembly than me should complete it.
According to the errata from Freescale, the proposed workaround should be a 
complete LRW (Least-Recently Written) implementation. AFAIK that would 
implicate holding an extra table in RAM with LRW information for each entry 
in the TLB.

Anyway, with this patch I am experiencing enormous speed-up overall. Some 
example tests I have done so far:

- 'mplayer -nosound -benchmark' shows a speedup of roughly 22 %

- 'prboom -timedemo test' (where 'test.lmb' is a prerecorded demo) shows an 
increase from 14.1 to 16.7 fps.

Sysnthetic memcpy() benchmarks may show a more drastic improvement (if they 
are hit by this bug):

Using 'minibench' from Gunnar Von Boehn, memcpy() speed goes up from 27Mbyte/s 
to 173Mbyte/s for memory-2-memory cases.

Greetings,

-- 
David Jander
Protonic Holland.
