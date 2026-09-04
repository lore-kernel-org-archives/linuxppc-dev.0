Return-Path: <linuxppc-dev+bounces-26556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41653C79F83
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 11:31:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbvRc2NFcz2yr2;
	Fri, 04 Sep 2026 21:31:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788521468;
	cv=none; b=RKcKjlpVYld4oFNvHaANmM3jqGqx47HwFvHBpR/sLWVYgsoaNcOsb459DSoxFq/s/sb+TH76t/PaXxg56+drbtr0pQj/9y51gtnN1GjP8UetdaVzE71o9eyJVsuW4nTo61jDO/YM4AWiXemVlxcl451/+kyVsOs/vEFxOnaxFJzvrvm161QuoJfvCioULq/ShwU7o8YgJpYE3QnR9xuY/AxcU1xQZEI9dyKLcbivJhLb2ug5i1CMs1NGT+GRb8f6t7lJ22Eoiacndliv+37TDeNltFB8w2zD+7TrmrTn+a5wf8GfHKmatVh64FX8cqfQG1+sxqxVScN6C/qbrPl16w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788521468; c=relaxed/relaxed;
	bh=K+IoTVkUclqrBJaphlR7Sdz6aOjFdc8LUSpVkeS44nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADGPjl+FN7zXuGIqXIZMK8Sdc4bfwFK/VCfRm5QvoW4V40NFIOkqx2JTtyZQMG9JTc8qXu8VBahBUItmKiZvT4wE0/vSIoyB3kXK8Gi10TT8dOYu0qjt5sByKWjgwuWOMqr9IRBEuR/hiI/Vl8OfESszGzjE6rqgQ+daNaPYOF3vA/1NWuFy4noXs5Shim5Gqo6STLn2Qqh/lkrJ50B5Ds/ejab483a57vblNRpLJa9mop8BM99igqUC5lXjZKV+A8FGC66Nzd2/lBxx3DmieCnbzkeUVNt52TFyvCt3a3b3S5TcOk/hcNr7yjadBRfXFIzG+QyDYs5ocT4NRH07tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kuPl5rlV; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xCTBP5V9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TU/gvdTU; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xLQozFkO; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kuPl5rlV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xCTBP5V9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TU/gvdTU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xLQozFkO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbvRZ50vCz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 21:31:06 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1848D2281E;
	Fri,  4 Sep 2026 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788521459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+IoTVkUclqrBJaphlR7Sdz6aOjFdc8LUSpVkeS44nY=;
	b=kuPl5rlVl9IpR3TNKqSr0rLzVVPZKpcxpyMYFiJqSQY5nJeqL9HDwm17Vt7qxT4V4UqQ1+
	5070U6o3l73D6zjrTBAKEDQeSxewEFlNVpqTdZHdkDhroZw/aflAww9qn35mb0imlSU0yk
	WwtWxjXiuseqgn2wBzK/vwUUwUh3xQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788521459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+IoTVkUclqrBJaphlR7Sdz6aOjFdc8LUSpVkeS44nY=;
	b=xCTBP5V9o0xna1yRz/AdVeIJnM7UawXYmwi3EhpCcnj4UC1uA/xt5EPz+CMHn45MYtNg6T
	4WT5NIRVVn7OlwDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TU/gvdTU";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xLQozFkO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788521455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+IoTVkUclqrBJaphlR7Sdz6aOjFdc8LUSpVkeS44nY=;
	b=TU/gvdTUGgvGKXeSZwVqCQMHCDjiFRXPIxSiQEd1EEW4TpNYP5akz7vlsSoo5Pvp2JrP0O
	otSphC3uvBy7zUpD9I9DFzjoSPlKoQh/MWayrsZNNwdzN/pbOVK4ctSz4ubeovUaJYa59O
	vPlp2Vd7W9AyJvULcO5PMdYnijSy2NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788521455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+IoTVkUclqrBJaphlR7Sdz6aOjFdc8LUSpVkeS44nY=;
	b=xLQozFkOAALdvy4aHiiQm4P0ZKVTCsPYOc4T4fFx4G+tWcRe0ZdonZgNMDtAHWHbeGuIX8
	jXki6Q8+z0lFHDAA==
Date: Fri, 4 Sep 2026 13:30:54 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Dan =?iso-8859-1?Q?Hor=E1k?= <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: systemd-journal segfaulting with 7.3-rc1 on ppc64le
Message-ID: <apqr7oUzHxrcj4mW@kunlun.suse.cz>
References: <20260904125349.15b764f80bc54296b88e8f87@danny.cz>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904125349.15b764f80bc54296b88e8f87@danny.cz>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Queue-Id: 1848D2281E
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [12.17 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.02)[-0.118];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,fedoraproject.org:url,fc44.so:url,kunlun.suse.cz:helo,kunlun.suse.cz:mid]
X-Spam: Yes

On Fri, Sep 04, 2026 at 12:53:49PM +0200, Dan Horák wrote:
> Hi,
> 
> I am using the rc kernels via
> https://fedoraproject.org/wiki/RawhideKernelNodebug on my Fedora 44
> Power9 based system (Talos II) and after installing
> kernel-7.3.0-0.rc1.18.fc46.ppc64le my system failed to boot
> successfully and I have found systemd-journal segfaults in the boot log
> like this
> 
> [   12.485876] systemd-coredump[1464]: Process 1409 (systemd-journal) of user 0 terminated abnormally with signal 6/ABRT, processing...
> [   12.578533] systemd-coredump[1464]: Process 1409 (systemd-journal) of user 0 dumped core.
> [   12.578554] systemd-coredump[1464]: Coredump diverted to /var/lib/systemd/coredump/core.systemd-journal.0.b7f8bc16143c4cc1832aeb4c64ff16a4.1409.1788339090000000.zst
> [   12.578560] systemd-coredump[1464]: Module libpcre2-8.so.0 from rpm pcre2-10.47-1.fc44.1.ppc64le
> [   12.578566] systemd-coredump[1464]: Module libselinux.so.1 from rpm libselinux-3.11-1.fc44.ppc64le
> [   12.578572] systemd-coredump[1464]: Module libz.so.1 from rpm zlib-ng-2.3.3-3.fc44.ppc64le
> [   12.578578] systemd-coredump[1464]: Module libcrypto.so.3 from rpm openssl-3.5.8-1.fc44.ppc64le
> [   12.578583] systemd-coredump[1464]: Module libcrypt.so.2 from rpm libxcrypt-4.5.2-3.fc44.ppc64le
> [   12.578596] systemd-coredump[1464]: Module libsystemd-shared-259.8-1.fc44.so from rpm systemd-259.8-1.fc44.ppc64le
> [   12.578602] systemd-coredump[1464]: Module systemd-journald from rpm systemd-259.8-1.fc44.ppc64le
> [   12.578608] systemd-coredump[1464]: Stack trace of thread 1409:
> [   12.578613] systemd-coredump[1464]: #0  0x00007fffaa82ae74 abort (libc.so.6 + 0x2ae74)
> [   12.578619] systemd-coredump[1464]: #1  0x00007fffaa8a4e60 __libc_message_impl (libc.so.6 + 0xa4e60)
> [   12.578624] systemd-coredump[1464]: #2  0x00007fffaa8a4eec __libc_fatal (libc.so.6 + 0xa4eec)
> [   12.578630] systemd-coredump[1464]: #3  0x00007fffaa8b54bc start_thread (libc.so.6 + 0xb54bc)
> [   12.578635] systemd-coredump[1464]: #4  0x00007fffaa9613e8 __clone (libc.so.6 + 0x1613e8)
> [   12.578641] systemd-coredump[1464]: #5  0x00007fffaa9613e8 __clone (libc.so.6 + 0x1613e8)
> [   12.578646] systemd-coredump[1464]: #6  0x00007fffaa8b4e40 create_thread.constprop.0 (libc.so.6 + 0xb4e40)
> [   12.578652] systemd-coredump[1464]: #7  0x00007fffe66094a0 n/a (n/a + 0x0)
> [   12.578657] systemd-coredump[1464]: ELF object binary architecture: PowerPC64
> [   12.646917] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 2.
> 
> I have reproduced the behaviour with the latest mainline kernel and my
> bisecting points to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3424d8c18a7da1010d03391a22e728b857d0d5c5
> (which is not that helpful as it is a merge commit). There are also
> messages about "dbus-broker.service: Failed with result 'exit-code'",
> so the journal crash might be a symptom of another root cause. Using
> the Fedora prebuilt kernels
> - kernel-7.3.0-0.rc0.260818g0f23d56f17fd.3.fc46.ppc64le  = OK
> - kernel-7.3.0-0.rc0.260819gbd5f485f3f02.5.fc46.ppc64le  = BAD
> doesn't help much in narrowing as it is when the big merges happened.
> 
> ---
> git bisect start
> # status: waiting for both 'good' and 'bad' commits
> # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
> git bisect good 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> # status: waiting for 'bad' commit, 1 'good' commit known
> # bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
> git bisect bad cee9395acd8043be0644b25c34bfa86623f2b935
> # bad: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
> git bisect bad 55ab7e14222e5f0b0fd9f7711ca391d2924b35e3
> # bad: [e5c91aac491def6ab3f90c4cc246e3fcb0f8f058] Merge tag 'sound-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect bad e5c91aac491def6ab3f90c4cc246e3fcb0f8f058
> # bad: [cbe8aadf1551f3f4a853f24b3b96d9f0eea49c53] Merge tag 'soc-dt-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad cbe8aadf1551f3f4a853f24b3b96d9f0eea49c53
> # bad: [762fffa407d8d24288513538cf5d17c2c5425258] Merge tag 'irq-core-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 762fffa407d8d24288513538cf5d17c2c5425258
> # good: [a5778046a02570fd23bdf0b48dce330237d1996c] Merge tag 'pm-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good a5778046a02570fd23bdf0b48dce330237d1996c
> # good: [85cdaca6970028bf6f544c355c90035586836ddf] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 85cdaca6970028bf6f544c355c90035586836ddf
> # good: [8915457146a11d20a6c0786396376afda65eec40] Merge tag 'perf-core-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 8915457146a11d20a6c0786396376afda65eec40
> # good: [e2457a664ea02c414c6b9828bff3a0df4c300f63] Merge tag 'sched-core-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e2457a664ea02c414c6b9828bff3a0df4c300f63
> # good: [3a0dd7ba4f44cdc116d83712f61e7c1a95be3588] Merge tag 'x86-documentation-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 3a0dd7ba4f44cdc116d83712f61e7c1a95be3588
> # good: [fb419d53f2619e29bf4f96613d9a614e1c263736] x86/entry: Simplify the syscall number logic
> git bisect good fb419d53f2619e29bf4f96613d9a614e1c263736
> # bad: [6138016752322261e26ac88eaeb64c0c890f98a2] Merge tag 'core-rseq-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 6138016752322261e26ac88eaeb64c0c890f98a2
> # good: [71ff30013f19ca46c2c72c25731c32b6cc7b5620] entry: Make return type of syscall_trace_enter() bool
> git bisect good 71ff30013f19ca46c2c72c25731c32b6cc7b5620
> # good: [2a98ffac7733e77a178af7240f9fa9392ca45aad] selftests/rseq: Add missing test binaries to .gitignore
> git bisect good 2a98ffac7733e77a178af7240f9fa9392ca45aad
> # bad: [3424d8c18a7da1010d03391a22e728b857d0d5c5] Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 3424d8c18a7da1010d03391a22e728b857d0d5c5
> # good: [05c033db7e9ad3c34f6968ec568cb6ee01051c57] entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution
> git bisect good 05c033db7e9ad3c34f6968ec568cb6ee01051c57
> # first 'bad' commit: [3424d8c18a7da1010d03391a22e728b857d0d5c5] Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> ---
> 
> Also can be reproduced by using the recent Fedora Rawhide installers
> which won't initialize properly.

Hello,

can you try applying recent fixes for the entry code?

https://lore.kernel.org/all/10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com/
powerpc: Don't drop _TIF_RESTOREALL on syscall restart
https://lore.kernel.org/all/20260820134718.2176411-1-mkchauras@gmail.com/
powerpc/entry: Fix irq_soft_mask corruption on replayed
https://lore.kernel.org/all/52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com/
powerpc: Do not restore KUAP in
https://lore.kernel.org/all/20260828053811.1042300-1-sshegde@linux.ibm.com/
powerpc/entry: Clear TIF_SYSCALL_RET before syscall error
https://lore.kernel.org/all/20260904025831.3439809-1-aboorvad@linux.ibm.com/
powerpc/entry: Fix double accounting of user time on

Thanks

Michal

