Return-Path: <linuxppc-dev+bounces-27670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE348C982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:21:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPF42jpSz2y7r;
	Fri, 18 Sep 2026 17:21:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716088;
	cv=none; b=mpfm9FiiWW/5w7QZXhG5PDUlEA67KGFahJqxLcbzHrxLR+mfkAAFfD/NQVZGsX6xwic0fJjIaiI8Yf8rQvt21EZyT4Ruf+p3HcdXgw+F+RLZFtTdKYJ5OJOPlE1IBV6jlZQs0rej5pauW3llq8Y9JEdWPm2gRoXvo8CdWFcUEwj2D/J3qfj06sVVhiIgh7idEFFLNfjify4vgU8dtvBsIIMXPjyWL44o/2ImCIXWMFvMushP6EC3luYW7ELImz3ObrugngFBB+BD6SEbKXriNoOoeVDc/VUFAxUt+GY397QP4v7AAmZLxyX7YK8d5Ww3ppw5pwNtdKU0bsQMs0BLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716088; c=relaxed/relaxed;
	bh=obg8mrHZCzteuKsjo7uKdsL8y41j6SI2KsHB7Htsuzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1gTaxg/SnGMjZTIcdBpFdACD+F5FP8nOB9BD15muKUp2cWrxPq61r/wosBXp4DXUKlxd+EaxGgYqFpAVXq/dymLynrL3OIETx88jVVUeR0RB/P3S18qyn9L9+AiQEPt6e3zNzAyKiIBD/VZsI2W/Waz2NKZCO7shleOz7Ga/mfCM2lYxmybvE8Cj8+MnYQIxoQoIMULu1iX7WqYVKdeMkNylX/Xut1+SIpx6aOnUQH/U80bCGjjeXdYLFkPS6rmGQ0VdITk44QmTT+qJNtVTvxJqm/KsJ6XiGJZ27ocOz84mFHgwWxh3rH54Sf1bJYIDsZ6BAkOyHl1zEBRAaqqrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIyTlj5N; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=joel.granados@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIyTlj5N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=joel.granados@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPF31xMgz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:21:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A49F56053E;
	Fri, 18 Sep 2026 07:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEC21F000FF;
	Fri, 18 Sep 2026 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789716084;
	bh=obg8mrHZCzteuKsjo7uKdsL8y41j6SI2KsHB7Htsuzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NIyTlj5NJMuaPvyQ0XBnI1g4RrH1i2vsqeU5lgtPy1mcmGtvatA8gdIG2GifZnvBT
	 8Rsiih3bsJlYTSvo6buCgjlOkIXwIumRxGoV5i3swZs+YbwhwPxVw/NylyqbgWvUFm
	 2pzeZO4Ic3AtUaTeL/lJWqjQmBDOxnf6O4XctyuNRsyUUdd6ce89XQxHZAw0eHCMG1
	 vTl+7z+qj2O0FweW32GKRGefz09ejUwtNWjgeiXKAjkwHUABi28uBAC83Zp7Mivq21
	 VwNzwVrfZ5UdW+Vb+SqPxPixX/bOhscg1YZ5skM5x9iClqTW9d4n+l+ZKEIVSJdtDW
	 NwZ6DaeJ040oA==
Date: Fri, 18 Sep 2026 09:21:18 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	Kees Cook <kees@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	rcu@vger.kernel.org, virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, 
	llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 17/17] sysctl: assert static storage for
 DEFINE_CTL_TABLE_POLL()
Message-ID: <av3s3fgets23siaqxbtyu5gvcekqpq2nmyey6oa6o6amfj6jbi@zomsnfvvxtf4>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-12-ynorov@nvidia.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ds2q3rrmscwpm7nx"
Content-Disposition: inline
In-Reply-To: <20260915031334.1194975-12-ynorov@nvidia.com>


--ds2q3rrmscwpm7nx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:13:32PM -0400, Yury Norov wrote:
> DEFINE_CTL_TABLE_POLL() statically initializes an embedded wait queue.
> An automatic local poll object cannot provide the persistent lockdep
> class key expected by its wait queue lock.
>=20
> Add ASSERT_STATIC_STORAGE() to reject automatic declarations while
> preserving file-scope and static local definitions. Leave the underlying
> initializer available for embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/sysctl.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index e5d7226ab6f5..be79359346af 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -22,6 +22,7 @@
>  #ifndef _LINUX_SYSCTL_H
>  #define _LINUX_SYSCTL_H
> =20
> +#include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/rcupdate.h>
>  #include <linux/wait.h>
> @@ -216,7 +217,8 @@ static inline void *proc_sys_poll_event(struct ctl_ta=
ble_poll *poll)
>  	.wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(name.wait) }
> =20
>  #define DEFINE_CTL_TABLE_POLL(name)					\
> -	struct ctl_table_poll name =3D __CTL_TABLE_POLL_INITIALIZER(name)
> +	struct ctl_table_poll name =3D __CTL_TABLE_POLL_INITIALIZER(name);	\
> +	ASSERT_STATIC_STORAGE(name)
> =20
>  /* A sysctl table is an array of struct ctl_table: */
>  struct ctl_table {
> --=20
> 2.53.0
>=20

This looks OK for sysctl and the two users of DEFINE_CTL_TABLE_POLL in
utsname_sysctl.c (hostname_poll and domainname_poll)

Reviewed-by: Joel Granados <joel.granados@kernel.org>

Best

--ds2q3rrmscwpm7nx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqs5mgACgkQupfNUreW
QU+Slwv/V1va9Xy3ewVVGpZbKof7lX0SuxpAV+wYGoQU9hE6Ofexe2lgpstvBg5q
R4BplT9ThJvF8d3hzCkPNWmWHuXW19VfnmKKdy7zNHYo8lyVLEyFmOlw+3sZ6czr
e7JVfspT2rWbf/0oF8GiQvMCV31pFqQty+c4bb5ZV64xBCKqIxBX9DMXYOstdt1z
hRlSyBTjYabun1LJPo7Nkj/puYlCklMcipRzJNONXZgWt0LFRsCYSZRrAdk2ISeP
y7e87NG2DiVBd/d58WvPvdwdpmhX4vHSNXdSbeLwTn26F3bg7yaNsXd2sCSVTu/o
4S0G/bMFUP/e2oNe/wtaO+XBnDhJYPk3DGvYkFf/C8DFyCVi36tjb4SrQv3D0QV9
PGWE2Hek8KHr3W4oRbZIQm6zMUwg9/fu4speRR5+1xnuBlVsRXtEOQgEr/DkWYHw
8SYHe3rOXtaFsbMWdItXR1CRib516haep77aGjErq93c3ViZF1JEEMBQdXjqjWmm
LKs/7uqR
=5LAv
-----END PGP SIGNATURE-----

--ds2q3rrmscwpm7nx--

