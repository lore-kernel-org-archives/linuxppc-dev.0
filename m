Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F571A097B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 04:54:45 +1100 (AEDT)
Message-ID: <546B87E0.3070802@suse.de>
Date: Tue, 18 Nov 2014 18:54:40 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 00/11]: powerKVM, release the compute power of secondary
 hwthread on host
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16.10.14 21:29, kernelfans@gmail.com wrote:
> Nowadays, when running powerKVM(book3s, hv mode), we should make the secondary hwthread
> offline. Which means that if we run misc tsks other than dedicated KVM (e.g mix java and KVM),
> we will lose the compute power of the secondary hwthread on host env.

I'm personally more concerned about IO threads and the likes blocking
CPUs that could do actual work.

But really, IMHO this should just get fixed in hardware. The patch set
looks like quite a good addition of complexity to an already complex
problem - which means it will definitely break :).

Couldn't we just do something as simple as partition the system into SMT
and non-SMT cores? Then the user can just say "keep 2 cores in SMT mode"
and we would refuse to run KVM threads on those.

But then again we would bounce on these threads and increase latency on
entry if we happen to get scheduled there, so it's probably not a win
either.

I really don't have a good answer, except for "POWER8 wasn't designed
for this".


Alex
