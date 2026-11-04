Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC52607030C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ok0iN6uZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb6J1mMRz3c3x;
	Thu, 05 Nov 2026 06:26:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820408;
	cv=none; b=j0SdW77QcEfNW5ini6afuP6YrA89xoZttNvXVkPFX+bwSsXttwNbaSsBvtnm9DGj+ivYMj4s0Py7P75A1ozoV7lmL5jrepHUMYHvSsL6T8PVvmi5vhuldNGvytYGQ5MDS5zi7N5YHfu84yGcPK/zJXO52QKxDfVuxpQ7zd0Fj4BnXhh703libCLBZ5Bgvi00p4mRIUxf5DGKrXV6xuJ7WDxtyJsE8VowVbzAa8WahK0ADLUhkRgAWTyENxxDnp1GrazO1ED8sd4CRIDWSiFY2RDYeUamkR4T2XyMEOLQaWp6YPyLtaZTW0Kc2u0qjVNONAhlVBjMr1MU6GZ9XN1Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820408; c=relaxed/relaxed;
	bh=cd2dCZjA0tUhyc+igqHnY6+9OAULLk3Gm7203fq742M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3P6jO4a5BLood4ldfU3lJIreRUmCkFIuP7ACNjmq+xgVkdLbB0Z6t5XcGF7OCoTxi6Zg8sqw+0aHkvUAjV/gwQTRm6KuCjK2V2afzG07a4AFcic9aWT07HyRNpJ33aOZMWh+kjCIvIMWalgldIqrwDbDUjQmcQgZc9Qdmu5IkAWwcdPU6RP7bOz9V99+T0qBcNKz6tubvUiFvgFfIWnUdr3+YY4yeUorzrua0QT79c8aCV+If24eJaHm/f/MlDvCLGSfAv/UtdBr5MJDr1ELJa5g+1/OwaVMEpT4js7WHNXp3MNrGpDZtvX5pqexhuvlS2r6Zsv3DC9G2T6iJXRDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ok0iN6uZ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ok0iN6uZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb6H3V22z3c3w
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:26:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C7E7F404B8;
	Wed,  4 Nov 2026 19:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BE81F000C1;
	Wed,  4 Nov 2026 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820405;
	bh=cd2dCZjA0tUhyc+igqHnY6+9OAULLk3Gm7203fq742M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ok0iN6uZQVSYaoCJ8QVSJT8l0lXYmNP35ncQljCwM9H9v59k+rKBWDwXyFuH6JO+M
	 V+A/kQXQfWgbGohORmoO87IV8G5a3EeicQ9/77UKK7TnPSNtklntEWp/u4+8ZixD0c
	 bRD3pYtw6zhIWR1FS+A6aVjGwZINr1WSqex7QK4NXh4aMIjo3IjIJsUG8/xkIzVtfH
	 6o2/KO4Dtfl777uLHIT6W89DNE9MAKgRdxN0CGLmaTZrAGaPjU++EC952vB7Nwp+HX
	 +JJQg7IqWsBi5yUZmEzjETxgVGZ58lqdaOlqsnXdyQP64dFRJssogaTbhl3zVphWpc
	 sA8Q19qZfKV8A==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 43/51] powerpc/pseries/lparcfg: return h_get_ppp()'s status as a long
Date: Wed,  4 Nov 2026 20:26:31 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-43-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=brauner@kernel.org; h=from:subject:message-id; bh=sCHTY4Gek8l3mLAy0sLNwHA69+qK9OBjRO3AuZdnaeo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bmJIPL5OsslnfcA9hxcbt6X7Pli9ZcIKN0trZ+9tW 8ub7XmfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykQojhn5Lb2YKPu5tvWS/Q sTtlvpG7vLPqxuJNXEniS7v7VbrqjRkZ/oRc3st548nj6x0rtvtHXl6Vli/7IVk4c/HNJ0nM2So V7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

h_get_ppp() returns the status of the H_GET_PPP hcall as an unsigned
int. update_ppp() hands it on as its ssize_t result, and
lparcfg_write() turns the hcall statuses it knows into an errno and
returns anything else as it is. So when H_GET_PPP fails, say with
H_PARAMETER (-4), the status comes back as 4294967292 and a write to
/proc/powerpc/lparcfg reports that many bytes written.

Return the status as the long it is. lparcfg_write() then treats it
like the status of H_SET_PPP: an unknown error status is at least
negative, and one of the positive long-busy statuses comes back as a
byte count, as it does for H_SET_PPP already. Before commit
11529396ea31 ("powerpc/pseries: Split processor entitlement retrieval
and gathering to helper routines") a failed H_GET_PPP turned into -EIO.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 11529396ea31 ("powerpc/pseries: Split processor entitlement retrieval and gathering to helper routines")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 9882f98c0efb..4f6b2975c6e9 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -113,7 +113,7 @@ struct hvcall_ppp_data {
  *	          XXXXXX - Entitled procs capacity % available to the
  *			   partitions pool.
  */
-static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
+static long h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
 	long rc;

-- 
2.53.0


