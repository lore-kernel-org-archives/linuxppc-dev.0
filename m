Return-Path: <xenidis@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 876EEB6F76
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 05:59:11 +1000 (EST)
Received: by gyb11 with SMTP id 11so2654720gyb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2011 12:59:08 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH v2 0/12] Hypervisor-mode KVM on POWER7
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <A857E6BF-D88C-46E3-BF09-268A43B7F7CF@suse.de>
Date: Tue, 31 May 2011 15:59:05 -0400
Message-Id: <2BAF958E-DDDC-48AC-BD21-80429DCE66C8@pobox.com>
References: <20110531064028.GA2533@brick.ozlabs.ibm.com>
	<B84695B5-5DD2-4962-AADB-A0B29009FF13@suse.de>
	<20110531123521.GL2505@brick.ozlabs.ibm.com>
	<A857E6BF-D88C-46E3-BF09-268A43B7F7CF@suse.de>
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 31, 2011, at 8:50 AM, Alexander Graf wrote:

>=20
> On 31.05.2011, at 14:35, Paul Mackerras wrote:
>=20
>> On Tue, May 31, 2011 at 12:40:31PM +0200, Alexander Graf wrote:
>>=20
>>> Thinking about the testability of this a bit more ... how much
>>> effort would it be to get this code running on a 970MP with SLOF?
>>> There should only be a few POWER7 specific pieces, right?
>>=20
>> Do you have a 970MP that has a usable hypervisor mode, i.e. not an
>> Apple machine?  The 970s in Apple machines have the HV hard-wired to
>> 1, which means they do have a hypervisor mode but it isn't any use.
>>=20
>> If you do have such a machine, then we would have to look at some
>> details like the instruction sequence for the partition switch, and
>> make sure we don't try to use SMT4 mode.  Also, I believe we will =
have
>> to flush the TLB on partition switches, since Power processors prior
>> to POWER7 didn't tag the TLB entries with the partition ID.
>>=20
>> So it should be quite feasible if you have a non-Apple machine.
>> I will check whether the 970MP machines that Terrasoft were
>> distributing would be suitable.  We have one of them in the lab.
>=20
> That's the one I was thinking of and yes, I have one available. That =
way I could test 99% of your code, you don't have to release hardware, =
and everyone's happy :).
>=20

Be aware that on 970s (off the top of my head):
 - did not have the LPCR architected so you'll have to access individual =
HID registers.
 - old style RMOR is supported, not VRMA
 - no MEDiated interrupt
=20
-jx

>=20
> Alex
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
