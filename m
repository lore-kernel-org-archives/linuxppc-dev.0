Return-Path: <olof@lixom.net>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6ADDDB6F7F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 15:31:38 +1000 (EST)
Received: by bwz18 with SMTP id 18so6623821bwz.15
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2011 22:31:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110531123521.GL2505@brick.ozlabs.ibm.com>
References: <20110531064028.GA2533@brick.ozlabs.ibm.com>
	<B84695B5-5DD2-4962-AADB-A0B29009FF13@suse.de>
	<20110531123521.GL2505@brick.ozlabs.ibm.com>
Date: Tue, 31 May 2011 22:31:31 -0700
Message-ID: <BANLkTi=q2vV3eieO8VFXH_RNavkSXmVkrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/12] Hypervisor-mode KVM on POWER7
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2011 at 5:35 AM, Paul Mackerras <paulus@samba.org> wrote:
> On Tue, May 31, 2011 at 12:40:31PM +0200, Alexander Graf wrote:
>
>> Thinking about the testability of this a bit more ... how much
>> effort would it be to get this code running on a 970MP with SLOF?
>> There should only be a few POWER7 specific pieces, right?
>
> Do you have a 970MP that has a usable hypervisor mode, i.e. not an
> Apple machine? =A0The 970s in Apple machines have the HV hard-wired to
> 1, which means they do have a hypervisor mode but it isn't any use.
>
> If you do have such a machine, then we would have to look at some
> details like the instruction sequence for the partition switch, and
> make sure we don't try to use SMT4 mode. =A0Also, I believe we will have
> to flush the TLB on partition switches, since Power processors prior
> to POWER7 didn't tag the TLB entries with the partition ID.
>
> So it should be quite feasible if you have a non-Apple machine.
> I will check whether the 970MP machines that Terrasoft were
> distributing would be suitable. =A0We have one of them in the lab.

PA6T is closer to power7 than 970 when it comes to hypervisor features
(i.e. VRMA, LPCR, mediated interrupts are all available there). I can
try to find some old hardware if there's any interest from anyone to
use it.

Of course, there isn't much of a roadmap. But 970 isn't really going
anywhere either. :)


-Olof
