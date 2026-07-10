Return-Path: <linuxppc-dev+bounces-23986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B39C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 03:44:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxHl134dMz2yQH;
	Fri, 10 Jul 2026 13:44:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783655069;
	cv=none; b=UgnUXNoimoLb/uYrB3QcoxvTVkJdktTu9xtFSoGQSdY5tln7MoNJ9y/rGd95vzykcvMSCI9N+OjoRiWHWIegZ4TvLt7ylMHzf1QpZGePVPosehlMVm30TdLasHjrjlbZ/PJY3M4Vj04CRNxv3niHibadJ0LmPJByXVF46r0wuRrDIV4Ka1ImGfMRMOvBtYNAKc70LusgKWVDmnOZ8VfnLzoquMKy9zxX4bk0Edc7prZvqKngs7x/QfMQXcch1pzlDzlmLoPJ/CY4PFJYK4lr6P9g3dLCzh9dV5DJmP3zPpBrT5OLhADwtGhGbxc91rFbC4RgO9D/Mvub2iUtYO6f6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783655069; c=relaxed/relaxed;
	bh=ZMHNuukiYEjMHGohJc/w4Y0XAHqa0MO9l8BEkGAjTUM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JL4tcvPAnQSOLsiG5jrh426bnTWdLHqEoj+VpfKBItoePkFC7nb1rtmXHG09jAqK168Csrv2TZ3XkM1wZLIamJsoO3vOQ1gIprHPCKxJiW93FqksyGbpEXce8dYWdklAaAL8y7WYp0JQf+GTyUq3aZrbi3Pjb1XtAw6yDTZJq2MoHGJEotc4eUFzks1IPQykrLxi49hTVl96y1eJu+HjqBF7Zo/oMPFX5TmZYEsRM69vHALv9M+zxTWtS+SHO8RV6w4vNlOb6qKdSnTSKkuxbf/afbAi3nSSbEljyhZWCICCx/jJ/Id2L5k20cSlpFwc5okn8Zee6DHiKtAR53bf5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LWBV5FSY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LWBV5FSY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxHkz5x6sz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 13:44:27 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso261178a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783655065; x=1784259865; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZMHNuukiYEjMHGohJc/w4Y0XAHqa0MO9l8BEkGAjTUM=;
        b=LWBV5FSYN6v5AXiebLdpWFT3KgbuaoEjWDLRxKLZqVfm9O52Tzd7DwVV5TZsOyeZRO
         4/yKzuwVvGWhmlVuIas2NDhwGI9Wd5f30E9sFiHoRN93vxw+5Y/RqHZbICIeHY1HB33R
         34hfSbbSXp9ewmU3jRHLdnfU9ne3Hhh5m67aiPsomgzq+aTc6+RhVo8jrNMVsMA92nya
         zN9pFCF/mZ/hwnjP9GePt8oTTgQqFR1eXIOajVIMyDJOQ14vlBJuuTTMI+XJFIPRVTVP
         kYo1XUoCkVrBJthANuHOo0fmdI543JkC9Y+03CRng6PjtFraXb2V9Xq3UcHlbP7IIdhm
         ElJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783655065; x=1784259865;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMHNuukiYEjMHGohJc/w4Y0XAHqa0MO9l8BEkGAjTUM=;
        b=l8mFvVqpkYAXvPAEmdntJSJJkAJs3Ne4lA6O+ynvCLrmbQowNwsYwGGL0exsjeGQ4x
         EKQCI1JIiuu/CgoGIT+Av/bhPQRg8ozvLUG9nz7KN6adNFVr0+jPOqaY/OTRv84U9Wfj
         7vuZPkIiArmLqsnVoQ8bxpFLE2ZuCr6IUwQcQzvpud47WCL0fOcygzGxiBc8zadtoHaW
         ymejjzCV7VhjLMJNDe9n0ybhEiymM0qf/aZi3stN08K0nMwVj6V3943ltGN6RcqwU6Ls
         c0f1sXH5AdlGTC1+Np64LTJU1JxsPkE3VRtgHzUOCT5I/2BBrYQAgKg+egqGalDeThlN
         W9ng==
X-Forwarded-Encrypted: i=1; AHgh+RpGqAnHkKrOKcZiYTwQA0fTJAqI1SKf6aOL/AengzD2ybKwpynsUPqvxxKjEQO0+QKKASkVRQ/sk4tNkpQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVp4ssTJiCtmvDeyaNM43bhjnFlSRaapsE7u8+R7lRUs//73NA
	pfsOO/nrQxi+mqca9rrxgc8SnhbbuY7LS3gzcbPO7nOS5aah9U20hDHG
X-Gm-Gg: AfdE7cmaUyB/WtjvDEmLro/UNWQVRfm6r76vEdZQ82Om+yjnFL9T+L5kgsVKOUaGHX/
	ju4CPLkdxZMorFoXCeFDXAB0xLRTKQ/z7/c7XQ1URK78HFnuGttDxKb97iRLMk+rqyyXoVP+def
	pqGJvwO5i5nYkJfoMEeYLo1FfjzlojnrUuIA8EhbWZNlEmkFR/TbwCzmd6COFXD2nG2ouhNI8SB
	8uKTd8NVr+17tvRBVB6QWP4p89T9PHbeLNo4qRmX1hA9TLb3quG16Ium9LMxQ3EuQjBL+Ay7I9Y
	ioUpH/zzjTx+V9USl9nM6L2tHcyhzg9P6R4+JxkqqHtzxYiSloQT6VYeL5DyH/iHCUYIetM6mME
	DsuZB1UIK7SXMf2bxEC22gxiis0CONkGDJTUtpc2kmOuiKMEWWcfzzbEPyyaiuO3wNJaSjbFLJt
	mTfv+c0ZvtvLs=
X-Received: by 2002:a05:6a20:2591:b0:3c0:9c19:6598 with SMTP id adf61e73a8af0-3c0bd1b0c2emr12041413637.64.1783655064507;
        Thu, 09 Jul 2026 20:44:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c9a1sm42597840c88.2.2026.07.09.20.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:44:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/kexec_file: print configured kernel command line
In-Reply-To: <20250725124438.327593-1-sourabhjain@linux.ibm.com>
Date: Fri, 10 Jul 2026 09:10:54 +0530
Message-ID: <zezzv7eh.ritesh.list@gmail.com>
References: <20250725124438.327593-1-sourabhjain@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Kexec with the -d option prints extra logs about the kexec/kdump kernel
> that help debug kexec and kdump. For example, it shows what kexec
> segments are loaded, their locations, and sizes.
>
> One key piece of information still missing is the kernel command line
> configured for the kexec/kdump kernel.
>
> With this patch included, the kernel will print the kernel command line
> configured for the kexec/kdump kernel as shown below:
>
> kexec --initrd=./initrd ./kernel -lspd --command-line="test1 test2"
>
> Loaded elf core header at 0x22e30000, bufsz=0x2000 memsz=0x80000
> kexec_elf: Command line: elfcorehdr=0x22e30000 test1 test2   <--- New
> kexec_elf: Loaded initrd at 0x22eb0000
>

Looks like this slipped through the cracks. agreed that this is good to
have info. LGTM. So please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

(this was still cleanly applicable on my latest dev tree)

> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

-ritesh

