Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5060A2602
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BdrhFCcA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ1Cm5pYGz3bSy;
	Thu, 12 Nov 2026 11:16:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794442612;
	cv=none; b=J5tYVnyfroQSGARSdVkMZZ0wKCIKnLfGOA64QQ/ST2tyUdifTXllV2EaWQ/4D/2ujm35gHjPtzUIL0IRHDVNyczHVD3J/VC/hPkmskjR/b536Z5/8bzLb3s4S6vmUFRI0UvOmRXnzMtnVFpcGTZs1hWX1ln69x8U6gNMeruKKC8HELKhuIKJoFDdmFS7yqFFeTvX+b9TGtz6H6O9EatZl8b8uiTCOSRR5sCSbieFVWh+DItzWD9fEZ8np7y/NXAeYeKKbQ5iH1dir4fjgxWyi+GSj+fSx0KAQiqDHQO8em8+8PBSBqXZicYKQ6ooMFbyqEfOvYA8UiXytCi5rtzoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794442612; c=relaxed/relaxed;
	bh=BFLYcLYyJpDgB8FwsuriCtQnWcNZlWPgX5/Y0ltka4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blif42BmL2zSiTTHNjxkl/Ky0Cles28/6k1EsqjGpUzyq9MjlafwqIX9xUpciihir01B7W6ySCdhZGpr2k70irMk0xDhpsMxTtJXHryhy8EYcPay3xgfIl7rVtvN67UQrErgsjc7fbZPIeid2Fh5qf/TyGBTQv5k8Sp5juDUKghj7NnL7MWiyOByHevx9sVP2cYY0t39qfVGJwHFqqdqWFhLinVpITTBof9l0l6MeyWMDLOCD6JoiM4pgtw0xP6bjod75AVbRmwfLNRZocPWrdpJ233h62aOh4bKjZKPkWEma9ZvGLPi9Bs70Xk4kcky2wQ1yF/B3A/8TaUi1nJtVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BdrhFCcA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BdrhFCcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ1Cl71Srz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:16:51 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3720addb068so6654058eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442610; x=1795047410; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFLYcLYyJpDgB8FwsuriCtQnWcNZlWPgX5/Y0ltka4Q=;
        b=BdrhFCcAPC5VUdMlvvfJSlUl26uN+B2vFLEUrn2lJ6AWMCN7j2Elz0ZI10c4XHUtGa
         H9QEoi8HUYs062I/ukrpzFPbHfTXEe7l+GA6UFzxswqNymZhF6lGjlfEPvdTs/yke4/m
         Q7ww7r3TPDcJNcW+0ctO7nR1iFaYQs77tKVhz52buDyMjrc+oEIk0fI2g1sP5yIZJEbC
         LbvFF6LxwHJoEA4LIGfEZVbqCyn16THtMsVabAzQAFsCRbriU0+SEahKrR6+byXuLc3e
         k0feWxIAyFVILQkIz/r4YEMM2+rS3d7DbGMCqli/8X6HEl9Z/oW1Mpq8Sa0YOoTRQfnb
         hWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442610; x=1795047410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFLYcLYyJpDgB8FwsuriCtQnWcNZlWPgX5/Y0ltka4Q=;
        b=nRU8wJekf55Anh7TiKQ2d4ueuFPvQvK84y4XnyW6Qat3D34v0ytQ4IFLCEpWlxrOtW
         TJsxlquYH1lFpLnCrR+Avz5iVcR/5SgsNIGGgGsOG6eXO1pu7yDz6W1FEfBoGCjQcqDz
         SdPEm4v3mhjIM3Hdjw8SDRtUP2dnL75Df5XOvXRaeAJAvkMMH4hpTi5qMJgorquI0P6i
         Fa8D2trFY2dPSigM087B1BiM7YxX1FGqTb55Uzu34uxjAk7mF2/wzLpGD72QD8rGehEt
         7eaZe752VWzciMGbVHqBQEBG5Pnwph0Ste+sFWxZLUxluebdRImCQhigDqQCeIlmQmQ4
         fvGA==
X-Forwarded-Encrypted: i=1; AL+hErEzqwmuZ5qPid6jTMCBUdB9012naMOqWd4f3xg3kndDVhAQ+wZniNYQkMH1lpx+JMFjL3xKhmTF5XAWCjk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9i+l+D4Vf05AZpFBIKB2bQwC7VOrMRtGv5GDnLPS5Z9nz74lvT
	t5wfsRyM/sNzy5wBzo/vaZwI9CNA9Cc/2GUWGfSQrxm59JeJVyjltyx9
X-Gm-Gg: AYBFou1iCU3kxBUlubvZAEnuARPdiejHe3ZWypMGIeTXgl3RTAwQtNROQH6PVJxwiRw
	odkgnAwQ52RmZjN5yiyWLeMOzaDkPQdeZgdgUq3GK4j5/F7v7HvabRbXs1XcxY7LOw2fZrBfOYn
	3I+bwHe8b367zFO1dHz+oP+Ql9URzbPTwnvbulNt0bveOP3//NQvVPlp70Bhsjo7+fpqJmQueZn
	MHomgWV9suTfLqqF6+rboTfxIz75Z6odlci+bKd6YX8ke8yO7OQpnOaXcC3o4/LZ+z+7DEaFyqs
	s2CVdi+RfWRfPJ5YdfMFLyvzrr2EK7wduqV7KU8LvZ6RVt+T653y5aBTy8XezNbv/LLxRnXm7oC
	7ctuF4PwePQ2Lg+iNiwnokX4NT5lA46oTKocx2NO6mb/Y1BRU1aBe+wRJAB1GcJgJXs5wle3bQQ
	rLhxyINxkyYZA9fcYWPv/dCT5hmiz2dLVPPVJZhwB81XMPixGHgvq6BrxvImFGRFi9wwGxEhKCX
	jPgbNGQaOun1130gpx2SS2DcWrtyPpvLKCOsTBni6c9zywL4m/1i3nCwjdPByj3pumG26gub06Y
	2UrACFGuuZrRK2rHA9Yg1qk67mogb6r0dh/i4M9RxyqpDlOD1LIOu1dyCIWm1ZyTj59k+NthGOE
	n7t4NkgbPfs5YKY3gcroPU0oxoZ49Ho0O5G692Q==
X-Received: by 2002:a05:7300:6a8f:b0:360:e2e6:f849 with SMTP id 5a478bee46e88-376861732afmr3870927eec.28.1794442609584;
        Wed, 11 Nov 2026 16:16:49 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm40492697eec.16.2026.11.11.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:16:48 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Shaun Jackman <sjackman@gmail.com>,
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
	Florian Euchner <florian.euchner@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Xue Lei <Xue.Lei@windriver.com>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_CM109 from ppc6xx_defconfig
Date: Wed, 11 Nov 2026 16:16:41 -0800
Message-ID: <20261112001642.243554-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cm109 driver is obsolete and being removed. Drop its module
selection from ppc6xx_defconfig.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 29acc77573d6..4ba35b9377d7 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_INPUT_ATI_REMOTE2=m
 CONFIG_INPUT_KEYSPAN_REMOTE=m
 CONFIG_INPUT_POWERMATE=m
-CONFIG_INPUT_CM109=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_SERIO_RAW=m
 CONFIG_GAMEPORT_NS558=m
-- 
2.56.0.567.gdb80ae8cd5-goog


