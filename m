Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9261F1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 07:23:06 +1000 (AEST)
Message-ID: <1436908977.3948.266.camel@kernel.crashing.org>
Subject: Re: BUG: sleeping function called from ras_epow_interrupt context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, kvm-ppc@vger.kernel.org
Date: Wed, 15 Jul 2015 07:22:57 +1000
In-Reply-To: <55A55846.5080904@redhat.com>
References: <55A55846.5080904@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-14 at 20:43 +0200, Thomas Huth wrote:
> Any suggestions how to fix this? Simply revert 587f83e8dd50d? Use
> mdelay() instead of msleep() in rtas_busy_delay()? Something more
> fancy?

A proper fix would be more fancy, the get_sensor should happen in a
kernel thread instead.

Cheers,
Ben.
