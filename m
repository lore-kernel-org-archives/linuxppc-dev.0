Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR62045nmzDrDV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 11:47:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/macintosh: Use true for boolean value
In-Reply-To: <20180123174349.GA19627@embeddedgus>
References: <20180123174349.GA19627@embeddedgus>
Date: Wed, 24 Jan 2018 11:47:02 +1100
Message-ID: <87vafsulq1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> Assign true or false to boolean variables instead of an integer value.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/macintosh/windfarm_pm72.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems to be common across all those drivers. Can you please send
one patch to fix them all to use bool:

  $ git grep "started = " drivers/macintosh/
  drivers/macintosh/therm_adt746x.c:              int started = 0;
  drivers/macintosh/therm_adt746x.c:                      started = 1;
  drivers/macintosh/windfarm_pm112.c:             slots_started = 1;
  drivers/macintosh/windfarm_pm112.c:             started = 1;
  drivers/macintosh/windfarm_pm121.c:             pm121_started = 1;
  drivers/macintosh/windfarm_pm72.c:              started = 1;
  drivers/macintosh/windfarm_pm81.c:              wf_smu_started = 1;
  drivers/macintosh/windfarm_pm91.c:              wf_smu_started = 1;
  drivers/macintosh/windfarm_rm31.c:              started = 1;

cheers
