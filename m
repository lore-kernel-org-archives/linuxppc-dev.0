Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2C606A327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNNwZnWZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRTLQ0bQfz2yVd;
	Sat, 14 Nov 2026 20:27:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794648462;
	cv=none; b=ir7xhMuy7/Pl9QlCPYt1s6yunbwZqUR5kyvearXfeXfEftZXLCq/yG5WM1CC40S9aeTc2txk22ELhShZgX5lZuTUKgEBy6XcuXKG5P8qdP6H9j7DVEiPkKU0OHXExmef26773cnVxpw6ECSuM9EninVgqzjZ7gJhD4CZo14uNbAKN2bunmD8VJSm5NXKBbzti7sKtdyhYsfqDwqy4nNHxn+sMC0HttzG2mm0zXe72fTspTAQoJV6ZV4ejooEtg50li1gK5GTmSWKhftw4oySvZv8lO7kJYC6wdsjX5rpyLJ3c+naMP1Qe0UYPCZHOhxJORld+NN0SPYls/vVsO3UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794648462; c=relaxed/relaxed;
	bh=IYfseqkO7OC6/oxcEmE8wFTp9WLs906rRXW1lcqa5cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQLI17GAEBjPriC5EJiFUA7+5B5UTIaNixODkiEWN66FCikXyv3tSmpV2j+oBETnzDJEBaQA/qNw1P8ODK56kwE2mn2v6LNW3ZWPbm80D9YtZNu8I0eFmwqDLFihRi9E33W1XBU6OEWO2FbSpw7iefpK3JnXJkTVrY5rOIb6/HLes5dAcA4e/akLbfCGeIY/BoIjLYePUNia2fG+N9YbBQRmYh1YS8Ft1XGMW+MxfaSbJLg3n9x7YwDPPi/QkqvvmAWKFcH+S8Wb+UeXL70c78Ypo6Q6ycdsSXsPPHyhHa3f/9t6Ct584tUYryztZtWnZwbdIe6oUP25xIw69w3BqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNNwZnWZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNNwZnWZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRTLN38mnz2yVT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 20:27:39 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so11112465e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794648454; x=1795253254; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYfseqkO7OC6/oxcEmE8wFTp9WLs906rRXW1lcqa5cA=;
        b=KNNwZnWZL3QG094G2X2F3fLApHjMY6UpWD1e0cJ/k82UtZGFlKQV7KLrCjb6wLArVd
         MSOucLN835hayFIXV30rRG2VH7fi0IEzA31cN0f5JiOqHgYeuiUW+Sb9OwNhLMb+Qgw1
         OoUKK/VRKJ8VWZaoKeti4QGiXKhYPZ4PMkPUUftmn0e8O2T8ry+jYlqEePBecm2tOLp5
         6VVrN0SB6m/hiXoZH1LWHztlykx4TumcQLT1cQVutRZQkw3m+7K4Pgh+5iYIE0VthtFc
         V+ow0cCvHLMlYRPtWteiHjfky6IG0a3JabjuPk0Lp4fb+oUAGbjO+0qCP49R9dKpoAl3
         CqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794648454; x=1795253254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYfseqkO7OC6/oxcEmE8wFTp9WLs906rRXW1lcqa5cA=;
        b=DMtQhPWTZ8X9ijYows6qCUtx3plSrsytdSSIdviTGFY1S6T1tW5fRmKL5Lssl4NzN5
         8riKlggrgIwOGurxEvQI3mp/lUyWze8lQTncs9Ds2YvKr6kVttO76913qiDcy+5qJEkR
         IhRF8xqcJ2KFI4LtbcxMOopFEn3T1NDXmnvLPhXuYZ2y7TAG0EXdIbL3tpETCGETvEJ/
         hrLHiKEx4rMsQ5/Ui9OqL+TLV07a7V9Xnyk7jOutXInhk87RuAtcxRwGwL6+wPJ9Njjh
         BFRW49ejvhxMyAlOu7U7uxyyV6rjbgwH7IXirpsBkW3PaerQydqQ+NIlbbFX11aHp33I
         pH2Q==
X-Forwarded-Encrypted: i=1; AL+hErFuxHcT/jmCy03DjEAqcc47ay9JE8thADDtny1tmWEgdjRAsc5qRJGGD7xrF2IXd+oUxlISQCWPV9Iel9s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9gh2o5g2+kA35bpf0e6v+ZQrtOHbq4VDN6vAlgooHXzmkq4qvN
	ODzi4LvBDPxtqS1e1aacV2x0SCSU8qMGR3O+NB0Jzg5YCJGrd10IrfY3
X-Gm-Gg: AYBFou3OnkFTw3Nb4dnSwTUC3u9wUO0P1BITkGwvDc4kxBwdvYEUqYp4mHajCVJtfUL
	G63auSO2v4uH+r+J1A/EJqex9GpJk/Na2yB4rMmXRLijHm6T2Cd2ViTZ8yZw6j3iNT408BNlmkr
	U6h5PCsz60d/qKgnkJ/mx6S8OgmwZBNqBs9I32sj/IaJKxofE9teaBqdjhP20CokWX1a1yLX5Mx
	Xg8fx1cpKjXBOwmsLF5R1kCUTUVnNMkNAm8eNhKaSOg9vimZHppfkmRfead4a2Pi/zlNa31jomu
	AGQ1zojRAUcftneKjduqYyS4725Kp0BOBaY835CBLIykYlLbV2ERmnrmV5kLpx2mdrCK73aX2GO
	h+1I3yEAecKtnrGnB7Z5Nu2w6Zx+dtgGivApESC86hNN9fr0OfgJ5TJ/WJQrXw2Z2JCKS8iuNQP
	AE2RZZidQk0YG8GQ+uBVu+L6ejAHNK3Xr6546sgygIpuZLEG0oPmt3a7l/ZjolVOEBlTM7GuGmg
	v1w4rYwomx7MAYBpP7fBT9ektNRBSvWvoQQEi/7BPTzHRWy5wqRGmanLrO+DCkVQPdcyBJ/J/LR
	uMHxX/WRl2ohb6HV3PVw1YLM5BNhGhVMdlaVcUyspOY4lh0hB4JyAfbFMhnXeWq+vitrJJNysP+
	z+Ib2gRub9IcwMwzcWbG0741isi8fW+I5nfuFy/IH8jU30DLpf0GmQLezlKIW9vLTFoBlxbC15y
	n6ojudTWV2n4ldou+UKmxImJkho8VmZ/8X7HLAHXN/OcffT4sVy2LwrTI=
X-Received: by 2002:a05:600c:3b2a:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb55aabdf9mr108908365e9.25.1794648454037;
        Sat, 14 Nov 2026 01:27:34 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b358-dd01-fd08-0f0c-fef7-8409.310.pool.telefonica.de. [2a02:3100:b358:dd01:fd08:f0c:fef7:8409])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm62372995e9.4.2026.11.14.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 01:27:33 -0800 (PST)
Date: Sat, 14 Nov 2026 10:27:32 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Hari Bathini <hbathini@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Naveen N Rao <naveen@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Abhishek Dubey <adubey@linux.ibm.com>, Dan Carpenter <error27@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc32/bpf: return false from
 bpf_jit_supports_fsession() on ppc32
Message-ID: <avgpYvt_Gf_1obem@gmail.com>
References: <20261003184226.76740-1-kmehltretter@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003184226.76740-1-kmehltretter@gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 03, 2026 at 08:42:26PM +0100, Karl Mehltretter wrote:
> bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
> ("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
> ppc32 until fsession is validated there. The negative value converts to
> true, so the verifier does not reject fsession programs on ppc32. Such a
> program loads, and only attaching it fails because
> __arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.
> 
> Return false instead. The load then fails with "JIT does not support
> fsession". Tested with a ppc32 kernel on QEMU g3beige.
> 
> Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202608010958.cYfBCQAC-lkp@intel.com/

A friendly ping on this ppc32 BPF fsession fix. Patchwork on netdevbpf
marks it awaiting-upstream for the powerpc tree. Is anything else needed
from my side?

Thanks,
Karl

