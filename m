Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 91BB62BD81
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 08:01:00 +1000 (EST)
Date: Mon, 18 Oct 2004 15:00:55 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Message-ID: <20041018220055.GA8713@gate.ebshome.net>
References: <EFB813091B18D511BD3600508B644F820A6181E7@tx14exm06.ftw.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EFB813091B18D511BD3600508B644F820A6181E7@tx14exm06.ftw.mot.com>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: Help on tuning the Linux kernel for soft real-time requirements
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2004 at 04:30:54PM -0500, Zajac Adam-AAZ004 wrote:
> I'm seeking any help on tuning the Linux kernel running in an embedded
> environment to meet some of the soft real-time requirements that we have for
> our platform.
> Our custom board is based on PPC MPC8540 processor and it runs kernel 2.4.20
> with the low-latency patch and kernel preemption enabled. The applications
> running on that board keep experiencing a "task starvation" scenario, which
> leads to missing soft real-time deadline requirements.
> 
> We've tried to prioritize the applications that needed to meet these soft
> real-time deadlines above other "background" tasks performing unarchiving
> operations (gzip + tar) through the means of adjusting dynamic as well as
> static priorities. Dynamic priorities were assigned through "nice()"
> function and static priorities were assigned for the round robin policy of
> the scheduler through "sched_setscheduler()". We've pretty much exhausted
> all combinations of the priority assignments without finding the right
> configuration that would satisfy both soft real-time deadlines and overall
> system performance requirements.
> Soft real-time deadlines are being missed during unarchiving procedures. 
> 
> Any hints and ideas would be greatly appreciated. 

Could you elaborate a little on what those soft-realtime requirements 
are? Are they sub-millisecond, milliseconds ...?

FWIW, I use 2.4.21 kernel + preempt patch (MV one, _NOT_ from rml 
patches), low-lat, O(1) scheduler and HZ = 1000.

Thread with real-time priority (any, all other threads run with 
SCHED_OTHER) and FIFO scheduler doing 10ms sleep runs pretty robust on 
440 hardware. During worst case scenario - heavy disk (SCSI) 
activity, I'm seeing rare sleeps up to 18-20ms.

--
Eugene
