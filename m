Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 4A21767A41
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 22:09:57 +1000 (EST)
Date: Thu, 27 Apr 2006 14:09:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 02/16] ehca: module infrastructure
Message-ID: <20060427120951.GE32127@wohnheim.fh-wedel.de>
References: <4450A165.4000701@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4450A165.4000701@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 April 2006 12:48:05 +0200, Heiko J Schick wrote:
>
> +	if (ehca_module->cache_pd == NULL) {

Hmm.

> +	ret = kmem_cache_destroy(ehca_module->cache_pd);
> +	if (ret != 0)

The " != 0" is completely superfluous.  Above NULL check is a matter
of taste, this one demonstates lack of boolean algebra understanding.

> +	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if (!rblock) {

Hmm.  And your taste seems to change. :)

> +	if (ehca_hw_level == 0) {

And since we're on the subject.  Ignoring the recent discussion
involving akpm, viro and others, the kernel historically used int both
for integer and boolean, plus return values as a special kind of
"boolean with error indication attached".

For boolean, it is nicer to do things like "if (!error)", for
integers, a comparison as above is nicer.  Return codes fall into the
boolean category.  Pointers after kmalloc() and similar are viewed as
rich boolean by some people, but not by all.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
