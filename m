Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 29066B7116
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Nov 2010 01:05:24 +1100 (EST)
Received: by ewy26 with SMTP id 26so1746558ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 06:05:22 -0800 (PST)
Date: Fri, 12 Nov 2010 17:05:15 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 1/2] ucc_geth: Do not bring the whole IF down when TX
	failure.
Message-ID: <20101112140515.GA28223@oksana.dev.rtsoft.ru>
References: <1289570109-8160-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1289570109-8160-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 12, 2010 at 02:55:08PM +0100, Joakim Tjernlund wrote:
> ucc_geth_close lacks a cancel_work_sync(&ugeth->timeout_work)
> to stop any outstanding processing of TX fail. However, one
> can not call cancel_work_sync without fixing the timeout function
> otherwise it will deadlock. This patch brings ucc_geth in line with
> gianfar:
> 
> Don't bring the interface down and up, just reinit controller HW
> and PHY.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Looks sane, thanks!

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
