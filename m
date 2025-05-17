Return-Path: <linuxppc-dev+bounces-8628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F88FC2D0CD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 May 2025 13:50:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b051t2p0Bz2yqy;
	Sat, 17 May 2025 23:50:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.236.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747489842;
	cv=none; b=IFmyHLZA4zQvvjbb13QyMPtg6vmb0xj1vj1feQO76krWg8ZyQKJ9/W5Elj8iE6glv497I93b8oQ2qWfo2coZY9aGkV7xd8NNgNWxCScxQTYQZn10jjjPIJwsf/guQn+fz2OEIlaSwb7c2iqmNdu1w7EaLkJo8xAEClycWn2ZDwIZGr7TkME2i9t3lyJo6M/xmRNsSYzgQvcYzyBYgBRDRtFGuOEBGg6Aj190/85qV88DcNJQ29SQri2cUIPiZK6u+KaJVmIZCpbNNm3Qwo+knmZ5cJHMXbkZ78pdfFKX+FkUFJBFkqbC4DJH+OPOM9TxzcUp4uX3sEuFb7YuzGMXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747489842; c=relaxed/relaxed;
	bh=lpIvoovaLHQgEEEBmEzf8Pj9rIFdLD6mZz9+mU93GAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbrHGk5RVjBF/OeN2iph8TqQxEvWbNo7Ib9yWucrK12VUmPxZUlkFBCcihAZ+/R4k+O8oCaMjv1ly9LcX/la28CWXw9qlEvPU2tCGGO15Avni4pQ5z4vVOdDvojnWF0Apn4PYDQqJ8WV1NRiKh8IO5JIdxkE8lcfZx8Zfsv/kGOXd6Y3tVjfXYon0U1GFSqbz+iO6FtgFctp088GI4tFDBHQVpYeh1R73iMzlHkUkN4fQKPeOl5x+GB3x25WlLmIdr0sX6obcLvB/1uANt9BFpR0lMw+YnVhKfck7l/am3hJ+trkCaS+XKzgFhcgtlSy2JVYEWyM7I+QZ6nHGvvvNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b051s5cFMz2xgp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2025 23:50:41 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4b00Lw4Q8Lz9sWd;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAQGIddjf2x1; Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4b00Lw3gtmz9sVS;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 778DB8B768;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LHtpXwaBRXOP; Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 40D948B763;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 54HAK3Eq013312
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 May 2025 12:20:03 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 54HAK04l013287;
	Sat, 17 May 2025 12:20:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kees Cook <kees@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sean Anderson <sean.anderson@linux.dev>,
        Camelia Groza <camelia.groza@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qbman: Remove const from portal->cgrs allocation type
Date: Sat, 17 May 2025 12:19:35 +0200
Message-ID: <174747706460.12970.18215881041765719309.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250426062040.work.047-kees@kernel.org>
References: <20250426062040.work.047-kees@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747477178; l=823; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hNTrwDECXwzB0w5bCYwkYV4UpWwqz6HdVtTVORZF/Fw=; b=mFKsjfXcvpGeGE31KGr09d6oDBkiSjZI94a2MDnCQHBHukcnmeqcKT4xhZFmPL+AOOsVnsPBU ZAVkzoD/un4B/P+9R6d8wR5yHjP/i80Y1UZC5JifRFWXwlPuejDEQbq
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit


On Fri, 25 Apr 2025 23:20:41 -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct qman_cgrs *", but the returned type,
> while technically matching, is const qualified. As there is no general
> way to remove const qualifiers, adjust the allocation type to match
> the assignment.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qbman: Remove const from portal->cgrs allocation type
      commit: 5ddac92be4209f29ec26b3ec59a08fc76afe9ab1

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>

