Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDf1F3fQszDqJd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:08:17 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Kosina' <jikos@kernel.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, Jessica Yu <jeyu@redhat.com>, Vojtech Pavlik
 <vojtech@suse.com>, Petr Mladek <pmladek@suse.com>, Peter Zijlstra
 <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Andy
 Lutomirski" <luto@kernel.org>, "live-patching@vger.kernel.org"
 <live-patching@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Miroslav Benes
 <mbenes@suse.cz>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Chris J Arges <chris.j.arges@canonical.com>
Subject: RE: livepatch: change to a per-task consistency model
Date: Tue, 24 May 2016 15:06:54 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4C5254@AcuExch.aculab.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160517225357.GA30725@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1605181011550.31937@cbobk.fhfr.pm>
 <20160518165147.vyuamqfnm5kfwiqf@treble>
 <alpine.LNX.2.00.1605182221420.31937@cbobk.fhfr.pm>
 <063D6719AE5E284EB5DD2968C1650D6D5F4C40D2@AcuExch.aculab.com>
 <alpine.LNX.2.00.1605232043300.31937@cbobk.fhfr.pm>
In-Reply-To: <alpine.LNX.2.00.1605232043300.31937@cbobk.fhfr.pm>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jiri Kosina=20
> Sent: 23 May 2016 19:45
> > Related, please can we have a flag for the sleep and/or process so that
> > an uninterruptible sleep doesn't trigger the 'hung task' detector
>=20
> TASK_KILLABLE

Not sure that does what I want.
It appears to allow some 'kill' actions to wake the process.
I'm sure I've looked at the 'hung task' code since 2007.

> > and also stops the process counting towards the 'load average'.
>=20
> TASK_NOLOAD

Ah, that was added in May 2015.
Not surprising I didn't know about it.

I'll leave the code doing:
  set_current_state(signal_pending(current) ? TASK_UNINTERRUPTIBLE ? TASK_I=
NTERRUPTIBLE);
for a while longer.

	David
