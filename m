Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22F606A8A0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EN3FAQ8B
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTJ2V5BVlz308j;
	Tue, 17 Nov 2026 19:35:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794904514;
	cv=none; b=noLA15LsEev5MAB8SNcp2Vd6qSznpLbDDKhFjvDBFqNPZnBXaeZOkdEPmm9PvInIpRuSyUVAe/2GOIjg6QJ7d1YBEEHjO93i3pLEJHvqypriGJRBjjoh7zLVLHCVGKBf/4SABAj7sB1hhCCkPZaKzZLYFsXN+6xbJhoyEwU7vu5X/LiJcBApwPCuOun5YyUoZR4II2SoeKHuQlVUemwbKQric913ZBEn6LcoLr7jWPz+/DPqnKegOflsiKF0xlXaB4eeIX8cuTnFaRHJ6qQ7kxjwnDf6QkI8zPnFzd1tj7p4yBIkHCAeqe2P7FV9CfjS9pTtP8a6Xmd5f94ArDwsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794904514; c=relaxed/relaxed;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiJZ1QHIg0MsqGXjQW6WGhpMqKfJ/mvljxZtrhJimcvwlN2q+8uqbZ3xbjmyhNSgUfFjeLOOU4uLaR+KSh/HuJNvNEbV932LBzDEZo/Z/6dVLjaJGmgB+WmnehoJc9112LX63UeSyUZ7CulefkigOxwSc+UlFoBqaGVBsCcZ9gFfcRw4MU2wsmugLq0pGVdebW8RaPWhdY0h7FZYcrdTlFxQH+tnT+MMXGmlDfWmWojpYs/wM6h/9UInd2WR3ssYHoWjjnEccewWcFoDy2ybsgUzbyOb/+61X6C4RnwBTEva6evg1Aki3ur6al5WH2wwqMSKN4dEUUNXI80522yJSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EN3FAQ8B; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EN3FAQ8B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTJ2T5z93z2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:35:13 +1100 (AEDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso581577f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=EN3FAQ8BMiImgI2/cm/87UIZw4BtDjH9L6jjiSKVoxQWA70l6MTU4pWCygBY25oRqh
         tlVeCDSMdpe8sx8zAol/DZ0Uo38aR4Dhdt3fClE7YjlLlzrtz93g+pd3CKk2Oonwe+YF
         NPuqWoI/AYljAZDDEJNNT4sRJ6L2Bf/70AE/2yzCQZA1v75MSmJrwIlq85L1p/1tC5qD
         KR42uWLxE9/xzXUUmkEOcrqJKj7Yjx80+/j78Uqv5UopdxIu/z4fXHu8vqzUjUaZA11w
         xDt2kWDOzGIJ8bTe/8XklLCq2qO2qtHNxmTRvL8wlWxFH67UZ/oQqQnC4mvhaJ3QYb5+
         9pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=New9/tSDV/ryhrq+TDAvvziX20tUpKwdXcpa/VLtuXJwGJD4UgcMBBlBOGfpoRDJUW
         N/OBMgoH1bEoU0hC0C1KoJNAmngpPNynBkGymLRBBpEHp9mbT1c3gjbwZtXgJUVLgKus
         rSf5OIykm4XTKbO7rNBCWnwBEKSy42v3l8Ahjfo5DxGa2nkxecmlnb13Wz+M9KAjbKS9
         kuhYaqpnoX+VK2D76DdjP+p2okvhZsFR5eySShYehS5VAXHmk5qwaWzgjCpyOG1gYuw+
         1KJu66nLtM69N92IxgjPI2Twt8mkd3Ntc/fjk0vxAR/eq2jRSZdEsD3LEmW9sgtL6hCx
         sZiQ==
X-Forwarded-Encrypted: i=1; AL+hErGBvYPR7ai1idnG0NZ2JXwBL6JaW2wLB0ECQzHS8YbgWoHWPLCGQaetKMLpOS7/U5iufyYxqyyXO0EuFMc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/8v57cMBZag2oUzFiJIu/zZI0AoWABFWm4ZIASMDSzNnHNPvHe
	z9T2rRq0/W7q77Y1M1VPjw4iQ9VTLr3NKDyNd1ONdaJp2W/mkPUea0dMfVZ0Hx9ClPVg
X-Gm-Gg: AZFdTZcDSRHPJds/Foc1p6A4VH6QgWZzWrBxAgIa5f2qfXXzdhSjMrFwoePKj/i7dNg
	zS9iJ5epTi8IPLJqv5ZR5Em3+AFigOcIjetsVE4eQ0uJ8KpWccJ27osIbHa3ahwbLOUrNTMLc4S
	snyza7OIX4biZK7gGIhXVaxZvVuuUVQxUNHSxD/BQfmXtDM4NvOzoWoldzKj1DbY3Y7Q89UNhwZ
	L46lR+Ibf11T8WAE5akOoKAYBuJ1j4Iz0ljW7dcIE+P4LCgbAep/6SCr7TJ//woeQQRiWbvGxGV
	TU8/75te/4bAJaAN//ALPAgTJErRNEagq9X9qG+c9s9QuvATl0nUnEkjjjJ+R4+vpdgOIuZZ//o
	VfEW/CkVstfa0LgJkqf5fblPr3MKsH7Wy6lYqnfZAgTpZyHaaX0er6dypLlNSD/6ETqSpyTNDGO
	ysO7wdFNRs9+cVVghz3Hab19X3CnzsvrlTxUJKvF8xaJBOEDHhABcXfqt5jTLnh1+sw5G0KuAxs
	emNRb/WgCjDko8vSY+DtyW0txDRhaqmcnBdaVEHSRehVKMYORhKsKNj1eV9RWiJ0kcQLrWw21HE
	FTmSFu4LffspEzgDzhOZp05kW/1wVpOURrIODs0MiiFAnaipZ6l96o8rkRY4Dqt7kBNxTnx3+6M
	Zzw5Gi5S2oE9jACWcmpzIgqTIvuDtNJDqch4Nu+lGOyhk1kxVkz5es84L
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;

