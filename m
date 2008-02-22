Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1B5FEDDF27
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 06:05:32 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 22 Feb 2008 20:05:31 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <ebff4ecb45908616728fb5c8ede8b0bf@bga.com>
Message-ID: <20080222190531.103050@gmx.net>
MIME-Version: 1.0
References: <ebff4ecb45908616728fb5c8ede8b0bf@bga.com>
Subject: Re: How to dynamically disable/enable CPU features?
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

-------- Original-Nachricht --------
> Datum: Fri, 22 Feb 2008 11:24:38 -0600
> Von: Milton Miller <miltonm@bga.com>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: ppcdev <linuxppc-dev@ozlabs.org>
> Betreff: Re: How to dynamically disable/enable CPU features?

> We handle cpu features in a couple of ways:
> (1) we replace assembly instructions with nop early in the kernel boot
I'm pretty sure that is the problem.

> (2) we test the feature flags in c code
> 
> In (2), we form two expressions for features that are
> (a) always set
> (b) never set
> so that the compiler can eliminate the test based on the config.
> 
> To change a flag, you must make sure its in POSSIBLE but not ALWAYS, 
> and also set it before it is used, either to nop out instructions (see 
> early_init in setup-32.c for 32 bit), or tested by c code (in this 
> case, maybe the initial_mmu setup is testing NEED_COHERENT, which is 
> between early_init and probe). The code path is a bit different for 64
> bit.
The flag is in POSSIBLE. I now use this code in the platform probe
function to nop out the code affected by the flag:

cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
/* Patch out unwanted feature. */
do_feature_fixups(cur_cpu_spec->cpu_features,
		  PTRRELOC(&__start___ftr_fixup),
		  PTRRELOC(&__stop___ftr_fixup));

It seems to work so far, but I would like to know if this is the right
way to do it, or if calling do_feature_fixups() more than once can have
any side effects.

regards,

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
