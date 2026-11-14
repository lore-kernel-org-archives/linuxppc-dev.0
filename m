Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57A606A337
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ogihjrtX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRXdD6kFnz30P3;
	Sat, 14 Nov 2026 22:55:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794657344;
	cv=none; b=ABfIi9RMHnfiumY0P8TG32gDOEcfdoaYpLgujbwoElYz8954wV//t9+c2tPKdwpEHd/+CO9HCmXPecewXzvSZBYz7iJsXsUfsjH7AGtpybD98rWn8WFLm3OC5ZeMBAAXg4aQx1DcjUu+UTd+AY6R+6iA5yJoTYMP458rNJzIF8I0Tf8M3GSONmqKdQvWzIz9cpS/7+UZzJMfr+rWQRcsYjfrYl8qGH5SFb2jpOlK0VT8zsQThzvWy6ds/BCQdqWm5EC9fGKCbqu6uJbgcSYrL1oq8j3Yw9Kv/XfFfjtay9/WGJgRrIhgf9/8VzWx1OL2/a/0RSn2W2Q2FcvRWUgJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794657344; c=relaxed/relaxed;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpDvsLBnbG3TOGJ+f92aPI+/6VHhmjOcsLP1T1IeyvLpRXU1hZLhH7yjLWUF/ch+yvismeb4PfKQRPYOXLCh3/eHXfQL2PJSRldPGlmMU6wMpV6If64+xzpZTX7r1M81s+dW26JmiwF5Rj7sRqll7N/vew3IsGjgecmgyUs9bOAtC+nMbpDhKW287jK9xJckPOmC3wDgjvIzBnxWLt6TD/LOjMO8cJd//MKhYOR61oH3WE3p/5KtS9IqufGGp2lYTFIs5xco0O/blv5k8y74Lpt8lNXyHTIGOPIknvdwRCPoKs/vsI6qQ2qBNvquZdRyiQtaWIu46OoxA0H+H38hAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ogihjrtX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ogihjrtX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRXdB5vzyz30C0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 22:55:41 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c4cdc606b47so373829366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 03:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=ogihjrtXfGm9JQvbk00KbXfqXPO7Yp1GaAaiKdNmCstKlmYxX2zzLimrSZEy4tsFlp
         A6t8rE6ybVO4gZS3urgDXp/nBoqaR/jkCFH4xwzkc5pXUwAEU7qdstkI5LI97jcik6Xa
         O1T10hg/PmuNwywTjPMBLi+1fPZCWTnEqAvwRpJCqaydU9m9vpZNQtV9s2cKasc3gN5m
         QQQdY2qqQmZL2dEkFRsQ/NxqLubpy5P+mbqkP9iHBjxmxQdnaGPLhFQ0uO03+Bk1eCWK
         zk0fyRzvlxyomR6swcg5K+mI1nTef9Rn2k+YiFv/NeFNFZASKS29Ik5vwByEFIJmVwHo
         YXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=cSM1aP+13Hr2W7d5X4PFgCqLlzPy6zHCFnk+ysovDDunnsOlvUUAjFe0nGOLBtqpIC
         7CCbtcLvKcDK6appYCDFKx7L2Ek4BBoBzbjMQvDeAlt243dDyj0PXGFt8IxFSYJXH24D
         OL1YD6g3a/tfqIXsOynyJUeJ4fKoUSFtI//bp70kRJGyUYMl3HgYHfp0UuE3TONEDiFD
         S1mJdFYyNdSaF4ZeWLIUt21ybGTOI9vlIgpbxiEp6wa5/Wb1aoRtLVumfzFKTyrDADL3
         RwtlfQXKNv7y/KtIPwq8pODt/4L9C6em/e6QfYuuvuAF45BYnogSBsw4dTWUoqquO6gQ
         i1tw==
X-Forwarded-Encrypted: i=1; AL+hErFpLJpL6ztgU+zTn4r5RQaaMagi5OXTzfvqLeDtRwaIZZG6+5ZBaLCfGho562xqOxVhSZSZwmwu+x0fWPI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+rJpa71IVUjmLc9Iov1L74qWYrG20dQagRme3OhuMM7sRPth0f
	3ol5N1C5OqTRA5DKBS2ecfiRNuZfdOhlc0OdT/PWtoc9j3eCL6GGClcM
X-Gm-Gg: AYBFou3w4w1tYKunB+W2QjSK305BvqgkhdTHHyXQE1jfUHDKOzKQYmxVySCtfXi8NmI
	/UiwXwSiXrWP6IibRh2UDOaKwIyulNlzZKPn2lhl5NTXAznjc2TZInKL/SGAfrV28Ztb6xLOtGz
	KZLA/mH1pq93w/lNvONkAZMe29puu+r1K5ZMu9ekSMForiO6lHJxF5CRG5l6JS3UhVECeZE9vsS
	DpG+H611P90pOxzx/aD1oKD670H0zyaQggUguCJJY7EZwq1Pz3Swuxaia25+qfrDrK2LP80vQ4H
	KQZ4caEAUDVymdJ68+R/+Xw9tjiiwuOQGa3EYSjzrV9RlW0qxsGRi5yZ4EufR0EEhrqiG+zGQym
	fvIJPE4xYl6htvsdTUdU3z2CXpAden9qiTs7sjx+6FO3JpeQdhkZ4w/rKu57oWSmm6nrtCWKF2d
	3JXFQ1Fs3CZ4KMBAtl66qBOrDJKmcD4mSEy8ZaAHIqrUaazGru7syW4HOBzvwlCZCZ/dwnCz9X+
	GQ6CGuTYFkNYczMqdB3IQOddNdgMiw1+1gfSYlU8OgL/j5Gmf85nTJk3Zlk3EFQiP3WLlJVG5ZN
	VVugCDvIJeeBjsgIefIMIs+2U1n3arxnR2M4MDqzmLnHVn6rNWI2DVIMSMvCMWKckjTppR3PHUZ
	UhkEbV9lrozg=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.

