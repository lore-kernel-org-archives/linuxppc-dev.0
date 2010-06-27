Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A789DB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 08:05:05 +1000 (EST)
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <0E529B3E-541C-4E3B-81E7-AACCD96CBF2C@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
	<4C270BB8.60404@redhat.com>
	<0E529B3E-541C-4E3B-81E7-AACCD96CBF2C@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Jun 2010 08:04:59 +1000
Message-ID: <1277676299.4200.132.camel@pasglop>
Mime-Version: 1.0
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avi Kivity <avi@redhat.com>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-06-27 at 11:47 +0200, Alexander Graf wrote:
> I did that at first. It breaks. During the patching we may take  
> interrupts (pahe faults for example) that contain just patched  
> instructions. And really, hell breaks loose if we don't flush it  
> immediately :). I was hoping at first a 32 bit replace would be
> atomic  
> in cache, but the cpu tried to execute invalid instructions, so it  
> must have gotten some intermediate state.

A 32-bit aligned store -is- atomic. The other threads/cpu will see
either the old or the new instruction, nothing in between.

Cheers,
Ben.
