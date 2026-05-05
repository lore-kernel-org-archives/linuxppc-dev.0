Return-Path: <linuxppc-dev+bounces-20470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D5DFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:14:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t9H3Kmzz3bh6;
	Tue, 05 May 2026 19:13:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972419;
	cv=none; b=SxUyrjd+ehE5vlrxsq8U2IuR2Kzask6eXMKhL+p7HVhDmu1+sjM55m86R5fbfFPzR26eggs+Z3Y0C0xxA2Nb366WCJIk7FXgGY056lsIql5yLsyqdWxxct2A8DazouFpqKKreaBCn29g7skixHNeMHm+gyNXHmjkTsANTE6NNftBZvltBdr3fCHYVVx6+I9FtQpgXa9oi4ok+vvt15FHLcHqkGhWwqxFeL1ldvBzDmPFhTk1J7Jyk72WDFmyFn2JyQglySJPg8qYxbbZGhlEZyTMHOtwKCvAsPj5+0kcg4krdrEe8FPeN3TBL4jETZJLH1RH6FZmoDL/1uVM+WhvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972419; c=relaxed/relaxed;
	bh=q1WKuPixKas8/Na99fAqYUbllmTgdW23TCYIUWSaFbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ST/Y0K8trGilF1285H3VOFyE8xOdVpu74QY94eNQUdCIPowjI5M2KmWHbgI9a/4WKKH/Y1UUnB7Q2+c1MtaVNEpx6QyclrxUgGAEG9a4UsuVhW5Mo5/jGXkINb0jgslTrM3SEnzdk09AKJ/mrN2yy7uUPDNXZ7GpDeNJ3nVxHHRVC9STNpsLR5A4SQMApbbiPdQP3CjiQwI1Fj3wdZMfzkRU0EC2RJ2D6fY+SqTEiiDnzrlxmm4SGss3/2DnDv9kt+x1fuHCgCq+JZBR12d91le6s1/kt+b59gT6tjJsUNkbZv0x4hmqRrUFxy4bup12nIf80AegTb8gvS335sEXHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=LMrZa8UP; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=LMrZa8UP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t994Bvsz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971922;
	bh=3+TfV+G2pdtyPon4UoiayN0MzOd9dLRawRkDkEmqgQk=;
	h=From:Subject:Date:To:Cc:From;
	b=LMrZa8UPBgDJoGIsTna8H4ZvARP53soQigqMBW1IArgIR1gf6B9u0afV70UvF1Uin
	 jY7hg4rJog4rDzYGOXybUL/fOAPQdxnme7eKMB1xSTM2jyWQ7Rglh8OxRK5megVbEz
	 wRQOU4R0TgMW8eukf1MmwueT3G6MQvi+aspNjLe8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Date: Tue, 05 May 2026 11:05:04 +0200
Message-Id: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMy2rDMBCF4VcJWldlZiRFUVZ5j9KFLuNIkNrBS
 tyW4HevHAgFN13+B853E5XHwlXsNzcx8lRqGfoW5mUjYvb9kWVJrQUBaSQy8mNI1xPL7GvmKq0
 34G2M5BWI9jmP3JWvu/f23jqXehnG7zs/4bL+J00oQSaLENl61SU8fHKptcZ8za89X8TCTfQgD
 CDBmqBGBI+400w22O4poX4JTW5NqEYAsCOzS9w5fkroB7EFRLUm9EIEpygFF8w2/CHmef4BycC
 Oj3gBAAA=
X-Change-ID: 20241225-module-hashes-7a50a7cc2a30
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 debian-kernel@lists.debian.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=7338;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3+TfV+G2pdtyPon4UoiayN0MzOd9dLRawRkDkEmqgQk=;
 b=B5jNaK8nrebPKZ5DQeOkk+hpzui5ffCiBEg6BGEicy81yoV1XDItYSp0mFpver92Pe1Oxtti+
 zOglNe9yqCQDsVc1y3PKkLJ8f0E9od2X+pmDKCsBbWMM9LZJWIQtHXw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds. Either the module signing key
is generated at build time, which makes the build unreproducible, or a
static signing key is used, which precludes rebuilds by third parties
and makes the whole build and packaging process much more complicated.

The goal is to reach bit-for-bit reproducibility. Excluding certain
parts of the build output from the reproducibility analysis would be
error-prone and force each downstream consumer to introduce new tooling.

Introduce a new mechanism to ensure only well-known modules are loaded
by embedding a merkle tree root of all modules built as part of the full
kernel build into vmlinux.

Interest has been proclaimed by Arch Linux, Debian, Proxmox, SUSE, NixOS
and the general reproducible builds community.

Compatibility with IMA modsig is not provided yet. It is still unclear
to me if it should be hooked up transparently without any changes to the
policy or it should require new policy options.

BPF/BTF folks, please take a look at patch 1.

Further improvements:
* Use MODULE_SIG_HASH for configuration
* UAPI for discovery?

To: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
To: Sami Tolvanen <samitolvanen@google.com>
To: Daniel Gomez <da.gomez@samsung.com>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: Serge E. Hallyn <serge@hallyn.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Naveen N Rao <naveen@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
To: Nicolas Schier <nicolas.schier@linux.dev>
To: Daniel Gomez <da.gomez@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
To: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Cc: Arnout Engelen <arnout@bzzt.net>
Cc: Mattia Rizzolo <mattia@mapreri.org>
Cc: kpcyrd <kpcyrd@archlinux.org>
Cc: Christian Heusel <christian@heusel.eu>
Cc: Câju Mihai-Drosi <mcaju95@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-integrity@vger.kernel.org
Cc: debian-kernel@lists.debian.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Changes in v5:
- Document tree layout.
- Make scripts/module-merkle-tree more robust.
- Remove all changes to link-vmlinux.sh, use vmlinux.unstripped instead.
- Clean up types and logic in modules-merkle-tree.c.
- Use "auth" over "integrity" naming scheme.
- Reduce the changes to the existing authentication flow.
- Explicitly send the series to BTF folks for review of BTF changes.
- Link to v4: https://patch.msgid.link/20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net

Changes in v4:
- Use as Merkle tree over a linera list of hashes.
- Provide compatibilith with INSTALL_MOD_STRIP
- Rework commit messages.
- Use vmlinux.unstripped over plain "vmlinux".
- Link to v3: https://lore.kernel.org/r/20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net

Changes in v3:
- Rebase on v6.15-rc1
- Use openssl to calculate hash
- Avoid warning if no modules are built
- Simplify module_integrity_check() a bit
- Make incompatibility with INSTALL_MOD_STRIP explicit
- Update docs
- Add IMA cleanups
- Link to v2: https://lore.kernel.org/r/20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net

Changes in v2:
- Drop RFC state
- Mention interested parties in cover letter
- Expand Kconfig description
- Add compatibility with CONFIG_MODULE_SIG
- Parallelize module-hashes.sh
- Update Documentation/kbuild/reproducible-builds.rst
- Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net

---
Thomas Weißschuh (14):
      kbuild: generate module BTF based on vmlinux.unstripped
      lockdown: Make the relationship to MODULE_SIG a dependency
      kbuild: rename the strip_relocs command
      module: Drop pointless debugging message
      module: Make mod_verify_sig() static
      module: Switch load_info::len to size_t
      module: Make module authentication usable without MODULE_SIG
      module: Move authentication logic into dedicated new file
      module: Move signature type check out of mod_check_sig()
      module: Prepare for additional module authentication mechanisms
      module: update timestamp of modules.order after modules are built
      module: Introduce hash-based integrity checking
      kbuild: move handling of module stripping to Makefile.lib
      kbuild: make CONFIG_MODULE_HASHES compatible with module stripping

 .gitignore                                   |   2 +
 Documentation/kbuild/reproducible-builds.rst |   5 +-
 Makefile                                     |   7 +-
 crypto/algapi.c                              |   4 +-
 include/asm-generic/vmlinux.lds.h            |  11 +
 include/linux/module.h                       |  18 +-
 include/linux/module_hashes.h                |  29 ++
 include/uapi/linux/module_signature.h        |   1 +
 kernel/module/Kconfig                        |  29 +-
 kernel/module/Makefile                       |   2 +
 kernel/module/auth.c                         | 139 +++++++++
 kernel/module/hashes.c                       |  95 ++++++
 kernel/module/hashes_root.c                  |   6 +
 kernel/module/internal.h                     |  18 +-
 kernel/module/main.c                         |  16 +-
 kernel/module/signing.c                      | 113 +-------
 kernel/module_signature.c                    |   8 +-
 scripts/.gitignore                           |   1 +
 scripts/Makefile                             |   4 +
 scripts/Makefile.lib                         |  32 +++
 scripts/Makefile.modfinal                    |  28 +-
 scripts/Makefile.modinst                     |  44 +--
 scripts/Makefile.vmlinux                     |  40 ++-
 scripts/include/xalloc.h                     |  29 ++
 scripts/link-vmlinux.sh                      |   3 +-
 scripts/modules-merkle-tree.c                | 416 +++++++++++++++++++++++++++
 security/integrity/ima/ima_modsig.c          |   5 +
 security/lockdown/Kconfig                    |   2 +-
 tools/include/uapi/linux/module_signature.h  |   1 +
 29 files changed, 919 insertions(+), 189 deletions(-)
---
base-commit: 585c2e775b12ef45bdf9cef5f679dcb1220e0d65
change-id: 20241225-module-hashes-7a50a7cc2a30

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


