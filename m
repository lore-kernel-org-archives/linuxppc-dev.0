Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 26627B7B8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 04:07:57 +1100 (EST)
Received: by yxe8 with SMTP id 8so11382502yxe.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 10:07:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1255538154.26753.13.camel@allano>
References: <1255538154.26753.13.camel@allano>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 11:07:35 -0600
Message-ID: <fa686aa40910141007i3ec0e636yac62a5cccde8b44b@mail.gmail.com>
Subject: Re: MPC5200B panics with high ethernet rx traffic
To: Asier Llano Palacios <a.llano@ziv.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2009 at 10:35 AM, Asier Llano Palacios <a.llano@ziv.es> wrote:
> Hi,
>
> I've found a very simple way to create a kernel panic, that's happening
> to our MPC5200B based boards. The issue was that when our boards
> received a burst of ethernet packets had a kernel panic.

This looks familiar.  Look in drivers/net/fec_mpc52xx.c and find the
function mpc52xx_fec_reset().  Remove the calls to phy_stop(),
phy_write() and phy_start().  See if that helps.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
