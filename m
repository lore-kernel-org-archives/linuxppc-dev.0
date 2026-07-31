Return-Path: <linuxppc-dev+bounces-25162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D634C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 04:59:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBDPg3mRgz2xlQ;
	Fri, 31 Jul 2026 14:59:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785473959;
	cv=none; b=GP3TIPDieqPcc+xcVPNwAEEod8Km1e1RKMVKR6n3jvOM4ej05U9zxovmhltj8X6peQPzjkK2KV0DvUBcdu+Ocv98XQodPgkF+sV2nqY/FtSwDjW3rp+CagEhP92Rm+SIf6QIojvvwdmg0nTrk4Y8/MXS62YT0QWCy55GizjC/Fk8meeZln4fkEpgYC+ninipbEXg9jmnHH2AeOOgtECOm2egy2HxZcLyW0G7NrDDPrYcUQkF7J1GROYrNFUFQvKtLkrEJNPcBHYkFD91rdqI895CPhGh/FFy8p31x9XnDDZSITl3EZ8+dud+Fa0Aw1y21TYtRd9nE7OliIN/aFp53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785473959; c=relaxed/relaxed;
	bh=a999mUVEywWRQZPkmOa+G1jSM9VJYIVya6xi8BuT0Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCfxe9yJG1RUGUXPriIlQWeunhtpY2TrVz4IWM/0CmxdqKCnxtN1aDztId6drHw7SpUhyH95TelFYTgwAxNquJp0mG2roAdjotJiETnBq+UgwC0W3a4YV+YEGq06rQ2odUTIBtW/8z3AGMHf4yhuTI20CDGs3zpNwh2/7QPv0JK4lQ+o2yQ/rO2AuunqH5NaSyF9/IecmRbUI8USnH3aA6z+QcWKaQJqiMuOipZzwobzhCtZ1Mvy2Z/LopOFYjnLoKfBqn+4DVUOnCO9f4X3dwNGQnHwRFunS0IS2XzfhlEK06FdW1+tLg/n8v6xq6hOvVPEAilyLaeQC3i5cdXbBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOSt66wf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOSt66wf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBDPf3Jqsz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 14:59:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 45880601E0;
	Fri, 31 Jul 2026 04:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDE51F000E9;
	Fri, 31 Jul 2026 04:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785473954;
	bh=a999mUVEywWRQZPkmOa+G1jSM9VJYIVya6xi8BuT0Vs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IOSt66wfK06lO8C5JtXJp6Wa67OHg+dxdOMKJkCnd7tFDmoSzoeKuLii6OMZKWzeh
	 66Fsdv5CLRbq+01vCQVbhB+q8SDPnR+Goc0P51NrYna0WKtwaTJhkLWBp5fKk8AywH
	 8YZSXUn7T+e+x8u9oZky+Ykdwf9YQsA1OTRIt1EY3EW2mhvlMbPYd2f9WoP92cf3lQ
	 K3Gy9q+lCBLEzlnE+iGrimARFdNuBqbCojNRARv3Vfxwgrbe0yzw92WEerz0FH/KoT
	 ebe483y+ckTC25KKOHqzhlie0cp9+sQD0rmGVM8g6im1rgK9wyXhX48/2DdR5dcLw+
	 kye+0KOjh7JAA==
Message-ID: <7269d45e-93ea-450a-912b-d1ba6ba6eb8b@kernel.org>
Date: Fri, 31 Jul 2026 06:59:07 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Segher Boessenkool <segher@kernel.crashing.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Jirka Hladky
 <jhladky@redhat.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
 will@kernel.org, linux-kernel@vger.kernel.org
References: <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <a1bb8e93-47b5-4f23-91fc-54d1492eca15@paulmck-laptop> <amuauJfgjA-dJEQM@gate>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <amuauJfgjA-dJEQM@gate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 20:40, Segher Boessenkool a écrit :
> On Thu, Jul 30, 2026 at 10:26:58AM -0700, Paul E. McKenney wrote:
>> On Thu, Jul 30, 2026 at 10:40:38PM +0530, Shrikanth Hegde wrote:
>>> Barrier are in core implementation, not in arch specific.
> 
> "Compiler barrier"s are not actually a thing, it is not a barrier for
> anything.  It's just telling the compiler that at the point of the
> "barrier" all the registers should hold the values that they
> conceptually do also *actually*.
> 
> (In theory the compiler can sometimes prove it can do things that do not
> even guarantee that, but in practice this holds).
> 
>> But barrier() is just "__asm__ __volatile__("": : :"memory")", which
>> does not emit any instructions.  Or is this doing more machine-register
>> flushing/restoring than one might expect?
> 
> (__volatile__ is redundant, any asm without outputs is always counted as
> volatile.  If this wasn't true, GCC could always delete any such asm,
> since it has no side effects at all!

There is a comment for the volatile:

/* Optimization barrier */
#ifndef barrier
/* The "volatile" is due to gcc bugs */
# define barrier() __asm__ __volatile__("": : :"memory")
#endif

> 
> People often think "volatile" asm is some magic that prohibits the
> compiler from optimising stuff, but it is not, it has very contrained
> and very specific meaning).
> 
> Nope.  The "memory" clobber says that all memory can be read and written
> in that asm, so any value that conceptually resides in memory there
> should have a stable value there.  This can trigger some save/restore
> stuff, sure, but on all Power ABIs we have actual registers for pretty
> much everything, so nothing at all is done here.
> 
> 
> Segher


