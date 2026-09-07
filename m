Return-Path: <linuxppc-dev+bounces-26699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C288CC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 22:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf1p15Wf7z2xLG;
	Tue, 08 Sep 2026 08:24:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788819865;
	cv=none; b=JmZU62G8hgwsigXQwo0g7r9hNCWNsUMn0TblqHqJ1fwl6jefOM8X7+/VDceo3bJAXyE+YQbNAjEQnc4UXNDpTnsTsCIuSAQSA1f2jiRrdfuA8WH6jOErCItN5Wl9JFdO6igS9ZnNlwvel2wT0R33OTc/tHmUujrTuH+AIQMg4HpXIN2H/SILwiepZo+sCXeSNZ7y7z/3/0sugwXSY6PfVV+RBrrkoUulZcg298GZpeNgbye2IHq+iT5WNtaN8FJ4m7X79CGCZ9vR3h/2BjgFfo/pUzKPQs1UL111iIjiWSiqlGP8WyNo6nU7tGiAsc3sl6z+CElZ5vMo8sMYJfzB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788819865; c=relaxed/relaxed;
	bh=Ji4Kvu7LpQqhECYZ1pmgrD7b9aAuvcEK2ZryUdGXyQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6MOD1h7Un4WUX/ht1j34mwiWB+iOyQhQvO2DZPH9S5k60Qqxg/Fc6thjGV7V5sd8WvgCwm7liidQ/B7Q4q9kzut5yref/iPQNkPtHXdZ07+Lkd2Rq9cjyCJHLpKFsrDtfficz0CJTgyv/cuYlTR3T5YILEA8oqHo59i1LsSc62cJ15978f9FmyHrc9taxNeI4wAEPHEHLzhXVjVQ8tnIgVhVHgH8gckm4zruGAONk0VipyRbPmsoi5fOwwgWWjfEWVAYyS1yV9bgB/Ac8xGbIw1wmAl0NjQLc6O8RYqvnndfG52hA2aCcTUUbfsMcVouEhSkfS3dTyKDCCMKcfk/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWbFJ4K7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWbFJ4K7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf1p054dNz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 08:24:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BBA18601DE;
	Mon,  7 Sep 2026 22:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A11F00A3A;
	Mon,  7 Sep 2026 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788819861;
	bh=Ji4Kvu7LpQqhECYZ1pmgrD7b9aAuvcEK2ZryUdGXyQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jWbFJ4K7m6sh97A0VyTs+bdWzlhd15mB1KnG6i9jInZw/uY1abiISWLt7fsSjdlR4
	 c+hLE3XzZHRZID4X84TFLpkV6hoBCSPsapuzEJW5ZagNAs2Dr7mFdtRQPm1SKixdb2
	 4/d8zwybENmG3Fg4vVcSI4F+qSXousnmwa5RmHnTona09JHTCsCUOlkYPuEq3mlkvk
	 gsp9iCW2nRQZtFr0HEuwZu+WRugX/IsPhcOKwDnvfqWPkq4BSFFi4phfhGFUDiVIJC
	 Kt85rAMfVomYOfvfvr+Sv8B4eeyxzNqHfpD8bO65uQD2CxjXhZD4kdaQgvRSVU6t2c
	 FD7Wv0NCGu11w==
Date: Mon, 7 Sep 2026 23:24:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Yushan Wang <wangyushan12@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, Khuong Dinh <khuong@os.amperecomputing.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v2 2/3] drivers: perf: Use __DEVICE_ATTR() macro to
 initialize dev_ext_attribute
Message-ID: <20260907232416.4b0fb386@jic23-huawei>
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
	<20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Sep 2026 07:45:02 +0200
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> The upcoming constification of the device_show_*() callback
> signatures requires the users to handle the transition automatically.
>=20
> Switch to the __DEVICE_ATTR() macro which can do this.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for cxl_pmu

