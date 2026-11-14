Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727B606A327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=nV5RXcAG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRlW05nW4z3cNj;
	Sun, 15 Nov 2026 07:06:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794686764;
	cv=none; b=Q81gs3i1VbseXNDMBJXHLQfncnH8US+F7jKvwW4LUgEP8XoxN28V3569ULBE7Jt+nKCW8By1kA+pcER+HWiudoxV29s3gocJNPMYOvg3TOFg83KRE5yK1PHEiZUc8PGb4uc9ecl4Nd22hKbCT5iCDFo3MtrKomvzQbeQXwo3MMB+SbQ2amrBrC3fOCWGz+xu9vLzxV2ULO385bJmZ47KlOxo2JRNrchKJogg6cYc2F3ZbzvJGj24+BUyR7XCtrqBTk2yev0XxXEER/+XU7Jpi3uYv5/JphPJ3+sGq24q1DpkOtirDvuKxxzrR6HmFGFx0Z4QUeT5xBjVwoUhG03heg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794686764; c=relaxed/relaxed;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID; b=PkspV/sGfFsY/WF/emxDw1yvwAfh2qsa/cSerk3JczrTx74aBBsV2Kdy14JW6963hqAewT/fVSwZ8Ojwa06luolZPoW3bvrlZ2lufctE9F9R5hytgzQoWCjzwlj5FgBXZizZ8uAc/VTyeP7tc6fDJlKtSsz1HSmUu4EDGxjKcxUvzM6CimqOI+z4h3cppUxVmAZ21+OFjpyxUipaV/nLiwNc9r3Ev9nJ109bcspVAT65mv2djjZEknoZXpgyDCusThhNEgOWbU+QFBqdesugqC2WTHN5t4EHZl4HL/T5vz4wDej/Sr4xFfy1kujDiq4Rr79WChkB8t45HKay+yer2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; dkim=pass (1024-bit key; unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=nV5RXcAG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=chris@chrisdown.name; receiver=lists.ozlabs.org) smtp.mailfrom=chrisdown.name
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=nV5RXcAG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chrisdown.name (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=chris@chrisdown.name; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRlVz4sXwz3bjN
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 07:06:03 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso2097065a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=lists.ozlabs.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=nV5RXcAGUsYxIwGwFCOeZgIpoXWzEtmPBtlSIdHencdTQQs4b38rK24JrkX7xbB1m1
         ozUK/KqRhCmQNwdP9xgsqzDitR15XCvqwPmDurmJ05f/W6mKTCjSxE1aFbhWO5nd3/7H
         Npovnc+gVGzgpen3Yz8ugKhNX51m/s6T4Mwpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=fblawAarIvOu7/5wDJOyN079ptv3BQMnDieT+GozFrIOPXqhc+QVtNjMBs+iQXQUKL
         bKGQpsc0wbkP2dei6OCiUndlxxSY3kOfPevuG2L3OynOhqCSdX85lTHK7vqnf0zSzZzt
         XHTUwp+mNjms1shNYsKmcdz+qikbZ3+9/9HQOu0slNNFkwFbTxufukHIHlaijeo+GD6P
         P3Ta+nDw5Dp7d+Td1/Kv1/nQPk8488n7Xpj5M4DHlAqJtikMmdp0vgYXIJeltjgXSafj
         7Zi6FIeNjvwjKIEn0h3kl4oms/S1yTL8F0Y5p/ANKtbrJP7GPHikt/3qj7bOciLxZLkB
         Bhkw==
X-Forwarded-Encrypted: i=1; AL+hErFN5/nO5goZtSlRE1kB/1nl41C9pr32ZE+UYBPd0n05Ur7w/PhCpAv8AeYFaKXwpyKwXr/u2Mgn2glP+Ds=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/aWyKluSQ1CkRHdtru/ZVnBa1tNkgDHUrI4DSe+8edZT15vaBk
	2qArNgQ/NgzYMk0wbu4mnKJTDaYmQafOR62GOBhms7W0xxWZokdoysqJiA9p8pAB65g=
X-Gm-Gg: AYBFou2Ha0CcK4AB9d0/Uzvp0mSo59JnLV+Ai931qAoYS5d3xLc8IB/JAPZmHg8zbf7
	KzmepF+O9wb+vpnfdst4MLWvuPeYv1rUHYf55iUeLArKFc8yippuaWEgya2w/izRfDdNfFkzXZN
	rJPdIgQ8UL3R+1cr9h5z5tbkDkfwfTnJkoXy0DJyVM/hkunEHcQ21VRWVTYZEIDzppoFCV+YzjJ
	VVt4DIAWbj9Q6zPdH9l2SjKdKYSf7TZ7+cFCu+sBDreVVKLoCezIdyfE+x1XSTExaEA3aU2mSeG
	7mfQC5lbPxgjFIjQ/Xr7tsHcin5hL5rnV89jnF92U3+HreX4f+Aw7W+sfS6Cz/wIqRy35ljs1Kk
	9ggsTpCKZDgH/j314z83A3d8tnQriWMvOx8JgVTj2xhk4dOdVBchb9ObkDZOKFR22XhaxGi2aFU
	iKjB1sM4fKkeoWSRwCSjQQlZnBbvmVgzmxTi/Rxyoi2ru27SjS3xexyXXmzy2yPqHssTKb7hF1U
	x/jUV3KNTfG36fWwhguR49/7fJ2sc0XO7m74H/uKqRrwKNpEnZhSWEiLViQDGNbiivp/NG3S1qQ
	36ZQ79LhNTGfh6qqTksngLLVjcqjTVu7+bNUxmJFZOcb3nGOzSi60vx8qhgQDKXeJgQDMvxcceX
	Gnk6GYxGi03Mp+tXBXjydvwm9z0PM6WM19llyuOKNAUmFSSUw/d+uz5nMO1zhb3qUZBQTED7khT
	lKUyJTXC+1/7IQYBaLSXd4OwPQirvt7rcI1ODQ+3P0QqSYzwXKPYIHmmKr
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris

