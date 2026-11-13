Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BD606A8A7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LaWkj3Km
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDCk4X3fz3cR2;
	Sat, 14 Nov 2026 10:36:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794565566;
	cv=none; b=TXPpnDpaIlaE3AFJV2fTbzJJHjs6Djp7sz7kGyB7wiwDmaLvvy27NUgZaOpXUf852lkYHDEK8EhZOeaVuTeZLYl5TkQPiYaBkgEa27+Npcr97v+znmkmaoFlYqk35/lvbFw6wyEAfOF4BS1itI0ge6/BPCGuGC1lCg9fsXzNdopqwfKPGLhol/5LTzUe2/UFKygcZiwJ14JoMgGrET9xTOu0UDVupNHpIKuKJV49by+WhjGsA+JV9cnlOXxB8Q3QkcfWaLZnrfPyPOkZythDK/PCbGlWT8LDYqksSL/H0CX9o4FQ5B9R/L/i+xRCEqeajMU5ENYVRtsz1BBF7y4mZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794565566; c=relaxed/relaxed;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cd259fxFg9HmGbhjA9AVxznq8iKB0OMHvoUGWGqyX/YbYXfsWnr3QBGE2IwcinXcTOH/bXAbrxyezsVKM05T38P+NAi5oXicyuu8juMJ3dIAsBWlfRloEydBRIkJ0A8IDqxLhdKnxdRZS2oGlyQM0LQeBSKTgovWwX44XVLL0+WyovDTjrWU1RxXsHciaibO0ShNJMTyniA+DPzPl550MBVAqTXOMy+I8dbcDQTCU9Yu7OlQmUQMXqD4du4O6I4MHVXSV8/Zxejzt89l9P2waLVUGFGiJZBlcZmbFafQdLfGKwilPnux2hOv8UVXm+NTYmVbW4wX15RLYhXq3A6efA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LaWkj3Km; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::b; helo=mail-wm2-x0b.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LaWkj3Km;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:31::b; helo=mail-wm2-x0b.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x0b.google.com (mail-wm2-x0b.google.com [IPv6:2a00:1450:4864:31::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQthD4ygHz3bgw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:26:03 +1100 (AEDT)
Received: by mail-wm2-x0b.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso1224175e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=LaWkj3KmWZM4XIl2PkwQaWNN7s9XA6W67kS522hruf/6h8Og/ESDEeAi6ONR2IIKB3
         h3LSBl2Yuk0FAfl0RaIxRdMpmym/VdRbSHxlWf+jK8qXi8qfzQUnVJsstVLlzroMXcNO
         3bDlNiPEAR8DN+sPgvjohZHmtL06NfhxAcpJYC+X44GjYsjM6qNvnuJGuOrkt9oj8REH
         kSe+bwTcSGf36xECsIVKcWqou/wqZU+PmiRyFhAfMfumWw0UR/mwQKwNLquNSLclHRDm
         1sZ2K6KgypK7sMwJv/8VoU7WU1Y4BYQ7sNNrLbYPFkoWRcSfGIo5GbRSjvOgaUioDIWT
         VTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=hrgkng8LzQneo4kDfVADEXowTz/04TX9sztAgXaDAzdIMs/I4RFTA8FJoLtBLerVbK
         oeBROC4letjfoWv+Lollb/U2uEpjenqzBWCQi+igPkNhUT8aYOf1r5IdzHX0JwavR9gO
         r1Y/mDEJ2IcuTQpFIa3+HDBO+3aTgu/7246LMXSYcHyLNiCIpXoT5InbKFAz8Pr3JYno
         JUBOYcn5kNHzm3oP+G0hhInnxIz7qZdd5lxAGfsvyPssPmwkMNmILm4f3DERViFQZ4ay
         G+tMGxwuQvLgNLPM4fx7Ndjyikv2iAu32oPUc7U4KW75T/mf/s+9XqtDa47FsOhvYWmV
         Vl6A==
X-Forwarded-Encrypted: i=1; AL+hErEjfOuSUuFXFFcP59WMW+AvSIHWGrHQaUAm/Snst7eVrfVrrTaT89/UFFQ86hmXE0bfO8QOMsqS2vSCQyQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9k0lgKfggAF+des1DtGhrIuQBM03H8MORbgwdBV6U7GMRP0Gd4
	XULOcLcM1vdfnt7AG+vX0FJYUdEea4GD/Ur1yMrPHQp3sX+boObq4BpIaUkvVaR3qfID
X-Gm-Gg: AYBFou0CHWy+MqjenHjOve7x6c2KaH4/Udozc1NxdDjpmRvWIwfhzcDFSensKWY1zgx
	Ww7rUq6XrDCa1y01stsGKmgq/ie/flviFOxP3BfuytRQKa+11WQNQJo+AwKEnjRt3cnCm8TIoHS
	Vfx1DEiebc6Cp8gprBp+KdmDL/d0MWv1UZs2VLh/989SlcdUv0elAShFRleaVMtAxj6xwzKZxlA
	Rn+Fh+a9O0VPIkgqDyGDqZOXRJQ+2nQ9D1lNTZh8f3oCQpM0v0EWtb8jZLge8ktn4K7Ugmb7Jc+
	vKfVBo3HTp423kbyES3W+Y4UciqPFMGtCXKJgrZBv9AR8slZz1lH80rXGEI6hdYByQ+Kf4AwmTJ
	3F4PvJELUwSL81lnptpGKq+4+YL2YlD5hHbSOCJetyT/34wkxTnuAYjWDOqaFyuYy0YY/17DY6Y
	QTkl+R1eOdAUO2klWLTm3MJuzCSE1zcK48/nR4WSK8n8mee0R/lZYhj1rOH/+yhjV7KEmQruHOG
	yWo7u+/etoCrt09Yp1s/OqYqkeF9oQukM5L1aHMOINZyNijG/SVPRghO3735odp8CDG/+gvBxCa
	Z/esoFAxG8cILb2UA4EK0XmOWTfshJ4Dcp81IwNJmr5jUoICbR1NB41IGOVk5PM=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex

