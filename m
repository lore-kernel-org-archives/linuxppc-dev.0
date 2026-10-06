Return-Path: <linuxppc-dev+bounces-28978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AD9CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:46:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqZX0kB1z2yrQ;
	Wed, 07 Oct 2026 08:46:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791312163;
	cv=pass; b=CIEXfS/xF58dKm/n4F3CdX6aD8fSYUtl8mXVabz71ep0S1e1pjJgVRknQtqRO7bYq2N2rvOCWx2MpmqP65Iz8qJgxG0Cm7ZwZJ+5xRm7lypA2un3K432vqEatTkhfivKYigV1VCHd/0MO1xnc9Y54k4TJTIYoOEKk/WuKxcrZtwtngwMzki5Z9lADcYlOv5mDqn+JE+bBGx71Q8OOnrgt1ZSTXpMX+4u1StjnBu1CAHZxVLtMzT49JVMS7xRn5dRgqfR7RTd0P5tkPMYqEOXWDlxiOC55C8zsxrJOYuVqUkfYlijMnc7c2WGNrBvKDs8Xgs+wyHnXyUBWEQZ5BAMNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791312163; c=relaxed/relaxed;
	bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8e+OwMKHBpPId6Kq7qC2Ed87dZ69Uf3Ia5JwRZaWA3KCFvrKYxtWkBw0sNw8ZYz12jeEiC8+uygKRkeM+qQrNp131P/O42sKpg4PJ/QiKgo+86hwi4fIcJZg/lfo7jlNuNN64tu1OdAprX0UqV7Ix16D2HB0feUz/W532tuBs67Dx/NjbwbGy/+IDVYZ9pNDrXmq0ibTDVXcRdhXunM5WEqanlQ+hhglz1+P/vQNCZkgcoOvYiNQpZdhjwDaCz3IfNJMVSR2t2RWJLDgWkhi8RTZk/lqnsbqNj5D1YzIPYdFnpLAfTgT74wWDgnwhWLsNzaHhIW1l+zYnqO9IqPVA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JVt72vct; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JVt72vct;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzlVp6bJ8z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 05:42:42 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d3b445a84fso10975ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 11:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312160; cv=none;
        d=google.com; s=arc-20260327;
        b=b3ghUka1iiebdO4VN0yrK172InT+uI2jiH2YXsbIy1I6GZTjgJ+cfH5kdznd+hOnA+
         MkdsXGfqrgzchoayh9JG6xiVZ9lo8cQZGszj+POXwwCpekNLYMfgszfKJni6zSBaK8JY
         7ehCZGsAED61hXBkktQWcbcDnw1wcNTbxI2WXGoMOi3/u+wQs/R0Foc5hWPRzEK8JcWg
         2ivyXZadjl0Dbzkn4hcDoN7x+yUZ7QtWR2euGfguVZnTJVHRbidMILLzwEGANBjRxqP2
         wa0518xXmn2RIT3pE5yBC4o6jcMcRgvKmGyoccI4lYVYDg3Nt1gN51Tzwb/p3is2F21Y
         njJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
        fh=QDavWX2abfE/diUp+rgAueenOG5N1Uap7me4I0lvV9M=;
        b=NVf/Ceov5ECvo84q7/dng7mi9KidIqzbrYnZ6XkVyJB+8DaefBV700Ss0y+nFAZPqT
         ui6p+I8B/HOOrkT+sV5483dHLNArLF84yIXVYlpvjj1NbbAPRDFPD7HVjs5BTCrketru
         l4sBXh1AofyQzssuAVEeTyTiF3yIi7+xB3KRusYwAZOkEgtXgYKuLpFl9dbjJxhi+dq0
         CtHK9XcJArXrrhKmEzpXSJPvtxKQNU576/KaGdUCTDjpLBarblnEic0i99SKBQU64eS3
         Z7aijtI8RHVxRCBssnjdJlBwLUHBPSxXymZLYyxIYgQRE/XPbnzjT99E+xS93Ny2I5T0
         cLHQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312160; x=1791916960; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
        b=JVt72vctcozg0mYSgd2djh48YqHlm9bKuS3DgI0Z2rIVZvTXq2VR2XFiU4g5FSQGzX
         DCeTj0x7Re4XSFB1SfHetClMOsUBJZP1mS7/mbDUzAzgDDrjTom05w1RXEcvLa/rKHy0
         5UAlEn+8DqM999DFWZmkN0jv5EiGMb45hBuEsTQnEeb0dCea/1+kZHeme0KGSQICDq/V
         2h8uvK/8u3YKJ8OK4/bqxm2ghK/b8uHrg2sWhpeUcVbAGlJzOFwl79MgjJvn11Lx6Xe1
         jQ5oYBiG/wTNlW8v9ZxNIbAhof2LiIr5P76OuGHJOZnFXcGj9InQGDj96XBInE7/V9Lv
         1N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312160; x=1791916960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
        b=knzevsVn2vneLKLPQt3RwwjyNu5ottbrFCUabDme9/IUFAOH/mHDiODm0TILhCXyWE
         VG7M0fIzzacECeNZD6KfnMs0rnbkV2nw0+P5nC8V4+Inz2vKl2pW2FGYqJ4KmFts16xL
         Pk/Xp64d/LIxioiM1BXe3RDkJVg+PbxvJohGLIsfxtimBSEJSEDlPTvwY/AmM+CVj8Nt
         mJ3x9SpRxPLGJFyoIDnqTtBipnbrHky7WV8tjxqHpb5CT5f65U35Ilk/o8t6Ow/VQjSx
         zQ64YKmft3CL0Jfh9geiquqp+4UrG8s+hh9+EYCsoijSlNJclVcCmQqnC96Safk3VBf6
         ZRoQ==
X-Forwarded-Encrypted: i=1; AKwUvBySXfvX7kpydndiG532SpxQcKr597tTe2yOqM/ARLE98GYSy7afLuCRhSsbbHaqGTa3urZGmK+8AkTH0X4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lb1uXkIHMqKLagRSbTP8BTRARambxlRy1Y0MJ6P+L8NZ/i+bM9
	r74GFp4gkPBPRxPm+pHDd2b7fYvI4uLn+NDu4w7opGr1/qQFJtFjtdh19vpAGNygLSoW3WpYtOT
	5nBUFlkMAvNHfSGxj/70ghCyeB2IqOE9aSr8s2UI=
X-Gm-Gg: AYBFou0/VNirP1E+wb0uMzYJID/13x3cYm5EipX4Cr/moEFZtZtKdRkln8B3/n6OEMP
	iqGwtztFIvZcN4ysG3Cl0REvnMva8TN5aIEELW7f/Fji/9em7rNNhOe/q1b7Tlj4KqjE+skHZwe
	RAqXGFGm++6XNtn0diLu2nDCQi8TGpODww++hdf5tBj6Eh33dn2lxUEPOUuHc5csJGvRnQ/XqJk
	3s9NXIm5JWmq+Lk9/CYhmOAiZIzTh2KKgLKRUxWYEa+uSYFLW5hkLAjE8MCQ/hgt+Cxq+GxWYk6
	MjtV/eWMasK0Dn4NQyHkd5HznqY5kXUYATuLBSvGUw7efF6R8/C7w6uHrL54a6RbQeCh5R2p1IK
	6C1m4NPOhIroAUQEFbiuzdGdF3atVgwXzZn1L
X-Received: by 2002:a05:701a:c901:b0:124:748c:2ba5 with SMTP id
 a92af1059eb24-15e1297c33dmr34061c88.13.1791312159692; Tue, 06 Oct 2026
 11:42:39 -0700 (PDT)
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
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-16-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-16-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:42:28 -0700
X-Gm-Features: AclHuK-63AoTbyB-3ClbIEIaYMGnGi4ajlf3gZyouGmo8fAAGNgvYduwL3zAm7A
Message-ID: <CAAdrzjsz2hVMLTPJKtuRakHxMi7hGRr8_C2EsCjBX516tKTesg@mail.gmail.com>
Subject: Re: [PATCH 15/15] PCI: Remove the per-capability save buffers
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:35 AM David Matlack <dmatlack@google.com> wrote:
>
> -     /* Buffers for saving PCIe and PCI-X capabilities */
> -     pci_allocate_cap_save_buffers(dev);
> +     /* Room to save PCIe, PCI-X and LTR state */
> +     pci_reserve_saved_caps(dev);

Nit: this should be "Room to save PCIe, PCI-X, LTR and VC state".

- Josh Hilke

