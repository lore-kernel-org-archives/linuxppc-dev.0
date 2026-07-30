Return-Path: <linuxppc-dev+bounces-25132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17E4C5516D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9yj63r7Nz2yH4;
	Fri, 31 Jul 2026 04:41:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785436906;
	cv=none; b=AKHxuQlLBkPU1t8rMW7sY9Qt1DDEQXw7OdukjZVDEoSPbDw69KTQpt5pGsU6y5NWx/UANVV0bDwGDbb5YuTf9YThywyt3stKRCYczMRStVJxhfUjEePowVGo5Sn5mJ6qYWg8sIvylczYKlXUqnFKMlEm1x7KJC/zWUSo3jAl+pyM0XQi7Dh4ikUWfRIS3obekj42zh4aeZ1BIgy0BFanm6oB8VlQdH7dppB4s2bFsl1C57YnEjJpuSGB3GQe7r77K2bm/FIxrcGUttmmbnHhBXM8ITIj6MY7cBxDQepGz9MRtwI07gpJ+0mR41+YXec3ao/BeA4VosbPxlDH/2Gv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785436906; c=relaxed/relaxed;
	bh=Gm23DNYbEfg8ubuEu4vnMRSs8IwqFVs/p8Gj9FYFJBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnxobiT1kpv52aFHAuKn/ItEViI/jUriQLdAdfXGJUVOMQe+F+yFNCYu6bx2Qqx3QBxU/0GT/E0n1HxsJhecKCRf/nx4nFzXw/PkjJa6MxAiljqiCYmSfycKPMibx50SpganmY4pW06m/vNAyP7eAD10yMXPBC0yoqKhRFtHFp+avkJia95XY0AjD2YycI/SN0lZ3iPRZRzpLhZp+XDvVscY9FBJpW28pBZ/H7NJdalCa5IF3dd0Q4BjjklBc6L3D69tELQtASpzHMxzX7CyfnEqWdo21srITEUul7H+H0grNlDO4/LvDoMBUXVF6GTXKqj5Aj7Ins1qyfK2R15szw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9yj52wmXz2xg8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 04:41:44 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 66UIewG21781959;
	Thu, 30 Jul 2026 13:40:58 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 66UIevMG1781958;
	Thu, 30 Jul 2026 13:40:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 30 Jul 2026 13:40:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Jirka Hladky <jhladky@redhat.com>,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <amuauJfgjA-dJEQM@gate>
References: <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <a1bb8e93-47b5-4f23-91fc-54d1492eca15@paulmck-laptop>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bb8e93-47b5-4f23-91fc-54d1492eca15@paulmck-laptop>

On Thu, Jul 30, 2026 at 10:26:58AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 30, 2026 at 10:40:38PM +0530, Shrikanth Hegde wrote:
> > Barrier are in core implementation, not in arch specific.

"Compiler barrier"s are not actually a thing, it is not a barrier for
anything.  It's just telling the compiler that at the point of the
"barrier" all the registers should hold the values that they
conceptually do also *actually*.

(In theory the compiler can sometimes prove it can do things that do not
even guarantee that, but in practice this holds).

> But barrier() is just "__asm__ __volatile__("": : :"memory")", which
> does not emit any instructions.  Or is this doing more machine-register
> flushing/restoring than one might expect?

(__volatile__ is redundant, any asm without outputs is always counted as
volatile.  If this wasn't true, GCC could always delete any such asm,
since it has no side effects at all!

People often think "volatile" asm is some magic that prohibits the
compiler from optimising stuff, but it is not, it has very contrained
and very specific meaning).

Nope.  The "memory" clobber says that all memory can be read and written
in that asm, so any value that conceptually resides in memory there
should have a stable value there.  This can trigger some save/restore
stuff, sure, but on all Power ABIs we have actual registers for pretty
much everything, so nothing at all is done here.


Segher

