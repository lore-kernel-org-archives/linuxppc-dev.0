Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B188EB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 04:18:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
Date: Thu, 5 Aug 2010 11:17:58 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201193609@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <C9528078-D64C-4944-B960-0E985B3EE0BA@kernel.crashing.org>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
	<4381.1280815590@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
	<AANLkTinpwYnyc1oN1VbtBgUF6bk6E5q_Gq1Dj3WXV3wc@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011430BC@CORPEXCH1.na.ads.idt.com>
	<26581.1280979260@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011935BD@CORPEXCH1.na.ads.idt.com>
	<C9528078-D64C-4944-B960-0E985B3EE0BA@kernel.crashing.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>, Li Yang-R58472 <r58472@freescale.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Bounine <abounine@tundra.com>, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I'm looking at this now and wondering what we added the mcheck handler
for in the first place and what
> its trying to accomplish.
>=20
> - k

This protects system from hanging if RIO link fails or enters error
state. In some situations following maintenance read may initiate link
recovery from error state.

As it is now, MCheck mostly prevents system from hanging, but it also
adds sense to return status of maintenance read routine. I am using
return status in my new set of patches to check if RIO link is valid
during error recovery.

Alex.

=20
