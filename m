Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67582606B21B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcsHmz5f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY2N17jyz2yHD;
	Thu, 05 Nov 2026 04:53:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814796;
	cv=none; b=O0fgtUC/sdI0YgTrLuvwk0hzNOaK1xAS8BBu5Hzl+7bjRTqdcYqn/WVjlOF6lBj/nVFcVDuAbT2HVLeS2cNBHVfKO/M843D/xQCIiYOF2rTmW+wRcfTHQVUjB0gCfluhGcb+PQuyHO3O96eInxE0sPO66ufEau78U3TJ019aR/37PlWA0vXtbApTYIV3otzhSOjG0+o4TnAY5jbzBpAupUvYJP/z6BoNW9rHvGrVz/YQI768CLVRan2czrL7mERDs89LYKvRhz1VgXzIRNDP4O56p8CsCrJqR7aXS/Ea/kLIydYasm/yop+aVUCPx62Fwdu7YVMlWeOsT5hFHaHKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814796; c=relaxed/relaxed;
	bh=9dtN9D2ek/PODLB9eXKISWT+1DyRVltUAnsYO5R4w7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9ul7hbI1DA03c0TH0vXqz5jN0HoOLoOvU4gXT5pmzwD/T83JuLL1wDTBnbBcoLhVTGJ2vmRR1yJ8iq4Nv8KlH8dH6RyjWs3xQ1q985k4iNyiIMH1/lMcM2s/CfbSXlauCZMBCiHOOhGaKi+Gdwf6GvP1pU/Pe5qI1W0qLX6BYAbD5jkuRENSCXPF2KY+eeljIomDasi53FkD3NyIKsdeW8k4KAskkBykmUGBVVDDuvGHmMQ6erZf7r8R5IQBjp1Elp4gUP/UXekl63S7wh85NZaik1E0I1P7MYinvGtNRbg9mKbrDBqIegKi0PKcMr3u4ZEdIQVOb5hqw4DIyK5wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcsHmz5f; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcsHmz5f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY2M15Qtz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:53:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 322A643C0F;
	Wed,  4 Nov 2026 17:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924261F00919;
	Wed,  4 Nov 2026 17:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814793;
	bh=9dtN9D2ek/PODLB9eXKISWT+1DyRVltUAnsYO5R4w7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcsHmz5fK/rq4Bthqez6bEjgj3XEj/c4XKC7cTJTsyy7D8CM7px4kYtiPIzpCal3e
	 YBnBaglaHwrkG0flLB3F5W7+c/cuVEsjWKHrViqroXNJjS/gLfGejJZpTfdZwQ3hxC
	 MmTHns7R80U7RN5yvO/p+jAHpSlpp28zonoPL5JONcxOoGjLH7eL2t5N/YO/Ar8kN9
	 Uv53YRcqkSaZvuCyD2wDiglbNsEmatVgs/O4H1aOlq+Q2Fx7/kPdW3ED163deYMdjW
	 mzDyj/1PR2eJIDW/uTXVOsrPDnM7bk3qNxgMT69wH0jr1TOdByT+AbZB6eZHAK8Tua
	 TqbNm9ftkTIoQ==
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
Subject: [PATCH v2 29/51] proc: don't walk through a non-directory when resolving a name
Date: Wed,  4 Nov 2026 18:47:15 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-29-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=brauner@kernel.org; h=from:subject:message-id; bh=syoXv99Xi8HZbn/gUZHMWCnjRlLtpR5bAeJLx/CLQI8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znvEfdPiys++q6WXg17bqvjo1yRcanm93G/LTAvP+ yo6V5wqOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSps7I8Lk1e9tBje0T0qw2 XN3x9V66cYxZdMKvVWWifA53/z6tv8nwT2XZnUOOz2p0hO4vzbeojJFe8k4sMSUqVEPr/fE7CSI PWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__xlate_proc_name() walks the components of a name like "a/b/c" and
takes whatever it finds for "a" and "b" as the directory to go on in.
It never checks that they actually are directories. So
proc_create("file/x") hangs x into the subdir tree of the regular file
"file". Nobody can look x up there, but remove_proc_subtree() on the
file removes and frees x along with it, behind the back of whoever
registered x.

pktgen passes the name the writer of "add_device" picks to
proc_create_data(), and only the part in front of the '@' has to name
a network device:

  echo "add_device lo@"   > /proc/net/pktgen/kpktgend_0
  echo "add_device lo@/x" > /proc/net/pktgen/kpktgend_1
  echo "rem_device_all"   > /proc/net/pktgen/kpktgend_0
  echo "rem_device_all"   > /proc/net/pktgen/kpktgend_1

The third write frees both entries and the fourth one makes kpktgend_1
call proc_remove() on the freed second one:

  BUG: KASAN: slab-use-after-free in proc_remove+0x8f/0xa0
  Read of size 8 at addr ff110001134c8e70 by task kpktgend_1/243
  Call Trace:
   proc_remove+0x8f/0xa0
   pktgen_remove_device.isra.0+0x118/0x500
   pktgen_rem_all_ifs+0xeb/0x1a0
   pktgen_thread_worker+0x1b42/0x7280

The files of a network namespace belong to the root of its user
namespace and these writes don't require a capability. So once pktgen
is loaded an unprivileged user can do this in namespaces of its own.

Treat a component that isn't a directory like one that doesn't exist.
All names with a '/' that the tree passes in as literals only walk
through directories. pktgen is fixed separately to not pass such names
in the first place.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4c3fcaf68ef4..6ac9c4c13897 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -170,7 +170,7 @@ static int __xlate_proc_name(const char *name, struct proc_dir_entry **ret,
 	de = *ret ?: &proc_root;
 	while ((next = strchr(cp, '/')) != NULL) {
 		de = pde_subdir_find(de, cp, next - cp);
-		if (!de) {
+		if (!de || !S_ISDIR(de->mode)) {
 			WARN(1, "name '%s'\n", name);
 			return -ENOENT;
 		}

-- 
2.53.0


