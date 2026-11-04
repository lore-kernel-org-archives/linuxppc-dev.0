Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2F606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=anB7HMDt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK6j633Xkz2y71;
	Wed, 04 Nov 2026 12:06:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793754410;
	cv=none; b=cUpICRhtl6UTJrTHzsZzLYZsEMGQh74KDE14pogbdfyZxzf6n7XM+GqV1gPbOQmEqjU5uOvZuSVKYT+iYenFG0i6/i8+9XJnYxWoGrUGcqtLJrdqDcv3OldL7nr3Egjl6YhZ5xJ4FMk4kxy1ThLqEd5dedtZkKUekCyQC5zb2CBeTUDJvFyK27jEfBrL/3mXuzjV6pMtricdjhRRP1cQaAr1u/9vUVbOkVows0Rrhkq3D746dMtBmZDXX1oFeFmswhBNa8uxcuydqYyZXcsE1MaUWuiqBlKSgwWXZ7usEP2OgCLYnhq8LL/NvqCaFZJnEuq1vVl6gaYHdpNMiBYD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793754410; c=relaxed/relaxed;
	bh=nM390zJfDJhH3r1E7uK0oCMzgHFhkctGH9GBoslOWqg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sp5M/Dtqi8YNWeCQ/j8SjT3tsbKhHP42w9IMfrjTGhAHtSY9Cm5A49HOiay2qIdMBGUqs3OSieHSkIWSwJz/UTGsG1XguCH/MuZ42tJy2A62ucdEChw00AP2tOiz1cC+dB7+d3+ltRqRMGDowUt8HLBZ/ts1189zP0CLfqODY0cJaEY7b9WFJHdkS6HRAAe2mPJOtWySE8tbQss6o1iyFYWLd/Xq1O2eeMmjrPyu4G2dE0mO+NqZy3YtnsPgtkmwFEyeHiVQ0X800+yukWkDn7e4Wi6YzrROTzMSJWqdyg3B92J5FXpQyYYnOU2ecnSuAOV1osqRfYnlNmOdpqibrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=anB7HMDt; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=anB7HMDt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK6j34Wxdz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 12:06:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793754408; x=1825290408;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=85EkBDYhA8YsKy22XUqQ7C8WjlCRnrkM13drPAUQTiU=;
  b=anB7HMDt8mLd9M4GAxrY77oLe18clWBtpZmR5LdNUA/Z1+MGPimz23Ep
   xmoXwdmw3JdgO+WljH51IKQtkrgqiuCVHU7Z59RjcWEmxV6Ge9IqXRXIX
   +UsqIEeLH2zOpxsCzeuMxwO2uOhTA4h0igscDMqVWHwTfvFUBj+b/9D4T
   WpXA0TLA+K5hX/4wDfGbtKY1EDjD4OvcHrNr5qZvZzQbWaEF6RFod18vP
   TB06vH6frFzlI2jmWDezjDmB+yR4WS1BxoUC0YGGSSlzqixYu4bf8jcvL
   XuTP8LOmaHAL2cFHA0DabFPXzgxQ8pEwDPzsBaEWPfBuCg/9hf6+qyOel
   A==;
X-CSE-ConnectionGUID: WtBY8A44Si+FvVfwDCvUew==
X-CSE-MsgGUID: Zej7C4qdSDS6wxYHzpDN6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2376719"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2376719"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 17:06:43 -0800
X-CSE-ConnectionGUID: A/iUfZu8T1OABz3P35Q1ig==
X-CSE-MsgGUID: dp1Tb637Q66SJg7n9HNtJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6916218"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 17:06:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Nov 2026 03:06:35 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID
 register
In-Reply-To: <20261104004609.GA1167435@bhelgaas>
Message-ID: <6cdf31f5-63ce-a232-5bdd-d45a67f0a384@linux.intel.com>
References: <20261104004609.GA1167435@bhelgaas>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-547830596-1793754395=:1105"
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-547830596-1793754395=:1105
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Nov 2026, Bjorn Helgaas wrote:

> On Tue, Nov 03, 2026 at 02:57:58PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 3 Nov 2026, Lukas Wunner wrote:
> >=20
> > > Certain Intel and AMD Root Ports are known to populate the Error Sour=
ce ID
> > > register with an invalid value.  The AER driver seeks to recognize su=
ch
> > > buggy silicon by assuming invalidity if the bus number is zero.  It t=
hen
> > > searches for the error-signaling device in the hierarchy below the Ro=
ot
> > > Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> > > invalid error source IDs").
> > >=20
> > > Alex has provided dmesg output which shows an invalid Error Source ID=
 with
> > > a non-zero bus number.  The AER driver's heuristic fails to recognize=
 its
> > > invalidity:
> > >=20
> > >   pcieport 0000:00:07.1: AER: Correctable Error message received from=
 0000:01:00.0 (no details found)
> > >=20
> > > The Root Port at 0000:00:07.1 has subordinate bus 04, so an error sou=
rce
>=20
> I always think "subordinate" is just slightly ambiguous because it's
> used for both "anything below this bridge" and the more specific
> "Subordinate Bus Number" (the highest numbered bus below the bridge).
>=20
> It's perfectly accurate as-is especially because in this case it looks
> like Secondary Bus Number and Subordinate Bus Number are *both* 04 for
> 00:07.1.  But "secondary bus 04" seems less ambiguous to me.
>=20
> > > on bus 01 is obviously invalid.  The range of subordinate buses is ca=
ched
> > > and checking against it is cheap.
> > ...
>=20
> > > +=09return root->subordinate->busn_res.start <=3D PCI_BUS_NUM(id) &&
> > > +=09       root->subordinate->busn_res.end   >=3D PCI_BUS_NUM(id);
> >=20
> > I kind of hate the order of this logic. I understand you're probably=20
> > doing it for the alignment which has some value but...
> >=20
> > ...For me, the more logical order would be to keep these in increasing=
=20
> > order even if doing it results in losing the alignment:
> >=20
> >    start <=3D val &&
> >    val <=3D end
> >=20
> > Maybe that's just me and it's not an end of the world either way.
>=20
> I agree, I think "start <=3D val && val <=3D end" is more readable, thoug=
h
> not quite as pretty.

I suppose a local var could be used to shorten the derefs and it would=20
even fit to a single line then.

--=20
 i.

--8323328-547830596-1793754395=:1105--

