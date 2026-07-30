Return-Path: <linuxppc-dev+bounces-25080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2038C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9hn70Ct5z2yjs;
	Thu, 30 Jul 2026 18:14:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785399258;
	cv=none; b=LVXz7qOCa7owHWRBEgjcWyCgCWcZ7lZgrSiT0f0Esz1bkRzJEbn9+Qcu2EvuQhP4++0p/hYsqJ87tWJe3JYjvLVcxoxtol4dF/3Kt/Hbs53vTXUsCJygnNvjwzd7PxlkRMsf61u8Cxe57X4FRIMnsyadWuqeADej7zTXV3FIvqJOUKlnMQPTL2eZA13I66l52sl77rB4irH9Ab7ALHBFWxtDDBKF8EDj57Or0ZvtTZZ8kx/PQ+q2Z3fiIPP4kJsv5Dfa1sk/Zo0EX3Pp6hlg4FQ11QN8z+TslcF21p0typMXUTla13X2L5GKIpy5wx+jCzWMBtr0cvZlWCFOGOyaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785399258; c=relaxed/relaxed;
	bh=3RyuYiWkIsIF0bnbFXnZIsZlBEwacFAb74eytrnFkrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvyY8mRKsXiXMJzRk5Zy0K3tPvF/JlgxelM29LJscX03LZfLA6DO6z/pObC4XpNCZF0SmkVI+IIZw4NaVHt7+1bR2Gi/uz6SJPK0KsV300o77g09M+CY6x28AopQzhNXfGSrO87fkGt/4fhotaWMylaOS8FqaBDqNPinlQnDrwKFcMNbuxx3zjE/RygKx69Qwyux6cJ+o5MI80A2wOFnKG+Spvo5zDNJUdz8op4je7L9JVjyPEIY/f4xRSPS3c25RSrAbD4D98g9kB7Z1x+YQ5hJQ+b+7G2Go85Nswj5bGumlnDexJEM2QCr0RXRnXU338sZpsoR7cJeNAdCKF+9sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD5GWOyQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD5GWOyQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9hn631FNz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 18:14:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 13546600B0;
	Thu, 30 Jul 2026 08:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC651F000E9;
	Thu, 30 Jul 2026 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399255;
	bh=3RyuYiWkIsIF0bnbFXnZIsZlBEwacFAb74eytrnFkrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BD5GWOyQjPssy98jae4bLRoyAJ20Bs0VG8QulCZUq/ZcBjS1vOtC83sv0ROFEBJB2
	 5qMmX2P4GqYz/Nv7+WpJyyQ3s/Dhim+t5UpufxsvaZ3WodxjF1b8BP3UVlM1kqnJg8
	 MAXK2dqwEjZuqfTW5ZFmB3qxahgQkH+rbBJjvvB6QK70Va0rEfVF/nNEntpg9HQiMD
	 pYnfwINAWUg71whVrzTPbo3wZGb7LVcxiU8qwv14igcfBEX/5FWHnXhLW/ziNtfKDN
	 4iLwmM7dNm9nMHYGIG/eyC4ZCoQ06sNI9+lvm8i0d9zptN759MPrCzbmZsR41rWKCo
	 VFNIKLeTVUKKg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
Date: Thu, 30 Jul 2026 10:14:03 +0200
Message-ID: <178539922190.574381.1359588018451529893.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=chleroy@kernel.org; h=from:subject:message-id; bh=afjedPbY+ONakwbpJQf2IsSZEO+cCH0rwLmfP4Qd6mw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRls5/5EOHyML93C3Ob6yNlge9rg7LW2ltcmmAhZxKly XV9TR1rRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZiIzBJGhtbPk7asWSxQbn/8 rtvX3+sSN7drGoZt5u2aPeOvzMTG3LkM/4NE7zaqijrrdju9eB1zPtJG5M3p8oIOzvr47MdHpcw ZuAE=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 29 Jul 2026 16:10:36 +0200, Christophe Leroy (CS GROUP) wrote:
> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
> proper platform driver") qe_add_gpiochips() was walking the device
> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
> 
> After that commit the discovery is handled by the platform core,
> therefore it is necessary to call of_platform_default_populate() on
> the par_io node.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qe: properly scan GPIO nodes at startup
      commit: cf91e5909e620b77164b53c9b316a5c1f11f9ea7

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

