Return-Path: <frowand.list@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRt0g5blLzDrSD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 17:48:35 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id p124so8131203ite.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 22:48:35 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <9c03edf1-564b-dd40-bbdf-e21e499869a6@gmail.com>
Date: Wed, 24 Jan 2018 22:48:31 -0800
MIME-Version: 1.0
In-Reply-To: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/21/18 06:31, Wolfram Sang wrote:
> I got a bug report for a DT node refcounting problem in the I2C subsystem. This
> patch was a huge help in validating the bug report and the proposed solution.
> So, I thought I bring it to attention again. Thanks Tyrel, for the initial
> work!
> 
> Note that I did not test the dynamic updates, only of_node_{get|put} so far. I
> read that Tyrel checked dynamic updates extensively with this patch. And since
> DT overlays are also used within our Renesas dev team, this will help there, as
> well.

It's been nine months since version 1.  If you are going to include the
dynamic updates part of the patch then please test them.


> Tested on a Renesas Salvator-XS board (R-Car H3).
> 
> Changes since RFC v1:
> 	* rebased to v4.15-rc8
> 	* fixed commit abbrev and one of the sysfs paths in commit desc
> 	* removed trailing space and fixed pointer declaration in code
> 

> I consider all the remaining checkpatch issues irrelevant for this patch.

I am OK with the line length warnings in this patch.

Why can't the macro error be fixed?

A file entry needs to be added to MAINTAINERS.


> 
> So what about applying it?
> 
> Kind regards,
> 
>    Wolfram
> 
> 
> Tyrel Datwyler (1):
>   of: introduce event tracepoints for dynamic device_node lifecyle
> 
>  drivers/of/dynamic.c      | 32 ++++++----------
>  include/trace/events/of.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 20 deletions(-)
>  create mode 100644 include/trace/events/of.h
> 
