Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A2E4DE1F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 04:29:44 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8NITc97005776 for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 11:29:38 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m8NITbLZ022683
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 13:29:37 -0500 (CDT)
Date: Tue, 23 Sep 2008 13:29:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Michael.Kang" <blackfin.kang@gmail.com>
Subject: Re: confusions of boot sequence in MPC8572?
Message-ID: <20080923182936.GA9984@ld0162-tx32.am.freescale.net>
References: <a7f827420809180649j1f0c6005iea4b9bc82aff3dad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a7f827420809180649j1f0c6005iea4b9bc82aff3dad@mail.gmail.com>
Cc: Xin-Xin.Yang@freescale.com, Yu Chen <chyyuu@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2008 at 09:49:34PM +0800, Michael.Kang wrote:
> And jump to __secondary_start -> call_setup_cpu,  source code in
> call_setup_cpu as the following:
> 112 _GLOBAL(call_setup_cpu)
> 113         addis   r4,r3,cur_cpu_spec@ha
> 114         addi    r4,r4,cur_cpu_spec@l
> 115         lwz     r4,0(r4)
> 116         add     r4,r4,r3
> 117         lwz     r5,CPU_SPEC_SETUP(r4)
> 118         cmpwi   0,r5,0
> 119         add     r5,r5,r3
> 120         beqlr
> 121         mtctr   r5
> 122         bctr
> 
> here it seems cur_cpu_spec here is not a valid value since
> cur_cpu_spec will only be set in identify_cpu() [
> arch/powerpc/kernel/cputable.c: 1301] later.
> 
> So what is my mistake? Who responsible for initialize cur_cpu_spec
> variable for second core??

There is only one cur_cpu_spec for all cores, which is initialized by the
boot core before it releases the secondaries.

-Scott
