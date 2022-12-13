Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEF0C4167B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Dec 2022 20:32:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWqtZ4J5Wz3bjY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Dec 2022 07:32:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWqsv618wz3bcM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2022 07:32:02 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2BDKPa1d030311;
	Tue, 13 Dec 2022 14:25:36 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 2BDKPZ42030308;
	Tue, 13 Dec 2022 14:25:35 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 13 Dec 2022 14:25:35 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] [BACKPORT FOR 4.14] libtraceevent: Fix build with binutils 2.35
Message-ID: <20221213202535.GL25951@gate.crashing.org>
References: <c4629a12d4a2a21ff131624d3ef1d9f8b5fd64ad.1670954579.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4629a12d4a2a21ff131624d3ef1d9f8b5fd64ad.1670954579.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ben Hutchings <ben@decadent.org.uk>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-trace-devel@vger.kernel.org, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Salvatore Bonaccorso <carnil@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 13, 2022 at 07:03:07PM +0100, Christophe Leroy wrote:
> In binutils 2.35, 'nm -D' changed to show symbol versions along with
> symbol names, with the usual @@ separator.

2.37 instead?  And --without-symbol-versions is there to restore the
old behaviour.  The script is parsing the output already so this patch
is simpler maybe, but :-)


Segher
