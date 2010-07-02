Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id B14AAB7095
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Jul 2010 17:44:49 +1000 (EST)
Subject: Re: [PATCH 16/27] KVM: Move kvm_guest_init out of generic code
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <alpine.LRH.2.00.1007020937160.17095@mink.sonytel.be>
Date: Fri, 2 Jul 2010 09:44:45 +0200
Message-Id: <22C0FDBA-B23D-4F7B-893A-02F6253D5F0C@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-17-git-send-email-agraf@suse.de>
	<alpine.LRH.2.00.1007020937160.17095@mink.sonytel.be>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2010, at 09:41, Geert Uytterhoeven wrote:

> On Thu, 1 Jul 2010, Alexander Graf wrote:
>> Currently x86 is the only architecture that uses kvm_guest_init(). =
With
>> PowerPC we're getting a second user, but the signature is different =
there
>> and we don't need to export it, as it uses the normal kernel init =
framework.
>=20
> Making the signatures match (i.e. always return `int') wouldn't hurt,
> since kvm_guest_init() apparently can fail on x86, too.

I'm reasonably indifferent here. Fact is that the x86 hook is done =
completely different from how we do it on ppc. So whatever we do, the =
signature doesn't belong in generic code.

If you like, feel free to send a follow-up patch making the x86 =
signature return failures :). I personally don't think it make sense to =
expose failures for PV speedups - they should never be mandatory and =
thus failure is no problem for the system, so the caller doesn't need to =
know.

Alex
