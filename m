Return-Path: <linuxppc-dev+bounces-17987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4709CFD88D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 01:12:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVt5N50yHz30BR;
	Wed, 11 Mar 2026 12:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773191544;
	cv=none; b=jGwGL52VkX697SIsYqa18E17iI46njSo7E9rN6vhH2Xf2msTQbwkxpZOT6mA9dbV53IVE43qyspwyWCMrf2hgYL9K+W/NtpsS6sy+em5W3Z9lDJguO4yFznEk2mGBZmp3R/8dhCBm2vEpMiZt6HJWrt3vGmqrsK7rQ7W1u+S4+hXjtJIs47W+ajvMkws0dpu8Y36/Ggf72Gz0OQ9fhnE18zXv16078gr4JYMkNca4/635gYSZr5Z1i+kvfPsGr6Ffx3HCnF4Bx7KIQ1oXRdSCG22xPgMGccWb0clGQAOD5HdTGbMzWDsJcIwKueR+OjPJQqg6aiT82W8I9Kq8WhpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773191544; c=relaxed/relaxed;
	bh=A27qAJx6FI9YasLb8t9m8pvAvF+c2BJWEpdEuHe7+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBbkfkjdb1kL4qkmjsLIel1EzN11KAOvLJPAMkwroVLepk1iQECX6MDTmy9z4PGib3T4YYKS7ejeDljtr7bbSuxs8yHvk4gProAhR4cwEPJ2THwYnlhSGFqFeHM8AFSWfqIZ3zr9t1PYxC4aQ0d8nzx90Ly+jVllThq1XcJoRA8S4ngfL8LZlo0+RpcfUCB5zICZ9wK87t/650pxhWQJBXeOZYFBpS5XaTkc9ZluT6kjqNgGXrFHhuwUXFBmt78Voykz2uvxj4U10WBf7gCpgS0SAry/f3Ighas7urfsnhaGcAr6A78aVZNU3/GYWfBwL4crdkdyTkjPnXyzt/cxQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sdt6QFSr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sdt6QFSr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVt5M4M1Nz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 12:12:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9957D42A22;
	Wed, 11 Mar 2026 01:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E371FC19423;
	Wed, 11 Mar 2026 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773191541;
	bh=U/SQlh9eoA7aNwhrztie/y/wf13I3qMxDdkdMOCTE1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdt6QFSrTCNLiZBwKHlduCFIqUyGtdRPe5EFgpkF9YeyDcF3v3jNsJscSUkGuqXvL
	 d5P/Ui/E5sCPsCJm+cGK+Ear/ZMW1+OstQw2o5RYIdgPe9Y6Gf77hLvxJuoV+J6CLL
	 +XBDMxYZXyY8ct5nR/O6mvNq8tC9q2VPa47380Ks78EqPMbMK0QpGUtLSMzBlM0Wz+
	 yojTIufSanR7vEU7B1goXkTIBlA4ySiZoJhbcTZnHDSUG2Cu+bHafIUTuUch3hTD9C
	 u9kXjtUnuL66e/t++jOmq2Et+/hBvUdZoeJYVK895TToskvqqvrQZgYYAjvXbNfbqo
	 BUUPS7Xy7eppg==
Date: Tue, 10 Mar 2026 18:12:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260311011218.GA212983@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.

I think this actually undersells the feature.  It's also much simpler
than the signature-based module authentication.  The latter relies on
PKCS#7, X.509, ASN.1, OID registry, crypto_sig API, etc in addition to
the implementations of the actual signature algorithm (RSA / ECDSA /
ML-DSA) and at least one hash algorithm.

I've even seen a case where the vmlinux size decreases by almost 200KB
just by disabling module signing.  That's not even counting the
signatures themselves, which ML-DSA has increased to 2-5 KB each.

The hashes are much simpler, even accounting for the Merkle tree proofs
that make them scalable.  They're less likely to have vulnerabilities
like the PKCS#7 bugs the kernel has had historically.  They also
eliminate the dependency on a lot of userspace libcrypto functionality
that has been causing portability problems, such as the CMS functions.

So I think this is how module authentication should have been done
originally, and I'm glad to see this is finally being fixed.

> +struct module_hashes_proof {
> +	__be32 pos;
> +	u8 hash_sigs[][MODULE_HASHES_HASH_SIZE];
> +} __packed;

Is the choice of big endian for consistency with struct
module_signature?  Little endian is the usual choice in new code.

> diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> index a45ce3b24403..3b510651830d 100644
> --- a/include/linux/module_signature.h
> +++ b/include/linux/module_signature.h
> @@ -18,6 +18,7 @@ enum pkey_id_type {
>  	PKEY_ID_PGP,		/* OpenPGP generated key ID */
>  	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
>  	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
> +	PKEY_ID_MERKLE,		/* Merkle proof for modules */

I recommend making the hash algorithm explicit:

        PKEY_ID_MERKLE_SHA256,	/* SHA-256 merkle proof for modules */

While I wouldn't encourage the addition of another hash algorithm
(specifying one good algorithm for now is absolutely the right choice),
if someone ever does need to add another one, we'd want them to be
guided to simply introduce a new value of this enum rather than hack it
in some other way.

> +static void hash_entry(const void *left, const void *right, void *out)

Byte arrays should use u8 instead of void

> diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
[...]

> +struct file_entry {
> +	char *name;
> +	unsigned int pos;
> +	unsigned char hash[EVP_MAX_MD_SIZE];

Considering that the hash algorithm is fixed, EVP_MAX_MD_SIZE can be
replaced with a tighter local definition:

    #define MAX_HASH_SIZE 32

> +static struct file_entry *fh_list;
> +static size_t num_files;
> +
> +struct leaf_hash {
> +	unsigned char hash[EVP_MAX_MD_SIZE];
> +};
> +
> +struct mtree {
> +	struct leaf_hash **l;
> +	unsigned int *entries;
> +	unsigned int levels;
> +};

'struct leaf_hash' is confusing because it's actually used for the
hashes of internal nodes, not leaf nodes.

Maybe rename it to 'struct hash' and use it for both the hashes and leaf
nodes and internal nodes.

Also, clearer naming would improve readability, e.g.:

    struct merkle_tree {
            struct hash **level_hashes;
            unsigned int level_size;
            unsigned int num_levels;
    };

> +static void hash_data(void *p, unsigned int pos, size_t size, void *ret_hash)

static void hash_data(const uint8_t *data, unsigned int pos,
                      size_t size, struct hash *ret_hash)

> +	unsigned char magic = 0x01;

uint8_t

Also, when defining these magic numbers, maybe explicitly document that
they are domain separation prefixes:

        uint8_t magic = 0x01; /* domain separation prefix */

> +	unsigned int pos_be;

uint32_t

> +static void hash_entry(void *left, void *right, void *ret_hash)

Could use stronger typing:

static void hash_entry(const struct hash *left, const struct hash *right,
                       struct hash *ret_hash)

> +static struct mtree *build_merkle(struct file_entry *fh, size_t num)

Could use clearer names, and constify the file_entry array:

static struct merkle_tree *build_merkle(const struct file_entry *files,
                                        size_t num_files)

> +	/* First level of pairs */
> +	for (unsigned int i = 0; i < num; i += 2) {
> +		if (i == num - 1) {
> +			/* Odd number of files, no pair. Hash with itself */
> +			hash_entry(fh[i].hash, fh[i].hash, mt->l[0][i / 2].hash);
> +		} else {
> +			hash_entry(fh[i].hash, fh[i + 1].hash, mt->l[0][i / 2].hash);
> +		}
> +	}
> +	for (unsigned int i = 1; i < mt->levels; i++) {
> +		int odd = 0;
> +
> +		if (le & 1) {
> +			le++;
> +			odd++;
> +		}
> +
> +		mt->entries[i] = le / 2;
> +		mt->l[i] = xcalloc(sizeof(**mt->l), le);
> +
> +		for (unsigned int n = 0; n < le; n += 2) {
> +			if (n == le - 2 && odd) {
> +				/* Odd number of pairs, no pair. Hash with itself */
> +				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n].hash,
> +					   mt->l[i][n / 2].hash);
> +			} else {
> +				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n + 1].hash,
> +					   mt->l[i][n / 2].hash);
> +			}
> +		}
> +		le =  mt->entries[i];
> +	}

There should be an assertion at the end that we ended up with exactly 1
hash in the root level.

It might also be possible to refactor this code such that the leaf nodes
and internal nodes are handled in the same loop, rather than handling
the leaf nodes as a special case.

> +static void write_merkle_root(struct mtree *mt, const char *fp)

fp => filename since it's a string, not e.g. a 'FILE *'.

> +{
> +	char buf[1024];
> +	unsigned int levels;
> +	unsigned char *h;
> +	FILE *f;
> +
> +	if (mt) {
> +		levels = mt->levels;
> +		h = mt->l[mt->levels - 1][0].hash;
> +	} else {
> +		levels = 0;
> +		h = xcalloc(1, hash_size);
> +	}
> +
> +	f = fopen(fp, "w");
> +	if (!f)
> +		err(1, "Failed to create %s", buf);

Above should log the name of the file.  'buf' should be removed.

> +static char *xstrdup_replace_suffix(const char *str, const char *new_suffix)
> +{
> +	const char *current_suffix;
> +	size_t base_len;
> +
> +	current_suffix = strchr(str, '.');
> +	if (!current_suffix)
> +		errx(1, "No existing suffix in '%s'", str);

This doesn't handle base names that contain a period.  strrchr() would
work if the old suffix always contains exactly one period.  Otherwise
another solution would be needed to identify the old suffix.

> +static __attribute__((noreturn))
> +void format(void)

usage()

> +{
> +	fprintf(stderr,
> +		"Usage: scripts/modules-merkle-tree <root definition>\n");
> +	exit(2);

This should show both parameters, <root hash> <new suffix>

But they probably should be flipped to put the output second.

Though, is <new suffix> needed at all?  It looks like it doesn't
actually affect the output.

> +	hash_evp = EVP_get_digestbyname("sha256");

EVP_sha256()

> +	hash_size = EVP_MD_get_size(hash_evp);

The old name 'EVP_MD_size()' would have wider compatibility.

> +	ERR(hash_size <= 0, "EVP_get_digestbyname");

Log message should say EVP_MD_size

> +	for (unsigned int i = 0; i < num_files; i++) {

size_t, for consistency with the type of num_files

> +		fd = open(signame, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +		if (fd < 0)
> +			err(1, "Can't create %s", signame);
> +
> +		build_proof(mt, i, fd);
> +		append_module_signature_magic(fd, lseek(fd, 0, SEEK_CUR));

Maybe build_and_append_proof()?

- Eric

