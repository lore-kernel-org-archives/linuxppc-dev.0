Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E137DDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 19:40:33 +1000 (EST)
Date: Thu, 18 Oct 2007 10:40:13 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH][NET] gianfar: fix obviously wrong #ifdef CONFIG_GFAR_NAPI
	placement
Message-ID: <20071018094013.GU21136@shadowen.org>
References: <20071017195746.GA15592@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071017195746.GA15592@localhost.localdomain>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, leoli@freescale.com,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The check then is to see if a non {}'d block has no statements in it if the
ifdef is null.  Hmmm.  May be possible.  Will think on it.

        if (err)
+#ifdef CONFIG_GFAR_NAPI
                napi_disable(&priv->napi);
+#endif

-apw
