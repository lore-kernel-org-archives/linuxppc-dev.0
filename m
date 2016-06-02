Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rLHHC68W6zDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 05:24:55 +1000 (AEST)
Date: Thu, 02 Jun 2016 12:24:51 -0700 (PDT)
Message-Id: <20160602.122451.160749876120675817.davem@davemloft.net>
To: qiang.zhao@nxp.com
Cc: oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, xiaobo.xie@nxp.com
Subject: Re: [PATCH v2 2/5] fsl/qe: setup clock source for TDM mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <1464831901-15913-2-git-send-email-qiang.zhao@nxp.com>
References: <1464831901-15913-1-git-send-email-qiang.zhao@nxp.com>
 <1464831901-15913-2-git-send-email-qiang.zhao@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhao Qiang <qiang.zhao@nxp.com>
Date: Thu, 2 Jun 2016 09:44:58 +0800

> +static int ucc_get_tdm_sync_source(u32 tdm_num, enum qe_clock clock,
> +				   enum comm_dir mode)
> +{
> +	int source = -EINVAL;
> +
> +	if (mode == COMM_DIR_RX && clock == QE_RSYNC_PIN) {
> +		source = 0;
> +		return source;
> +	}
> +	if (mode == COMM_DIR_TX && clock == QE_TSYNC_PIN) {
> +		source = 0;
> +		return source;
> +	}
> +
> +	switch (tdm_num) {
> +	case 0:
> +	case 1:
> +		switch (clock) {
> +		case QE_BRG9:
> +				source = 1;
> +				break;
> +		case QE_BRG10:
> +				source = 2;
> +				break;

These switch case bodies are over indented.  Same goes for the rest of
this function.
