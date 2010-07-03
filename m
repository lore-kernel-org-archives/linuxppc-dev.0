Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C631FB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 08:42:43 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <A98DA9FC-DC42-452E-BD44-5F86D1707BF0@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<A98DA9FC-DC42-452E-BD44-5F86D1707BF0@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 04 Jul 2010 08:42:36 +1000
Message-ID: <1278196956.4200.390.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-02 at 20:41 +0200, Alexander Graf wrote:
> The u64s are 64-bit aligned, should they always be?
> 
> That's obvious, isn't it? And the ABI only specifies u64s to be 32 bit
> aligned, no? At least that's what ld and std specify.

No, the PowerPC ABI specifies u64's to be 64-bit aligned, even for
32-bit binaries.

Ben.

> > 
> >> +The "ld" and "std" instructions are transormed to "lwz" and "stw"
> instructions
> >> +respectively on 32 bit systems with an added offset of 4 to
> accomodate for big
> >> +endianness.
> > 
> > Will this add never overflow?  Is there anything that checks for it?
> 
> It basically means that to access dar, we either do
> 
> ld  rX, DAR(0)
> 
> or
> 
> lwz rX, DAR+4(0)
> 
> 
> > 
> >> +mtmsrd      rX, 0           b       <special mtmsr section>
> >> +mtmsr                       b       <special mtmsr section>
> > 
> > mtmsr rX
> 
> Nod. 
